Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8524E74C769
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEM-0005pY-Qi; Sun, 09 Jul 2023 14:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZEA-0004ea-Ru
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE7-0004Jn-Qb
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf107so8739125e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927621; x=1691519621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t83L6VQqehKor298fA996V/rrvqxT+XEe+3FbTWkw4k=;
 b=kQaUVUPQHaIfuWMdM6KPEnpd41H8weDogiYdg+ahuQs3fuP763VCmoofEAwrGNDZgU
 ClaVUgb7o3nX8Wq6TyTLefd68wl3OMFnhGtaX6OakKTb/BEgXjf2DzYr2s5wrcDbl5Ef
 KsrY7ehB00eBo2Waagk7yWeRBdi7X0824QYRBNh2iAGTxschPplO3hrvTFupOy6tVYeq
 uRwPBWQ1Tg1AwahAycLribuuWRmWI08vXyggTExjL8YmSH9VsZxBS5HW/+RHpktQRtT0
 Y4znok1w5Sl/ssuGasaIX04B2lurqO55J9RTupe523r8LAPilc31F0lsUF+bsnRrIbdf
 c0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927621; x=1691519621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t83L6VQqehKor298fA996V/rrvqxT+XEe+3FbTWkw4k=;
 b=V44QD8Fskcdkl0jLKHgIOPvCe0wsSyAsqTh+0POv1WA0Cju1lFVVD36Wy6DU77PeQd
 QKAckZb4sgHM5fC/osATRSH6ojIW1N/lk85gbCCO/L+sVpcqy7xLbg7e60v20E20RHF6
 2xOSemy71cIxljU9kJ1K5/xCDo9NL9Yi/dfNBJc6GInMPIJ9YPmzvxsni69v5KwLTxhl
 CiKzXF6hhTqtWc/pFn7dl/lxvq+xCsPO8n744GtlV8rURO6Cd+91cFTiV5rtdQM+skUn
 5zW2AMNmxgSr3G/eiM9Lr+O9lDhfZ/ewANrIAvUxt1s9GvaMOQOhu5hvO8VunhERgija
 C5NA==
X-Gm-Message-State: ABy/qLYOr/bq7XnOC7jg2IvTC49STE+HpX/IwVT2pSVpMMPw5nhj0T1n
 p/vMxHVSFlJtdFyamRwR2ObJpGrrSM0IliECvd45zg==
X-Google-Smtp-Source: APBJJlFGPnkG9jnMB62fakJYv2KbwyezP1/rAIco1iLmgsS/SQS2Up4zmrHL3n/wGsmMO4185Vjttw==
X-Received: by 2002:a7b:c8cd:0:b0:3fc:5d2:1f47 with SMTP id
 f13-20020a7bc8cd000000b003fc05d21f47mr3988040wml.20.1688927620957; 
 Sun, 09 Jul 2023 11:33:40 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 39/45] linux-user: Simplify target_munmap
Date: Sun,  9 Jul 2023 19:29:28 +0100
Message-Id: <20230709182934.309468-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

All of the guest to host page adjustment is handled by
mmap_reserve_or_unmap; there is no need to duplicate that.
There are no failure modes for munmap after alignment and
guest address range have been validated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-23-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 22c2869be8..c0946322fb 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -789,9 +789,6 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 
 int target_munmap(abi_ulong start, abi_ulong len)
 {
-    abi_ulong end, real_start, real_end, addr;
-    int prot, ret;
-
     trace_target_munmap(start, len);
 
     if (start & ~TARGET_PAGE_MASK) {
@@ -803,47 +800,11 @@ int target_munmap(abi_ulong start, abi_ulong len)
     }
 
     mmap_lock();
-    end = start + len;
-    real_start = start & qemu_host_page_mask;
-    real_end = HOST_PAGE_ALIGN(end);
-
-    if (start > real_start) {
-        /* handle host page containing start */
-        prot = 0;
-        for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
-        }
-        if (real_end == real_start + qemu_host_page_size) {
-            for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-                prot |= page_get_flags(addr);
-            }
-            end = real_end;
-        }
-        if (prot != 0) {
-            real_start += qemu_host_page_size;
-        }
-    }
-    if (end < real_end) {
-        prot = 0;
-        for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
-        }
-        if (prot != 0) {
-            real_end -= qemu_host_page_size;
-        }
-    }
-
-    ret = 0;
-    /* unmap what we can */
-    if (real_start < real_end) {
-        mmap_reserve_or_unmap(real_start, real_end - real_start);
-    }
-
-    if (ret == 0) {
-        page_set_flags(start, start + len - 1, 0);
-    }
+    mmap_reserve_or_unmap(start, len);
+    page_set_flags(start, start + len - 1, 0);
     mmap_unlock();
-    return ret;
+
+    return 0;
 }
 
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-- 
2.34.1


