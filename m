Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F67C5E75
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfvi-0005DM-Lp; Wed, 11 Oct 2023 16:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvg-0005CC-2q
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvc-0002yI-Vh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ua6xmFWU4iOC60Y+zpJTNsVRJO7waprrZtgOleH1kPE=;
 b=Dwt33E/bI8+r9asoQA4vjr6GuWHuj4B4iyn9Pe04Xmj7NxzHDAnVpNhPJBJu0lDOz4E2X2
 RxvGdUR0ZG565+unm3wIEwVg0rcdVbJ+U0R9RiAH8Oirzhj5eYPGlvXt/Z1XVxXexftU+1
 ZuKWlSvOrgu9ZDHWECf+kLSbxzBBvtI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-zn49rY8zMVCtcy0b1CnvGA-1; Wed, 11 Oct 2023 16:35:30 -0400
X-MC-Unique: zn49rY8zMVCtcy0b1CnvGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB7329A9D46;
 Wed, 11 Oct 2023 20:35:29 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58F46492B06;
 Wed, 11 Oct 2023 20:35:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 00/13] Removal of QEMUFileHooks
Date: Wed, 11 Oct 2023 22:35:14 +0200
Message-ID: <20231011203527.9061-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In this version 3:

- rebased on top of master (markus changes affected a bit.)
- the patches that need to be reviewed are:
  2-6: I have to do the QIO_CHANNEL_RDMA() dance after checking that rdma is enabled.
  11-13: I did some more cleanups,it should be only style changes, no
         behaviour changed intended.  I found that bits while reviewing markus changes.

Please review.

Later, Juan.
 x
[v2]

This was in a previous PULL request, but it failed CI.  Fixed the
problems with using:

QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(obj);

Before we had checked that rdma was enabled.

The problem was identified by Daniel.

I remove the reviewed by from peter for 2-6 because I had to touch
those files.

Please, review.

Thanks, Juan.

Juan Quintela (13):
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
  migration/rdma: Use i as for index instead of idx
  migration/rdma: Declare for index variables local
  migration/rdma: Remove all "ret" variables that are used only once

 migration/migration.h  |   2 +
 migration/options.h    |   1 +
 migration/qemu-file.h  |  49 --------
 migration/rdma.h       |  42 +++++++
 migration/migration.c  |   1 +
 migration/options.c    |   7 ++
 migration/qemu-file.c  |  61 +---------
 migration/ram.c        |  50 ++++++--
 migration/rdma.c       | 260 ++++++++++++++++++-----------------------
 migration/trace-events |  28 ++---
 10 files changed, 218 insertions(+), 283 deletions(-)


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
prerequisite-patch-id: 6823bd96ee68beaf88980346b1e4a77acb6dcd6f
prerequisite-patch-id: c5bfab495ed8a885b489c582a294173598c02a25
prerequisite-patch-id: 2b4537690434218704ea75f557b73c97f5a8ac52
prerequisite-patch-id: 84ae6708e36ece3785a10f5ae1a95e0b2090507f
prerequisite-patch-id: a6a7fab2ffae7cc6211f9609ca9ce06cd2630aca
prerequisite-patch-id: 1d9485db2af9a94d19da8ff30f02d53cb9a82e73
prerequisite-patch-id: 68fd3b478a69bd2c0e69345b192696ad8d339837
prerequisite-patch-id: f6a30cde148e9b16e61b30a5619a1de97f8c15e7
prerequisite-patch-id: 2c3754fb098f74eb43e076ea1664b6a199fc19b7
prerequisite-patch-id: d7e93c2c8d79f954f0e9befc9e968147ead93895
prerequisite-patch-id: 1e8b3c0bc3480d5e84b1174a8340a233f496feee
prerequisite-patch-id: 8299ecea6069abe2a487ae74613368a5168f5a5e
prerequisite-patch-id: 00993842d3771f406c8ad7ba9286874483937e91
prerequisite-patch-id: d36ee7a372233c9a4fe79e3c8c37e0040bdf366b
prerequisite-patch-id: 741c00ba81025ca4d818d0c4836e4893e15dff55
prerequisite-patch-id: 92f98da641d37cdeb5dbb0e0976c52f184dfd3a8
prerequisite-patch-id: 6144c172af573ee4d49dbe1a7d1b137d64fda833
prerequisite-patch-id: 80dab0ced0453f03a6d5460e928d8c3361482fae
prerequisite-patch-id: 0eba7039a4d22f2c75190675dcaf830198baeeb7
prerequisite-patch-id: 42bb1b5546325f459357ccc6a3f98616fe81e36a
prerequisite-patch-id: 9641142c69c604842afabae1ddef46da7876037e
prerequisite-patch-id: 7cf8ebf37fec9b02f25951d0b5327c4fc6c9ad65
prerequisite-patch-id: eb37d1ca1c36a093e20e42a91e37bee7616344b0
prerequisite-patch-id: 3dea5fee8bd1e1c4504c33ea304d395f3c8d24cf
prerequisite-patch-id: 016c43d63c306df0e933258c9bacade75c2599ad
prerequisite-patch-id: a6d45bb4c9a49098ef74d01a296ef25d9948df31
prerequisite-patch-id: cd4ae219d9550160dba1c1b3b65b5146ff541c8b
prerequisite-patch-id: d039b3038ad90215bbbba8629075d0c79325a402
prerequisite-patch-id: d08941930a26dbb0986bc1749eb91cfcf11c80d8
prerequisite-patch-id: 04499268709efab5a78c57e1bf702901b6aea223
prerequisite-patch-id: 245477bd0790be8320fd42d79a769dacb6ba649a
prerequisite-patch-id: 7e8bcd6706fbee1937359a1de1f44db98019d204
prerequisite-patch-id: 574d32c9b0a762ef745c8ca4cabb4f8dd9d664f7
prerequisite-patch-id: f5b85360d5fd768ee3777f77be718b8fc5e6898d
prerequisite-patch-id: 0237bf2072665b87b122fdfd1d2780a9953aaea5
prerequisite-patch-id: 623e26baba4ab58e6db7e5fab55af21cc703b47e
prerequisite-patch-id: 33b5ddb95318120d45bf52c4ca15c2f9d4e8c21f
prerequisite-patch-id: 1e44d6ced4b5a40b6dc129e342d652f9b0bf173d
prerequisite-patch-id: f544e3070b70cf9beeba9a06472dd288a4a6a629
prerequisite-patch-id: 59b79fd9a3197bf6ffb1a754df5132c183eff987
prerequisite-patch-id: 7fb9863bb8b966cdc48ba84bd481378be2b3ae9e
prerequisite-patch-id: 88cd18b39911c65555330fdc101fe4c77ba6c86e
prerequisite-patch-id: aaac7c69584853923f3cf52d53114253a8c66492
prerequisite-patch-id: cba200cea7ac738363bc67ecc80f51603bc3d879
prerequisite-patch-id: e8b75d23ec12259ed71629c51354e2d87acf1cfd
prerequisite-patch-id: fd1eb9163547061cbe869c3d396a9e938681975c
prerequisite-patch-id: d30fff3c01862f14419efd1014fe0c6f2141c21f
prerequisite-patch-id: 122eab56e2d951665f2afeba063690a81d14a065
prerequisite-patch-id: f4d11e0ad1dd956090bf0f6cc0151a2d61422182
prerequisite-patch-id: 6c37b25c7306ef54a304e7b5189e8e0197bd264e
prerequisite-patch-id: 0559b3b63b97904c706ce5e787b51df67a84ac98
prerequisite-patch-id: 47145f1803b70f8991b35a9e5a97bfe24281980e
prerequisite-patch-id: aae60043f4a4d5379f73ea4c6a32d0ee17bc07cc
prerequisite-patch-id: b2b0fd1503c6b0e82d65cdd045e05530a3f61825
prerequisite-patch-id: 3dab59dcb5c86f5af8aef1107e36af6331131f97
prerequisite-patch-id: c8c08183539df9462bad7487f6622ee3007b8aad
prerequisite-patch-id: 66a1535a62accced57d682e2fb5dd5dbfa04c0da
prerequisite-patch-id: 1215c931d4d2ad04040d130a45d8727e45ac3a41
prerequisite-patch-id: 720312ba274670c4e33b731f90ce45704d2885d0
prerequisite-patch-id: 93ce6e4af5d78ccad9bec9e5ad23ea816f85707c
prerequisite-patch-id: 0990e21c9630514ba3cf595522a077bf4f40828a
prerequisite-patch-id: 63c55126cfeadd699b85c7d058afc0855d3c2e3b
prerequisite-patch-id: 02e9f51ccb8cbb4a6eed9d849fbbdb331fb44629
prerequisite-patch-id: c40c07cb63c3c6843cdfdf438870ca0537365757
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
prerequisite-patch-id: 34d8eb8e21bd75dde0f11c4ef81ebf13f7fdd8e1
prerequisite-patch-id: 25bb8888eefda70790bd5a7fdba63ebedeef779c
prerequisite-patch-id: 27e5d8496d033586a9d11baf1a074fa002ea7994
prerequisite-patch-id: 80c1d7013af023120c0d5433117ebaa74d2f7cc9
prerequisite-patch-id: 03970a0c08d4508d9f4a42448d2e622be0a2e70c
prerequisite-patch-id: f11c2b2276d6976b8eb884edcb0986e270c45e38
prerequisite-patch-id: 2b6db66aaad79983a369222bab3b06838e0c70d0
prerequisite-patch-id: 41a2854375b05b4799f35a3bb463b5c50a36f632
prerequisite-patch-id: bb8b2a51bf99d8edd9870eedb7cf0f4978a4322b
prerequisite-patch-id: 26170a7c70e984354351d3821e8452baed286378
prerequisite-patch-id: 0fa6ff823cf980db3db7c56ceff8df325725023f
prerequisite-patch-id: e03a6f772cb1daaf543d794f77ea74d8c9b6f025
prerequisite-patch-id: af08db276a0f6739dfa2fe2265f0201855e116ba
prerequisite-patch-id: 8840340812d54380cd9001ae14a06db11f0ec95d
prerequisite-patch-id: 5ad7f78a7a609dc63df5f620ab77319a3751eec2
prerequisite-patch-id: 12b8fe32f51ff9d7ab27c4b7932707617538f981
prerequisite-patch-id: 80dcfc29089e21ada005ec8a1a00ff5b24c238dd
prerequisite-patch-id: 9d8ad7691436c6eb5f6bf1cd300c454f474c3cf4
prerequisite-patch-id: 0c1d3f580c0a978243c5f2dabb8db3768cc1f42e
prerequisite-patch-id: bd7b56fe76bce49390fe9d38d3cb4ff49886a945
prerequisite-patch-id: 309c92a23e990d2fb6751f496eea41a784ead810
prerequisite-patch-id: a7446da60e286bc718accda0986c9c5487de5b23
prerequisite-patch-id: a16f00c8bca5cf3a686c6181053dc1fc545d2b0e
prerequisite-patch-id: 300aed2cf3511cc17778050ec88248de90ff413c
prerequisite-patch-id: 1ea8c6d0b80f1e96ceccb0069516cc09ccedecc7
prerequisite-patch-id: a4a02a9d69f70c0c64e2867e715dd01d9fc36a25
prerequisite-patch-id: d4cad4f931e565451cbafd211d2ec71f1415fd3b
prerequisite-patch-id: b71059dff0fd4254a363d9e069f2e4f171f1a017
prerequisite-patch-id: e7e698d80aea66c7603939267c0c8bed2f1520c4
prerequisite-patch-id: 5c07460effcda2cd96da8699b6b6f882fd9d657e
prerequisite-patch-id: 604ba40ab99a70d5da95c7788442aa09f9ec4363
prerequisite-patch-id: 8daba8c0c684d375e32ce8004d62195ba323d625
prerequisite-patch-id: e933622649b3d9c135b197bb610254d1df76357c
prerequisite-patch-id: 6261e03dfd2a03cd99dc3a14eb72ef1b9318fa84
prerequisite-patch-id: 5a6a9be47bf4001c61e80679ef5e78d883dae1a1
prerequisite-patch-id: 5955b0dcae54b25a689d613650c94fd600df5264
prerequisite-patch-id: 9d59d8e351dc0ab754048369c258420d363e6f8e
prerequisite-patch-id: c195dc8d9c2bfdf177a21322abfdb0687a316280
prerequisite-patch-id: 3a23b4162f6c6ffe72460f86999b99c0ef72c8dd
prerequisite-patch-id: 96ea106137936418531b176b3df8a95a7ecc73d9
prerequisite-patch-id: 03bafab7c9ac1f2d541ba0c4ee782564cc627053
prerequisite-patch-id: f57098aeab32c09af19ef25689fd4cf7debc48c5
prerequisite-patch-id: 46e18a2974ad72068bbd95de6e1479f9e7f39b28
prerequisite-patch-id: 177a9678b43144b2fa16c2dac978cb1b02bc050f
prerequisite-patch-id: 7bb75c1679ad2aba67ed08d717a6861758d3353e
prerequisite-patch-id: ce7580a5904127563f201afa0df5f11516322988
prerequisite-patch-id: de15dbe8d7020945ac1fe0e5ea2227acb0126871
prerequisite-patch-id: 16124dc834c3c0be7772c500d8bc072ae88ebf18
prerequisite-patch-id: e1a1a39c8d05d8ee7af281f1368ac24199f1a64f
prerequisite-patch-id: 646cfd01f7123e7177aa41dfa3304a52886f1391
prerequisite-patch-id: 52f698b374451a7a5fc0d89ca7e4910104664a61
prerequisite-patch-id: 06477098a3c103b6e930e76ea988f8cd9751f14e
prerequisite-patch-id: f8641ec86e276dbb9b8573570929296d78a496be
prerequisite-patch-id: 62eb4dfeb345265921e0a3fe63c8b03379d8e1f9
prerequisite-patch-id: 85e2283dabcbaa1a4e6399e6a3fdbbdcf5fe8df6
prerequisite-patch-id: b034427e1d468d2c3e68c575cb223aff07c27f18
prerequisite-patch-id: fe1c96869b7bb48ad946fe8960dd47236428316e
prerequisite-patch-id: ed618da2baeb745656bbcb85233717f4e8a16ec6
prerequisite-patch-id: ce494bc64fdc5d8f5349c4956b2c2c28309d24d7
prerequisite-patch-id: adc40223384923e68ffa1cbf04fa1109031fd070
prerequisite-patch-id: 3558ec675825f2637ee1ffc2803ffe4c71e9adf1
prerequisite-patch-id: 6a923c5060c6fb310c3123ab6934b7146c1fa62b
prerequisite-patch-id: 2ddd27b3bb34dc874d72a213888f2baa08066cfc
prerequisite-patch-id: d1e7476dd13b50448f23d05f3841a3fbeec2a29b
prerequisite-patch-id: 8edc85731afa09ab3ead2801cec4c6da0c155ce5
prerequisite-patch-id: 11d23086508f828362c1368963068aa3f8176bc9
prerequisite-patch-id: 226743af578ca7ea5536e6b969c4320c8534efa8
prerequisite-patch-id: e1ef91702838bb02342a4bcda1edaaf88f5be25f
prerequisite-patch-id: 6fe048e362a5752d4e35b5704f64f7306336013c
prerequisite-patch-id: 8d0c0b4964bc844721e75fc9d61e5a0ea9b7007a
prerequisite-patch-id: 0667214d7a2274b881b28290566fe7b42a40c707
prerequisite-patch-id: 5698bae54385032156f997c3d142d8f3ba2082d9
prerequisite-patch-id: 5b63eb3b7a6752ea45faa4a1b79197c74796478a
prerequisite-patch-id: 5e3eebf376b7946e3b1472efdc65fb8f0262ba04
prerequisite-patch-id: ed44519538434354dcd57ed1471921dff42e48cc
prerequisite-patch-id: a61e73ed91b2e43fb6a4605e237e2f5234935788
prerequisite-patch-id: ec74c40d81a69bd9def8e72c0c2862e7bfa34392
prerequisite-patch-id: 28cc87e81b9f18f6b4020527aa2667b3c5a08992
prerequisite-patch-id: 575325b0c59416c456f785c571b8cbe6832ee3c9
prerequisite-patch-id: d293132c07c0aa29eb6daf6558b13c0994f9465e
prerequisite-patch-id: 50da47e08987ac369dd3c537b199780b87bd07f7
prerequisite-patch-id: 2d5d49b0297924b6ae4bedf549e76a53d09ff241
prerequisite-patch-id: f705318953cee2a88fa8539c50c5c7cb34b47e81
prerequisite-patch-id: 6556b25559c8f2d9221119fcef7a6f8b0000bffc
prerequisite-patch-id: 15b336dd016a55286b9a0cbe66c3468042c6988a
prerequisite-patch-id: a2d3f2b0756961a6dee938e0aee80af6a5107462
prerequisite-patch-id: 32242a624531fe2761057a310abe3974d7b72932
prerequisite-patch-id: f6c7dd04f61b64cf8ed50b97e1e52c856c4bdd58
prerequisite-patch-id: d942269a0d51d635a3c0a24d3cbbeb07d7ba0cd4
prerequisite-patch-id: 4972c66c943f28385282404907731d60a15ae6a2
prerequisite-patch-id: e01bec67b49cb36f03b3faa8b7cd0025829e9967
prerequisite-patch-id: 12b4099c12ab1052cc183679e4dada4d20e32f9b
prerequisite-patch-id: 57dbd88e3f1b723da124ed32eff9209724d4fe36
prerequisite-patch-id: ca74756b672853a56f0685d52bdff3b5e9fde8ec
prerequisite-patch-id: da3d809bfccc44920952ee0efc4ef58bf33455e1
prerequisite-patch-id: 64a058d6f4376703f3e189116a607399ee910938
prerequisite-patch-id: 791c5706b52d5681207fa31bda57b12737dc62bc
prerequisite-patch-id: cf4cde0f39206b724c4645e3ea9cfa6956ad6a41
prerequisite-patch-id: 5c6248eea976632d7282cfddc084aab044f31a88
prerequisite-patch-id: 51aeac7010fb3d4485cbf7a7d786a4127bd35974
prerequisite-patch-id: bd0b9c4e94ec6508289c3d42c17fd5047f15d159
prerequisite-patch-id: 540cb2a36b0263712c010f5c257b1bccca217fb7
prerequisite-patch-id: a4366d2cbd802c8b19b1391d72c80e1ac7f20bb3
prerequisite-patch-id: 54cb6a8a063b2b9ad6173e581da70db9e93792ed
prerequisite-patch-id: 3abda2f36b2abcc0efe48764a57b5126800e3416
prerequisite-patch-id: 12145df8756446dd6b83763e2796ae5e269e1408
prerequisite-patch-id: 74f48d1ef15f6c8325533663b4e19be851daad93
prerequisite-patch-id: 5c252ef4bfd112cbe7bac4b1f5a9ab5f57adce7f
prerequisite-patch-id: c6690df423dc505938a5469c8f5519ea6dbb4c44
prerequisite-patch-id: 14daac78b63222cb227e2431f5acc3891e4faaf7
prerequisite-patch-id: cfd531e736925d8e761aa40eb20b9fd785beaf30
prerequisite-patch-id: 0b41879a2cf98f43aed1f95c52cf0cd1a86d7f4b
prerequisite-patch-id: baa1aaadfb98868cd9f1abb2cf94884b1a01a526
prerequisite-patch-id: f93f40b3933cd666a46714fd75aae647e2f8f423
prerequisite-patch-id: 40afc08766f52958eefcae46f722b07693573515
prerequisite-patch-id: 22e0a7ac2de82492c7c4f29b99e8d7829e8eaa2e
prerequisite-patch-id: 206e1271c5bdf238756a25eb737d9b238eccea9d
prerequisite-patch-id: 1a24cf62c5207a6b25d44333c4987ad6e6fd8666
prerequisite-patch-id: 399290f9249d59a827b839fdef2516ebe7adea9b
prerequisite-patch-id: 3b55efc67157b2fd864c4b4d95cc40b81abeb3f5
prerequisite-patch-id: c445f642cea2226e88d7bda1c9290a6bf2661aee
prerequisite-patch-id: e84efae9e420a5bdaa338990e3d7e5fa69399521
prerequisite-patch-id: 878dfcc403394df26a16017556c111de96caaaee
prerequisite-patch-id: 5c76fcd52fee4095d2c85bd8ea5e24b2c52435f2
prerequisite-patch-id: f27240b7f7fbbd7d64d062994618c62b64a99963
prerequisite-patch-id: 03937b6b34d7724d50f60d9a892aee352a038f8b
prerequisite-patch-id: 7f11a5824cc7051155a7f2630c5a892008739138
prerequisite-patch-id: 86459ebd6e1874265a2d0f9d820c17ef7a4c1100
prerequisite-patch-id: 9b3484a93206a1e2acc21ef5b5fe1f59cc1119b4
prerequisite-patch-id: 44cf1b2a2e69b349f6ec77ae232787cccc706374
prerequisite-patch-id: e9ee30adae84568f8b4b2964092d381dd59f4495
prerequisite-patch-id: 079be170ade5c38c85b41916d0925818ed169bf8
prerequisite-patch-id: 656dbda52ae8f30fbf8234768695eab3563f8efa
prerequisite-patch-id: ed73007e467a652b2805814461f208f6d599fa92
prerequisite-patch-id: 26605334fba845211ba8c34f01e7b42dcb7159a0
prerequisite-patch-id: 3359e913bfa87bd7dfb184d05c10391d63840856
prerequisite-patch-id: fdd714f52d4e0eeecebdcf26ce885eafe622d5f0
prerequisite-patch-id: e4c9c22de0668a0093e58ed505350adb765be101
prerequisite-patch-id: 7085ad6bbcffaf044ad3d2be7de69c0986e907a6
prerequisite-patch-id: def93f1825f3ea005340708cb6d66c0c72ea3f08
prerequisite-patch-id: ba54a3757ca8ce22d1d3680637e61b92354e2145
prerequisite-patch-id: ef2cbc9a035206dd254d7d593f85520cf46c89bc
prerequisite-patch-id: 4053a82bda4d675259e50e681b585d21deb8a3f4
prerequisite-patch-id: 020948bb4287a1d3948e374bfcd1c28a54b2f089
prerequisite-patch-id: fc32dd217075ee911cc471910fad1dabdf22b460
prerequisite-patch-id: 303535557c2e0481e3da00cafd28a96bbed3bf15
prerequisite-patch-id: aeff03dad7186a69e23838c55033855348c4215e
prerequisite-patch-id: a750c1baa5364117a38246b95b796613a1f17488
prerequisite-patch-id: 7d1c6734c99325b5c112a9ba86e23f70eb9d1d5a
prerequisite-patch-id: b48b56de03cc6b4c5eb507e292425f1a6d2bda35
prerequisite-patch-id: 04f179d074713c7fa971725b288481559807fdb9
prerequisite-patch-id: 4993a43580d07e1ebd0eb89021dca20131168abd
prerequisite-patch-id: d995de72b856764d0c08200d318de138824832d3
prerequisite-patch-id: 2e79dcb5c0234ea43e417a97c1b0a67447052e0e
prerequisite-patch-id: 29d16e89d3ef1ab2991f78c5b8109dcc952aeda0
prerequisite-patch-id: 0569786ca769d286dbec202177cc87e0e1477613
prerequisite-patch-id: 5836a3680ca0cc615f980c8bd6e6c66fa0136b7a
prerequisite-patch-id: 467de9f897ecb6df2e80ebf801253a47369eb724
prerequisite-patch-id: 1ea8b1461386758cd19f8b10a1b083f124df3759
prerequisite-patch-id: 72a39381c4bd71587964f0f248782ed6ec2980dc
prerequisite-patch-id: e6bac660218cc79c9715a21077668344ec07654a
prerequisite-patch-id: 974c6e842fafc6c1b72ef738eca44c0c0ab7c6cf
prerequisite-patch-id: dca81bd632b40ebb98be6ae63bc52e26da7a9529
prerequisite-patch-id: 365d9ae519abf820f4b1a5a1a62dde1ca8aa5959
prerequisite-patch-id: ebfac8ea7d7066ca8b74cd380400f05b3522bb75
prerequisite-patch-id: 159e256bc5355d0c44071727e267994045f30d5e
prerequisite-patch-id: 06bc44fed8381627fef2c617f8d51d3a3fc1a7f7
prerequisite-patch-id: c942c4f97c3cfe4d9fec407ed5e617d61cb265db
prerequisite-patch-id: bb7663158d8cdd5204026ccd44427a39314ab61c
prerequisite-patch-id: 45fc5b84d8b6582a8a1c63f7bdd58f8a12ce2097
prerequisite-patch-id: ea144131a78bd4845e059f6940b77f9f629441fa
prerequisite-patch-id: 0a1df2069218bf5fbed5eb34ebfaa91ab735d375
prerequisite-patch-id: 5669286f5ffd11ebe60c8b3c195df4807fa3046f
prerequisite-patch-id: 032e77c81d8d5b46d150b772b48c9fe44c59417c
prerequisite-patch-id: 9c187e92782c9e10cce20fb85abb9313ac8dca34
prerequisite-patch-id: 04a32a1f4f04dd2be4990aa932b89c13309dff5a
prerequisite-patch-id: 12ae21d99550ab3017e061e876a54a7813b98a24
prerequisite-patch-id: d6ab1a1e0543e6a811fb8660bff7b3c6c9fb79ae
prerequisite-patch-id: cae77a161c6436e273443a60ab89ea2b9caadcae
prerequisite-patch-id: accc6aa85d96048d9573f6024ef19e892fb771c1
prerequisite-patch-id: 0755a15be619e22a1807663a63b2d4aaa865c39f
prerequisite-patch-id: 0fda70e84a1f7a8826f327a8903216d931350313
prerequisite-patch-id: 7521c2674155ee33c6fd4b13433dfc37b7da1545
prerequisite-patch-id: e35f52d3aaf92e494278ab198cd9daf41c87be05
prerequisite-patch-id: ace24a892268d39e125268de1539b13e770b7dab
prerequisite-patch-id: 5088a3dd5c582bf94a0192a561082ef8d358626d
prerequisite-patch-id: 4f4cf713036961e5ee4c2c083494e41ea878eab9
prerequisite-patch-id: 993c013205edfdfc0cc02dd9c2d84dfafaea7f2f
prerequisite-patch-id: 479940c84f0a3912450f8c5a01f8fa8e5a147ae9
prerequisite-patch-id: 547e6b809238472cfe60f9cf2c13a4e1406431c2
prerequisite-patch-id: e95cb5aa5abadafdc3e223e3652562e4d4ae0b42
prerequisite-patch-id: 37c55a638ac1c9255a960efa850f2993df636283
prerequisite-patch-id: 3649898edf67c2efe4fdeee7a4c9a19c64758015
prerequisite-patch-id: f3814ebb95833dfb2b781c6d1b721358fe7a86c4
prerequisite-patch-id: 582c153fb0196263c46d6bfecfca474cf97ea86a
prerequisite-patch-id: a4193bdd1a804212b51590df345830fe30c91622
prerequisite-patch-id: c40bbd0696c4a3c3159f41cc76d20f3a989d1d92
prerequisite-patch-id: 109c3ed81a22502e152c56cbaf30de6508cfef10
prerequisite-patch-id: 83ab1edeeade5181ec01f61b3ad5589709cacc98
prerequisite-patch-id: 8bde4195baa5d57c0c2178e194521321db203015
prerequisite-patch-id: 050bb11ad1d44fb1412a36610674fc630cf055ba
prerequisite-patch-id: aa8f02d2c6c49e6a3c83b5d5b30f7a620f647575
prerequisite-patch-id: d64333cd2b975b9007c3ff40d313e092da8b4315
prerequisite-patch-id: 0daecd52ff675cb116bcec7c9b56bc789499ca8d
prerequisite-patch-id: b295020f202874a7e56eb1ca47cc401f1cb2970b
prerequisite-patch-id: e007a3c545af12c4f6e58f9c89d7408654eb2303
prerequisite-patch-id: 6598db8c7e66851971467844133edb09475aa0e4
prerequisite-patch-id: bbc69807a7f816d7aef864a2c38320fbc8ffd15d
prerequisite-patch-id: f07b8ce0913ceb49e2c68f97c38c7f085a066d05
prerequisite-patch-id: 5194c8a5a0e285b45a58df725659730a5d995cd7
prerequisite-patch-id: ed045b28a470a647a11807868a8b017c9d690cf2
prerequisite-patch-id: 55e52337c273e4727ffcd40f08ae0cca735ea6d4
prerequisite-patch-id: 8580494286eea9828056a0bd83aafb49aa5f56d5
prerequisite-patch-id: 455467289a62c2d86fe1da779959fa5935545d1b
prerequisite-patch-id: 24949818dce6c86ddfdb32494a9ea6bf80640733
prerequisite-patch-id: 1c0121dae636bd281dc487f9a8c76329da62e70c
prerequisite-patch-id: 6cdd272a9c39179b1a0fa857732703003f639ccc
prerequisite-patch-id: 36554575f8b98afb3e1406f906161f799f7836e7
prerequisite-patch-id: 5c33d75cdfd075f5ffff9ea98a3e12674f0952ca
prerequisite-patch-id: 3665c6622ed681d78405a5f346053f189e1fe7ca
prerequisite-patch-id: 41594c69b954d9b9fa4be524f187594ce16d81a9
prerequisite-patch-id: 3f589aae46cf8584d58be6196a1a392c04c0019b
prerequisite-patch-id: 4b6be64bc16edae79116b8177c7c1983874a66a7
prerequisite-patch-id: 6cab31f76f654992c828be80e45ebfb12d362153
prerequisite-patch-id: 026e2066cb9cfddd2c4f31c6c080e5bf3f44411e
prerequisite-patch-id: ae23d6f28ddc25aa9cccda7c8271db10018d7733
prerequisite-patch-id: abcf87333076ab9fa41741a75c1f43101c39d679
prerequisite-patch-id: 3fa60cebaa7996d93b7aaa8a9fc48b65f75698ba
prerequisite-patch-id: 8f3ec67550379c78e19a436390f14e32251fd827
prerequisite-patch-id: b0f4b0358ddd471fcf81a369f72e63ffec45d02d
prerequisite-patch-id: 5c32dc557e1bdd02f275e1c3e241dbbfe9b9a879
prerequisite-patch-id: 5a4fa5119ab2e82f621bf6bdeaf540e75f3cefb9
prerequisite-patch-id: a4141b27715fd9887f27be6ce819b3245afa5430
prerequisite-patch-id: ee46c59cd96e4d8b72c86d286834e34b9fbe6ace
prerequisite-patch-id: a8470f5d7704417c9e959521ee3d1e07ab42a7ce
prerequisite-patch-id: 792a7d643886eb9653c391a6461bd07f4a91799d
prerequisite-patch-id: 9aa8fa4212c14331cd0530b86035d783002d761a
prerequisite-patch-id: 01d49bfc3b5c6bd8d627332a84767abbb2bbe8b2
prerequisite-patch-id: c0f0721bd22d2de7b3e25fdb978d4e30f7c097a9
prerequisite-patch-id: e791a370f70b7affac0ae6050a77f5b41f700b30
prerequisite-patch-id: 19d17977cf06d06071289b16460079da3e533b1a
prerequisite-patch-id: a72f335bb4f6a0b99488b59b1a0968bbe52b57c1
prerequisite-patch-id: 721f9dd546cf51a1e3fa1aec5f1fae7ab3d15147
prerequisite-patch-id: d241b99a6b27cd32c5ee3ad59c15af345d0f7089
prerequisite-patch-id: 86f09d70fa1c60f6e4198d325ee2a15896b576f7
prerequisite-patch-id: 9abb9746d7e561b86c8e51ec723df18fd892864e
prerequisite-patch-id: 37ea219f3665e02b0fe2613587b83d8ebe922bd7
prerequisite-patch-id: 3479a7f74626b936e55c441b19fad5254250a30b
prerequisite-patch-id: 263fa98ed0599e55d0a88595d021a54241cabc03
prerequisite-patch-id: 7d7d01cc86ca00282c266f2e1b98ae4b27e03e42
prerequisite-patch-id: 3217af762876bdc11225ff77a4dd8961b75c1bc0
prerequisite-patch-id: 4563c1d310473c8a5f781d7f00e344619524180e
prerequisite-patch-id: 50b4a4b9f298299615aa47121dab2054a684b2b3
prerequisite-patch-id: e55bfea4b57fbdb315695ad0c30d3605e8dba53b
prerequisite-patch-id: 65178566427b05904ef3a8bed39cc717aa6421c8
prerequisite-patch-id: d04608ad87ea6ccaac2ab02b9fff29127baae542
prerequisite-patch-id: 2cc7893d9f59702f6eb11025a27ceaf66cd25450
prerequisite-patch-id: 022d51df339f7814443b6a8e63ee0e2b88477990
prerequisite-patch-id: aa131e1b3e56cf85c3c694d72ca3dca26f5cd25e
prerequisite-patch-id: fbfa28943694f7d4a5349859bed6e1ff5f1206f6
prerequisite-patch-id: 0bb83e97dac64aab7ef3472a8375c4f4cecae7f7
prerequisite-patch-id: a5163a84158d4cd9323d7fa3f13fc944345811c1
prerequisite-patch-id: bfb936bb71c275c157290f11388113b7ac9ec003
prerequisite-patch-id: fec230607a5121c485b56cf7c93041c897b64c90
prerequisite-patch-id: ae7007ef07d8573a43069c4adc20026f1597d9d6
prerequisite-patch-id: 47ddae10011cbc9b33c5b3956d691fe2a2f98837
prerequisite-patch-id: 4753c802d003347c73f37d9d75fd41f659d3cc6b
prerequisite-patch-id: 497bd197282d29ac00d4cd325bd916a47539990f
prerequisite-patch-id: fddcb9ada5aee17c0d521a4221b10b80f83e1693
prerequisite-patch-id: d9300056c8010874467ced302d5bc79220f6cdfc
prerequisite-patch-id: e7740fc4f9e42bc25867ae3b137ec6e295f599a3
prerequisite-patch-id: 535d9840efd087be6a18d7fb832d97db5c914f60
prerequisite-patch-id: c07d47c658501076f697d6fef1217cc71baea125
prerequisite-patch-id: 78ed5159ed35e45fb742bded8a2d0b6d9f35cf78
prerequisite-patch-id: 818881e28606fe5bfd87ce924d2b97bacf5d2dd7
prerequisite-patch-id: 168cf494133e41cf697456a6d5041e0bd30034a0
prerequisite-patch-id: a5ec071a2cb5ad59e93da8ce967343ce2aca22e6
prerequisite-patch-id: 6678803fd8aadf3d5f6587eba1634d3d15a18efe
prerequisite-patch-id: 5e761e10d74c37fb0a566febb7da69e2fc7b7bf5
prerequisite-patch-id: 43cc49f4fe37cbe261042e7218b6a0758450fbbf
prerequisite-patch-id: c59d0047937360ead2a09553abe1ae5aacbf175e
prerequisite-patch-id: fed3e7cfeb646ee4bd752c376c0e02d1f07d9bf4
prerequisite-patch-id: 4fa28eb48d52f8f450c32fe737efbcb9d12a789e
prerequisite-patch-id: 310ddb4840c7998c24faf90184a878d5365eeff7
prerequisite-patch-id: 163bfee098805601bcaa08135866a9e4c71dadd4
prerequisite-patch-id: 29f7730f31688a2d8f6abc66063b0dccfa54b47d
prerequisite-patch-id: 2d615f33f790b3d0d2bad07b54edce239db73706
prerequisite-patch-id: bf7e953344a27705ebc3bf132c945cb3fd4f6f16
prerequisite-patch-id: 7e9a6c2816cb0bbf60654f9defb76a750503e7e1
prerequisite-patch-id: 1d5af33232f90ffb0e916b4a18f0f18ca9d8dc27
prerequisite-patch-id: 42e7677255323422410fec3ab663fe3775f4c853
prerequisite-patch-id: 1d48b0550736055134b452f1b1bf418d833ac3c3
prerequisite-patch-id: 7d902425133d420b2efda486b6b3bc549b9e83c5
prerequisite-patch-id: 4282c639899ae55ce37c331fd448cb80b8fa2b13
prerequisite-patch-id: 0f5cf0c7fa68c21128b883154eba1b1626742c6e
prerequisite-patch-id: 25999cb34dd4dfa87215f53377a60795922aa4fb
prerequisite-patch-id: 6fd8e3fa1de596ddeb1126548c5d5c4017d7940c
prerequisite-patch-id: 699ca54f48a38a12d905f4a3135357699555f54c
prerequisite-patch-id: 9f96f63302914d3888be06e44444dfa5ccd506e1
prerequisite-patch-id: 39068eb9ccca93871e8c1d4cc7cb0c3ef1b0cf4c
prerequisite-patch-id: 597f470c751d53ad4e996856bfffd1369d6f809e
prerequisite-patch-id: 37f1e013db7f1c08c4fffe5f790a162878b9389e
prerequisite-patch-id: d1fd08422b13e9ae291ff1e545a435e4f3ee5fcb
prerequisite-patch-id: 8d3ed5a544e3f007bd7be46a6e77ae4a58eea2c6
prerequisite-patch-id: 31ebcd0a9928b77b72d13b82dc529a720f8f9425
-- 
2.41.0


