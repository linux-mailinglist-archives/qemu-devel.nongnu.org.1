Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45380996B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:42:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQhV-0003Dm-Er; Thu, 07 Dec 2023 21:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQhJ-0002dT-0p; Thu, 07 Dec 2023 21:34:40 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQhH-0002uC-HV; Thu, 07 Dec 2023 21:34:36 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c9e9c2989dso19467011fa.0; 
 Thu, 07 Dec 2023 18:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002873; x=1702607673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igayQuYX/F7iH3RNFaYv1D/3MuPEz8Ua3kpb9vPSfPs=;
 b=ldMnbRvMy2xPbadzRIHH9rqNKFWldjwWNQb4yLT8b04GBedQPUik8LadcmGSpwmp0T
 ddJVXtoppAmwKc5YGlO5U8myDwPIAomgM8yKBh7XfPz4vWVsOMALoMuOBSQnfwclizLD
 hHS6wSpxDzxr9jYK/Kram00SHgynwB7djCVdZHuGRopmj+CiFPscB0kcGLPRkoq1HkyE
 XyKbNacxioEGFc4760mTBh2kZi+Wen6ssDlLzEekvhTrxpIia+3Ic1HPTHpNMdv2BL1N
 txRbnxZvrRcW4+GCSCNrMxUhO02QlSG8Qk/UJT6v+UDdSYgdeNkJVZky83Y90GWsDgcQ
 EKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002873; x=1702607673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igayQuYX/F7iH3RNFaYv1D/3MuPEz8Ua3kpb9vPSfPs=;
 b=chDT1C3H5i85mjFPldW+c4T8eqNa3DIrEHeOxrjKMWiRt/li+xy+LaeV86IjuHbW63
 khHIptpflu16+lxvHx7xxKdDxCZFrz7sQRkQ+qNgkArWdEBtMd/uS/o8CEFznWG7iHsZ
 Ts1SL8EssobayIVy+1sHJd+0V0nlWj3YGwVJfcvn8qOYMHe5Gf77HHM9O9VddxeD7hGp
 10G7FB3ezBpYEnZIiXEICazL9EfT3pV6xEFogSIAjWYbmNNZcOOv8h676sZHI6GhmuWb
 Dy+pllDZev7bhgn0ro8tHHnmyItQZ13W0pHGGSzQsBvRwSfMyVMq6y0tKvyVaFCd2txF
 L1sg==
X-Gm-Message-State: AOJu0YxqN3QbsuC9T5NdAwDV2GL+KaoZB9OQ3KfxChGM0MZ0fQrzff9X
 DJ7+LlbTIy/aigSy6Cc2TtOYe89HWdfzwA==
X-Google-Smtp-Source: AGHT+IF1j3ekbAelZttIPVfoyZKrF2gFAGVYTRMZKh3a9KWunbkPs0ZLnovvA3+M8zOyW2gIwTWiAA==
X-Received: by 2002:a2e:a7cf:0:b0:2ca:227a:ebb2 with SMTP id
 x15-20020a2ea7cf000000b002ca227aebb2mr2312302ljp.0.1702002873226; 
 Thu, 07 Dec 2023 18:34:33 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:34:32 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 45/45] Add RPi4B to paspi4.rst
Date: Thu,  7 Dec 2023 20:31:45 -0600
Message-Id: <20231208023145.1385775-46-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x230.google.com
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


