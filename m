Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F6749C3E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOKj-00030k-11; Thu, 06 Jul 2023 08:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHOKg-000308-E6
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHOKe-0004Sl-Pq
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688647415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YpN+gpBqrQ6vDZ9ShzCKAHpCEp0xmNk1NTUdT589mns=;
 b=CmgWjS48dOsjoD/IlhdMA+bVlef+G/4KsdL4PQa5/v+Ce6uLILTN0nA+B51ZZFKLw/MEVp
 YcrVWrBpjZE0Fy8u6tAConx03ftebnZcamDnJwqFIVeHk2mJrKUz3bRY7wqWENUucbfyFu
 O1nmSJoksXKf2pCg67ofTFJMbmUEHS8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-_tU8N7rqNFiqhjsE0ds5Yg-1; Thu, 06 Jul 2023 08:43:34 -0400
X-MC-Unique: _tU8N7rqNFiqhjsE0ds5Yg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7672918d8a4so19848885a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688647414; x=1691239414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YpN+gpBqrQ6vDZ9ShzCKAHpCEp0xmNk1NTUdT589mns=;
 b=TGv1ls1RTILsQpK42xgbS1WgFFzWO6zxdByWEYU5b9jGKLpCYoCGq1RkhpL3jtBvTa
 DRVSuLAqfkbrJYGpWkqyDnnqr75K84+fvnOVmQCOwRVEfuLiKbNJHHVyMh8brTu3PRVq
 urUblRd1sm28WEHCVlKnyW5FkVR3CYe4wkoo9Q29DFiHAXX26JVVgxbLZpLYHnOhZO0U
 VEhK9w/kAt3k8335ctSi85GLH7D6IMQojETOvM7g1+Mx6ZhFojMUn8N2ROPj7LvQG/wj
 hhXTrmwm4rrAXaWeYkHu9Pfjc9pm510+KfHSIp7djtLxOqQxGFW+tK2eyh4Gt0XYZJ44
 so4A==
X-Gm-Message-State: ABy/qLYzYoKrNHE+pFff+3gjKPw7fE/C6vHLhKPIRfyPVDgowAO54+8O
 uxAo9t2uleMWCazUJ/3XoFjXvEm0yEheuWmyqlblSKH6RZNh1cH3XPdsVZq8qQrSzAgbDVpiqsc
 TSmE88OIZuewtRaVxHmpHQLt7zHxFN1QYL33yJ0sVYf3B8Yz70ffRNFnjV/x8mC8rYqqweRNm
X-Received: by 2002:a05:6214:410f:b0:625:aa48:e50f with SMTP id
 kc15-20020a056214410f00b00625aa48e50fmr1670811qvb.6.1688647413925; 
 Thu, 06 Jul 2023 05:43:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEqmFR+kXYbZwhPJg+PolaATJ+wcf03zaIZB8DHXtRqZzVXGGhtiP7rBfO6oJYnfy3Q8XKIxQ==
X-Received: by 2002:a05:6214:410f:b0:625:aa48:e50f with SMTP id
 kc15-20020a056214410f00b00625aa48e50fmr1670783qvb.6.1688647413521; 
 Thu, 06 Jul 2023 05:43:33 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a0ce44d000000b006301d3cab9csm832816qvm.27.2023.07.06.05.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 05:43:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 0/2] migration: switchover-hold flag
Date: Thu,  6 Jul 2023 08:43:29 -0400
Message-ID: <20230706124331.377939-1-peterx@redhat.com>
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

This v5 patchset is based on master.  Since I'm not sure how long this
series will take for review, we could probably apply Dan's previous patch
10 first, then when I repost I can provide a revert patch when needed.

v5:
- Fix HMP set the new bit [Avihai]

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
 migration/migration-hmp-cmds.c |  7 ++++
 migration/migration.c          | 69 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++
 tests/qtest/migration-test.c   | 39 ++++++++++++++-----
 6 files changed, 157 insertions(+), 17 deletions(-)

-- 
2.41.0


