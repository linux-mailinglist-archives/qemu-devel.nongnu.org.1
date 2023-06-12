Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075872CF9F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nIc-0004LA-V9; Mon, 12 Jun 2023 15:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIW-0004Jr-Qj
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIV-0006BX-6c
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686598429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YUs+t432ZYm4fyak1Pi/F3QKPugKjTeCQJEHcgnF5o4=;
 b=WF8MdQnVx+SJ3ZWPqKDP/AeCDEPIkeyK07iWMEq4PPN3O58oWh6lUr/45wLaIs4W5rjeqK
 2peg1TIOPM+39ynyZ0j9y7fOewSNrXROUezNR6cnQNlMlN1xU5eBDQAjdj1NSj+HkY6fAu
 nzJJ1wFGpFrW5rou8DiFHPMkXHlhNS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-hpVWAGcSMDS54j-ElBtRpA-1; Mon, 12 Jun 2023 15:33:48 -0400
X-MC-Unique: hpVWAGcSMDS54j-ElBtRpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB335185A78B;
 Mon, 12 Jun 2023 19:33:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C277141510A;
 Mon, 12 Jun 2023 19:33:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [RFC 0/6] Migration deprecated parts
Date: Mon, 12 Jun 2023 21:33:38 +0200
Message-Id: <20230612193344.3796-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi this series describe the migration parts that have to be deprecated.

- It is an rfc because I doubt that I did the deprecation process right. Hello Markus O:-)

- skipped field: It is older than me, I have never know what it stands
  for.  As far as I know it has always been zero.

- inc/blk migrate command options.  They are only used by block
  migration (that I deprecate on the following patch).  And they are really bad.
  grep must_remove_block_options.

- block migration.  block jobs, whatever they are called this week are
  way more flexible.  Current code works, but we broke it here and
  there, and really nobody has stand up to maintain it.  It is quite
  contained and can be left there.  Is anyone really using it?

- old compression method.  It don't work.  See last try from Lukas to
  make a test that works reliabely.  I failed with the same task years
  ago.  It is really slow, and if compression is good for you, multifd
  + zlib is going to perform/compress way more.

  I don't know what to do with this code, really.

  * Remove it for this release?  It don't work, and haven't work
    reliabely in quite a few time.

  * Deprecate it and remove in another couple of releases, i.e. normal
    deprecation.

  * Ideas?

- -incoming <uri>

  if you need to set parameters (multifd cames to mind, and preempt has
  the same problem), you really needs to use defer.  So what should we do here?

  This part is not urget, because management apps have a working
  option that are already using "defer", and the code simplifacation
  if we remove it is not so big.  So we can leave it until 9.0 or
  whatever we think fit.

What do you think?

Later, Juan.

Juan Quintela (6):
  migration: skipped field is really obsolete.
  migration: migrate 'inc' command option is deprecated.
  migration: migrate 'blk' command option is deprecated.
  migration: Deprecate -incoming <uri>
  migration: Deprecate block migration
  migration: Deprecated old compression method

 docs/about/deprecated.rst |  45 ++++++++++++
 qapi/migration.json       | 141 +++++++++++++++++++++++++++-----------
 migration/block.c         |   2 +
 migration/migration.c     |  10 +++
 migration/options.c       |  20 ++++++
 softmmu/vl.c              |   2 +
 6 files changed, 181 insertions(+), 39 deletions(-)


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
prerequisite-patch-id: 0c7fb969e83ed1b01f15b54abb106026fadb7707
-- 
2.40.1


