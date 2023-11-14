Steps to update RHBK quickstarts to the newer product release
-------------------------------------------------------------

These steps are useful for the engineer, who want to update RHBK quickstarts to the newest version.

The RHBK quickstarts are fork of [Keycloak quickstarts](https://github.com/keycloak/keycloak-quickstarts). They contain some subset of the community quickstarts as RHBK product doesn't
support in product all the things done in the community (EG. authentication SPI or actionToken SPI). During each major release of RHBK, there
might be a need to do some steps. The idea is, that RHBK quickstarts are:
- Up to date with community quickstarts
- Updated to the latest version of RHBK

The steps needed for those:

1) Create branch in RHBK quickstarts corresponding to the last product release. For example creating branch like `26.x`, which is copied from
the [branch `24.x`](https://github.com/redhat-developer/rhbk-quickstarts/tree/24.x). This step needs to be done only for 
major RHBK releases (for minor releases, branch should already exist).

2) Sync the commits added to the upstream since the last release.
   
   2.a) Look at the history of commits in upstream `release/X` branch (X is the major/minor corresponding to the current RHBK product). For
        example for RHBK 26.0 release, it is this branch https://github.com/keycloak/keycloak-quickstarts/commits/release/26.0/
   
   2.b) Look at the history of RHBK branch.
   
   2.c) Cherry-pick the "relevant" upstream commits to the RHBK branch. The "relevant" means the commits, which are related to the RHBK
        quickstarts (So for example ommit the commit related to action-tokens quickstarts etc since those are not supported 
        in product) . Use `git cherry-pix -x <upstream commit>` to keep references to the original upstream commit. In some 
        cases, manual updates are needed (EG. when some commit touches quickstarts, which are RHBK related, but also those, 
        which are not present in RHBK)

3) Update RHBK version and RHBK client version and test quickstarts against proper RHBK release. Those steps depend on whether 
the target RHBK product you are updating quickstarts to is already released in public maven repository.
Public product repository should be available under [this URL](https://maven.repository.redhat.com/ga/org/keycloak/). If you 
don't see artifacts from your version, you need to use private maven repository. In that case, follow the steps in 
[README-product-testing.md](README-product-testing.md) for how to update the version and test it. If artifacts are available,
things might be easier and some variables mentioned in `README-product-testing.md` can be omitted.
