Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E44807B7FC7
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Jl-0004Ns-Gm; Wed, 04 Oct 2023 08:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Ji-0004Jm-0P
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Jf-0006mB-V3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rtMwrgacXL6s/GqflNT5jTfDuJ8IZbTwRnqRg7hyOAQ=;
 b=EQwlrVQaMLN1vhqNg2dZcrOLUK0K4prpercU+7MQVjxGm+/cVphHX6Og8fx1rHRQKfXPvD
 h63PBvD31UAJOUi/1r1gICR2+8uMudixrRyNlFtTp+EzcIZpmx4JfANzJD0gREc39dm3Kr
 z4moXXnAvefHY0/L+3rLeE8A2Kv6D8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-L00sZGE0NBqXU-mVAXmQxw-1; Wed, 04 Oct 2023 08:49:15 -0400
X-MC-Unique: L00sZGE0NBqXU-mVAXmQxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F517803497;
 Wed,  4 Oct 2023 12:49:15 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2938EC15BB8;
 Wed,  4 Oct 2023 12:49:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 00/10] Removal of QEMUFileHooks
Date: Wed,  4 Oct 2023 14:49:03 +0200
Message-ID: <20231004124913.16360-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

zThis was in a previous PULL request, but it failed CI.  Fixed the
problems with using:

QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(obj);

Before we had checked that rdma was enabled.

The problem was identified by Daniel.

I remove the reviewed by from peter for 2-6 because I had to touch
those files.

Please, review.

Thanks, Juan.

Juan Quintela (10):
  migration: Create migrate_rdma()
  migration/rdma: Unfold ram_control_before_iterate()
  migration/rdma: Unfold ram_control_after_iterate()
  migration/rdma: Remove all uses of RAM_CONTROL_HOOK
  migration/rdma: Unfold hook_ram_load()
  migration/rdma: Create rdma_control_save_page()
  qemu-file: Remove QEMUFileHooks
  migration/rdma: Move rdma constants from qemu-file.h to rdma.h
  migration/rdma: Remove qemu_ prefix from exported functions
  migration/rdma: Check sooner if we are in postcopy for save_page()

 migration/migration.h  |   2 +
 migration/options.h    |   1 +
 migration/qemu-file.h  |  49 ---------------
 migration/rdma.h       |  42 +++++++++++++
 migration/migration.c  |   1 +
 migration/options.c    |   7 +++
 migration/qemu-file.c  |  61 +-----------------
 migration/ram.c        |  50 +++++++++++----
 migration/rdma.c       | 138 +++++++++++++++++++----------------------
 migration/trace-events |  28 ++++-----
 10 files changed, 170 insertions(+), 209 deletions(-)


base-commit: 9c53d369e5903375a2e3358f739be77dcb8dae49
prerequisite-patch-id: a642744ae4cf6c0496c47e370c426ad158f1d310
prerequisite-patch-id: aa888e3b6edd04b8142899097e362bdb92b8419c
prerequisite-patch-id: f134dbc50dbd43b08b7c75b4dab823c1a825e3f8
prerequisite-patch-id: 77b81699e718874f1a1f155b4adc027244fa4c09
prerequisite-patch-id: 41c776c1177500c0c1a1525502ce0b77ddd4e680
prerequisite-patch-id: 1a9ae5b4fefff0fd0324c9c1d1a4251d84f2bb3c
prerequisite-patch-id: 9b3b48af87e866fbc0d4375c0f2efa2b42c25724
prerequisite-patch-id: 32a8c6094e436d5f1c6a5d69956fec94c8bb881e
prerequisite-patch-id: 5f79b00ec37679bc31053c6c528afd13f06b42f8
prerequisite-patch-id: 94adbf9f2c95b70a37509a6f94e9e7bf1678cfba
prerequisite-patch-id: 337f3f3da1ae49ddc3891b965e16dc21405ed4d4
prerequisite-patch-id: c98919dc8a8b6269e506ee9045d14b231d18ab74
prerequisite-patch-id: 9620d1451b9f946b958548dd5a0dba0cbd563980
prerequisite-patch-id: 33eec6ff9be317b761828f462b8bef8b737b743f
prerequisite-patch-id: 7519631f4e405548fd1364ee9be6bf7441856034
prerequisite-patch-id: 0573e7503a2b4af033d6d891a335b17bde68fc32
prerequisite-patch-id: 31c1a5fba0dcd5ef4c2cc1d840782ac6daf3093b
prerequisite-patch-id: 9ccac4c4cbc449ac4b134dae6acc0d947db53c6c
prerequisite-patch-id: 45fc06b427ce32044a44beef01624f182d55e74c
prerequisite-patch-id: c8a09ca12169bbe1cbe78498a96b67bef54a3b83
prerequisite-patch-id: 96b55ca8d295baf92ca5326c2e1c2ff034f209d5
prerequisite-patch-id: ac07a42e73b99250240075db43e2346a43861b53
prerequisite-patch-id: 463ed3874c2105bc49c228a704f0f64082666735
prerequisite-patch-id: 6e0a7b926b1d1bd121b653b9af31bf86e2306d75
prerequisite-patch-id: 5a14bc1c342a5e106e9f5fc0dc3e9efe6115809c
prerequisite-patch-id: a8f2864bdc1e505d05b342c206a78f978aaaf256
prerequisite-patch-id: 192db2ae5a4f76ebbd8d4eba305c9ca04c238f91
prerequisite-patch-id: 0388fe2b872665f31e07d6ace2f6fc8828a9bd75
prerequisite-patch-id: f39efb2c37e5c44cdd6e0a9def244fd1b1983d15
prerequisite-patch-id: 5fe70f28e0e8bfc98f46997fe9e218f1b0760a74
prerequisite-patch-id: 705749e11dbcb0385a9271115db6de84e862d849
prerequisite-patch-id: f26a45e1d2a27ccb6f29389fee088c6c3cc34db8
prerequisite-patch-id: c51c6a79424753f2d0f91e972f6cc5541524b08a
prerequisite-patch-id: 55b8547b8d1b5e2fea645f9c7c1139579f496c7f
prerequisite-patch-id: afb1d33038f452ba2a6e8a941d1d5a1be19b7b60
prerequisite-patch-id: 1e08786cfc6e212def9dcccfb02cfb6367d50518
prerequisite-patch-id: 744b9bed0eeb611819c6ddd5df33f971f2f9dace
prerequisite-patch-id: 680112f82aec96983afc080a7d16b92bfed02577
prerequisite-patch-id: 00973779cec3f2b976055daa4192163b7d95b65e
prerequisite-patch-id: 18482ec2543e33f789e7a9c72e744af93ef33e9c
prerequisite-patch-id: 12ebcd6e922a83c12cbaadf9b4e6cbeba5af28bf
prerequisite-patch-id: e29068e93e63df655bf26d925e84cf5cc29b7ff8
prerequisite-patch-id: fec6297dfcd84bc16b16306b7d8bb327d1ab8203
prerequisite-patch-id: f822923d0ba068eff8f1ce3e9f64b3afffce548d
prerequisite-patch-id: caa125228de004ef52b92506423375725ca40e05
prerequisite-patch-id: 07c86a48d824a48013b7dadeceb1e1e0f92da2f0
prerequisite-patch-id: 21455c4c0686e02fa8391118abbd80092c3636ff
prerequisite-patch-id: bda8b62f586f3b8c0dc1654e29e41dacce3e7f22
prerequisite-patch-id: 7a6426f0f2f999580165d05aa3654314885f81cf
prerequisite-patch-id: 63b8ef272c9433df875763bd925d8509b54a7fae
prerequisite-patch-id: a276e679489d4c5d86843be460711ca2005e4942
prerequisite-patch-id: 573056cfd0d5b6010c0f641fd8d060c955516776
prerequisite-patch-id: 374e15b2f919e2c895cd67713bd1f505d47f6b6d
prerequisite-patch-id: 93de7caa8e8adbd91399fd328954a5235989e6ff
prerequisite-patch-id: ac4e8b8c471d825a7ba70a5ecb229ef4d422ddce
prerequisite-patch-id: a209f80f32c2871bc924f69b4990334e864e4beb
prerequisite-patch-id: b527a3384e047b338793bb4d72fc05b36a19897f
prerequisite-patch-id: d7818b56800afc3f8ba91281c010645192696ee0
prerequisite-patch-id: 9afa5b1d472470633a71f170b960eb71d7ddf9fc
prerequisite-patch-id: f1d30c2ac03b69114f4fb8c2da7ce7ffd3aec5c0
prerequisite-patch-id: cce34d6f1318ad5003f6d9bd50267bc269959890
prerequisite-patch-id: 2b5d29a274dc110f482d4855fbac8afed0eefc77
prerequisite-patch-id: c286c00b532c5bbc5eb47ff2eb99e96814a4557e
prerequisite-patch-id: 28ede7bda160e4558b17ee357788e5c8aa2c3924
prerequisite-patch-id: fdb380904bea7c8ad802ae3e7b49d79607fb86b2
prerequisite-patch-id: 986206d231f3c0f0c0f0e9752d998fe40d068daf
prerequisite-patch-id: 62abae9d4dac972dd5c2af94478f8203a3248702
prerequisite-patch-id: 4d5f9801ef51983643aa1e9eec6eedb043f8478a
prerequisite-patch-id: 0601e111d160488a42f280047742345f822d7902
prerequisite-patch-id: 859cdba61dce53d4c16610404592534950d97e96
prerequisite-patch-id: 7e7d10a05eb0688eb75058d7aac83a8eafb6d045
prerequisite-patch-id: d3fdb8829d5264eb825b6a5efc9373d517db7368
prerequisite-patch-id: fbe0f0d93e8f6260b366c205728a33368a57311d
prerequisite-patch-id: a39f7727cfc2bc6e14d6febe7e53f07458fd0b56
prerequisite-patch-id: 66b3e7c522420fae71cd72443761cc449e8c03c8
prerequisite-patch-id: 288b3d5062b66024d71e8a9a9089e133015c3253
prerequisite-patch-id: 082cfd7a93ebd1715f318645bed4c205cced6e6d
prerequisite-patch-id: 8149a8997c10700d30bfca4ae60686f09caf5ecb
prerequisite-patch-id: 819c8a90c902f7a7680ccb7a52ae15a28ddb88c5
prerequisite-patch-id: 3724f8660ecb024be25a0c1aaabb17d7e6f80998
prerequisite-patch-id: 579e9b84d69f3ba6aae0d7b09a65e690c2424351
prerequisite-patch-id: c3d5d45a2cdaf9cf7c8edbb351763442412957f6
prerequisite-patch-id: 80a08d3f929600a116ecfa152ad53eb60fbe34d3
prerequisite-patch-id: c5e0e1e17478377169e000b862c4bb597df77752
prerequisite-patch-id: c3c48e3d692f4750eada7d79b76b457c4a853b63
prerequisite-patch-id: d24535e03c26ff321b7e297d4f7ea7e9df4664f7
prerequisite-patch-id: 65e78109d58c9207e065cd6c3627ac449424b016
prerequisite-patch-id: 7001c8324337beb4aa308d824fd5f9a34e7791ba
prerequisite-patch-id: ac02f1952b0aee1a93e4b1d3fe8f43f0e339d818
prerequisite-patch-id: 72d790c4155c298b579336acb47c83ff6653589d
prerequisite-patch-id: ac19c959876a8bbb9c1882d8e9ff037f184cfcfa
prerequisite-patch-id: a56fdfa409932c69e33efa8c76f602e208880c0b
prerequisite-patch-id: 6d82a34b13088e4ce2f0dae93f32b9f66bd4c393
prerequisite-patch-id: db2f73c97a95d371d3fdb207515cce508c9989f3
prerequisite-patch-id: 89e1ac3c38860cb8cb04d71e20e9c9a65a763e3b
prerequisite-patch-id: 8a375e7f1c37bf428212a259d9cc1036d8d1dc1a
prerequisite-patch-id: 1c7a7f19a135e91ab9a53679b6cc6131b99ed517
prerequisite-patch-id: 4f7d1e5b103a04dca60ffd19f36e80e8cb429e53
prerequisite-patch-id: 9c4e4c3b46d322f47c6308fece957798f25eb8e5
prerequisite-patch-id: 9c34d1f77a441e4da38776a99fdde06e05df86ba
prerequisite-patch-id: b75cb81e6367165531b7d7b0580b38f39ef217e3
prerequisite-patch-id: cf9a2ca06cfbc952fdcb97354b7afd1a197fd7cf
prerequisite-patch-id: c0fc4ff42f0442ebd370524d70e9bfab875b6fb8
prerequisite-patch-id: c1026f17e91aa65896b6a9718a6c1561786a0dba
prerequisite-patch-id: c493c9396e56f8fe7450fa7793c4d76e2e24d19e
prerequisite-patch-id: ee1b773a973122e94d9e1575ba0b0e624b74bea0
prerequisite-patch-id: a550ae70e05edf36818d324dff3e69e119a67a66
prerequisite-patch-id: 559a8ec4ec570962130abab2e78233e3c6dd075e
prerequisite-patch-id: d5d40f38fe5a3791577141d5bb8638e2bc538f2f
prerequisite-patch-id: d93aff176a06e84a239d6c108fab7346bb2ef255
prerequisite-patch-id: 5024e0351a3325ed26a9908719962f769e4aaadf
prerequisite-patch-id: 86db074f818e88068e12bd99457686a407c511e9
prerequisite-patch-id: 56ec97f48de244067f8f7d5118bb5c23767ec8fb
prerequisite-patch-id: 1e339d1ed61e0d16148c0ad4b121590ff9a7de79
prerequisite-patch-id: 836aa30452015793da4f08745747b6da9f7416c6
prerequisite-patch-id: fcc50463c977c00c058c18cb2b2c84361307d0c3
prerequisite-patch-id: 092a7751bc81a3d88903880a6ff99195bc48a219
prerequisite-patch-id: 4bfdc23c62168ad668e8ba06a882b4e43cf25e73
prerequisite-patch-id: 6932e36797fe1dcd0964032d4fb302147d8427ec
prerequisite-patch-id: 7761523114e7ba32f38a2a20182a1575a7fae343
prerequisite-patch-id: 47263c10d2f7391f6ce0f10e8c3a76dd6ad29a64
prerequisite-patch-id: 422165caeeb95e85c4374a23d73f35d4c6320e94
prerequisite-patch-id: 87beb878745570d830ff586303ac05a7551ab921
prerequisite-patch-id: 161a92193b9b5104d75917ed4982c839fbfad936
prerequisite-patch-id: 6e6737a09918a406bfb2bf622de289c16ced570f
prerequisite-patch-id: 8d4fab2420801c339f6f57e74fafe8f77b838644
prerequisite-patch-id: c19fd26575e6eb1247fe12e7001ad0a98eeecceb
-- 
2.41.0


