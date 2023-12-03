Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F58027E1
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:34:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u2d-0002Zu-2v; Sun, 03 Dec 2023 16:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u2J-0002Dv-FW; Sun, 03 Dec 2023 16:29:59 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u2G-0005ae-Tn; Sun, 03 Dec 2023 16:29:58 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db8892a5f96so844671276.2; 
 Sun, 03 Dec 2023 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638995; x=1702243795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igayQuYX/F7iH3RNFaYv1D/3MuPEz8Ua3kpb9vPSfPs=;
 b=N08LSo8B1Gm5C+nnV936qqkUL7oThEwb4fhCu7Qw42JyuY2y4xVoCGoI3g5Ru1ztZV
 XxxTsjSlizVWcI2+eKAeHd4Ai4uviI/7xziW8hexHLSP7/Ttk9vD7bg77vtuMaf067C+
 r/oT2AU9dgNIk5YP12jrchu1cyPuyK7pl2VXpY5Fw83h8eBCCxXCs+T4LkdaUp1eIMum
 0qIrdJdLyQ+iuoK7NUW5gMpV+hhq3UH4WG8qdddGuP/triw9fj6CSaa7c+sfvunc1xhp
 SaVJDpQTE9qbK4B3dbpa7/S77groirKjHK15hcdDg1HdWrDzMx3hecdnjIR5mvBRMXB2
 zDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638995; x=1702243795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igayQuYX/F7iH3RNFaYv1D/3MuPEz8Ua3kpb9vPSfPs=;
 b=XprY+rxs1m3swyPyqasNt3zQha2+tMwtkte+BaKrcwoDHND1fnLII7ec1iTWRupxJ9
 i5j2X2qgTYHo/yAU6ZTVOEw865bl3Vp0uuCqIQ8ZjkaSx8tOgZr0vwrFBUHfnvYgRvcn
 IrVS9T8A2hpaF5T2QFgPnOd44VmjwNkIpyasBs8efJVsOUXnHeyUIIcVzs6j0bu6NVri
 Xwp0FzODLTj6SuXV+YEUcL2ZvLTbz36NYCkGGsuMeeetnpBCh8IkjZ1UvBjnB1erpvZn
 VB/tg8eEfgFM+bBmRGBG4pkCKk33y5XgAkIHNIiiX1F9KaUPtvxpE0JDDTvKFBWlU3kR
 Wo5Q==
X-Gm-Message-State: AOJu0YyKD+YZXuDcFnu3Uepxn+DuuZsN7ZEvcN1Kzj1Ir8vSZdHmZEPa
 AlrPwF38JD22qB42i9bmEVASjbAu/Q3H7Q==
X-Google-Smtp-Source: AGHT+IGp8l9nIreZkOFoAcEMRcLbCd9jhilYumz9ef3e/GUNhk4pzoxvFPYT82NvW0KBtenU6Kc2DA==
X-Received: by 2002:a25:68d1:0:b0:db7:dacf:6210 with SMTP id
 d200-20020a2568d1000000b00db7dacf6210mr2066292ybc.98.1701638995565; 
 Sun, 03 Dec 2023 13:29:55 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:55 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 45/45] Add RPi4B to paspi4.rst
Date: Sun,  3 Dec 2023 15:29:05 -0600
Message-Id: <20231203212905.1364036-46-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-45-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-2-sergey.kambalin@auriga.com>
 <20231203212905.1364036-3-sergey.kambalin@auriga.com>
 <20231203212905.1364036-4-sergey.kambalin@auriga.com>
 <20231203212905.1364036-5-sergey.kambalin@auriga.com>
 <20231203212905.1364036-6-sergey.kambalin@auriga.com>
 <20231203212905.1364036-7-sergey.kambalin@auriga.com>
 <20231203212905.1364036-8-sergey.kambalin@auriga.com>
 <20231203212905.1364036-9-sergey.kambalin@auriga.com>
 <20231203212905.1364036-10-sergey.kambalin@auriga.com>
 <20231203212905.1364036-11-sergey.kambalin@auriga.com>
 <20231203212905.1364036-12-sergey.kambalin@auriga.com>
 <20231203212905.1364036-13-sergey.kambalin@auriga.com>
 <20231203212905.1364036-14-sergey.kambalin@auriga.com>
 <20231203212905.1364036-15-sergey.kambalin@auriga.com>
 <20231203212905.1364036-16-sergey.kambalin@auriga.com>
 <20231203212905.1364036-17-sergey.kambalin@auriga.com>
 <20231203212905.1364036-18-sergey.kambalin@auriga.com>
 <20231203212905.1364036-19-sergey.kambalin@auriga.com>
 <20231203212905.1364036-20-sergey.kambalin@auriga.com>
 <20231203212905.1364036-21-sergey.kambalin@auriga.com>
 <20231203212905.1364036-22-sergey.kambalin@auriga.com>
 <20231203212905.1364036-23-sergey.kambalin@auriga.com>
 <20231203212905.1364036-24-sergey.kambalin@auriga.com>
 <20231203212905.1364036-25-sergey.kambalin@auriga.com>
 <20231203212905.1364036-26-sergey.kambalin@auriga.com>
 <20231203212905.1364036-27-sergey.kambalin@auriga.com>
 <20231203212905.1364036-28-sergey.kambalin@auriga.com>
 <20231203212905.1364036-29-sergey.kambalin@auriga.com>
 <20231203212905.1364036-30-sergey.kambalin@auriga.com>
 <20231203212905.1364036-31-sergey.kambalin@auriga.com>
 <20231203212905.1364036-32-sergey.kambalin@auriga.com>
 <20231203212905.1364036-33-sergey.kambalin@auriga.com>
 <20231203212905.1364036-34-sergey.kambalin@auriga.com>
 <20231203212905.1364036-35-sergey.kambalin@auriga.com>
 <20231203212905.1364036-36-sergey.kambalin@auriga.com>
 <20231203212905.1364036-37-sergey.kambalin@auriga.com>
 <20231203212905.1364036-38-sergey.kambalin@auriga.com>
 <20231203212905.1364036-39-sergey.kambalin@auriga.com>
 <20231203212905.1364036-40-sergey.kambalin@auriga.com>
 <20231203212905.1364036-41-sergey.kambalin@auriga.com>
 <20231203212905.1364036-42-sergey.kambalin@auriga.com>
 <20231203212905.1364036-43-sergey.kambalin@auriga.com>
 <20231203212905.1364036-44-sergey.kambalin@auriga.com>
 <20231203212905.1364036-45-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 docs/system/arm/raspi.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 922fe375a6..db9e0949ef 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -1,5 +1,5 @@
-Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
-======================================================================================
+Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b-2g``)
+======================================================================================================
 
 
 QEMU provides models of the following Raspberry Pi boards:
@@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
   Cortex-A53 (4 cores), 512 MiB of RAM
 ``raspi3b``
   Cortex-A53 (4 cores), 1 GiB of RAM
-
+``raspi4b-2g``
+  Cortex-A72 (4 cores), 2 GiB of RAM
 
 Implemented devices
 -------------------
 
- * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
+ * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
  * Interrupt controller
  * DMA controller
  * Clock and reset controller (CPRMAN)
@@ -33,6 +34,8 @@ Implemented devices
  * USB2 host controller (DWC2 and MPHI)
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
+ * PCIE Root Port (raspi4b-2g)
+ * GENET Ethernet Controller (raspi4b-2g)
 
 
 Missing devices
-- 
2.34.1


