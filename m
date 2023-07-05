Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E474894B
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5Ps-0007Ci-1j; Wed, 05 Jul 2023 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5Pp-0007CH-5j
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5Pn-00031P-Fa
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W5ObyngV/i2EDF8aNBNPe4LEpTXiZ7BBn64rExkwn7M=;
 b=D4jVzUdaeEJjEpBRiF7HUfnS6L0ZfY/p4gF6Emv4Gmn/iFwSl02bD4PhVlKD6xIjrxY8W+
 4vAWOHgrrxS3EZ+L7PWJOqDid6LWjrs4mB+h8GC0N5M8vd0alNlkj7KaOgtLRinq2eFU4W
 B72WjXt+2+TBhc+UXJlB6XEAUMoPQRI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-FNsglliTOnqlPmFZuAujhw-1; Wed, 05 Jul 2023 12:31:35 -0400
X-MC-Unique: FNsglliTOnqlPmFZuAujhw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76716078e78so123056085a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574695; x=1691166695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W5ObyngV/i2EDF8aNBNPe4LEpTXiZ7BBn64rExkwn7M=;
 b=MuejtzN03fcGuB4laO2YFjixzb9nKb+/231Z/a7WY3YRFF01QwDMyFJUV2XzOBhtST
 xaO1Rgv08o9hMm6UGhx8j9DbpJ9uUOawuHuj+9/7CGnGoOE4OpKZtsfd6a7U+CCIZi9H
 /N4mtp4NcQkkAcSbPu4Pk1R0K07Cal9qLA3PABFUoor5PBCESh/Ku33RGUo3ritIOxOT
 hb2+TntVaAnB0pIQbnw3FgQ+e/CX7fVWQ/a8BKdQp9PCfVp9PEZuJKYwmPzYYFioHbzL
 86VTp5tl+Onav/ut5zfQ2rJbVlxCwi8YwJED4DoRv2i4XhP6/ZH7y6KXpqzxD236mhbs
 6ibw==
X-Gm-Message-State: ABy/qLaJDQuMfC0UjzVqcvfo6e8KAhIcdZ9NoeFHlTS2N47SlKueYWqt
 Rp17QvTNRnF4Kf3uYl4OiBcFaoSrYOdSjsFhA9p4vpKSiBpe0qnENpkUqNFBEgSzvllZh1dGfsk
 67GGWw4V94I6MX1xAqDV0pU/cWgNB6L+OMF+Nt+IhI730jhgq5y2elQKM1ayBJiKwMgbccM/J
X-Received: by 2002:a05:6214:5002:b0:625:aa49:c182 with SMTP id
 jo2-20020a056214500200b00625aa49c182mr5091136qvb.6.1688574695152; 
 Wed, 05 Jul 2023 09:31:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGU2hqx5HFffixegXIuxTMuoQUpP1e0OJagdz2ND5XBw/rMs6cCMc+mwIfKJgZcGXDbeYEJgA==
X-Received: by 2002:a05:6214:5002:b0:625:aa49:c182 with SMTP id
 jo2-20020a056214500200b00625aa49c182mr5091107qvb.6.1688574694709; 
 Wed, 05 Jul 2023 09:31:34 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 oj2-20020a056214440200b00631fc149a19sm3003159qvb.110.2023.07.05.09.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:31:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 0/2] migration: switchover-hold flag
Date: Wed,  5 Jul 2023 12:31:30 -0400
Message-ID: <20230705163132.329501-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This v4 patchset is based on master.  Since I'm not sure how long this
series will take for review, we could probably apply Dan's previous patch
10 first, then when I repost I can provide a revert patch when needed.

v4:
- Remove one unused var (accident after the rebase..)
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

 qapi/migration.json            | 25 ++++++++++--
 migration/migration.h          | 17 +++++++++
 migration/migration-hmp-cmds.c |  3 ++
 migration/migration.c          | 69 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++
 tests/qtest/migration-test.c   | 39 ++++++++++++++-----
 6 files changed, 153 insertions(+), 17 deletions(-)

-- 
2.41.0


