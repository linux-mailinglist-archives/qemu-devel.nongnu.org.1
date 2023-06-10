Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CEC72ABBD
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:34:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhC-0004Qj-Qh; Sat, 10 Jun 2023 09:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh5-0004NR-5f; Sat, 10 Jun 2023 09:31:53 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh2-0007Yy-85; Sat, 10 Jun 2023 09:31:49 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-392116b8f31so1084047b6e.2; 
 Sat, 10 Jun 2023 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403906; x=1688995906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K9gkgRuPeOTJgcGGyxmloyD4HVqDlOxJ75tqz+86oQ=;
 b=rX/pZ4c2Bryk/BJFNiDEfcNQNa1yLjGY/0jVJcLJNshW+Hmvu095O6A9EC9Zk0ABMi
 m3lR3Ye5Y2U611p2E/vvA94W/9vOQ14+lUmRO6K3HNRR82dlsgS0e+i/1zz4ATYh7UjJ
 zGxQtR4ZsUS3iv87PVXCnDJCGy/dWqQBiLF2vCJ4UeT4YFfUzOPnbt6V+1tRJWn37ZXV
 Lxr/qxBl5I4ThHpbijmfO4s8EwSAVEed4fGEc7Q3OoHz/T/jVycgDYWINNjSduMQtj8L
 QmAdams6fu80ERGu8saEza0iTf9MlyQBYBjMkMUXWKFhPLbQ5jvXdtnqWv+RH2R2aSJR
 LGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403906; x=1688995906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8K9gkgRuPeOTJgcGGyxmloyD4HVqDlOxJ75tqz+86oQ=;
 b=aAjp2UpbWlWaNbXMbYA2/cVedl/uYv18o6vqCRVdpHWZ+XFSD7+2L/mgMos+yxUnSM
 BJgT8NZZvXzQ9EPkzDCjCWIUFGUs9D7F5/Ro1zMUjoTWqlOdBcYcL8EBL7++w6SPnkMF
 /66yMo8wnyHlhF1sotO8/Ng7ukSH7soA+/woMCa3e+gMYQ5YHcXcpiBKXZ1HbUpfsWkL
 tHv1qXijvdNLxo5UkakLG6soe1kVwTujsCa5tyTKbuSGGY1h81o/laeN/0DlVGt4dLRV
 p7uO8xGVPOYejrRLUjtbpuDfp/PCDZE4hkjGtKCbYWrJkCZmUblKxmmYn9wGvrJUfsap
 wK5w==
X-Gm-Message-State: AC+VfDyVLgMQrDkXWqd6DKqdj8hrbHtTJtMasvc9KZOnYNNSo6XhJxfq
 sme0KoF7Caq085UL95hkV/lXqA0TjWI=
X-Google-Smtp-Source: ACHHUZ504rufp5hIwdYRoPL92soaKZ6J3IVNX8jGOhiShgYzT5kOeG8SYpQxwidH9Kjqn/96Cul52Q==
X-Received: by 2002:a05:6808:3087:b0:39c:785a:9751 with SMTP id
 bl7-20020a056808308700b0039c785a9751mr1075483oib.32.1686403906519; 
 Sat, 10 Jun 2023 06:31:46 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:46 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 02/29] pnv/xive2: Add definition for the ESB cache
 configuration register
Date: Sat, 10 Jun 2023 10:31:05 -0300
Message-Id: <20230610133132.290703-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x236.google.com
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

Add basic read/write support for the ESB cache configuration register
on P10. We don't model the ESB cache in qemu so reading/writing the
register won't do anything, but it avoids logging a guest error when
skiboot configures it:

qemu-system-ppc64 -machine powernv10 ... -d guest_errors
      ...
XIVE[0] - VC: invalid read @240
XIVE[0] - VC: invalid write @240

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230601121331.487207-3-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c      | 7 +++++++
 hw/intc/pnv_xive2_regs.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 889e409929..a75ff270ac 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -955,6 +955,10 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
         val = xive->vc_regs[reg];
         break;
 
+    case VC_ESBC_CFG:
+        val = xive->vc_regs[reg];
+        break;
+
     /*
      * EAS cache updates (not modeled)
      */
@@ -1046,6 +1050,9 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         /* ESB update */
         break;
 
+    case VC_ESBC_CFG:
+        break;
+
     /*
      * EAS cache updates (not modeled)
      */
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index 8f1e0a1fde..7165dc8704 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -232,6 +232,10 @@
 #define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
 #define  VC_ESBC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
 
+/* ESBC configuration */
+#define X_VC_ESBC_CFG                           0x148
+#define VC_ESBC_CFG                             0x240
+
 /* EASC flush control register */
 #define X_VC_EASC_FLUSH_CTRL                    0x160
 #define VC_EASC_FLUSH_CTRL                      0x300
-- 
2.40.1


