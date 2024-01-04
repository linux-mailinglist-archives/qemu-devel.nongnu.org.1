Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F4824853
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaH-0001Lq-4l; Thu, 04 Jan 2024 13:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaB-0001HM-A1
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSa9-0005EL-8k
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CA227CE1BE2;
 Thu,  4 Jan 2024 18:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E17C433C8;
 Thu,  4 Jan 2024 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393398;
 bh=ZzR10xynnWGSPmqQ+FJAOn8jb0OTmW4poPHUkB6v5Cs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pwB2/jEsxWE+/TKeYEPmVT0SSj1G5vt9IB9fH8aJwEfyHNdfdSlzqYUJRzA/zJNZS
 511HVfw0SqTHL/uJVazpoZpzGeKyzoZYFFTZNaprjWRNhQORL50pTlIIhbeUjFrEAN
 xQSefyM8qHbpGmghOudlyl4mcewHzjgMzC9UjJlAk4PPAsj6ydYOBj/Z9Z+lT1T9uy
 zfX0g0rc4csA5EYM+VYL8nCHevdXvalgOc1/OsO5lihixRqzu/sjWlSZpkl42i0rxs
 tGz0t9jGl58TS2KhrcOrwUcZ7Imav0UlTlieAyxo/60CuOUGFlKR8+064y4aqwMBwm
 ejQefJX7D1iaA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 3/9] hw/pci-host/astro: Add missing astro & elroy registers
 for NetBSD
Date: Thu,  4 Jan 2024 19:36:22 +0100
Message-ID: <20240104183628.101366-4-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104183628.101366-1-deller@kernel.org>
References: <20240104183628.101366-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

NetBSD accesses some astro and elroy registers which aren't accesses
by Linux yet. Add emulation for those registers to allow NetBSD to
boot further.
Please note that this patch is not sufficient to completely boot up
NetBSD on the 64-bit C3700 machine yet.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 7d68ccee7e..cb2c8a828d 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -166,6 +166,8 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
     trace_elroy_write(addr, size, val);
 
     switch ((addr >> 3) << 3) {
+    case 0x000: /* PCI_ID & PCI_COMMAND_STATUS_REG */
+        break;
     case 0x080:
         put_val_in_int64(&s->arb_mask, addr, size, val);
         break;
@@ -175,6 +177,9 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
     case 0x200 ... 0x250 - 1:   /* LMMIO, GMMIO, WLMMIO, WGMMIO, ... */
         put_val_in_arrary(s->mmio_base, 0x200, addr, size, val);
         break;
+    case 0x300: /* ibase */
+    case 0x308: /* imask */
+        break;
     case 0x0680:
         put_val_in_int64(&s->error_config, addr, size, val);
         break;
@@ -538,6 +543,9 @@ static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
     case 0x0030:        /* HP-UX 10.20 and 11.11 reads it. No idea. */
         val = -1;
         break;
+    case 0x0078:        /* NetBSD reads 0x78 ? */
+        val = -1;
+        break;
     case 0x0300 ... 0x03d8:     /* LMMIO_DIRECT0_BASE... */
         index = (addr - 0x300) / 8;
         val = s->ioc_ranges[index];
@@ -624,31 +632,43 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
     case 0x10220:
     case 0x10230:        /* HP-UX 11.11 reads it. No idea. */
         break;
-    case 0x22108:        /* IOC STATUS_CONTROL */
-        put_val_in_int64(&s->ioc_status_ctrl, addr, size, val);
-        break;
     case 0x20200 ... 0x20240 - 1: /* IOC Rope0_Control ... */
         put_val_in_arrary(s->ioc_rope_control, 0x20200, addr, size, val);
         break;
     case 0x20040:        /* IOC Rope config */
+    case 0x22040:
         put_val_in_int64(&s->ioc_rope_config, addr, size, val);
         break;
     case 0x20300:
+    case 0x22300:
         put_val_in_int64(&s->tlb_ibase, addr, size, val);
         break;
     case 0x20308:
+    case 0x22308:
         put_val_in_int64(&s->tlb_imask, addr, size, val);
         break;
     case 0x20310:
+    case 0x22310:
         put_val_in_int64(&s->tlb_pcom, addr, size, val);
         /* TODO: flush iommu */
         break;
     case 0x20318:
+    case 0x22318:
         put_val_in_int64(&s->tlb_tcnfg, addr, size, val);
         break;
     case 0x20320:
+    case 0x22320:
         put_val_in_int64(&s->tlb_pdir_base, addr, size, val);
         break;
+    case 0x22000:       /* func_id */
+        break;
+    case 0x22008:       /* func_class */
+        break;
+    case 0x22050:       /* rope_debug */
+        break;
+    case 0x22108:        /* IOC STATUS_CONTROL */
+        put_val_in_int64(&s->ioc_status_ctrl, addr, size, val);
+        break;
     /*
      * empty placeholders for non-existent elroys, e.g.
      * func_class, pci config & data
-- 
2.43.0


