Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E359374B030
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhX-0002n1-OM; Fri, 07 Jul 2023 07:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhU-0002lW-AI; Fri, 07 Jul 2023 07:32:36 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhS-0006kF-K7; Fri, 07 Jul 2023 07:32:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b74791c948so1606418a34.3; 
 Fri, 07 Jul 2023 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729553; x=1691321553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4XgprL0dlmBbclHYjrldyUf3PM1j8iGfIGTFFXU+Vo=;
 b=n5TA0JHE3ubBA/BHd0HoqpQy+1Df7wKLDBNIzY5tfRHGxnWSI8NQXaRepB2QV3oIXu
 zfLB5cZxauo17np6BRCdlNHJHw8hvZ0h/jg1Eu7jSO+8MqpsCUfy6kY6z/zBqaLNAnDx
 UV/6bkom4cMC2UIKXesGWHSA4RLLLT3a0Lsu+AoiAlP8vd7IGdexor0c1bTNWnemmxfK
 RvJjDzzBF6aNkpcM2eZKrFIX6nMz9kwdR7Fkj/nJxb8aKLbrb6kQOoPs5cpcbHE8X2su
 UGeXulu8yHe/iZjcauPIBJ5o7YxrgkqWVsN3oDJjjHjCUu7dWjEKV4AQXa8wZo9YLEGe
 3CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729553; x=1691321553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4XgprL0dlmBbclHYjrldyUf3PM1j8iGfIGTFFXU+Vo=;
 b=cU8wfFyWpcYEWHHrVHJJwygvmHOsnQ8SDH5R36RnMsTN7MwL4utdB8YuPVce3HydAE
 KEK5O9v4GPfoBw0udR6c3TXiDbB4VcYOoYnpNacSaKSAl7sDCb0PmtXW1uAhtFKwR1iT
 Ro4jCgrru0JopPSdwEjF5mcK+yuMv0MFi++Hfo1QVnjeAFU3O+GgO50/qClXWmvILp6G
 g5c6+i2xV6mgNwz/uA9pQ5YEbOb4wo+/WIhTa4QBPkh/I7qeQwYWod8duwFeI4kyHYki
 oJBP7nlghWrhJeHHMIrS0Ckh78PVbeuLVr2r9+fkYztkp6oTZYslOsYz2Eq/urr6Czk1
 I0zg==
X-Gm-Message-State: ABy/qLYmkXcoQT1mjMcDXb87hJi3mUXqd6Z3faQy1FDs17jaDP5imIeA
 WWAIC54eGGQ0nMKGPGU3qFq/VlF21Qc=
X-Google-Smtp-Source: APBJJlHcVTKjRvtim0ZNW5TS40iIT9P5u0E5ZDRJLISW0ddHYxHZ9T70j8enZMtAFO6J4BDbQkQ7kQ==
X-Received: by 2002:a9d:4e95:0:b0:6b1:d368:557c with SMTP id
 v21-20020a9d4e95000000b006b1d368557cmr4675931otk.30.1688729552956; 
 Fri, 07 Jul 2023 04:32:32 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:32 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 27/60] pnv/xive: Allow mmio operations of any size on the ESB
 CI pages
Date: Fri,  7 Jul 2023 08:30:35 -0300
Message-ID: <20230707113108.7145-28-danielhb413@gmail.com>
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

We currently only allow 64-bit operations on the ESB CI pages. There's
no real reason for that limitation, skiboot/linux didn't need
more. However the hardware supports any size, so this patch relaxes
that restriction. It impacts both the ESB pages for "normal"
interrupts as well as the ESB pages for escalation interrupts defined
for the ENDs.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230704144848.164287-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/xive.c  | 8 ++++----
 hw/intc/xive2.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f60c878345..c014e961a4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1175,11 +1175,11 @@ static const MemoryRegionOps xive_source_esb_ops = {
     .write = xive_source_esb_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
@@ -2006,11 +2006,11 @@ static const MemoryRegionOps xive_end_source_ops = {
     .write = xive_end_source_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 4d9ff41956..c37ef25d44 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -954,11 +954,11 @@ static const MemoryRegionOps xive2_end_source_ops = {
     .write = xive2_end_source_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
-- 
2.41.0


