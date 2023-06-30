Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C288E743C9E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4l-0007gT-4Z; Fri, 30 Jun 2023 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4g-0007bo-TE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4f-0003Pi-8T
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e34ab99fso2025483f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131328; x=1690723328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrYEO83mUZLefivMHniXeqFBDxyfnNPTYsBHzpccNBQ=;
 b=LXYUpdWrRnIAD1HM6dGh+2e903minFPvPqaLvgDsIHpVZ+3Mlh/GrzybUBu0gQR+Ug
 Yj3+hKguXBr/5DqXhG4Xe2qISjIS3VNDYDmqhXxmEeeugWB/t02EDUJulRT68/Cakr1o
 v/tMgCuHQ08x9wjzI6crDrfA8YtjGcTXYzrfSi+U8MQWltpFsNgZAavS1C3twDfLVWL8
 RBBWaOEThYCOz7z8K2eOP8E2qlWbLNb+vhLDx2ghcdKC+Fq71dgCwDGMLijVEe3uU1pe
 7pMGWqZWN+SfUTMYydRu7Yl29USxhRMoM10FoAXfLCjHYqE1W75ciu37El+lCNdZFNVD
 aHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131328; x=1690723328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrYEO83mUZLefivMHniXeqFBDxyfnNPTYsBHzpccNBQ=;
 b=YvluMkCbTxARkyFAEv05XWklGZt88XSIgX+33LUgxRScgDcUKdMLVWASkYgIy0mddH
 QwQnV5rXckeAuUlIdcxWcaVHNQBPi0on5h0fBhT/MMfb96QvH9iKuAusooEIf3D+MC2T
 NEZnuxYPpT4bp2Op6aDvDoAdQIrlpOHwiDdwDm82h543QgTz0swryX8N6qgAQ4u4fxyd
 59Fg5Tgs8OO844Mb2QnT8fuVylL914DXl1x2PNBgQwK2rXLF9PhM4QPILQ4MgOEP8ZT+
 S4T+NcjRBitR5aOVD4ncASa42CVwWQdElzSNetxCWu+pJxDPUFgsA9CZFFWdZa8QPQrF
 Ex2w==
X-Gm-Message-State: ABy/qLY5p2+slTcMZFVeES4Pa5FZ3TlxuPuzuLml3sRYYW1uGsMfYZxp
 2onWXVlmu3eUUmMIeN7OLv+sXJzNWbdifHOE/sPnYg==
X-Google-Smtp-Source: APBJJlEy+WFHtHVYVoyWWsfXT3QgakM0FCl36Gku7relYk6vN/jPtye+CmHpxhHkVA3Ln+NXYA2BJA==
X-Received: by 2002:adf:fc12:0:b0:314:14ea:e2db with SMTP id
 i18-20020adffc12000000b0031414eae2dbmr2088627wrr.0.1688131327731; 
 Fri, 30 Jun 2023 06:22:07 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 09/24] linux-user: Implement MAP_FIXED_NOREPLACE
Date: Fri, 30 Jun 2023 15:21:44 +0200
Message-Id: <20230630132159.376995-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cb5369d2d1..41c2f09fd5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -502,7 +502,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      * If the user is asking for the kernel to find a location, do that
      * before we truncate the length for mapping files below.
      */
-    if (!(flags & MAP_FIXED)) {
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
@@ -544,7 +544,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
 
-    if (!(flags & MAP_FIXED)) {
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         unsigned long host_start;
         void *p;
 
@@ -593,6 +593,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
+        /* Validate that the chosen range is empty. */
+        if ((flags & MAP_FIXED_NOREPLACE)
+            && !page_check_range_empty(start, end - 1)) {
+            errno = EEXIST;
+            goto fail;
+        }
+
         /*
          * worst case: we cannot map the file because the offset is not
          * aligned, so we read it
@@ -608,7 +615,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 goto fail;
             }
             retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
-                                  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
+                                  (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
+                                  | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1) {
                 goto fail;
-- 
2.34.1


