Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04982A397
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:53:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNgV9-0003iF-LT; Wed, 10 Jan 2024 16:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUx-0003fO-Cw
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:31 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUt-0005k7-C1
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:28 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7831362c9bcso356011985a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704923546; x=1705528346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNe84Wm/eO/XQH/99RqV1VT7/D2nQwtaPsBh5uvsHFY=;
 b=S4YJkeK12jwLuaSCbYc56I/O5CQa+IiWGgvr3WCpBP1ctclCWCykRYTbWxGwyop81d
 Hgbo1XecebJ83kSPkKiWyfFMgFMp0PjdB3XIMa6bz+geml7PFEbqpIIf0wQEjbw0ovQG
 TZugNPSo9F1q7symZnEJUs94Uo0/iU5sJ/ZCpxylUG8nixOp7ucPcUTHQ2ac1YhIyHc+
 vLZ2hHpYBIUNynMdy42wZcHNdF86bx6tChTfCg1VJSSQN3vNAVvGwYToHMHbQBX7l2Y/
 oZxqqIa127mHFVBMsgmQHASDfbb1Lfc19GicpMcrWSh2q45HhX2abB/eF5cv3khEb0lu
 JeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704923546; x=1705528346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNe84Wm/eO/XQH/99RqV1VT7/D2nQwtaPsBh5uvsHFY=;
 b=a891wmEh0fDjUyBmME4J+xoQwKNFiy9v9Y6/mc0LtZhcMvsOXil70lCCGedapYpERr
 mehvFQvezxRSf+mlPCcsxEM5j+zLt3WyGtME0UJTf6C1X3p+9ojBrEdFP/IxqZQiBkdZ
 ORJ+ulC05GrCUNv5jP+uoyuaKLlQb6PlCD1mZwPnTtBLDZdkeQPZmFmzLl5atmNkd+bX
 XbWgcCY9eIrTXdnvOGOQwWdbV+vk3/ux6IHCp20tUobwZLP7L65O0BkiFlwzPdo2md/9
 MxSey4kRt7vTKaHv0m4iKsBNyOK+dXDeflOwnBhfonIp5S7viAakjDutrxRlslpXyiCt
 iRJw==
X-Gm-Message-State: AOJu0YxgT9DknlDt/+A928LYwje4XQX6ZyKQYbGtMgBL6NCB+vONIPGB
 b8dAE4RdRE0mgrBAoqbnUgtU3Kcr54XJN/On/fpxIf+xxa3CwpAU
X-Google-Smtp-Source: AGHT+IHlFlSVkXj492KWbLsE53t7YF//BaKYu7KfEx78xkqXNl0ddhI/4jKMFBzbRJQn1kS6GUTUZA==
X-Received: by 2002:a05:620a:2589:b0:783:1a6e:99bd with SMTP id
 x9-20020a05620a258900b007831a6e99bdmr256898qko.53.1704923546267; 
 Wed, 10 Jan 2024 13:52:26 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b0078313c87609sm1888387qki.100.2024.01.10.13.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 13:52:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Natanael Copa <ncopa@alpinelinux.org>,
	qemu-stable@nongnu.org
Subject: [PULL 4/4] util: fix build with musl libc on ppc64le
Date: Thu, 11 Jan 2024 08:52:04 +1100
Message-Id: <20240110215204.9353-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215204.9353-1-richard.henderson@linaro.org>
References: <20240110215204.9353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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

From: Natanael Copa <ncopa@alpinelinux.org>

Use PPC_FEATURE2_ISEL and PPC_FEATURE2_VEC_CRYPTO from linux headers
instead of the GNU specific PPC_FEATURE2_HAS_ISEL and
PPC_FEATURE2_HAS_VEC_CRYPTO. This fixes build with musl libc.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1861
Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
Fixes: 63922f467a ("tcg/ppc: Replace HAVE_ISEL macro with a variable")
Fixes: 68f340d4cd ("tcg/ppc: Enable Altivec detection")
Message-Id: <20231219105236.7059-1-ncopa@alpinelinux.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cpuinfo-ppc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 1ea3db0ac8..b2d8893a06 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -6,10 +6,10 @@
 #include "qemu/osdep.h"
 #include "host/cpuinfo.h"
 
+#include <asm/cputable.h>
 #ifdef CONFIG_GETAUXVAL
 # include <sys/auxv.h>
 #else
-# include <asm/cputable.h>
 # include "elf.h"
 #endif
 
@@ -40,7 +40,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= CPUINFO_V2_06;
     }
 
-    if (hwcap2 & PPC_FEATURE2_HAS_ISEL) {
+    if (hwcap2 & PPC_FEATURE2_ISEL) {
         info |= CPUINFO_ISEL;
     }
     if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
@@ -53,7 +53,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
              * always have both anyway, since VSX came with Power7
              * and crypto came with Power8.
              */
-            if (hwcap2 & PPC_FEATURE2_HAS_VEC_CRYPTO) {
+            if (hwcap2 & PPC_FEATURE2_VEC_CRYPTO) {
                 info |= CPUINFO_CRYPTO;
             }
         }
-- 
2.34.1


