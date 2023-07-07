Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881974B03A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhM-0002WV-6x; Fri, 07 Jul 2023 07:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh8-0002Jy-PC; Fri, 07 Jul 2023 07:32:15 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh7-0006eI-77; Fri, 07 Jul 2023 07:32:14 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1b056276889so1677053fac.2; 
 Fri, 07 Jul 2023 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729531; x=1691321531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3z7ZkmerTt3FkKmNM52Gq2r4Uh/UMGM/N6i9sZCzcwE=;
 b=r0Lhdo7R6Yo0Ql4wF08mV5P8h9EWScwIshjLJQbU6vyfYvcWt2WKTM92I3Ye+PfYBq
 yYAsBhp14x9gf6uEpL4z+lhJee8zfA10I3VvvWOAE47zguuw+Vg5Pvyi1/AxQXRAAdco
 LoAhtj/J6suYsBq0PWNOecASyZu40LVlRW9SjabP9Zp7/lxagBPUUVyCsE/zM1Je4XLb
 q38WmKryFOXlpP+id3qzzVxp82ekoCTSI+vYFzpnOTw2Xtf8cdFJMi5AFTL5FTuYPkxk
 JM+oihhfvQYgLLamcvYXhT1srwNsgpQndLcnMYZUHYSbzYm8EWFZHsWi2rypXSYC4vjx
 +nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729531; x=1691321531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3z7ZkmerTt3FkKmNM52Gq2r4Uh/UMGM/N6i9sZCzcwE=;
 b=Nmd3AppNhAo39kuAZOLH1bSJiDu/Wii2O8n9kYuIYN6DaHWICSSBFjIZIhO8n07Uj8
 V/FWZJ6WmKos2TEvnY1i/uZ9Aw8RzsMPFGhIu4Dl0X0DDqfBOeKNAykb8QfwgphSCx8o
 BT3Pz1EGZEXB8iPfsN6ehHHyaZp+KrGjWvKVORS/wawvowUSSmegWY5oe9ZUW9Muv8a6
 Ux+5snA7Q5ZOKw6IVXLTCVwuKfUxier/gn9fKZj1I7GnBgx4SgDksFDcgDq5/fCLMX9z
 YY7AUACTj63fQK2kQyUklTgpSkimA7AvMY/doQRdGffFdYf2x4r/RKcIwQ9EE7yJAz0m
 2qNA==
X-Gm-Message-State: ABy/qLZTkldfusxe/UePvq1PJm3l2XONezHzaT2Qs2ettCOO4/sqMSkn
 bzqG9IigS/SDHIbFviq0UkI3goRbOaA=
X-Google-Smtp-Source: APBJJlFwLk+VnjF/Ro3cSqlUnQRtMAzCrvGIiys4+CiC3yye1va9C1CSVlTkPvx68DRdIi6lptRqQg==
X-Received: by 2002:a05:6870:d193:b0:1b3:d10c:440d with SMTP id
 a19-20020a056870d19300b001b3d10c440dmr5450357oac.9.1688729531680; 
 Fri, 07 Jul 2023 04:32:11 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:11 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 19/60] pnv/xive2: Fix TIMA offset for indirect access
Date: Fri,  7 Jul 2023 08:30:27 -0300
Message-ID: <20230707113108.7145-20-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Direct TIMA operations can be done through 4 pages, each with a
different privilege level dictating what fields can be accessed. On
the other hand, indirect TIMA accesses on P10 are done through a
single page, which is the equivalent of the most privileged page of
direct TIMA accesses.

The offset in the IC bar of an indirect access specifies what hw
thread is targeted (page shift bits) and the offset in the
TIMA being accessed (the page offset bits). When the indirect
access is calling the underlying direct access functions, it is
therefore important to clearly separate the 2, as the direct functions
assume any page shift bits define the privilege ring level. For
indirect accesses, those bits must be 0. This patch fixes the offset
passed to direct TIMA functions.

It didn't matter for SMT1, as the 2 least significant bits of the page
shift are part of the hw thread ID and always 0, so the direct TIMA
functions were accessing the privilege ring 0 page. With SMT4/8, it is
no longer true.

The fix is specific to P10, as indirect TIMA access on P9 was handled
differently.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230703080858.54060-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e8ab176de6..82fcd3ea22 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1590,6 +1590,18 @@ static uint32_t pnv_xive2_ic_tm_get_pir(PnvXive2 *xive, hwaddr offset)
     return xive->chip->chip_id << 8 | offset >> xive->ic_shift;
 }
 
+static uint32_t pnv_xive2_ic_tm_get_hw_page_offset(PnvXive2 *xive,
+                                                   hwaddr offset)
+{
+    /*
+     * Indirect TIMA accesses are similar to direct accesses for
+     * privilege ring 0. So remove any traces of the hw thread ID from
+     * the offset in the IC BAR as it could be interpreted as the ring
+     * privilege when calling the underlying direct access functions.
+     */
+    return offset & ((1ull << xive->ic_shift) - 1);
+}
+
 static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
 {
     PnvChip *chip = xive->chip;
@@ -1612,14 +1624,16 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
     uint64_t val = -1;
 
     pir = pnv_xive2_ic_tm_get_pir(xive, offset);
+    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        val = xive_tctx_tm_read(NULL, tctx, offset, size);
+        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
     }
 
     return val;
@@ -1629,13 +1643,15 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
                                            uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
 
     pir = pnv_xive2_ic_tm_get_pir(xive, offset);
+    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        xive_tctx_tm_write(NULL, tctx, offset, val, size);
+        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
     }
 }
 
-- 
2.41.0


