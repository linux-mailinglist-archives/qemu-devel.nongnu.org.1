Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5A825711
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:49:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmO7-0000pA-JA; Fri, 05 Jan 2024 10:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmNc-0000Ty-UR
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:45:04 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmNU-0003OW-Lf
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:45:04 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d76923ec4so16150265e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469493; x=1705074293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN0awrbP5OQORGwTdpI9FL1dvbQ4lYRKpoXyYpVskO4=;
 b=uDsRx22HU9SPJoRjW5EZmUusQOdM5juuuem7KmvDmMSmC21ft5eSOz0A8EelsndkkL
 yvLdtQ5T2T5dbhwOguPxw3Ouh3UA/UpdLBm+TEOOIe49tUH1AuRvW3zrzVL3jIoooL4e
 jzNpbPbGf8tGzf4mf/SXHTAU92X1dEtMVbEQf7pNVk8nCIU1VLLBQBB4NdBA1weSdFXN
 yUPi88L7njaqphZbehhPVtUZ35GmpBYRKLrdWjxn4gx2whGjTNOyrFrnSatbH2H0EoT0
 DEKT9FpnXTIpraEGR1sgDuot99Wd9068pIAYMUqsZ0ZXUzRirvhSiDEXdZl0Vr2CdhdD
 aERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469493; x=1705074293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VN0awrbP5OQORGwTdpI9FL1dvbQ4lYRKpoXyYpVskO4=;
 b=fGTzquMp0DMzEmkN2PAkJlRCfgJT/3fMpItXY3CfIGyov10xDC17ISSh16qaQWmFqQ
 4t1D3FNh1I6cDhB4O8Xn/FZsWk7VN9U61Q4Ayt4zZ9oDrL5W0gWEvbQCLDMD8VCheK0O
 7BbZG6E6WXiKHT2KvvpJQ5skUBMgzS9HJXTS4xdYb/za37itAA3AVRlGDWCzYOazSA4A
 PQQ/L8P5gx5JzLc6uSs6KnjqbKQS8RMzL+Az5Y9UrA1leuJR3EU7s3VLATwb6wNc+nsE
 xEzDkH0tvcm+Vc2hGsDwJz/kLbO35yffZ177H/qhUGOcW8SkzJZ48QPM2SyxQjkSYzFX
 VJyg==
X-Gm-Message-State: AOJu0YxInElMEvChfoSBWgZoOCprLlkfHZ+ayY8jJyylxWDJognWUv5N
 e7aCR3FAnCcMGjvAhHdrxtEGkNbFXtd4SCt3Ezyu6jegqMg=
X-Google-Smtp-Source: AGHT+IHWSYp2jY1eYlnMa1CbjWJHJImj2Iyob8urRls6KMAyBOW061rgsbEXlE4kBPy9kYveR9woYA==
X-Received: by 2002:a05:600c:5487:b0:40d:877d:ca1 with SMTP id
 iv7-20020a05600c548700b0040d877d0ca1mr1218138wmb.54.1704469493513; 
 Fri, 05 Jan 2024 07:44:53 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040d6e07a147sm1938605wms.23.2024.01.05.07.44.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:44:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 17/71] target/riscv: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:10 +0100
Message-ID: <20240105154307.21385-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Gavin Shan <gshan@redhat.com>

Before it's applied:

[gshan@gshan q]$ ./build/qemu-system-riscv64 -cpu ?
any
max
rv64
shakti-c
sifive-e51
sifive-u54
thead-c906
veyron-v1
x-rv128

After it's applied:

[gshan@gshan q]$ ./build/qemu-system-riscv64 -cpu ?
Available CPUs:
  any
  max
  rv64
  shakti-c
  sifive-e51
  sifive-u54
  thead-c906
  veyron-v1
  x-rv128

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231114235628.534334-18-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h |  2 --
 target/riscv/cpu.c | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d74b361be6..2725528bb5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -490,9 +490,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
-void riscv_cpu_list(void);
 
-#define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 523e9a16ea..22d7422c89 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1733,35 +1733,6 @@ char *riscv_isa_string(RISCVCPU *cpu)
     return isa_str;
 }
 
-static gint riscv_cpu_list_compare(gconstpointer a, gconstpointer b)
-{
-    ObjectClass *class_a = (ObjectClass *)a;
-    ObjectClass *class_b = (ObjectClass *)b;
-    const char *name_a, *name_b;
-
-    name_a = object_class_get_name(class_a);
-    name_b = object_class_get_name(class_b);
-    return strcmp(name_a, name_b);
-}
-
-static void riscv_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    const char *typename = object_class_get_name(OBJECT_CLASS(data));
-    int len = strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX);
-
-    qemu_printf("%.*s\n", len, typename);
-}
-
-void riscv_cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list(TYPE_RISCV_CPU, false);
-    list = g_slist_sort(list, riscv_cpu_list_compare);
-    g_slist_foreach(list, riscv_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 #define DEFINE_CPU(type_name, initfn)      \
     {                                      \
         .name = type_name,                 \
-- 
2.41.0


