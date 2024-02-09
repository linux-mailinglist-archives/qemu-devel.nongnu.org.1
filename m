Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B884F4E3
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Feb 2024 12:58:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPVD-0003de-IA; Fri, 09 Feb 2024 06:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV1-0003bv-KY
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPUx-0002RN-Ms
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:54 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 13345CE2007;
 Fri,  9 Feb 2024 11:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7A8C43394;
 Fri,  9 Feb 2024 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707479808;
 bh=vqjS4Tn8JsTETJjKAhscWBmZAWUWeDAIiHK9Uvc1mpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fqsfhCy0CmsJqv9zC6GfjOd92wjHzUHxao524QtRJE81BT+VAakC5oCn1+MSEbZMU
 5uGtmkxiriqJehqvbMw3y3ql78xYjAFo0lWHftXidfvSFGmMYz9+qOOGc4fa5BOAOx
 6+8esWd8yRi7FdknbjFQCNatNrPCGpMingN2KbHDA41QFWtX9EI7YmjI8M1HRgFFgE
 ice6woecg3JuWEKsxv80paNSp90FUkeUlTnRCsqTnADQXF8MiaaHv0mXPfVueTpqde
 jB89dj6/Abn6X/LgaL2Wguar9CaB1Nsx75lyBqYspz6plWR9E1B9qhGUGnljSOVlcM
 2PyIFd/lkWouw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 07/12] lasi: Add reset I/O ports for LASI audio and FDC
Date: Fri,  9 Feb 2024 12:56:28 +0100
Message-ID: <20240209115633.55823-8-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209115633.55823-1-deller@kernel.org>
References: <20240209115633.55823-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
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

Linux writes zeroes at bootup into the default ports for LASI audio and
LASI floppy controller to reset those devices.  Allow writing to those
registers to avoid HPMCs.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c         | 11 +++++++++++
 include/hw/misc/lasi.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 9cfa5bb316..970fc98b5c 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -36,10 +36,13 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
     case LASI_IAR:
 
     case LASI_LPT:
+    case LASI_AUDIO:
+    case LASI_AUDIO + 4:
     case LASI_UART:
     case LASI_LAN:
     case LASI_LAN + 12: /* LASI LAN MAC */
     case LASI_RTC:
+    case LASI_FDC:
 
     case LASI_PCR ... LASI_AMR:
         ret = true;
@@ -80,6 +83,7 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
     case LASI_UART:
     case LASI_LAN:
     case LASI_LAN + 12:
+    case LASI_FDC:
         val = 0;
         break;
     case LASI_RTC:
@@ -145,12 +149,19 @@ static MemTxResult lasi_chip_write_with_attrs(void *opaque, hwaddr addr,
     case LASI_LPT:
         /* XXX: reset parallel port */
         break;
+    case LASI_AUDIO:
+    case LASI_AUDIO + 4:
+        /* XXX: reset audio port */
+        break;
     case LASI_UART:
         /* XXX: reset serial port */
         break;
     case LASI_LAN:
         /* XXX: reset LAN card */
         break;
+    case LASI_FDC:
+        /* XXX: reset Floppy controller */
+        break;
     case LASI_RTC:
         s->rtc_ref = val - time(NULL);
         break;
diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 0a8c7352be..f01c0f680a 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -26,9 +26,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
 #define LASI_IAR        0x10
 
 #define LASI_LPT        0x02000
+#define LASI_AUDIO      0x04000
 #define LASI_UART       0x05000
 #define LASI_LAN        0x07000
 #define LASI_RTC        0x09000
+#define LASI_FDC        0x0A000
 
 #define LASI_PCR        0x0C000 /* LASI Power Control register */
 #define LASI_ERRLOG     0x0C004 /* LASI Error Logging register */
-- 
2.43.0


