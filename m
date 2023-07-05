Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3D74877E
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH47P-0004Bw-L6; Wed, 05 Jul 2023 11:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH47N-0004Ba-CF
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH47L-00004z-Qb
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688569709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Uqm6pf18jYvs3v/Eopr3LcI1HAlSLYjQ5fXZTypYis=;
 b=gZ0WDT26hIM5zWXwdthud7ayoGVk4DdnfD8AK1qny6Jk11INiASjOOLJnxh5VD6rUEFIdi
 oGQnvVrSJS0rEXlK1L5KONrSv5c3p//a0ni6v86fYVwNGO8ZF3FYuCGpq8B8LCE1820sVB
 +Y2SGOz/lNDeLsJB7j0bipauangdChI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-uiLolbnnODaiO6Y3-ENgAQ-1; Wed, 05 Jul 2023 11:08:28 -0400
X-MC-Unique: uiLolbnnODaiO6Y3-ENgAQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7672918d8a4so195851485a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688569708; x=1691161708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Uqm6pf18jYvs3v/Eopr3LcI1HAlSLYjQ5fXZTypYis=;
 b=h8N3y16oUqldWqy59CLHw61UdKAOFFA0NuPBvfcXxQ/UHQjvMQAS/NHt2G616vXb7C
 IcUZtz7GbPVT1qVOoZ1oiDkT8fd+ah1sAq5APKDHtt+7dVusyGBzeyqhRB5fAjrQfd8J
 BbZtfb7cclv/Rp6GKq2HpuyqZVyw9tNvjtPCXNfw3gjLSPvr4XyQRP+H8nWYrU4Vsh3h
 sNWEeQRLHcE3FnlF3HT8h59Sn0V97S7JinOyWoaecJisNLAUSM2yKtoXYkiaMPm6uJz0
 F9IsBrsElL9hmKbsXxNPbq9rv8xtyUZafX/u3cadtjqcgnd0qmnfk7MXrBDBzR+RbudQ
 WUyw==
X-Gm-Message-State: AC+VfDx6ksdp8YwjpTJZC/OTP4muhZPB/VuwhkBqfMFvnfQhoVKJ/9yG
 TbAvEFtX44PHQ9Ru/tJVAGdMtjzyBZwOAyxExsxGmHmmheIBJHjdZ2BMzvZZrbPAK+QjnQsKyWN
 ms6PaEp9P4ncc5pK5ACcnpWtN6oBPefpMA8izSFQ+I2uqXDYpLYu3MP45ujE3UamwSL4kwLF4
X-Received: by 2002:a05:620a:4010:b0:766:3190:8052 with SMTP id
 h16-20020a05620a401000b0076631908052mr22524257qko.0.1688569707891; 
 Wed, 05 Jul 2023 08:08:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oajnTHyV9t3iUDdndCpslr2J49LOHlTKk+xlT2uKS38zo0keU3FZih9kbLig6xWucr0b21A==
X-Received: by 2002:a05:620a:4010:b0:766:3190:8052 with SMTP id
 h16-20020a05620a401000b0076631908052mr22524208qko.0.1688569707354; 
 Wed, 05 Jul 2023 08:08:27 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 bs9-20020ac86f09000000b00400c5f5e713sm11826952qtb.97.2023.07.05.08.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 08:08:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 0/2] migration: switchover-hold flag
Date: Wed,  5 Jul 2023 11:08:22 -0400
Message-ID: <20230705150825.305076-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This v3 patchset is based on master.  Since I'm not sure how long this
series will take for review, we could probably apply Dan's previous patch
10 first, then when I repost I can provide a revert patch when needed.

v3:
- Rebase only (v2 is not yet applicable after switchover-ack series merged)

A new flag "switchover-hold" is added to allow src qemu explicitly hold
switchover for precopy migration.  Note that this flag will not affect
postcopy switchover because src qemu already has migrate-start-postcopy,
which is a finer grained knob just for that.  In general this flag only
affects reaching migration completion phase, when set it'll block it from
happening while keep the migration iteration going.

This can be used in two cases so far in my mind:

  (1) One can use this parameter to start pre-heating migration (but not
      really migrating, so a migrate-cancel will cancel the preheat).  When
      the user wants to really migrate, just clear the flag.  It'll in most
      cases migrate immediately because most pages are already synced.

  (2) Can also be used as a clean way to do qtest, in many of the precopy
      tests we have requirement to run after 1 iteration without completing
      the precopy migration.  Before that we have either set bandwidth to
      ridiculous low value, or tricks on detecting guest memory change over
      some adhoc guest memory position.  Now we can simply set this flag
      then we know precopy won't complete and will just keep going.

The 1st use case may look a bit like COLO where we can actually keep both
QEMU _mostly_ in sync.  I'm not sure whether it can be useful anywhere,
though.

Patch 1 will introduce the new flag.

Patch 2 will leverage the new flag to speed up migration-test. An initial
test is this can make migration-test finish within a little bit less than
1m.

Please have a look, thanks.

Peter Xu (2):
  migration: switchover-hold parameter
  qtest/migration: Use switchover-hold to speedup

 qapi/migration.json            | 25 +++++++++++--
 migration/migration.h          | 17 +++++++++
 migration/migration-hmp-cmds.c |  3 ++
 migration/migration.c          | 68 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++
 tests/qtest/migration-test.c   | 39 ++++++++++++++-----
 6 files changed, 153 insertions(+), 16 deletions(-)

-- 
2.41.0


