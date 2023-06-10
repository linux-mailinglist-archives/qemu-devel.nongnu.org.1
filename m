Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FA72ABC8
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yh8-0004NB-CJ; Sat, 10 Jun 2023 09:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh2-0004MV-1l; Sat, 10 Jun 2023 09:31:48 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh0-0007Yg-5Y; Sat, 10 Jun 2023 09:31:47 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-38ede2e0e69so1287802b6e.2; 
 Sat, 10 Jun 2023 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403904; x=1688995904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmR0h6/YvxlicyT6sKm9gabjuCHgBWHDRClts4Pnvbk=;
 b=DRR+SWKxLcn6pPUx7e0fOlXQN4y/w37mcf2gFiXHg2jrelvfLvjXRAU4lUSHUHjNwc
 Qx8UCSpFZdmHTiVWNSLmnXB01HQ/7RB8BIHBL/rwxbtqZ6qSx6T9FL9WydvCOJHFDgS7
 3sGuxB0qYrJWC1HXgiQu0RqR8Pb+zRvGKXyt+kvqJa2CIuQlSzA9+NsOkPYu58nKgbpM
 YYPC+tHxViFT4vG3yNhxvxgCWudWbYcJIZ46s43tN8aPiJSvBKjZZF4TfAMbKBMi4ssB
 D07JMBY94re1fgJ7p4dBF5tI84HXU3WVSa8d6eQ/FLGPB44Zeh9NCKZCje9f2yLlcf3r
 0ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403904; x=1688995904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmR0h6/YvxlicyT6sKm9gabjuCHgBWHDRClts4Pnvbk=;
 b=G6HYkzLbfW+F4wgroo1wLXdriGZg2habA8E4UaYqkZL+o6f53RWKFWrjsbXmWQr5sd
 VMy5stewnqdFD8jVcfCeBx9ZmlLiz0oSjLAGXwTFekan9TpMBQl+uHtW5d8TSERxJD9t
 gSkg4ih/nezn4m6Gm6WVShqlYFHDkVI2PFxt+TQspS2vw+h2SXVN6bRyVZRZGQTsH7CU
 WXKjvKK4UkSM6YB+JSHIlCz/UxucueiV09fH2O+XSKZ8Ib2qze48eDGXTZXXtXVlJhdl
 1E1I5kEGB6Mp+EowRwWm1HV0yTGuCF3brYO5gEnyC61v3B46a7Vz7bJwzt3RJ1Ox5mia
 n90g==
X-Gm-Message-State: AC+VfDwBuEIl50RdlH10W15wNlTuEQu6bHlxX0QasgogedWl8j7VMXUc
 CDfc+tN5DjpBzVwll6JddKp4pGIgsek=
X-Google-Smtp-Source: ACHHUZ7hEs4IEc0F3CEpjOQRzndWQc05m8tWTvTR5xK+qcJyHPYTzdrC48zXoj2/9XrnFDM0H88eow==
X-Received: by 2002:a05:6808:1249:b0:39a:5e92:2b45 with SMTP id
 o9-20020a056808124900b0039a5e922b45mr1196193oiv.10.1686403904214; 
 Sat, 10 Jun 2023 06:31:44 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:43 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 01/29] pnv/xive2: Add definition for TCTXT Config register
Date: Sat, 10 Jun 2023 10:31:04 -0300
Message-Id: <20230610133132.290703-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x235.google.com
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

Add basic read/write support for the TCTXT Config register on P10. qemu
doesn't do anything with it yet, but it avoids logging a guest error
when skiboot configures the fused-core state:

qemu-system-ppc64 -machine powernv10 ... -d guest_errors
  ...
[    0.131670000,5] XIVE: [ IC 00  ] Initializing XIVE block ID 0...
XIVE[0] - TCTXT: invalid read @140
XIVE[0] - TCTXT: invalid write @140

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230601121331.487207-2-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c      | 8 +++++++-
 hw/intc/pnv_xive2_regs.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 7176d70234..889e409929 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1265,6 +1265,9 @@ static uint64_t pnv_xive2_ic_tctxt_read(void *opaque, hwaddr offset,
     case TCTXT_EN1_RESET:
         val = xive->tctxt_regs[TCTXT_EN1 >> 3];
         break;
+    case TCTXT_CFG:
+        val = xive->tctxt_regs[reg];
+        break;
     default:
         xive2_error(xive, "TCTXT: invalid read @%"HWADDR_PRIx, offset);
     }
@@ -1276,6 +1279,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
                                      uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    uint32_t reg = offset >> 3;
 
     switch (offset) {
     /*
@@ -1297,7 +1301,9 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
     case TCTXT_EN1_RESET:
         xive->tctxt_regs[TCTXT_EN1 >> 3] &= ~val;
         break;
-
+    case TCTXT_CFG:
+        xive->tctxt_regs[reg] = val;
+        break;
     default:
         xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
         return;
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index 0c096e4adb..8f1e0a1fde 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -405,6 +405,10 @@
 #define X_TCTXT_EN1_RESET                       0x307
 #define TCTXT_EN1_RESET                         0x038
 
+/* TCTXT Config register */
+#define X_TCTXT_CFG                             0x328
+#define TCTXT_CFG                               0x140
+
 /*
  * VSD Tables
  */
-- 
2.40.1


