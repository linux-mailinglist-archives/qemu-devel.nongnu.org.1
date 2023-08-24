Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB478773A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZEJm-0002TU-IS; Thu, 24 Aug 2023 13:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZEJc-0002T8-GN; Thu, 24 Aug 2023 13:40:16 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZEJY-00033X-Kz; Thu, 24 Aug 2023 13:40:16 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a7e68f4214so79688b6e.1; 
 Thu, 24 Aug 2023 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692898808; x=1693503608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RzPM26uez5O1xvDDJF/49FdssB7dwlFCv22zegc30oI=;
 b=Zfhv0qqPiC28y41qW93Vq26l6fd03uq5UpGooJ45qAybFsG+46mhr/b7hsNY3/fVr0
 AS01QjS1Cu71HBBajB18yFCvZiEra/FrFr5Ict94W+/A8KgnggrXLFXs2KoXWQd29nA+
 wGynRaThs2hmj0Ub+K4qfr3Ku3oyry8uRpOP1l1uDPZ3b+98dpEfEE4r2y/16Lbn/iJv
 Oeq83QKQjurlrBWY9k8XpgxnhSFIupyStX3iZwfR8TKJkUkSCaiA76Kvxw22gVNg7Gt+
 k/qHPDjae/A0wTZniyHzlGYGnq+wi8nScW/s0Wjhh+SMBRRADc1R93wpsIn6YUt22qgc
 WH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692898808; x=1693503608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzPM26uez5O1xvDDJF/49FdssB7dwlFCv22zegc30oI=;
 b=VPhLHxcexNlVwBTqftufQibklup8LSbEPjUY4SAy0iEcTP36DX7p6S7v0dgM8nCGWI
 8ZF5rRno9NIVv8537BkMVc0ayCHkcCKmeJ9lCGAFpiIX15AxgKDyPLoIAE3Kv9KdIKVF
 mztIAL8tjjbt29ZFCYHS6UUmjf2pgyUdlkm0+Z9fXmbq/vm5U1zu/Zs5oYpf/l1BVzHW
 M2hB5kk38wyIDX+n4HosaRLCbtb5NXqXGr4JncT3gTMWJAbC2fX4dbm9IdCWOPtrRtKu
 N0q0UUDB5YpZXL4WyAQhDEv2Fx6oN3kzSFq69Oy+F63N9a3aTQDSc2HRBi5MqXTE+y+l
 BmIg==
X-Gm-Message-State: AOJu0YyMAMO8NqjHikQCrPqk9E0uImYG8gETgmHo16aiiywFWHz/0iME
 ehm0S6XKM7RT1yVt3tDZmhzYckLGbqLIWKFzgWs=
X-Google-Smtp-Source: AGHT+IEPrSw6sy1CXUEoPATMSDYG0ngVdLtF17F2ap1+/Bv2ifjdDeiZoKsQGAYXOkzys2C+SExlcw==
X-Received: by 2002:a05:6808:2228:b0:3a7:4a89:7531 with SMTP id
 bd40-20020a056808222800b003a74a897531mr539538oib.10.1692898807792; 
 Thu, 24 Aug 2023 10:40:07 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.102]) by smtp.gmail.com with ESMTPSA id
 u26-20020a63b55a000000b005695db23156sm10306877pgo.57.2023.08.24.10.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 10:40:07 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, qemu-block@nongnu.org,
 stefanha@redhat.com, hare@suse.de, dmitry.fomichev@wdc.com,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH] block/file-posix: fix update_zones_wp() caller
Date: Fri, 25 Aug 2023 01:39:57 +0800
Message-Id: <20230824173957.8472-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the zoned requests that may change wp fail, it needs to
update only wps of the zones within the range of the requests
for not disrupting the other in-flight requests. The wp is updated
successfully after the request completes.

Fixed the callers with right offset and nr_zones.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b16e9c21a1..22559d6c2d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2522,7 +2522,8 @@ out:
         }
     } else {
         if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
-            update_zones_wp(bs, s->fd, 0, 1);
+            update_zones_wp(bs, s->fd, offset,
+                            ROUND_UP(bytes, bs->bl.zone_size));
         }
     }
 
@@ -3472,7 +3473,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
                         len >> BDRV_SECTOR_BITS);
     ret = raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
     if (ret != 0) {
-        update_zones_wp(bs, s->fd, offset, i);
+        update_zones_wp(bs, s->fd, offset, nrz);
         error_report("ioctl %s failed %d", op_name, ret);
         return ret;
     }
-- 
2.40.1


