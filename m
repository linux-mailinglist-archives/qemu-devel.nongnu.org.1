Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E603683138E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:58:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNGk-00087R-RJ; Thu, 18 Jan 2024 02:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGY-0007Vt-BC; Thu, 18 Jan 2024 02:56:47 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGU-0007zB-M6; Thu, 18 Jan 2024 02:56:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DFEEB4504A;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 14F1F661B2;
 Thu, 18 Jan 2024 10:54:07 +0300 (MSK)
Received: (nullmailer pid 2381722 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Bruno Haible <bruno@clisp.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 31/38] hw/pci-host/astro: Add missing astro & elroy
 registers for NetBSD
Date: Thu, 18 Jan 2024 10:52:58 +0300
Message-Id: <20240118075404.2381519-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

NetBSD accesses some astro and elroy registers which aren't accessed
by Linux yet. Add emulation for those registers to allow NetBSD to
boot further.
Please note that this patch is not sufficient to completely boot up
NetBSD on the 64-bit C3700 machine yet.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Bruno Haible <bruno@clisp.org>
(cherry picked from commit 3b57c15f02050227c5c73ca97fa0dfc02f154fe9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


