Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA57B9715
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xN-0004Kr-4N; Wed, 04 Oct 2023 18:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xJ-0004Go-3H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xH-0003vC-6r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1cqlI1VUH/lXgjxhcolkEyvQ4rF0JBI235bTB+ndA2Y=;
 b=VPreARCP7zwPImE3tLaIVcTKxZ4qcShSh4TbBrTGoQgSVX24nEIaXM29ILRwqk8wUQeN1z
 ZND4I50G3yE1+4M4B6WQy769MvilLH+m8fe8MqVon+1mb5FOIVs05LKMMw72OOT48QpqD4
 9jRt1KD+x3opagGsWXKFEnZLyWDNwpI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-cBgVLXDXM-KBdCGGU5giUg-1; Wed, 04 Oct 2023 18:02:43 -0400
X-MC-Unique: cBgVLXDXM-KBdCGGU5giUg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4197878ffe9so1014501cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456962; x=1697061762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cqlI1VUH/lXgjxhcolkEyvQ4rF0JBI235bTB+ndA2Y=;
 b=YwBlUIA0vFWi7/sK3pps4yn//C3XUWDuCm/nknP1cQJ3/XTH3CcDZONEYloE5PiJz5
 eLLcjqXXyEkn7QwXtI1fgA/5LCDifcoTPe9RyGSsvFSICl5OquD8n411cImdibyNpcy7
 VekZRZ95XU1fa3dR35QNBmrGNLFcFXX3Y8r0V1WfhqDxYK5woOwawojU9eKU5qybr//K
 0LXzYAuYPpdrZ0XlIABK0MngHHJHLxZ0lJsjqVjQzHpnBDuyv22eEyStMGHUmaT9zsUo
 9UCABECIEKUsXulphC1HH+4ktmExP3pyT4MmZ9ktxwAMd1aL77P7lqHXQsELTRuZ2jzW
 UAqg==
X-Gm-Message-State: AOJu0YzuZaR65fF6hWIU4jBzt+p6VJ62HLqzR1CqrTDu6ASSRg33xE5O
 j9HnsOMWVauaeNW5z3BUPobRYNe99sitFs2y+VL6IVthHdFRqGhpcYs2XOl2n0YiaohrBQpLEfA
 dDYPrpqM+uN0ZhmbXsEBa4RMny0HHKpCF7M4iyPSNA0gTgRHbbkul0Gb0L7D4rVDcSv8UcqGf
X-Received: by 2002:a05:6214:d6b:b0:64a:8d39:3378 with SMTP id
 11-20020a0562140d6b00b0064a8d393378mr3677303qvs.4.1696456962623; 
 Wed, 04 Oct 2023 15:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWm0g6H16N9HYYJk5UU6ejiKD7C56VCRUj+elrvoykYSXDRdCOCPTlDHtVa/l1BXaNyl5/3A==
X-Received: by 2002:a05:6214:d6b:b0:64a:8d39:3378 with SMTP id
 11-20020a0562140d6b00b0064a8d393378mr3677272qvs.4.1696456962195; 
 Wed, 04 Oct 2023 15:02:42 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 00/10] migration: Better error handling in rp thread,
 allow failures in recover
Date: Wed,  4 Oct 2023 18:02:30 -0400
Message-ID: <20231004220240.167175-1-peterx@redhat.com>
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

v3:
- Rebase to master after majority of Fabiano's series merged
- Dropped patch 2: "migration: Let migrate_set_error() take ownership"
  (When looking again, I'm not happy with neither that of my patch nor
   current code.  But in that case I prefer change nothing rather than
   changing from one ugly to another)
- Dropped a few Fabiano's R-b due to either rebase (return path thread now
  is recycled when pausing postcopy) or additional error_free() after I
  dropped patch 2

v1: https://lore.kernel.org/r/20230829214235.69309-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20230912222145.731099-1-peterx@redhat.com

This series allow better error handling in the postcopy return path thread,
so that we'll start to store the errors in MigrationState and can be seen
from query-migrate later, comparing to before where we do error_report()
and never remember the error.

Meanwhile, it allows double-failures to happen during postcopy recovery,
IOW, one can fail again right during RECOVER phase on both sides, even if
RECOVER phase should be an extremely small window.

Please have a look, thanks.

Fabiano Rosas (1):
  tests/migration-test: Add a test for postcopy hangs during RECOVER

Peter Xu (9):
  migration: Display error in query-migrate irrelevant of status
  migration: Introduce migrate_has_error()
  migration: Refactor error handling in source return path
  migration: Deliver return path file error to migrate state too
  qemufile: Always return a verbose error
  migration: Remember num of ramblocks to sync during recovery
  migration: Add migration_rp_wait|kick()
  migration: Allow network to fail even during recovery
  migration: Allow RECOVER->PAUSED convertion for dest qemu

 qapi/migration.json          |   5 +-
 migration/migration.h        |  21 +++-
 migration/qemu-file.h        |   1 +
 migration/ram.h              |   5 +-
 migration/migration.c        | 206 ++++++++++++++++++++++-------------
 migration/qemu-file.c        |  17 ++-
 migration/ram.c              |  76 +++++++------
 migration/savevm.c           |   3 +-
 tests/qtest/migration-test.c |  94 ++++++++++++++++
 migration/trace-events       |   4 +-
 10 files changed, 312 insertions(+), 120 deletions(-)

-- 
2.41.0


