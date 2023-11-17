Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E27EEC6C
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:04:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ssW-0003xM-14; Fri, 17 Nov 2023 02:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3ssU-0003wp-10
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:02:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3ssS-0002HG-5H
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:02:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40a46ea95f0so13296935e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700204574; x=1700809374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NKaaCxi7dh9gZplifh7M5hNa24uba2xPB6ad219TfOY=;
 b=addGvEP7Iyyr3KhFM2QPAh+HULF2lhN0BzXtht15DQBqZkFceCMPA0n6b/SRNJ4ysZ
 i4edPyp56vZhI7TUyKeS9GoH5A6Ab/CFR+v0/HOaA1zwNfX4Bwgms8kVj6MwWOBffn0c
 VnYMr+YeayXaa7yPdJFuIbhPF9mE7ctrBKlAqFFvEGR/u43kvP8nRAS/tpOqUscDjDtG
 ZEGWfxAAPSAqkhEd0/K2IbOlf07w9Ar64//g5Gu640q2EiNQMQ0niJ03g4175EEMJY0S
 bzmPzjc9v27CFeAgwLfSI+YSE7sdit2c4zsPvKULRQI/lI5+4QNfMfZfFxiln0J/KwPm
 50Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700204574; x=1700809374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKaaCxi7dh9gZplifh7M5hNa24uba2xPB6ad219TfOY=;
 b=Iolf2XOBXaALJHMKkN+vmevFgwiWzCggtXKz/QWXQHXK1Rx7uvhvgFasjiY7Tiue8Z
 03U/+pL3C2hBfjS7kW4IRiflMTQzjUGOn4oUetHSlFCcMbOWQjhzLbrSb4xS7hsUFNqD
 K11BfNd3ljGdjhnj8dBP3iBsITZ9mYpJXInexFDz8rvtvszA8/RPE7HMAJFb2MIEaaqZ
 ozr7sKvad8N7bB4B/tPIEHk5QsbXxzBDIJgy4gEa0ygijvuVGog5JSZUAcJHGO/Mer/2
 J9wtHGE9vslznctiB4iLQAG1+NqUSMkIBPaYM45m53V2IHD3ppvisxm7D8FSvNiqnrYg
 oO4g==
X-Gm-Message-State: AOJu0YxneJlpXkXwIRPO6ap8cqJmgpaB3Q8kPJd4cMQHP0xeRiS3OW6f
 5Hvv03UEOhseAs6n7dmiaCyv4MeJpQK3sd2itNc=
X-Google-Smtp-Source: AGHT+IFG+RyMpbN13y+PY3AXTxAkj/HsZkC+7DY+Bq2UM7+lNWypToDSq5QVcpF3ZU5cZ4ljIcFKsg==
X-Received: by 2002:a05:600c:4e8b:b0:408:56ea:f061 with SMTP id
 f11-20020a05600c4e8b00b0040856eaf061mr15346014wmq.24.1700204573576; 
 Thu, 16 Nov 2023 23:02:53 -0800 (PST)
Received: from m1x-phil.lan (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b0040535648639sm1640191wmq.36.2023.11.16.23.02.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Nov 2023 23:02:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, devel@lists.libvirt.org,
 Sandra Loosemore <sandra@codesourcery.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2] target/nios2: Deprecate the Nios II architecture
Date: Fri, 17 Nov 2023 08:02:50 +0100
Message-ID: <20231117070250.32932-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

See commit 9ba1caf510 ("MAINTAINERS: Mark the Nios II CPU as orphan"),
last contribution from Chris was in 2012 [1] and Marek in 2018 [2].

[1] https://lore.kernel.org/qemu-devel/1352607539-10455-2-git-send-email-crwulff@gmail.com/
[2] https://lore.kernel.org/qemu-devel/805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 15 +++++++++++++++
 hw/nios2/10m50_devboard.c |  1 +
 hw/nios2/generic_nommu.c  |  1 +
 3 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 78550c07bf..f7aa556294 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -236,6 +236,16 @@ it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
 
+System emulator CPUs
+--------------------
+
+Nios II CPU (since 8.2)
+'''''''''''''''''''''''
+
+The Nios II architecture is orphan. The ``nios2`` guest CPU support is
+deprecated and will be removed in a future version of QEMU.
+
+
 System emulator machines
 ------------------------
 
@@ -254,6 +264,11 @@ These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
+Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Nios II architecture is orphan.
+
 
 Backend options
 ---------------
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 952a0dc33e..6cb32f777b 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -160,6 +160,7 @@ static void nios2_10m50_ghrd_class_init(ObjectClass *oc, void *data)
     mc->desc = "Altera 10M50 GHRD Nios II design";
     mc->init = nios2_10m50_ghrd_init;
     mc->is_default = true;
+    mc->deprecation_reason = "Nios II architecture is deprecated";
 
     object_class_property_add_bool(oc, "vic", get_vic, set_vic);
     object_class_property_set_description(oc, "vic",
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
index 48edb3ae37..defa16953f 100644
--- a/hw/nios2/generic_nommu.c
+++ b/hw/nios2/generic_nommu.c
@@ -95,6 +95,7 @@ static void nios2_generic_nommu_machine_init(struct MachineClass *mc)
 {
     mc->desc = "Generic NOMMU Nios II design";
     mc->init = nios2_generic_nommu_init;
+    mc->deprecation_reason = "Nios II architecture is deprecated";
 }
 
 DEFINE_MACHINE("nios2-generic-nommu", nios2_generic_nommu_machine_init);
-- 
2.41.0


