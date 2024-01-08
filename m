Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4D827A9B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:29:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMy6E-0006lr-Hh; Mon, 08 Jan 2024 17:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <363acZQwKCn4pcdkjguvghcpiqqing.eqosgow-fgxgnpqpipw.qti@flex--nabihestefan.bounces.google.com>)
 id 1rMy6B-0006kt-6G
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:27:59 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <363acZQwKCn4pcdkjguvghcpiqqing.eqosgow-fgxgnpqpipw.qti@flex--nabihestefan.bounces.google.com>)
 id 1rMy69-000443-Bg
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:27:58 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dbeac7a5b53so1685400276.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704752875; x=1705357675; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=9qBmftjLlpxjKXWRYQwSt7KsKP2Es44SquIQV1JrY0s=;
 b=ylkOFiRsNDJ02hi5JayjXn/Rpz9r768Ql/vRSJD7Y3Zqz0lNxoEYXPvyL7B9WsR3a+
 5qi/0ZvAJnzUetcdGARNoudxCFjsh/S/BfQXIADW+iGAhPG8jUi7xMwX6p5n41xM/FS6
 QtPBXy9eJoGAltl6GlZ1STn79Vo35MJxWEVrmiXY/BEybPKmz1uRZFrrrE+n/PwT6AZc
 ZPehxOQcw15uQa8JH51NKQGlWXgdCu/La72r67Oo6LIz8rGzrFmEQ+Ko1iiDv5/1h/VN
 5TV1pBUrqmEkTq2G9DcFqB16cEixYrBbHXc5K/pULuUQ/LDJP5y+1onWNMXFYkU1wt7g
 THeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704752875; x=1705357675;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qBmftjLlpxjKXWRYQwSt7KsKP2Es44SquIQV1JrY0s=;
 b=P13PNC1nyOO40XPcvlt4GVi4zJg9RWsOK1WLxP+whiLCKzz5N972y6IGX47ufTapI1
 LMPoZi6jL7XOsgIftwzXp/Pnp42KUPrI3QWWT4FcSdicGFebuZk3mIRztnbzSdd2FG3b
 dtCTORyniUjx3wwsrRQliwEqP4yzLVV0oLL0Sk3gm9x+0SgfDLuXuSy0WPXawnZd+xjm
 gDkLilEKgzJiNqS7kGs000M0KUv/wK11fM4DDCdW4obVXk+XCzWadsk0tWF2HnF1cqZ7
 s0d9BWIKK+DSTRN4htGdG+uZ2lkHTdOqd8xlRC20VC7j3cF9dyx3ylT2JOYjg01eCOFU
 hDJw==
X-Gm-Message-State: AOJu0YzKdxMUG1qc05rlOLVvHRujAen/kXS+6vWNrxie65PWa3dEgFCB
 ubBPtsyiNcEwdJpW8SICsEpxLZRqZrq4YDjSNjjNh8jSGQ==
X-Google-Smtp-Source: AGHT+IF1HDFQxbRHdap2wuMGTKtLU3iXTG4sQV/sfnZxoktz/pZkKVjVpKaB2MqwlVMXTbLVf8IE8UDEsg6kG+FHORY=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:56d:b0:dbe:aab3:4371 with
 SMTP id a13-20020a056902056d00b00dbeaab34371mr142411ybt.8.1704752875360; Mon,
 08 Jan 2024 14:27:55 -0800 (PST)
Date: Mon,  8 Jan 2024 22:27:39 +0000
In-Reply-To: <20240108222747.2453106-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240108222747.2453106-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108222747.2453106-3-nabihestefan@google.com>
Subject: [PATCH v10 02/10] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=363acZQwKCn4pcdkjguvghcpiqqing.eqosgow-fgxgnpqpipw.qti@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

This patch wires the PCI mailbox module to Nuvoton SoC.

Change-Id: I14c42c628258804030f0583889882842bde0d972
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 docs/system/arm/nuvoton.rst | 2 ++
 hw/arm/npcm7xx.c            | 2 ++
 include/hw/arm/npcm7xx.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b0..e611099545 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -50,6 +50,8 @@ Supported devices
  * Ethernet controller (EMC)
  * Tachometer
  * Peripheral SPI controller (PSPI)
+ * BIOS POST code FIFO
+ * PCI Mailbox
 
 Missing devices
 ---------------
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 1c3634ff45..c9e87162cb 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -462,6 +462,8 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "pspi[*]", &s->pspi[i], TYPE_NPCM_PSPI);
     }
 
+    object_initialize_child(obj, "pci-mbox", &s->pci_mbox,
+                            TYPE_NPCM7XX_PCI_MBOX);
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
 }
 
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 273090ac60..cec3792a2e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -105,6 +105,7 @@ struct NPCM7xxState {
     OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
     NPCM7xxEMCState     emc[2];
+    NPCM7xxPCIMBoxState pci_mbox;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi[2];
 };
-- 
2.43.0.472.g3155946c3a-goog


