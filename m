Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA779DBD5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlc-0007mD-3f; Tue, 12 Sep 2023 18:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlZ-0007li-RS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlW-0003Gl-IM
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=50A1im5IKgq0EUCsZQlbowS4Huk2fy08MtfHck/f0YE=;
 b=X+qLmzGRIWXADpc2ot7Yq5awBrJgMtBO58I5VtZcF4eBrhcH6v7YDWg++7L5Nm/hPhnPds
 ndlVkGk3xJidSKDBMfcQyBkPaW9gmFN/lxTnCcu2djQmpu8QTowwdvIqFejPCriKymz/SY
 2qPvID+r1XkTXXPthVnpUd3zmvhFmyw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438--bgvAHOxMMWRu_BNg3oB7A-1; Tue, 12 Sep 2023 18:21:48 -0400
X-MC-Unique: -bgvAHOxMMWRu_BNg3oB7A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso16835646d6.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557307; x=1695162107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50A1im5IKgq0EUCsZQlbowS4Huk2fy08MtfHck/f0YE=;
 b=aw2WoC83Z0DCeZfq0fD5ZQRIdVaiC8NbYSamBS6M3hb9k0M6iQWG5O7D539zCiyz/8
 233h4vAwwj0V47B8uCZc1QaxSN6xOH/1Q7GV5ZV/zJtI+SaNZKWbiTVnnrAM+h2nY3+8
 AZ11ApDwfyah4AgnSE2jl9PPrzNyaYx24uiymqVhxkaGa6fKGCuxqBrnAl56gM1RHh5F
 zfLJmk4amXb7mwV7j5EK590c3XGJQ1Eu/jQ2nB+IKF4UqXiHVlGLhaS4EiqjQPkB/fVV
 yTjzNmrE9m+dvlshDIaN3rFKjJ/rAm482NmHwsGj4o+A2bqsATEeNBVJBU6zsqQB+7Sy
 B+ig==
X-Gm-Message-State: AOJu0YwR322DDsmA2NivOW+azwCy7q1UAGnR1gfVnEWl0vPoDM9tJgEs
 dkkszRqFfgvHGxeMVdOngT/2fRIikICsqFc9Dbr+rys5NVdc14/SSiBVZldEeSKMMiVpTAOKJpo
 zm4G4XxW2jsWc3wo58SwlMsQbzCDvd9iMlQwZ2+RQl079Wc6afmAbeaNkqqmBIaC4KWN6PFCE
X-Received: by 2002:ad4:5dcc:0:b0:616:870c:96b8 with SMTP id
 m12-20020ad45dcc000000b00616870c96b8mr768260qvh.3.1694557307434; 
 Tue, 12 Sep 2023 15:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhBD3xHZ6VymVD3BlQbX4bZPwvFX9KjtIlDd0SD7v0YREfSu+4D/wA5g1boCp4tK7HmzQhRw==
X-Received: by 2002:ad4:5dcc:0:b0:616:870c:96b8 with SMTP id
 m12-20020ad45dcc000000b00616870c96b8mr768240qvh.3.1694557307076; 
 Tue, 12 Sep 2023 15:21:47 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 00/11] migration: Better error handling in rp thread,
 allow failures in recover
Date: Tue, 12 Sep 2023 18:21:34 -0400
Message-ID: <20230912222145.731099-1-peterx@redhat.com>
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

v2:
- Patch "migration: Let migrate_set_error() take ownership"
  - Fix three new call sites that uses migrate_set_error(), by dropping the
    error_report_err() later on.  [Fabiano]
- Patch "migration: Allow network to fail even during recovery"
  - Fixed wrong check for dest QEMU
- Patch "migration: Allow RECOVER->PAUSED convertion for dest qemu"
  - Newly added
- Patch "tests/migration-test: Add a test for postcopy hangs during RECOVER"
  - Newly added, based on Fabiano's test case provided

v1: https://lore.kernel.org/r/20230829214235.69309-1-peterx@redhat.com

Again, if this collapse with anything I can rebase.

This series allow better error handling in the postcopy return path thread,
also it enables double-failures to happen during postcopy recovery, IOW,
one can fail again right during RECOVER phase on both sides.

Big thanks for Fabiano on prioviding a base test case for the double
failure case.

Please have a look, thanks.

Fabiano Rosas (1):
  tests/migration-test: Add a test for postcopy hangs during RECOVER

Peter Xu (10):
  migration: Display error in query-migrate irrelevant of status
  migration: Let migrate_set_error() take ownership
  migration: Introduce migrate_has_error()
  migration: Refactor error handling in source return path
  migration: Deliver return path file error to migrate state too
  qemufile: Always return a verbose error
  migration: Remember num of ramblocks to sync during recovery
  migration: Add migration_rp_wait|kick()
  migration: Allow network to fail even during recovery
  migration: Allow RECOVER->PAUSED convertion for dest qemu

 qapi/migration.json          |   5 +-
 migration/migration.h        |  25 +++-
 migration/qemu-file.h        |   1 +
 migration/ram.h              |   5 +-
 migration/channel.c          |   1 -
 migration/migration.c        | 231 +++++++++++++++++++++++------------
 migration/multifd.c          |  10 +-
 migration/postcopy-ram.c     |   1 -
 migration/qemu-file.c        |  17 ++-
 migration/ram.c              |  77 +++++++-----
 migration/savevm.c           |   3 +-
 tests/qtest/migration-test.c |  94 ++++++++++++++
 migration/trace-events       |   2 +-
 13 files changed, 342 insertions(+), 130 deletions(-)

-- 
2.41.0


