Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6FF828C03
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:10:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGYQ-0002Rz-Mb; Tue, 09 Jan 2024 13:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXt-0002Pk-Fv
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXp-0003uq-5O
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e4d778e5eso12484495e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823780; x=1705428580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5j2p6OKwzJC1ZEqQVM4irz5Oy7NtypkEBAv8Xtr+qU=;
 b=TZCsYv6f+Fh5Zt3RQ1/RneNMH6rK5+J+9ew2bgNhPDn01HVbiG7u4eRjzLmXaCxu8a
 O8G1wUBOzLR51FRxYjH9XzEXg2mNBQTF1vYgdeRV/mG+FRCO7wcsWq1rGJ2YMH1KNVow
 p4GTe8j1Y1sLg2YRMY5Q0YMRf7LiuMMwDRNYmurtTR2wwxC4uRXAn6bb1H02q9ESnxix
 E9+X+T07nT/6NevlKA8twNjjEz8c+KBwHMVOZqFvf3eRJMRoCBWH12N510g7Yqy7ea6g
 6BOZFqzUMsNaqOZcXegBDK6ulrpytQHG7Bz8YlTSC3hHTcK7UfQ62i9/U6TlOqwfNftA
 XzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823780; x=1705428580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5j2p6OKwzJC1ZEqQVM4irz5Oy7NtypkEBAv8Xtr+qU=;
 b=sBz2deL4TPNOkLhjznq3kryiIg0s0hJ858LrOlgdziSTmxaQ+ljifOFvaO9ZHtNqrP
 LiDzcOojDhcU1MZRNt/vLY/cSOEX1VgLX2sne5VlUz4X4eFEd6B/nKn7TEXi8hQU/QI5
 h3kXRed7VpzN3Fwr+XRfVAYz5LJYlOZMtey2yjZC4Lvov03KzZHOuMIsYZQ5zZ7ffemq
 HJOd2hIz1LUQrYJnZENWcccEzEEGXYYSsZMM86CDa/B+0K7CRo2fYWqflXP+CZyov3hN
 Sg7VPqaQ+tJ+QlBCDiXiQkd3o9/51Ud7ZIju/oHGGWUSXw+hQB1ixkr06RQAamMCFVbk
 zMtQ==
X-Gm-Message-State: AOJu0YyX5hCiAu6+bWcBE5YQ6sG/4Y4lHIYKoDCYakcxks1EVDBaBFdE
 NcM0uIYEAc/MWhtAE10qZADhW1VS9n44VVnITi+fpYy/lA4NIQ==
X-Google-Smtp-Source: AGHT+IHV9YSsFjhJsNkaNRxtL2ZWaA4NYuAVVSfCkzcK/wAgLO9QVTkYuMRe13iW4oHxzjynZlEiCQ==
X-Received: by 2002:a05:600c:b56:b0:40e:52e0:baca with SMTP id
 k22-20020a05600c0b5600b0040e52e0bacamr368437wmr.129.1704823780337; 
 Tue, 09 Jan 2024 10:09:40 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 i12-20020adff30c000000b00336b8461a5esm2980486wro.88.2024.01.09.10.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:09:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/14] target/arm/cpu: Simplify checking A64_MTE bit in
 FEATURE_ID register
Date: Tue,  9 Jan 2024 19:09:16 +0100
Message-ID: <20240109180930.90793-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

cpu_isar_feature(aa64_mte, cpu) is testing a AArch64-only ID
register. The ARM_FEATURE_AARCH64 check is redundant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1c8b787482..c828b333c9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1690,8 +1690,7 @@ void arm_cpu_post_init(Object *obj)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
-        cpu_isar_feature(aa64_mte, cpu)) {
+    if (cpu_isar_feature(aa64_mte, cpu)) {
         object_property_add_link(obj, "tag-memory",
                                  TYPE_MEMORY_REGION,
                                  (Object **)&cpu->tag_memory,
-- 
2.41.0


