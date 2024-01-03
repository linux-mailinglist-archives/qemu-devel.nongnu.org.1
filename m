Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A68233BB
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5EX-0002WK-PA; Wed, 03 Jan 2024 12:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5EF-0002EH-6L
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:31 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5EC-0001Uq-Al
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:30 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so4670499b3a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704303626; x=1704908426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPGSESp/CUCLZoNx8N16PKLb5QqnmdpX6vsDgGj1+cM=;
 b=MVlP/4tJ9sJ6AY0eVxEzUq6kIKK4SjVbhTT1766iVu1MjzFMKNd7I37qS12ZImmqLk
 ymJx1W07N1eQnBT6wqy8aMK6SIHQhG4O7SUaREyLL5LOmTzOMivYU5M+axStJfoFvZPb
 5KSYS2gnapSn831qpiWcdcnJF2jSSlQ7h63KXrYMCKn6dUAZTIUbkOu3BS7qZ2YZpRw4
 O89xIXy7yDAEaQqgzdacvptirlracfMqSFbGV2z7H+q8YoG0mTy4wYTjIQEeepCtp3hi
 2FeSgnVw8WVoYF+EzvYW/MCxNehvapZGwLG0s3pjmeORH2iy5MjP1K95iRy+PGEfFVkf
 MsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303626; x=1704908426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPGSESp/CUCLZoNx8N16PKLb5QqnmdpX6vsDgGj1+cM=;
 b=RlZoA/5Q3o1MTxQEws+SsJdrMbxw2TzIiQypeZjcKZM+boXr0NJfJGIkAqffoeH/xj
 OSxlzho3Bd6QrCB08Ep1mJk6SJEoYcW8dgMt/64YEtATadqBFC81oMHT+3iX8C+Xm2Hg
 L6tqYF16QHinpjxUvHbiZg81/VKqnbvZP/2/6UlB7wLsiylw9piBzd5t7/6/XiPL97lD
 GjBpUucGivJoZFxA7hiPE/mo7H7ZSpSl0p7lyVMLfHPrGJnZRAblhpB0rPz85EsF0XUB
 B0BgMU/GW8z09O1qd5v8UlWDOTXwR7yufMirhOMzqHRnuFZjPGeDpOn3d7SdmctBKYTA
 Kqxw==
X-Gm-Message-State: AOJu0Yw8h0h/Y8wd4zSBXIr4ADC8gj2RCE3j/vaJvwHOB/dJJs2Jdum4
 yky2xL9CGKDdpDN/F6ULoQMonp2b3SmT/eCkrs5/cMotIDn8Ew==
X-Google-Smtp-Source: AGHT+IF6wVreYAvLZQxLZEH57HIJpgt9VScSAwYd7YJD2xnpPMQmb6tRDJuUMnZ1g0/9CdBFgv17Bg==
X-Received: by 2002:a05:6a00:90a4:b0:6d9:b173:4f9b with SMTP id
 jo36-20020a056a0090a400b006d9b1734f9bmr8975770pfb.38.1704303626046; 
 Wed, 03 Jan 2024 09:40:26 -0800 (PST)
Received: from grind.. ([189.79.21.107]) by smtp.gmail.com with ESMTPSA id
 v3-20020aa78503000000b006d7f1ae421csm24042050pfn.145.2024.01.03.09.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:40:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, vladimir.isaev@syntacore.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 01/16] target/riscv/cpu_cfg.h: remove unused fields
Date: Wed,  3 Jan 2024 14:39:58 -0300
Message-ID: <20240103174013.147279-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103174013.147279-1-dbarboza@ventanamicro.com>
References: <20240103174013.147279-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

user_spec, bext_spec and bext_ver aren't being used.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h     | 1 -
 target/riscv/cpu_cfg.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d74b361be6..40c96a32cc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -164,7 +164,6 @@ struct CPUArchState {
     target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
-    target_ulong bext_ver;
     target_ulong vext_ver;
 
     /* RISCVMXL, but uint32_t for vmstate migration */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..c67a8731d3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,8 +136,6 @@ struct RISCVCPUConfig {
 
     uint32_t pmu_mask;
     char *priv_spec;
-    char *user_spec;
-    char *bext_spec;
     char *vext_spec;
     uint16_t vlen;
     uint16_t elen;
-- 
2.43.0


