Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58464787EE3
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 06:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZO5d-0000ip-Aq; Fri, 25 Aug 2023 00:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZO5b-0000iF-5I; Fri, 25 Aug 2023 00:06:27 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZO5Z-0002a7-0m; Fri, 25 Aug 2023 00:06:26 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a81154c570so345822b6e.1; 
 Thu, 24 Aug 2023 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692936383; x=1693541183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgyduE1cNWQmXiArc/LpZuyhlEVZYQGVKd5wnAV5op8=;
 b=DtAEp+x48eypFDvRUNplws+xJa1sRcnYJ4U3VOLkipBVE1StMZ/i7a5WXBbs6tli5I
 3ZpjQwqbsBrJyMx7i7xB8+cyIPYH7OjvhQhU85Qh3Cpvobtzj/y4n9kkNbNOrCXQysK5
 cPaLqzyXng1A2Gh0WhgNgxFkBlUKUrNI3zePQVF4j9F2mnwfaxCgKPmXyQKjouySZ3mR
 E0p0HGs7hwb9I3KFLz2b9uf/G0xR0Je7WGDRcb1yNPBWjxvaVCD+upw1LPFg9AURLvqJ
 CAhJbrpPtF3B+tAqM7+xPgumvog3cikzvaTK32SMqtORLgy+hs3dIQ1ShcJqgyVpUe9d
 Em3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692936383; x=1693541183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgyduE1cNWQmXiArc/LpZuyhlEVZYQGVKd5wnAV5op8=;
 b=VR+mY3VO3zsQj81D1qg3lXzxjDsKDbmNXmegPdlUP3Z17LDzDvWWjvYsZOK7zOgFmJ
 iaK8xLGaH8Hxxb7TdNz5lZp4anQMrEmkTur2VWc60qYBrvvU5Iq+Z0Qpi4PYWF2MV53u
 0vy/7VkC1crxvotJYgKU+U0zjoGdjmPjZ6Qh1pmkLJRbdxEbBspWdI2OX1B+g83DuOQF
 8AVTc3ZxV2cGTAjaYSPhc3YNQ+u5FgMqXKOkffruj017L5EroeGRqjT6SriZo7ZI7p41
 AyDNx/9VNSdZ3KwWm/iafmouUHnD4AhzP2hSPQ2Oz7VGRAVkfbmzaR9MO2HuV2DK/yUZ
 lL/g==
X-Gm-Message-State: AOJu0YwPh9DnqURAVnSMEReiu23gtmEcJv4tMPohyOkZDUKmj0Tiy9ES
 1IsT0ruIAMyDeGhJCvLiUgL9ICPW/dLkCo39
X-Google-Smtp-Source: AGHT+IEOzW4Nvrj3lbVExdGP6QiOm9mJNYmrSmsp5BI5DU1MxtlxWJh90gUtI1+tI+yUGfdV3foH6Q==
X-Received: by 2002:a05:6808:181:b0:3a7:6acd:c7c with SMTP id
 w1-20020a056808018100b003a76acd0c7cmr1722489oic.18.1692936382359; 
 Thu, 24 Aug 2023 21:06:22 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.102]) by smtp.gmail.com with ESMTPSA id
 a23-20020a637057000000b00563e1ef0491sm455068pgn.8.2023.08.24.21.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 21:06:21 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, stefanha@redhat.com,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2] block/file-posix: fix update_zones_wp() caller
Date: Fri, 25 Aug 2023 12:05:56 +0800
Message-Id: <20230825040556.4217-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x22d.google.com
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

When the zoned request fail, it needs to update only the wp of
the target zones for not disrupting the in-flight writes on
these other zones. The wp is updated successfully after the
request completes.

Fixed the callers with right offset and nr_zones.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b16e9c21a1..55e7f06a2f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2522,7 +2522,8 @@ out:
         }
     } else {
         if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
-            update_zones_wp(bs, s->fd, 0, 1);
+            /* write and append write are not allowed to cross zone bounaries */
+            update_zones_wp(bs, s->fd, offset, 1);
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


