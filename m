Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD0B7C83F6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 13:02:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFvc-0000LT-8v; Fri, 13 Oct 2023 07:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qrFvM-0000I8-1k
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:01:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qrFvH-0002Hl-OK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:01:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso1665789f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 04:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697194897; x=1697799697;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iINLba3Z9IRPyClB9itO+7onNYKObdnht5URrf2joic=;
 b=xkEl22lYMJW86pqpLEiYF8xRSkNDuuzi5u13mON/MPU5R1AHdu9Y2sYfP2u+b5LsPr
 YNnC89fH4rPbesRw9YBJ45UQaOoLMI4jz2GZu0A5CSJA/MBiR3JqYeWHYAPi3PZdUXVV
 drAgMQJy2y04eT8dtrPZQ9VEuZ0KsrisJpBIZ5ZUuGx9VA+16WjX2Rnwaik3YnvFiyWB
 MdKlO7cTKbBfcgzA5lR2xhM+EgKLV63Es9G8JeuPi50SFAIWqSbaNwAO4h0aUmMH69zL
 tojMvUEwcCgD6jrfxz/26Rh3CNMuXdA8DWRVsIltWyvIzH9r5IeHmIIxhPQ4EtYZ+9kE
 c++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697194897; x=1697799697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iINLba3Z9IRPyClB9itO+7onNYKObdnht5URrf2joic=;
 b=mgo0MpPRauVeIjM5u/IXzBMUk2ZWA3ULgMHazliWDfpWYYpyb4rzbQvdzgQY2+WWzo
 PqFHYydizeYeZz3MiSbzegUS14IrO+rapfbZanrNOcUwHWbK7QKt2hYff6gokujd4EQ7
 z3XJpP7HhLgLvFDeICxv17qmq0HkQ4pe1KciK/lgdUGsEJpUc0ZpaI4mF0jnCGV5I5h5
 iJtzFYi18c7SvQDWZ/KjyVTF9LFg8qhuxdo5xE9lZPon479dRX72xzTUJ51KM8AvNTtF
 z3Os1fntM2ojm8GCG45Z0uYU21BTwars7rUZRF5B6XWbnZQEO/ifwEL8+awUZz5g87Hl
 3MGg==
X-Gm-Message-State: AOJu0Yza35+8MJdLbarQP/BOVHxA7w497RWptInRS7Adx590UFSccZSg
 sGGdLaYtBVZjcujo+ewJ7mbQnXyoaojVmcnR7QQ=
X-Google-Smtp-Source: AGHT+IFcI+6OY+haosN8G/SBb++UYo3pMErPptRA0Ak8u46NlvDD3LePkXqeiHLxn72w3kvlzgfobg==
X-Received: by 2002:a05:6000:cb:b0:321:7050:6fb6 with SMTP id
 q11-20020a05600000cb00b0032170506fb6mr21299814wrx.67.1697194897383; 
 Fri, 13 Oct 2023 04:01:37 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 p8-20020adfce08000000b003271be8440csm20455185wrn.101.2023.10.13.04.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 04:01:37 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v3 6/6] target/riscv: Use MAKE_64BIT_MASK instead of custom
 macro
Date: Fri, 13 Oct 2023 11:54:48 +0100
Message-ID: <20231013110111.34619-7-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013110111.34619-1-rbradford@rivosinc.com>
References: <20231013110111.34619-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A 32-bit mask can be trivially created using the 64-bit macro so make
use of that instead.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 9253e5f17a..052d5b1164 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -25,8 +25,6 @@
 #include "sysemu/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
-#define MAKE_32BIT_MASK(shift, length) \
-        (((uint32_t)(~0UL) >> (32 - (length))) << (shift))
 
 /*
  * To keep it simple, any event can be mapped to any programmable counters in
@@ -455,7 +453,7 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
     /* Check if user set it by comparing against default */
     if (pmu_num != 16) {
         warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
-        cpu->cfg.pmu_mask = MAKE_32BIT_MASK(3, pmu_num);
+        cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, pmu_num);
     }
 
     cpu->pmu_avail_ctrs = cpu->cfg.pmu_mask;
-- 
2.41.0


