Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215AF7CCE52
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqqZ-0007od-8e; Tue, 17 Oct 2023 16:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqqX-0007oQ-JN
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqqW-0003Nm-7x
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697575159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h6k+g0B0Vg+QIBJMjs/o4gmlz5GREYx4idsrMCdF43s=;
 b=Z2uApEo9VPSUn0UHZPlg3Bce2+OkJc/zMeJ1Ixrxoj5wWwRSVgxqQZDPRsyXJYiCHCkiKG
 tehHLhsUQkqIC8mCbF/K4lsNZhidoBXnQBD6fVuZu8+aNrLnOykXRifH4PgVSEpoMasnOr
 /zBPSwTT1r5VqXf9jmrBzMQqdSzuHag=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-sQ_NgseiPKKJG-v6tR9aOg-1; Tue, 17 Oct 2023 16:38:57 -0400
X-MC-Unique: sQ_NgseiPKKJG-v6tR9aOg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7756d0fb11dso103480585a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697575137; x=1698179937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h6k+g0B0Vg+QIBJMjs/o4gmlz5GREYx4idsrMCdF43s=;
 b=G52dkPQsAIS8a1BW80Y0BsshQ3UjNOOW+KSPs6sucYL2CZgE+y2bziJbAOMEg9aTLL
 5wIpezxjUbFvv0YqbwnHsh12JvPh6NwS3l1JyBc3nj61EQi2+QWl7YVDZYLbF1gbeti7
 hYySZqcrRS/CC4LGNlTzDeLH68faekCe5jOZrTmx153pTMEKiG0d1jKGPPDnxp2Kydib
 +CtLqVJJrs+DDiC4dgK4T3geCYrfB2re3ygU473Ahx1QRioc2GWSnyKqQSw43k7V3n22
 aknTjobjnw+6WMt4JSY/s/QnKT8zm61cVBBKz2UOV1YV3TOfeOTYZBQuJU3uPt6zRkL7
 VvsQ==
X-Gm-Message-State: AOJu0YyfVDAIKW4bts/6VkcPQTy2t+1kbnQOhB952k/Qg17i42/ZQatv
 HAgbarbuziAQNmFp+RpcsVBNZ6sgm86uP/D1d5UNtPWBdLi5wIIFstvt0dyndKinAvOCxaiZu9W
 +qaQ8RWQe9oodp11d0hg9naPZ52UB/BTvSx/ogdLBrITFwTV7xXtRCMzME7b4jdJ22sIm05CL
X-Received: by 2002:a05:620a:488a:b0:76e:f686:cad5 with SMTP id
 ea10-20020a05620a488a00b0076ef686cad5mr3517124qkb.5.1697575136998; 
 Tue, 17 Oct 2023 13:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi7j8k4uZfk5/FemQxyBrcixsVxxOrCeCE2qwEy5b8VlOiT1nMp9NWaMTyIJOVU7pHER5fag==
X-Received: by 2002:a05:620a:488a:b0:76e:f686:cad5 with SMTP id
 ea10-20020a05620a488a00b0076ef686cad5mr3517113qkb.5.1697575136687; 
 Tue, 17 Oct 2023 13:38:56 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a05620a408900b007677347e20asm940487qko.129.2023.10.17.13.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:38:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH] migration: Fix parse_ramblock() on overwritten retvals
Date: Tue, 17 Oct 2023 16:38:55 -0400
Message-ID: <20231017203855.298260-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
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

It's possible that some errors can be overwritten with success retval later
on, and then ignored.  Always capture all errors and report.

Reported by Coverity 1522861, but actually I spot one more in the same
function.

Fixes: CID 1522861
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c844151ee9..d8bdb53a8f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3888,6 +3888,8 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
         ret = qemu_ram_resize(block, length, &local_err);
         if (local_err) {
             error_report_err(local_err);
+            assert(ret < 0);
+            return ret;
         }
     }
     /* For postcopy we need to check hugepage sizes match */
@@ -3898,7 +3900,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             error_report("Mismatched RAM page size %s "
                          "(local) %zd != %" PRId64, block->idstr,
                          block->page_size, remote_page_size);
-            ret = -EINVAL;
+            return -EINVAL;
         }
     }
     if (migrate_ignore_shared()) {
@@ -3908,7 +3910,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             error_report("Mismatched GPAs for block %s "
                          "%" PRId64 "!= %" PRId64, block->idstr,
                          (uint64_t)addr, (uint64_t)block->mr->addr);
-            ret = -EINVAL;
+            return -EINVAL;
         }
     }
     ret = rdma_block_notification_handle(f, block->idstr);
-- 
2.41.0


