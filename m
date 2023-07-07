Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AA74B018
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhj-00031j-Mz; Fri, 07 Jul 2023 07:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhb-0002xX-GB; Fri, 07 Jul 2023 07:32:44 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhZ-0006mp-Gv; Fri, 07 Jul 2023 07:32:42 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b8baa72c71so1620061a34.2; 
 Fri, 07 Jul 2023 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729560; x=1691321560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0IGfw6Xlvn6Ruh1BQWIPvcYz0xr5/Lc2s74HF43lAY=;
 b=FNHe+uSvx2JCJsqlq33vQk0k6Mu7GqPSuT58xpv+6VReuzeJVCEBmStnzdjQMNAQo7
 GS/5TPzm3yvwVd64PHZZPlYQOkwYn0sf5eq9b+dKjOt7AaQUhldiIWOj6eeHb2WdPxB7
 kQRtUJG2FJwt+vxUF5ra7W7leJeZmSNWDLzhjYJ6hdAjMLZ31ZuulTNjvP3LUh/x4fVo
 zFoKOL5nDed2Mg8MZgWwR6KxiIjCm51hHfDmhmTkRee7joiqt3fpF1QE0iFdw02tJJ7P
 kmwKlJuoIdCf22l5WcLUkhK8p+Fn0qcAuY9WzWA1TNPgTp5pQnvYL4Y67yORLE263Ehc
 R3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729560; x=1691321560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0IGfw6Xlvn6Ruh1BQWIPvcYz0xr5/Lc2s74HF43lAY=;
 b=XGgwl3TZuceM+l4PA92865VJOSMN/xikGVlJORSB/LZJfMEABE+IAg7ZCH0YhALdl/
 asAgwEazdmJVEDAprJdbF1cND10wc14aq+1IGhTJQ25QSRb2ewAEq1Fr2YSb0zfWZilC
 UWzgwMbHkVxQLJtQRZlCG9gPEoDRCBx9u7U6aCoEnHmgMNELxYVYo19kj1WNmUsjeo/o
 xKKLpy4vsxCYQR9fr9J2dYrcC/ZFjkXP2tehW98krp5+HYcJhfnMWKho26zSWLEHEhcF
 xpN1NT63SdDLCgM3y8xLoRrVNchj9dGdx3neoCi+fuZkJhnnk/ohy327749Tu4xQoslT
 P+0Q==
X-Gm-Message-State: ABy/qLbcdxAnVSIIYotx579KYnQpgNSqjzsqhyUe0ZU2xb8mhoWeICvk
 30WaxSWuDAKrQ98135jsPl/Bkux8+8E=
X-Google-Smtp-Source: APBJJlE21IaAUIcUbROG30dZolyCi5UGRwrg2DHmCc+oi85uUPis/d1L9U+OsQMhaazclU0EiQBsoQ==
X-Received: by 2002:a05:6830:1d42:b0:6b5:ddf4:cb59 with SMTP id
 p2-20020a0568301d4200b006b5ddf4cb59mr4800571oth.28.1688729559863; 
 Fri, 07 Jul 2023 04:32:39 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:39 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 30/60] pnv/xive2: Always pass a presenter object when accessing
 the TIMA
Date: Fri,  7 Jul 2023 08:30:38 -0300
Message-ID: <20230707113108.7145-31-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
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

The low-level functions to access the TIMA take a presenter object as
a first argument. When accessing the TIMA from the IC BAR,
i.e. indirect calls, we currently pass a NULL pointer for the
presenter argument. While it appears ok with the current usage, it's
dangerous. And it's pretty easy to figure out the presenter in that
context, so this patch fixes it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230705081400.218408-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 82fcd3ea22..bbb44a533c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1624,6 +1624,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
     hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
@@ -1633,7 +1634,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
     hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
+        val = xive_tctx_tm_read(xptr, tctx, hw_page_offset, size);
     }
 
     return val;
@@ -1643,6 +1644,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
                                            uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
     hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
@@ -1651,7 +1653,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
     hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
+        xive_tctx_tm_write(xptr, tctx, hw_page_offset, val, size);
     }
 }
 
-- 
2.41.0


