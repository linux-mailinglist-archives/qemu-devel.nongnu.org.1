Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9FB7F6376
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4C-00060N-O2; Thu, 23 Nov 2023 10:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C47-0005yl-3R
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:31 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C45-0002LE-A1
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3316c6e299eso664119f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754988; x=1701359788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cgs4AXu1OeQxqa1QuWOIvdMfSPeenS1HCaJ1Sdn6f0=;
 b=GHYWovXhT36wUQqqD3pdPO9pVkqcMIx1eL8rz6lVxMjGSDtnhZn8HWIYg9AKFXAaSH
 KUNQePLeTMqxhmNs9aF11ZZGSclDbPSa5hvm6H16JYfe1DzhNJJV/5M664UYpljq2Rx2
 jYnBE96eWVmUfP8bcNrXG62+uGAqtxjuUOyaSU+c0K6FZ9KAi/fKfNNtcPSdatsQMI9b
 iatM1EtuaTyCBOVXwcBoHN1OhL6c3kjBLyXwp+4YLj7gsP3NLmvTpwerr65rIk2yvKDn
 wmLlgFf3WToVhGE85fE3tQKtSqmxR9lEHTcJGCRHFYJPObepf02W9jeYsv4eP6fk+V+F
 R+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754988; x=1701359788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cgs4AXu1OeQxqa1QuWOIvdMfSPeenS1HCaJ1Sdn6f0=;
 b=nNfG3KSSxkeXwEGZNcFqameFmFlIJlBWqs8OV1Cy7U8Q4Lsz4nsyL0BS0vvMWSSXM/
 mpt4/hgv7hgI/K4PIgM38xMPsCfX4W4lu95cq4j/t7hrMZsVzNP3mWc6ezXdvS8j+bQh
 YlqpLrkSofso9bdfmX+eBLl+Qz8OZ2Xx+rf9MVWP+qiKxufqNIHqZa+IeeJVkwttPsiP
 filxI2in9Vj+ffxsqEXRR+G9HDbt4UF7HhkEG+xgPeh16wZsbuykGWmhmQSAqQO4ou1H
 iY7vkztwDgpM/e/ykgz8kR27SoTT8C6yoWeoem3ipdHgaPyHb+nwN+/SAFsfkgPTPzrw
 SGNQ==
X-Gm-Message-State: AOJu0YwsFfWQgPeDiXkYbqzFkehNxLlKWuAdlYMRUhkGO5oXqXVdPD/C
 pPfQi51y1qD0ioCmZrLxsAbyyA==
X-Google-Smtp-Source: AGHT+IEcQYTMTA6kVNK1/wgEf+2X4KdquRDS+utJj983ZeFALTpSO5a1g385Fg64PfMD5AMk1iHI/A==
X-Received: by 2002:a05:6000:1842:b0:32d:9fc9:d14a with SMTP id
 c2-20020a056000184200b0032d9fc9d14amr4383750wri.12.1700754987900; 
 Thu, 23 Nov 2023 07:56:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s15-20020adf978f000000b00332c693c73csm2021371wrb.37.2023.11.23.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3867B645FA;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marek Vasut <marex@denx.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org (reviewer:Incompatible changes),
 Chris Wulff <crwulff@gmail.com>
Subject: [PULL 05/14] target/nios2: Deprecate the Nios II architecture
Date: Thu, 23 Nov 2023 15:56:11 +0000
Message-Id: <20231123155620.3042891-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

See commit 9ba1caf510 ("MAINTAINERS: Mark the Nios II CPU as orphan"),
last contribution from Chris was in 2012 [1] and Marek in 2018 [2].

[1] https://lore.kernel.org/qemu-devel/1352607539-10455-2-git-send-email-crwulff@gmail.com/
[2] https://lore.kernel.org/qemu-devel/805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Marek Vasut <marex@denx.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231117070250.32932-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-6-alex.bennee@linaro.org>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6c84db90b5..2e15040246 100644
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
2.39.2


