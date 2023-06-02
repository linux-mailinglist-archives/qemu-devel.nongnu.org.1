Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C671F79F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 03:17:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4tPF-0004Wn-Dr; Thu, 01 Jun 2023 21:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4tPA-0004Lb-8q
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4tP7-0004Wc-NH
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685668592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pmp0lSWzQ6cfjlgrxuRfxX1BFvUkqsiLNpCU9Lp2poc=;
 b=i/50s+NGs4LpBe4eYBjSEo5IR1fq/yGQAOlmvy8l9aMnNjs8bnf1nGwv/39rVnry8SBPFw
 zZnEoUUZFGF7X5/fuA43+RaBCXgpG39CJuBzIHlDRALcdmKtj8u30mAZrQGXeQ5+IQnQI/
 Y3S3T+a8cg7N+2pCQCqZWsvv2VoYbrY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-aRZQjuSJPCG0yxS1HR2p6w-1; Thu, 01 Jun 2023 21:16:30 -0400
X-MC-Unique: aRZQjuSJPCG0yxS1HR2p6w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62607e62fa8so1051966d6.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 18:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685668589; x=1688260589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmp0lSWzQ6cfjlgrxuRfxX1BFvUkqsiLNpCU9Lp2poc=;
 b=Acw4JzIcMy/vqDDGl0rj3QQsnqhEqLL2T9UKOPb2hZfq1PFZi4tleNevYOvXIlSrPl
 boSJkZ1uPQdnRm367Lp5V3ZKXRQCSGhcHx1GrxXSEJPU+hdLfx3UE9oeHX7E8ZRtaek1
 8RTT0QshOITiXeuLpaFQqbJegoaq+E05YG+KxeSdyvJBgH4weL8vk7obCJbSjjf6wFqL
 lAM2UIej4UyyWtel7NeW5hM0D3ZtiwDc0KqkxUUNKfKziCS+Bn7WcjXrxzEAVWI2bMi2
 BjGiZBtlm7yHVPlrGxf9VBydpdn52m3FCUNbz/8BkrlE4mnTw2EmuWuYcxoCFRN6fD33
 NG5A==
X-Gm-Message-State: AC+VfDzWHSKXyPOlKl8dXsshv/00DeY1jv/l4vAtGtwt4Ot2GIkgWtuf
 8Bs9+tlLhSoDew9VsOvspW9IA7mlz2g64/vI9+2QOmFRoGFrtUohZNcT3945s/tY1OjsWQJWKOc
 MmdOwLjCGGuKPO90hCofa/oVrT7QxY33Lh/zcLaKvZMfDa0RNFsyu9YUB6jsq8ee4haNiFZAJ
X-Received: by 2002:a05:6214:d62:b0:625:88f5:7c62 with SMTP id
 2-20020a0562140d6200b0062588f57c62mr9651596qvs.2.1685668589517; 
 Thu, 01 Jun 2023 18:16:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Q2GqWqXiyFCPkdp4xj6hObg/ZM5VkAPnT0MD/gISbIa7RZoHzkoSuJY4935UgS506o9SrqA==
X-Received: by 2002:a05:6214:d62:b0:625:88f5:7c62 with SMTP id
 2-20020a0562140d6200b0062588f57c62mr9651568qvs.2.1685668589177; 
 Thu, 01 Jun 2023 18:16:29 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l20-20020ad44454000000b006261e6a88c7sm170462qvt.36.2023.06.01.18.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 18:16:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH RFC 0/3] migration: switchover-hold flag
Date: Thu,  1 Jun 2023 21:16:23 -0400
Message-Id: <20230602011626.226640-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

This RFC patchset is based on Daniel's recent refactoring on migration-test:

https://lore.kernel.org/r/20230601161347.1803440-1-berrange@redhat.com
Based-on: <20230601161347.1803440-1-berrange@redhat.com>

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

Patch 2 will temprarily revert the last patch from Daniel's series, so
potentially this will temporarily make migration-test slow again.  If we
want to avoid this we can merge patch 2 & 3 too.

Patch 3 will leverage the new flag to speed up migration-test.  There're
still some difference comparing to Daniel's solution (e.g., we can still
wait for a whole iteration for each test since we run the initial 3MB also
with full bw).  An initial test is this can make migration-test finish
within a little bit more than 1m.

Please have a look, thanks.

Peter Xu (3):
  migration: switchover-hold parameter
  Revert "tests/qtest: massively speed up migration-test"
  qtest/migration: Use switchover-hold to speedup

 qapi/migration.json            |  25 ++++-
 migration/migration.h          |   7 ++
 migration/migration-hmp-cmds.c |   3 +
 migration/migration.c          |  56 ++++++++++-
 migration/options.c            |  17 ++++
 tests/qtest/migration-test.c   | 163 +++++++--------------------------
 6 files changed, 134 insertions(+), 137 deletions(-)

-- 
2.40.1


