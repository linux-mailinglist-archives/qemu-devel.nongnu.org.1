Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D06739556
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9pK-0005RB-FS; Wed, 21 Jun 2023 22:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9pD-0005QI-MW
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9pA-0004nw-Mb
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/0iaH6ZVJrNWGKaig4HW9eM1KLaw292Ek3FidavPzHg=;
 b=U5GGs2eYFLxNq1d/R9LxFd6JwqS/fRBVIs7yEEJl1x6a3x9T8dvAG97TGkOf4rAoLv6OTk
 wtlHc9fiY1f9LrrO7uuTJmAHiU5d46vANqy1xGWUd++9qHZY9JiVW7HhYulEuqfEkKtOAr
 QGwgnhvjcV50ohb6m31l1nibju9nPbo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-0pwVH1nrMpSrqaw4XtNahA-1; Wed, 21 Jun 2023 22:13:23 -0400
X-MC-Unique: 0pwVH1nrMpSrqaw4XtNahA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B481856506;
 Thu, 22 Jun 2023 02:13:23 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 460AF112132C;
 Thu, 22 Jun 2023 02:13:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 00/30] Next patches
Date: Thu, 22 Jun 2023 04:12:50 +0200
Message-Id: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following changes since commit 67fe6ae41da64368bc4936b196fee2bf61f8c720:

  Merge tag 'pull-tricore-20230621-1' of https://github.com/bkoppelmann/qemu into staging (2023-06-21 20:08:48 +0200)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/next-pull-request

for you to fetch changes up to c53dc569d0a0fb76eaa83f353253a897914948f9:

  migration/rdma: Split qemu_fopen_rdma() into input/output functions (2023-06-22 02:45:30 +0200)

----------------------------------------------------------------
Migration Pull request (20230621)

In this pull request:

- fix for multifd thread creation (fabiano)
- dirtylimity (hyman)
  * migration-test will go on next PULL request, as it has failures.
- Improve error description (tejus)
- improve -incoming and set parameters before calling incoming (wei)
- migration atomic counters reviewed patches (quintela)
- migration-test refacttoring reviewed (quintela)

Please apply.

----------------------------------------------------------------

Fabiano Rosas (2):
  migration/multifd: Rename threadinfo.c functions
  migration/multifd: Protect accesses to migration_threads

Hyman Huang(黄勇) (8):
  softmmu/dirtylimit: Add parameter check for hmp "set_vcpu_dirty_limit"
  qapi/migration: Introduce x-vcpu-dirty-limit-period parameter
  qapi/migration: Introduce vcpu-dirty-limit parameters
  migration: Introduce dirty-limit capability
  migration: Refactor auto-converge capability logic
  migration: Put the detection logic before auto-converge checking
  migration: Implement dirty-limit convergence algo
  migration: Extend query-migrate to provide dirty page limit info

Juan Quintela (16):
  migration-test: Be consistent for ppc
  migration-test: Make machine_opts regular with other options
  migration-test: Create arch_opts
  migration-test: machine_opts is really arch specific
  migration-test: Create kvm_opts
  migration-test: bootpath is the same for all tests and for all archs
  migration-test: Add bootfile_create/delete() functions
  migration-test: dirtylimit checks for x86_64 arch before
  migration-test: simplify shmem_opts handling
  qemu-file: Rename qemu_file_transferred_ fast -> noflush
  migration: Change qemu_file_transferred to noflush
  migration: Use qemu_file_transferred_noflush() for block migration.
  qemu_file: Make qemu_file_is_writable() static
  qemu-file: Simplify qemu_file_shutdown()
  qemu-file: Make qemu_file_get_error_obj() static
  migration/rdma: Split qemu_fopen_rdma() into input/output functions

Tejus GK (2):
  migration: Update error description whenever migration fails
  migration: Refactor repeated call of yank_unregister_instance

Wei Wang (2):
  migration: enforce multifd and postcopy preempt to be set before
    incoming
  qtest/migration-tests.c: use "-incoming defer" for postcopy tests

 qapi/migration.json            |  74 +++++++++++++++++---
 include/sysemu/dirtylimit.h    |   2 +
 migration/options.h            |   1 +
 migration/qemu-file.h          |  14 ++--
 migration/threadinfo.h         |   7 +-
 migration/block.c              |   4 +-
 migration/migration-hmp-cmds.c |  26 +++++++
 migration/migration.c          |  40 +++++++----
 migration/multifd.c            |   4 +-
 migration/options.c            |  87 +++++++++++++++++++++++
 migration/qemu-file.c          |  24 ++-----
 migration/ram.c                |  59 +++++++++++++---
 migration/rdma.c               |  39 +++++------
 migration/savevm.c             |   6 +-
 migration/threadinfo.c         |  19 ++++-
 migration/vmstate.c            |   4 +-
 softmmu/dirtylimit.c           |  97 +++++++++++++++++++++++---
 tests/qtest/migration-test.c   | 123 ++++++++++++++++++---------------
 migration/trace-events         |   1 +
 19 files changed, 472 insertions(+), 159 deletions(-)


base-commit: 5f9dd6a8ce3961db4ce47411ed2097ad88bdf5fc
prerequisite-patch-id: 99c8bffa9428838925e330eb2881bab476122579
prerequisite-patch-id: 77ba427fd916aeb395e95aa0e7190f84e98e96ab
prerequisite-patch-id: 9983d46fa438d7075a37be883529e37ae41e4228
prerequisite-patch-id: 207f7529924b12dcb57f6557d6db6f79ceb2d682
prerequisite-patch-id: 5ad1799a13845dbf893a28a202b51a6b50d95d90
prerequisite-patch-id: c51959aacd6d65ee84fcd4f1b2aed3dd6f6af879
prerequisite-patch-id: da9dbb6799b2da002c0896574334920097e4c50a
prerequisite-patch-id: c1110ffafbaf5465fb277a20db809372291f7846
prerequisite-patch-id: 8307c92bedd07446214b35b40206eb6793a7384d
prerequisite-patch-id: 0a6106cd4a508d5e700a7ff6c25edfdd03c8ca3d
prerequisite-patch-id: 83205051de22382e75bf4acdf69e59315801fa0d
prerequisite-patch-id: 8c9b3cba89d555c071a410041e6da41806106a7e
prerequisite-patch-id: 0ff62a33b9a242226ccc1f5424a516de803c9fe5
prerequisite-patch-id: 25b8ae1ebe09ace14457c454cfcb23077c37346c
prerequisite-patch-id: 466ea91d5be41fe345dacd4d17bbbe5ce13118c2
prerequisite-patch-id: d1045858f9729ac62eccf2e83ebf95cfebae2cb5
prerequisite-patch-id: 0276ec02073bda5426de39e2f2e81eef080b4f54
prerequisite-patch-id: 7afb4450a163cc1a63ea23831c50214966969131
prerequisite-patch-id: 06c053ce4f41db9675bd1778ae8f6a483641fcef
prerequisite-patch-id: 13ea05d54d741ed08b3bfefa1fc8bedb9c81c782
prerequisite-patch-id: 99c4e2b7101bc8c4b9515129a1bbe6f068053dbf
prerequisite-patch-id: 1e393a196dc7a1ee75f3cc3cebbb591c5422102f
prerequisite-patch-id: 2cf497b41f5024ede0a224b1f5b172226067a534
prerequisite-patch-id: 2a70276ed61d33fc4f3b52560753c05d1cd413be
prerequisite-patch-id: 17ec40f4388b62ba8bf3ac1546c6913f5d1f6079
prerequisite-patch-id: dba969ce9d6cf69c1319661a7d81b1c1c719804d
prerequisite-patch-id: 8d800cda87167314f07320bdb3df936c323e4a40
prerequisite-patch-id: 25d4aaf54ea66f30e426fa38bdd4e0f47303c513
prerequisite-patch-id: 082c9d8584c1daff1e827e44ee3047178e7004a7
prerequisite-patch-id: 0ef73900899425ae2f00751347afdce3739aa954
prerequisite-patch-id: e7db4730b791b71aaf417ee0f65fb6304566aaf8
prerequisite-patch-id: 62d7f28f8196039507ffe362f97723395d7bb704
prerequisite-patch-id: ea8de47bcb54e33bcc67e59e9ed752a4d1fad703
prerequisite-patch-id: 497893ef92e1ea56bd8605e6990a05cb4c7f9293
prerequisite-patch-id: 3dc869c80ee568449bbfa2a9bc427524d0e8970b
prerequisite-patch-id: 52c14b6fb14ed4ccd685385a9fbc6297b762c0ef
prerequisite-patch-id: 23de8371e9e3277c374a47f9bd10de209a22fdd5
prerequisite-patch-id: d21f036dd106af3375fb920bf0a557fe2b86d98e
prerequisite-patch-id: ca717076e9de83d6ce370f7374c4729a9f586fae
prerequisite-patch-id: a235b6ab3237155f2b39e8e10d47ddd250f6b6cc
prerequisite-patch-id: 6db2aa3d8a5804c85dd171864f5140fadf5f72da
prerequisite-patch-id: a799b883f4cb41c34ad074220293f372c6e0a9c7
prerequisite-patch-id: 5e012c426aef7b2f07513cec68e7efa1cf85fe52
prerequisite-patch-id: 4e614e7e3395dda7bae5f9fa21257c57cce45a39
prerequisite-patch-id: 67f8e68622c9698280ff5c5dc7469f36daf9a012
prerequisite-patch-id: d86078331449a21499e3f955e27bc87294969346
prerequisite-patch-id: 3f30d10e0ac7f53307f6b462eaf5b47151b73631
prerequisite-patch-id: a5d84769b776873697b1eb18b6b170a168e68133
prerequisite-patch-id: e5058b3e0ca9f80886bd2c1667349bffc6949da6
prerequisite-patch-id: 669d7e2ef30468034acfa33d4da0404caae526a9
prerequisite-patch-id: 3276a659cbe45efca6a6d3a4579af3cf7ceda992
prerequisite-patch-id: 624657b1f538edfb852b09889d6583970665cad9
prerequisite-patch-id: d7d70d557970f203c288f153361c6782245ba9f9
prerequisite-patch-id: fcbab0e48ac1385d2de1be7852b2adb74f04acfc
prerequisite-patch-id: 88e76e8dc51b054c84c497344424f24e877e325b
prerequisite-patch-id: dc4c193c8571ae5969a6c498edc7cec8ef438bc1
prerequisite-patch-id: 39c1ee32082f6ce1dd088d5a8340ca9b3e2434a4
prerequisite-patch-id: 28deb0caf0f5eac3fc0a866d2901667a56870f6d
prerequisite-patch-id: 53b48b35c9b8217b2da5212d7ed48320d355a943
prerequisite-patch-id: 4469f3663714a65a06b7c472ce9c92ab7502a00f
prerequisite-patch-id: a75f08b401d251fc3465b65f94a8db8d32d8900a
prerequisite-patch-id: 4b7ac86af078a260f656914089da8f43cdaab8ff
prerequisite-patch-id: 398f62abad95f55181d2cf8a383f69000de97af4
prerequisite-patch-id: e102cdc3834018fa88f9fe98a78afb46ff316124
prerequisite-patch-id: 1c30c139ef694b9fd8314bffb4b9b2a02c6c9233
prerequisite-patch-id: d96c304f1c63fa840440508f5b3be70a922b2210
prerequisite-patch-id: a8be25a6b6834ac542d40eaec47a60caf2fe545c
prerequisite-patch-id: d29aa52f7a6c5e61cf793addbbc7d7ea5f383725
prerequisite-patch-id: c7a6d171e568f4aba6f94126abc6a9a64caefcc2
prerequisite-patch-id: dcbf2e0e9b3b3cd985423993bdd411fc0cdf4646
prerequisite-patch-id: d5f1a450785cb6e8d74e152b7026621cd4077d04
prerequisite-patch-id: 6179fd2a7c7d6866906365b564fcef05428318b3
prerequisite-patch-id: 3f0e5189f1046e8fd37b2f104a5ee6c306438bed
prerequisite-patch-id: 9b8f5520663a347e1981c46d1d72f6b7efeef222
prerequisite-patch-id: 6171b4310abc56d03a21f95848beff3f04c04333
prerequisite-patch-id: 93336ba3fd1e3875b644ec6007ef22480df750a2
prerequisite-patch-id: 9a76b6408f38b96af9ad91269a0fac8d1893bdef
prerequisite-patch-id: 74c166a9a1ccafef04f3894085a3b3ed5215df7a
prerequisite-patch-id: 71833e48cfa5875247770ac8b94ab957e4eab4fe
prerequisite-patch-id: 9a14e6755e7d7605267abaeab62d70e651d622e3
prerequisite-patch-id: e0b2ce3211263007de8e2a2b60402cfea4a2f1c2
prerequisite-patch-id: bacccbe583a69dd0f081aa74822e92c23f344a64
prerequisite-patch-id: bee3183ab6c76123bc8795dfd5dd6eb19d417832
prerequisite-patch-id: eee73769e563ea8ad64f82473c235a4fef18ce83
prerequisite-patch-id: 5c2c95e068dc614a7708fe830d773e03e8cde4ec
prerequisite-patch-id: deae58b435dc10d80f1ea754613e9ed3e7bd4fe1
prerequisite-patch-id: 1e6e138aeb18a51b6496a265f84f5df1b98471b6
prerequisite-patch-id: 15865988ed0b88b1e28f0e16c50222f61db5ac35
prerequisite-patch-id: 7884031de035d910c1bddee4331a765c6a266243
prerequisite-patch-id: a2deb3751dec34448ab776b455a7b29bd6d8217f
prerequisite-patch-id: d24167f841efc3b8fd8afe06ae02da4d4a594fdc
prerequisite-patch-id: 4f23aea0e73aa0933a53db59ed716a19dcbd575c
prerequisite-patch-id: f54b42bfeb4241cb96b2490e1261e2bc44e7cc07
prerequisite-patch-id: 7e3f3e34be720b25f3db15d2a878bce23b99353c
prerequisite-patch-id: fc91b48c6593c862aa17b221663d2bbed9261f16
prerequisite-patch-id: f20dbadd1962f16e7f4fc4a2b8747443ada94f80
prerequisite-patch-id: 78de9ba010ec43b9ebbc998f4d3afb38fed6be8e
prerequisite-patch-id: 013c99f721a9a0a4af86772cb8d1d40f6942f16f
prerequisite-patch-id: 7ee4a5b056b343ba2d7491158965023af84f56ad
prerequisite-patch-id: d489b42dc81bf9dd7a51381c06182ddffb2230e5
prerequisite-patch-id: fcf1400a8d8b417801baf1450c8c10efa06f4481
prerequisite-patch-id: e475e1e9cd7ce746410ef9839d02ba242cb72090
prerequisite-patch-id: 68d24ec2081c2224a1c133f2c07544177e693a53
prerequisite-patch-id: 6e70864f4065b79db49a206523bcc8b4afded934
prerequisite-patch-id: 0d259c5d3ebb259d36c5d059a82df3b0ffbf1429
prerequisite-patch-id: 392a9fa483070625cad85778e4742c4fc5a2ac5d
prerequisite-patch-id: 62804c908c4abe71d644f18303780084a4c224e8
prerequisite-patch-id: 3f3f1eed1a6150df53aba846237329cf24bb9548
prerequisite-patch-id: 4d1387c6e00b9c62e638ce955cd5d9681754bfb5
prerequisite-patch-id: 3382e00119d0ecd997ae6f99855c74e3eed9237c
prerequisite-patch-id: 95fcef043070fc902f1cad42ef47a94744624530
prerequisite-patch-id: 5b6737d17f3ef9a4ae5d33343125bc597ad2fa62
prerequisite-patch-id: acc0a1e809cb0639e16d4b05cccfd809f8e299b5
prerequisite-patch-id: aa5c2db287402596e20ef0f935aea67007484f58
prerequisite-patch-id: a0318b66bb3f1f096f7d77c3f03e2018f68430b4
prerequisite-patch-id: 4d709e0d8ac627462de259723ac4fcb8efcc5342
prerequisite-patch-id: 811deca81c0cbdc5a3e977dd282f46427e79dbe2
prerequisite-patch-id: 8f66923ad1790ee9e567b9b1d155c7836c3e7cb8
prerequisite-patch-id: c0f2a71d9835e66a216af2ff3b3d434eec44ab0d
prerequisite-patch-id: 5e1a47e077d7bd22b1af9439e1cf1ae38830f763
prerequisite-patch-id: 04bd404d9e3268cbc399458be5bd69190852884a
prerequisite-patch-id: 6d630be7173e6e8da9a14739d32701f76bdf32a3
prerequisite-patch-id: 463c4f52f60b2c8fbf165caedbbc1bfa3bd2a265
prerequisite-patch-id: 67403a8553d60ec8938906f28319176f2ef0ecc4
prerequisite-patch-id: 18443a910e260eed010a2d4cd8f255678476eb0a
prerequisite-patch-id: cf8d1aab1c343ad9bb6de1b980bf7a8aa7479e79
prerequisite-patch-id: cb8ee956876a21478178d46383e760f2a29ec60a
prerequisite-patch-id: 0384e88e9105ce6907f44a55ae0d22bb57b11701
prerequisite-patch-id: 010b9094c8a9b1b41dc49fc07d9704a7be6374c0
prerequisite-patch-id: 3e96fcf9486ad8decca891534d4d2b41f786087a
prerequisite-patch-id: d77c491a6a5760ca828ecbb1445a77dcf9bebf0b
prerequisite-patch-id: 5c2e9b005429bca543ac6dd39912731d9388eb10
prerequisite-patch-id: 741c7b38494d42817d2d71adb6f267268c9cb208
prerequisite-patch-id: b97fb8b1e5848e8561fc599ef7173b2b07782918
prerequisite-patch-id: cca04ee447a117242679dc946638dd876bbaf931
prerequisite-patch-id: 7e7784bd5ec5ecfdb8d7130975a915fb88e8c26b
prerequisite-patch-id: 5a5137d28df7153718ef924d49a821fc1482b220
prerequisite-patch-id: 3d010e879709b5540948b11c2692a28fd5bdd1ea
prerequisite-patch-id: 3d418aca0f2a4a5a3e8cbd3c9da2a5229dd26f61
prerequisite-patch-id: 423c72136d6c85888dfac083efb54b518323f0dd
prerequisite-patch-id: 099453248d834931415e431e1bb470c1f99cdfa2
prerequisite-patch-id: 9fde172c51e107415194ecce2a3e218d2fab7f60
prerequisite-patch-id: 602a0f6b0121ef0296a3fe14872d59b8a0673b24
prerequisite-patch-id: ded33eb3b89b9da9e7a32ca5c6da3da2b65d3a83
prerequisite-patch-id: 56baaaf053e49e6306c076a80c5e7759a7c27805
prerequisite-patch-id: ec1ace1ef1e30d4c56143b3148b4f70c123ddd85
prerequisite-patch-id: da789135fed934d00e9020a90ec700a273fb18fa
prerequisite-patch-id: ca5e644043851df5c7472b4149806ac98b6cce5c
prerequisite-patch-id: d4f92797793802ce3021c4d1b45d2d0a94c51f07
prerequisite-patch-id: 992ab3fb9e82572494ff6f8af494ffbe8ba5cc6e
prerequisite-patch-id: 8baf34ed9789ac6a26f1d84648869131cea522fa
prerequisite-patch-id: 63f23c96115916e7707201d828fcab42ceeea385
prerequisite-patch-id: 7c166511597619b0f03043ce3a0a7237032bf7e0
prerequisite-patch-id: 35e2044bb5d5ea5d041ed01579943f6cffa6ee41
prerequisite-patch-id: 497b25db87c4c64173167f70d3a48154e44ca655
prerequisite-patch-id: d78941852e275e8b8ed03254a89324fef00fcf18
prerequisite-patch-id: 3cc8bd3f0886b6dca9197bfdba4bfa6ff360bf24
prerequisite-patch-id: 61890eaa88bcab4ac0aa2ef9a131d56ef8376f1d
prerequisite-patch-id: 097b002021ddd12f7b5180ccaa744ecce925f04b
prerequisite-patch-id: f599ecb06efafb8954fc9ad6d08a9819da860d28
prerequisite-patch-id: 484f86ad1f4fb5d8b2debfb1e7a8c7b6d0610f77
prerequisite-patch-id: 52db9f2823a1ad78ffb91f84911cd9963b295465
prerequisite-patch-id: d936469bba0e3720bf957995c0f842e56c815e85
prerequisite-patch-id: 9bfb8fba3a480dd5c8878fd307d96cbaaf521cff
prerequisite-patch-id: 13798977298ceb264b789af0eae36c714b0d17c1
prerequisite-patch-id: fc68338d9f90388d062471e46e9b691b00302c69
prerequisite-patch-id: 25e5e3c9ec0a10aa564b3cf32fe793aaf1e705b7
prerequisite-patch-id: 9160fde4ddf465965328264e443638a3ab0d09d9
prerequisite-patch-id: 20d490f27f569e5784d5501d842b4be8a4931127
prerequisite-patch-id: 9b7866c753c962fa8107eeff4d25ff40a546f329
prerequisite-patch-id: 653af78a35e216c7dc891a2d46849bdde83a5dfd
prerequisite-patch-id: f27f61687c1f423d4ad8f690a5114644364d26c5
prerequisite-patch-id: 705f5636837961012d4ad7cef93e3c06bf2828ad
prerequisite-patch-id: cf18ec6cc3cfb012e68e34f5319e5ca5fc08b04f
prerequisite-patch-id: 496d56c7025c252650cef84afef17c1cbe761011
prerequisite-patch-id: 849633dc3d51365926008341078b46e05349daf3
prerequisite-patch-id: bdd1c3731521ab2bec54b5757a1b1460ffa8a76b
prerequisite-patch-id: 7a4af5cc7a8d0c73fac182936c3034b8b97a1d81
prerequisite-patch-id: b6640f64140c35ef6614a47ac213d815eaacc385
prerequisite-patch-id: 619f2ef543c43d0e537cc5ec16a88aff8d08f7ee
prerequisite-patch-id: 5b7d7481f225dd506c53bc58d913b3dcf670ab3b
prerequisite-patch-id: 76b2c41e04d00656cff256f72fb81617baf75004
prerequisite-patch-id: e1e44b6305e28dc040a7495749756d39f086b407
prerequisite-patch-id: 23b6508f200dc43698cc460285ec47fef2e54a45
prerequisite-patch-id: b225a20694d23a03f11eab8c86a0a4b7b640a302
prerequisite-patch-id: e630536287ec238942c1948f8b966e15384fd3ff
prerequisite-patch-id: 327ccf1526eb31e0899de28c42c6bc687e274be5
prerequisite-patch-id: 6b4ab77555a60de86ad045538ea19460e0f65a27
prerequisite-patch-id: e9766937f032e867e3953ea53c47a5c385c68feb
prerequisite-patch-id: b6f9c8b0ac1722d3809bc48d89ace7070e1c447a
prerequisite-patch-id: e72efe42eec650c70433a02ce9c97ddeaef02d0d
prerequisite-patch-id: 9f17b908169ba05390869f3e35b69df00bd46d41
prerequisite-patch-id: b9a82d490d17914a2f80b0430cf4973dd93ccd2f
prerequisite-patch-id: 2563a1dcb7798936aa2c4a83dc1e1ddd585af241
prerequisite-patch-id: d4e0829e923f60dbf80b39493879280c8da2ff4e
prerequisite-patch-id: e42a585260f999d56d222e7b2f44405f6cfbc406
prerequisite-patch-id: e163a8cb28f70824dcde6295354df58a9ece12c0
prerequisite-patch-id: fb1ecde59655a27c8d3fdff20a66cbbe3f00bd6d
prerequisite-patch-id: 8cb6ee4b61ec57e6972ac1ee1253e85a7765deaa
prerequisite-patch-id: 499ac0cc3c1b5a08c8609ecc7d210c35edf01370
prerequisite-patch-id: 8434161ce61b9b53baf7c2643709e08bede8891d
prerequisite-patch-id: bf01608b5710ec0f4d041056988bf42e8785b7be
prerequisite-patch-id: 31a846018ddc61b29dffd1c56e8ef29c5aeb164b
prerequisite-patch-id: 1a0ab80ff0cde1bf49af90be105764d6504c42e2
prerequisite-patch-id: 4463e631ff73f48de1f761fa08fc2d3a0d02d2e3
prerequisite-patch-id: 1ef269c11829325108dc950ebb6ebbb0413f491d
prerequisite-patch-id: 244d96e340cb984ccaeb47ba1fc32c093df85877
prerequisite-patch-id: 6490e0a9923c2341d6aa355576fc178e830a10ef
prerequisite-patch-id: 73099e3b819e51e70cedf57b5de2da94161a789b
prerequisite-patch-id: 49c793919ad92fe3162b6cc8efac6762037534e1
prerequisite-patch-id: 53796f63653ecdf3f2a66d9cb3181546441d4ac0
prerequisite-patch-id: aa6fbd949a032b6fce2b599309f633393bc0bb08
prerequisite-patch-id: eb33de06c18bd23ef820d12cd5e340eda4fc15dc
prerequisite-patch-id: 9acaaae21935bd460bd45f89ac9e5b3c7be398fc
prerequisite-patch-id: d00c2306f14a27317918b63539f65df88ee08222
prerequisite-patch-id: 87cb389190ca57ff8250be430e3470b39575271d
prerequisite-patch-id: 2eaee2a99c51fd5a0df72b5253e8064d9facbcd0
-- 
2.40.1


