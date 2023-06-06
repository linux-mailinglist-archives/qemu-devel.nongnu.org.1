Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4572498A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZvN-0003QC-K7; Tue, 06 Jun 2023 12:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6ZvE-0003Pa-Hv
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6ZvC-0001ht-VF
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686070354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eQUb7K9AM0fR/6HP4mAXT3q/EkEn22gO+J1lmywlIE4=;
 b=dQEy3DWRbsZeJ5JPtnEKumZ983GAiytx/BXW+h9OeXR6kh7OncfqxLQHlZGYY3zgjdnXrS
 ivUuj2fBk9Lh4UnEEmgOhcR6uZJXL2/Qjwyb2Bez8CDMOF/F5dCEVhNCJKwuAGhGGx+HA7
 AsZr+nOzCuW7d7NHrcmjpY3E+pcod48=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-BEdgLzfYOlWJnFeanchdUw-1; Tue, 06 Jun 2023 12:52:33 -0400
X-MC-Unique: BEdgLzfYOlWJnFeanchdUw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75e681229c5so58972585a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686070351; x=1688662351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eQUb7K9AM0fR/6HP4mAXT3q/EkEn22gO+J1lmywlIE4=;
 b=ev4cn8Mq+nSTPYjK9U+kgsfhNqrokx1mMBXGO5tMR0d8g4XNdBc0saD8CaA92Rw1pD
 HT1coodPSa1C79CwMfmPB1VuXDFEE7E4yW/zBk676hoNgz95lWcZP3M0HvyQwDEJVKol
 zWbYKMmg4ApAGD3+DeB07ly75K9A8PzCrlhu5jhGYIFRiwq8wlc840/CGgHP17MdJN12
 pYwY95WXadW+DmoGCgZIb6ENaRO3xT0WEKLoLjBox6Fvw0CxrbPXRCdutGFCrvt/YuI/
 /tJbmmKAxoSpg9z3XEsMEuxEBs0zayFr8nU0Hd9LmPdAOHFa9z3ZNdKp5BiyfWqoOly5
 je4g==
X-Gm-Message-State: AC+VfDzTU/dvM5xbMhMZuXMFc+JImNt8y2LachxdVdS/mQ30yVYTvY5C
 hpfPiAOO5vDd2LsxAH3ooLjsHX7V7BiFGodTh5byMILpqWckfjgrqiQBXBZ5x9XIFYrUYt46QmH
 aoaHlDuzHI0Sf+QK7zn/yzFNFg+wmQUTqb31tLXOpOILrXNkTzh2Q6g5bbLW/R8TcVF+pqT6k
X-Received: by 2002:a05:620a:8009:b0:75d:5208:603c with SMTP id
 ee9-20020a05620a800900b0075d5208603cmr3086852qkb.4.1686070351572; 
 Tue, 06 Jun 2023 09:52:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7n45XOVk/au0WDW29dhv8DsH1FA2hfTdX6mJkXV1Z5wJlZSBM9u/sxmvU/QrIaIjg3JqkJzg==
X-Received: by 2002:a05:620a:8009:b0:75d:5208:603c with SMTP id
 ee9-20020a05620a800900b0075d5208603cmr3086816qkb.4.1686070351236; 
 Tue, 06 Jun 2023 09:52:31 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u26-20020ae9c01a000000b0075d4d5617cdsm3498168qkk.66.2023.06.06.09.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 09:52:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Eric Blake <eblake@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 0/2] migration: switchover-hold flag
Date: Tue,  6 Jun 2023 12:52:26 -0400
Message-Id: <20230606165228.491878-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
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

This v2 patchset is based on master.  Since I'm not sure how long this
series will take for review, we could probably apply Dan's previous patch
10 first, then when I repost I can provide a revert patch when needed.

v2:
- Make the flag transparent to postcopy [Avihai]
- Fix qapi/ indents to 70 cols, copy Markus, Eric too [Avihai]
- Adjusted postcopy test, see patch 2 for details (because patch 1 now
  don't influence postcopy anymore, due to this the test runs slightly
  faster than v1 but hopefully provides better coverage on postcopy)

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

 qapi/migration.json            | 25 +++++++++++++--
 migration/migration.h          | 16 ++++++++++
 migration/migration-hmp-cmds.c |  3 ++
 migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++++
 tests/qtest/migration-test.c   | 39 +++++++++++++++++------
 6 files changed, 140 insertions(+), 16 deletions(-)

-- 
2.40.1


