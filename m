Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2AA838799
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:40:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSARi-0004AJ-Ro; Tue, 23 Jan 2024 01:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSARc-00048k-Qp
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:36 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSARb-0008AB-As
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:36 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so50963985e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 22:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705991972; x=1706596772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39OP9EE9lF2EcfOzamU8x35qcADjGnzDFDx/nFOBMLk=;
 b=EIOczz3LhfvJ4hYnFW7VCm3+2+m/ZkvDJJdq5uhzDH5cKjTVdiZSSt28TvVtrCjGWA
 gPKpsDmvmhyFXCvJas3L2uWvpmqUnlbzRApRm24MrgZ6wGn+wcBs1xTw6Q8N2/E/nuVc
 25/nb7zynPqDlR0GEl8/NOTA9U4MED/NNRuSofSFdF/iqa0XAri/ZqMjMTeh+8USrtRj
 CHQQ3NLQYIa947NNRqbXt4vIls0PmiBhB5aFsO/ps3sDhsvOVQ5Cxa7LTbd6ppkRFRxX
 2qlBRfpifx8gXBrybJd7oNjGvkoqZD3T2GcxJfR8VKV/ZW0AHmINV+3E8liU6EWg6Smz
 KthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705991972; x=1706596772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39OP9EE9lF2EcfOzamU8x35qcADjGnzDFDx/nFOBMLk=;
 b=HKtDCuEpGRG2gTOhP7ZwNg81pM/IZZeBUfyVcVCPT6W9vNPpQ1K/pkd8qOsE0dYCDA
 Lb05gmOINL1zTl2B1eDb/YMYlW0ZLiP+svdKt/obWBElwtmHq+TfGawPdCyy/jUjnAZ7
 a6bFRdvtm52Zu0i6Ih0t1bHxPzGxvM4bGhgBM3cL3KpL1Z2q1BDDvo9H6d9AdlxqmDOd
 xzFAEMm+XygyfBLtE0uojqrJDFWU000gzUlqe65e8Pcu9UGA8e0ssf3+FuvE4to4ZuX8
 7PoGnYkj94yFPO1i7jAjbqgmBeKMEQhUAuo4NuqIhaaRpmkrapkNyFPxhjwiafyJAroN
 3VBw==
X-Gm-Message-State: AOJu0YweuClxAQS4zXkis8vIytHCxvQNb1kMeRRj1AI1ZHNrATz711vV
 fEYSqB0CoWDUbXxSZgPiUrV0SLj1L8/+fWFUIMNlBZPfK47SwKfEZqTLpNNJVCLCxmsBUcm8DCf
 dAQE=
X-Google-Smtp-Source: AGHT+IEDbiHmqBlmZZBK+ETn6jUjhUWKBsiRVDTufvBTAvrdo6/JbZ3APqx8VxqrYAAFIsFsBqVhnA==
X-Received: by 2002:a05:600c:c19:b0:40d:889a:4eab with SMTP id
 fm25-20020a05600c0c1900b0040d889a4eabmr228878wmb.87.1705991972759; 
 Mon, 22 Jan 2024 22:39:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a17090654d500b00a2ad1182e36sm14134270ejp.9.2024.01.22.22.39.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jan 2024 22:39:32 -0800 (PST)
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
Subject: [PATCH 8/8] hw/arm/zynq: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 07:38:42 +0100
Message-ID: <20240123063842.35255-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123063842.35255-1-philmd@linaro.org>
References: <20240123063842.35255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66d0de139f..6ec65d4780 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -355,6 +355,10 @@ static void zynq_init(MachineState *machine)
 
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
@@ -362,6 +366,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
 }
 
-- 
2.41.0


