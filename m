Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBF83879B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSARL-0003hg-BX; Tue, 23 Jan 2024 01:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSAR5-0003Wy-8U
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:06 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSAR2-00084U-Ot
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:02 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso4442998a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 22:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705991937; x=1706596737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i77zJu4XGXBVApw9vLRB2i1/pQOfnONi4E/tNbGXicU=;
 b=S1b2+tOH6PTVbzHapEHhdghVd18Nqe7Z9tSKB4B2Hrher6PoizNnuhKjVeWEHizX6F
 xlVgLYU6n+Re7HDT+4vN5cE025ATlC1ttBhiutawL5MYl3R5T731hriytpDEbOADkpZ9
 hajsUBEkvdR9CQiYAtwLd9kCwGf5hzpDRjOQMLW/4Dis3Y7S6z70GlA+/+DoRjJMHpFM
 5lGYTul5oiPjsmKwE/EvwhpkcNENyLqMlgCZaFcP+tvPQTsqnOuIuzqtTxVy6uLdWXqG
 O4AL1viAVEgEYNPIhjrLj3jloB/3utqY9iAY+uZ7QDkx3Mz9ne0tO6rnZR5yKx/5WGUs
 IORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705991937; x=1706596737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i77zJu4XGXBVApw9vLRB2i1/pQOfnONi4E/tNbGXicU=;
 b=EAGuWT5F0BeXMTW3rXNZMK6jppSNEX7r+fdg6ce2BiUFVS7mlpcl6JTGLCkyTULgsZ
 N3FKRcun+8mfOGZe5Qhww8A4tYCuLU0Cg/dZ8FWQBjn6wUWeRCra0/fK4oQtiZPgsJDV
 YJrphZxApPkrbU5iX7gxmrcfC+usqFdUECUnhSopQ5EyDmrA+7vCVUVJV63NRJfYXVTy
 +fN+YCVKulRTgtljI4AqDBJ059YNOC6yxXlIHAgcUjecBxeq5pRO6Uch3lvOLDsTJhDk
 Sll0KUadUnrvILLk+/81gfziXQjjuc0/GnDW+qPeCeOHr10qEHEltjKxla2vO+1hHWNK
 ZjJA==
X-Gm-Message-State: AOJu0YwXiqpPf0ab76NuyIaRe/zVmUeZTHkhTkVWu8mMIZVpN3znYpAQ
 hUn/zHSK9SdSB2l7BHrHT1C8DF8ZgxHcMbaLqfdESj85w8k8/boYrcVHNCdQ0aizLfEq2GyhoND
 A6QQ=
X-Google-Smtp-Source: AGHT+IFi07VBZVjQDkREKXZik2eUBCTs7lSYTU8lbQU47Yaa3HA2AK2ktEuhwJvZbbuQVNDj31o1FQ==
X-Received: by 2002:aa7:c3c7:0:b0:559:f1b6:bf6b with SMTP id
 l7-20020aa7c3c7000000b00559f1b6bf6bmr572472edr.68.1705991937548; 
 Mon, 22 Jan 2024 22:38:57 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 dm24-20020a05640222d800b0055c1433be60sm2864216edb.50.2024.01.22.22.38.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jan 2024 22:38:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Gavin Shan <gshan@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] hw/arm/highbank: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 07:38:36 +0100
Message-ID: <20240123063842.35255-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123063842.35255-1-philmd@linaro.org>
References: <20240123063842.35255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index e6e27d69af..67677eb651 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -344,10 +344,15 @@ static void midway_init(MachineState *machine)
 
 static void highbank_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Highbank (ECX-1000)";
     mc->init = highbank_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
@@ -363,10 +368,15 @@ static const TypeInfo highbank_type = {
 
 static void midway_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Midway (ECX-2000)";
     mc->init = midway_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
-- 
2.41.0


