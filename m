Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD046798B3D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew0-0005Ja-6u; Fri, 08 Sep 2023 13:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevx-00058Z-0x
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00017b-Kf
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so24469135e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192765; x=1694797565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UGPp9DRJTi6pOPUAFTUhyEuJ1Dfy48iJYxSCu1O9UrY=;
 b=PsZCDSM5a2AOJBP1jxgI69swsYs/jwukfthaJ/B1nmr9x0ea/obM4nWxGzQsNtlrGR
 aAIVt1hLBkKp6HWm0hEWozMFBZwgm0+1mYupHnd5gOSL5b0CunshQy6grnkexWtjQdcK
 SweaCUV2SA8Wnve9vJaEvvRGqOHYUyOPzs4Kv50odIF6S+NwtD24EHoyQvC+gFQcAayB
 Y5natZs0yVqxHEIsdRl5/KCBIgzxnXiZ6quqCxlq12p1AsxrDZvnxDUnEoahvAXdPb9U
 nGdzPuYfBeAIywzeLC7PLiXs2C1cmzSZmMkREQTF2SMtzFJkq6Fj+6xDEnbJDBLrpNqF
 CmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192765; x=1694797565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGPp9DRJTi6pOPUAFTUhyEuJ1Dfy48iJYxSCu1O9UrY=;
 b=cazma50Wt5GubC4jqs3Eacm89Nzhyqx8qv5cKZi6n5/LP2IiKl+SDfEjjf4btCMqpZ
 rhD+BYZ9IeLHqRkk8IT5mS3DBjTgF2lAcna/iB6COYP1ZWuDzb/dCIPMBDmBRxGlNxxp
 isseqRFINl0kjEnL21FXFgcVGPkrAUFFSnIpyTWgRA6cyypWZio6wTYdxyD+QuDJGrO4
 nybbUrC46phftF46RyHbq6YgTyszbGn9SgP9fCdNBWs1iuPKq5rsbExRKbuNQU/oNp24
 vJselFcndzEGTlZNZmWyeEYIgvgSVuo/XQALEmquUaStlJ7GjSQ1JeZ2bhgt32HiWLi6
 ZuCw==
X-Gm-Message-State: AOJu0YwU4OqjhnyXMwkgBvC2wpOdUVcp1LyJ/oEEOkbrZ7ccIwi8EWqw
 l2k0EiPNLU3WydR4+Oj0/h1JPbxJQcqKEMNUBSw=
X-Google-Smtp-Source: AGHT+IGOrkQ1SqgEiWXfnTtQEDL1fWE1jrxWbmvsGHu2MttzUG8CuiWXz2M5LeRAP2BRaCuBW8XOIw==
X-Received: by 2002:a7b:ce85:0:b0:401:bf62:9456 with SMTP id
 q5-20020a7bce85000000b00401bf629456mr2500010wmj.8.1694192765054; 
 Fri, 08 Sep 2023 10:06:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] hw/intc/arm_gicv3_its: Avoid maybe-uninitialized error
 in get_vte()
Date: Fri,  8 Sep 2023 18:05:41 +0100
Message-Id: <20230908170557.773048-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix when using GCC v11.4 (Ubuntu 11.4.0-1ubuntu1~22.04) with CFLAGS=-Og:

  [4/6] Compiling C object libcommon.fa.p/hw_intc_arm_gicv3_its.c.o
  FAILED: libcommon.fa.p/hw_intc_arm_gicv3_its.c.o
      inlined from ‘lookup_vte’ at hw/intc/arm_gicv3_its.c:453:9,
      inlined from ‘vmovp_callback’ at hw/intc/arm_gicv3_its.c:1039:14:
  hw/intc/arm_gicv3_its.c:347:9: error: ‘vte.rdbase’ may be used uninitialized [-Werror=maybe-uninitialized]
    347 |         trace_gicv3_its_vte_read(vpeid, vte->valid, vte->vptsize,
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    348 |                                  vte->vptaddr, vte->rdbase);
        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/intc/arm_gicv3_its.c: In function ‘vmovp_callback’:
  hw/intc/arm_gicv3_its.c:1036:13: note: ‘vte’ declared here
   1036 |     VTEntry vte;
        |             ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230831131348.69032-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 43dfd7a35c7..5f552b4d37f 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -330,23 +330,20 @@ static MemTxResult get_vte(GICv3ITSState *s, uint32_t vpeid, VTEntry *vte)
     if (entry_addr == -1) {
         /* No L2 table entry, i.e. no valid VTE, or a memory error */
         vte->valid = false;
-        goto out;
+        trace_gicv3_its_vte_read_fault(vpeid);
+        return MEMTX_OK;
     }
     vteval = address_space_ldq_le(as, entry_addr, MEMTXATTRS_UNSPECIFIED, &res);
     if (res != MEMTX_OK) {
-        goto out;
+        trace_gicv3_its_vte_read_fault(vpeid);
+        return res;
     }
     vte->valid = FIELD_EX64(vteval, VTE, VALID);
     vte->vptsize = FIELD_EX64(vteval, VTE, VPTSIZE);
     vte->vptaddr = FIELD_EX64(vteval, VTE, VPTADDR);
     vte->rdbase = FIELD_EX64(vteval, VTE, RDBASE);
-out:
-    if (res != MEMTX_OK) {
-        trace_gicv3_its_vte_read_fault(vpeid);
-    } else {
-        trace_gicv3_its_vte_read(vpeid, vte->valid, vte->vptsize,
-                                 vte->vptaddr, vte->rdbase);
-    }
+    trace_gicv3_its_vte_read(vpeid, vte->valid, vte->vptsize,
+                             vte->vptaddr, vte->rdbase);
     return res;
 }
 
-- 
2.34.1


