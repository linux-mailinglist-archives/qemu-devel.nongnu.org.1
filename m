Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 765807204DB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q564f-0001U3-9E; Fri, 02 Jun 2023 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q564A-0001S5-AE
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q563r-00076h-DR
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685717240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NM9X5FLS6iDClUdQI/m9PyVS8pUcLZUZ8sriHDmkrkE=;
 b=H/ETWfOBy7amnqQuRtq/X62K8Sz2P6WLi+thlpdbbNobTSbCL5Eqyi8Hvs1p+XJLBvTfYv
 7fE55kQPVBN3o/dMqq0ygQQ9JiT4/5EWBbfzvii+miRIWlLwntsNdQTLb/82h7htoBhZ0m
 uGADyH9xq8t/pPKPe7BkaFIaQRRfAQQ=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-KjwY02wNMhmo2C5QAm90TQ-1; Fri, 02 Jun 2023 10:47:19 -0400
X-MC-Unique: KjwY02wNMhmo2C5QAm90TQ-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7871b746cddso21537241.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717238; x=1688309238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NM9X5FLS6iDClUdQI/m9PyVS8pUcLZUZ8sriHDmkrkE=;
 b=HAcRcWWKLQHDgEeSKl7j66+/7Tcvv/BbuwbyL7CuIhYyw2cf/dociit5ZlRlHSlypb
 KUuwEeuyrfEbPsFOCmS6i4jAE+fYI+Tnpw3DPn6HePLc6Wa9yNyvZWd29EpFsPZTDBcz
 fXJoIKFTTs0lsnLY+qI2hot9OMealdKzHsiyB2jub1r3k7o9n8L3mbhsFVNG+tNQAU0C
 cxQO358AklRZRwsIoBbmryBPDLiDfDcgLHHm0AZzF1hipi/WJoCCJ0nCpfjP3kNT9rGQ
 g5jm2+otjdaXhiQ8NQdutXXmw+AXue1kdVuNMdJvUGdj/iiTMLxyGVyiIc23e0lq8nW9
 GOGg==
X-Gm-Message-State: AC+VfDyvDUQzkzNNbIBulpyskMhsBgl014TaS4b5+r5BEn/Fr5C898L8
 0i2UQj1MpixtGwArbfPDKlcoyxmfyiatsQolL/1e0zal6zX0lS/TxtwIl51OUrg/d8EQ1ikkyWh
 A/N++kKgS6YOXYG/abq2QUa/D813J3sXSHE2POKXV1xXD+UYSb6mHDREfhAAYYrh8SoRfQUlk
X-Received: by 2002:a05:6122:91f:b0:457:4502:a2b0 with SMTP id
 j31-20020a056122091f00b004574502a2b0mr3469578vka.1.1685717238220; 
 Fri, 02 Jun 2023 07:47:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6v8gt+OiUjqeSRVdDLgCs+s/1HkswhdFdFAietCWqmZaUxFJxclUgqW4mfDtukvbpemv7ncQ==
X-Received: by 2002:a05:6122:91f:b0:457:4502:a2b0 with SMTP id
 j31-20020a056122091f00b004574502a2b0mr3469555vka.1.1685717237830; 
 Fri, 02 Jun 2023 07:47:17 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l8-20020ae9f008000000b0075b00e52e3asm698419qkg.70.2023.06.02.07.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 07:47:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: [PATCH 0/2] migration: switchover-hold flag
Date: Fri,  2 Jun 2023 10:47:13 -0400
Message-Id: <20230602144715.249002-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

This v1 patchset is based on Juan's latest pull request:

[PULL 00/10] Migration 20230602 patches
git: https://gitlab.com/juan.quintela/qemu.git tags/migration-20230602-pull-request
Based-on: <20230602104910.35157-1-quintela@redhat.com>

The solution is heavily based on the original idea from Daniel, however the
impl is done by a new flag introduced which could be hopefully cleaner
approach.

Comparing to RFC version, this v1:

  - Dropped the RFC tag, rebased to Juan's recent pull request so patch 2 dropped
  - In the last patch, start to set bw=0 by default for all tests
  - Enhanced commit messages / comments

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
test is this can make migration-test finish within a little bit more than
1m.

Please have a look, thanks.

Peter Xu (2):
  migration: switchover-hold parameter
  qtest/migration: Use switchover-hold to speedup

 qapi/migration.json            | 25 +++++++++++++--
 migration/migration.h          | 16 ++++++++++
 migration/migration-hmp-cmds.c |  3 ++
 migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++++
 tests/qtest/migration-test.c   | 24 +++++++++++----
 6 files changed, 129 insertions(+), 12 deletions(-)

-- 
2.40.1


