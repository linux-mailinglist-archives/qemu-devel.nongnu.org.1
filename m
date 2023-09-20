Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 040897A8E94
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4tS-0004yP-My; Wed, 20 Sep 2023 17:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4tQ-0004xh-DV
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:37:56 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4tO-0006UY-Ro
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:37:56 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bc9c01e154so768065a34.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695245873; x=1695850673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuGegwgck8ZEFasbqFPHbzSlisDssAI2uj1gevUmTVY=;
 b=CJNTg+XIarrDxpOvJpzkF1L82ZlAPQcXd/ztUufOEMpPguc0lmsYWxLqiFTD2bSI56
 Jar6LV8XRntEw6olWxi2z5LsYBKmc4pl2btHBISB0JzC4QIObvYcC2aFmAb/U7rSM4si
 +f1LKmORmf5ezYj2YUBkHU7PWRfoFy8IXhdTzyaf+L/OPbeAVd9Ke5HfyxorY9/US2BU
 WQDVicM7Pq7YeGM0RdLTOwm3l2x2DhF8/ELWL2W3Ieuz4iT8eKKyGsIwNoYBbKeLXQ1G
 82UHEPEa4KybxJwvn2ILUXA5mU9mIOoIs/1VlkGWU1B9BNzgALLkLUnN9coxPY8KvkRf
 SMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695245873; x=1695850673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuGegwgck8ZEFasbqFPHbzSlisDssAI2uj1gevUmTVY=;
 b=JLT1lVCu3pJzUAcN8MxAdANVXJDAF/xas87vVXWm4hWZnlPUAZFmghXaCnbEmi1EWn
 SdiCiJROlgFrlTi0HjVP9gP28MKE3UCYQfTM1YPC6kxs2IE1nWi52eM5/pV9VdWXYH/l
 AAjpt0Qxf8S01fQa/TSD7/dQmHXFGujV/lL0y03y2CU7fGeLYmgTT3Cy1yRK3OYhjP7h
 vZaQPJZ4Oy3sAFkc9OjYcqhf60T4Fjc2m8z3/NHWxis1R6EcxOEB5j70w8TQc4v2sdTe
 zmwUkfYxXhSM0PbI9MDdDTb0Q/zwuQLn1G2vo3gdQ+aX6nBU6XpWxEDZ1A1LxNIqe4zL
 XyzA==
X-Gm-Message-State: AOJu0Yyf75X82Fz9ADlMdb9KTOQvU0Ql7xfvFXPAjob3ox5+z5R/CwBo
 OK5IKrNjbGh6Ko22S4EoziFt35gEvGGOPt6rJ+8=
X-Google-Smtp-Source: AGHT+IE0FQIXsImOFGvdL0B26UMsqCNheb/XWcMEh7MnJ0IcUpMYaEqRIDBvuLIdFjNOE6P/XcgBLg==
X-Received: by 2002:a05:6808:1a16:b0:3aa:1306:96e8 with SMTP id
 bk22-20020a0568081a1600b003aa130696e8mr4620035oib.1.1695245873364; 
 Wed, 20 Sep 2023 14:37:53 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 e1-20020a9d7301000000b006b83a36c08bsm64415otk.53.2023.09.20.14.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:37:53 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/8] target/riscv: add riscv_cpu_get_name()
Date: Wed, 20 Sep 2023 18:37:36 -0300
Message-ID: <20230920213743.716265-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213743.716265-1-dbarboza@ventanamicro.com>
References: <20230920213743.716265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We'll introduce generic errors that will output a CPU type name via its
RISCVCPU pointer. Create a helper for that.

Use the helper in tcg_cpu_realizefn() instead of hardcoding the 'host'
CPU name.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 11 +++++++++++
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eeeb08a35a..521bb88538 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -643,6 +643,17 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+char *riscv_cpu_get_name(RISCVCPU *cpu)
+{
+    RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
+    const char *typename = object_class_get_name(OBJECT_CLASS(rcc));
+
+    g_assert(g_str_has_suffix(typename, RISCV_CPU_TYPE_SUFFIX));
+
+    return g_strndup(typename,
+                     strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX));
+}
+
 static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 219fe2e9b5..3f11e69223 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -730,6 +730,7 @@ typedef struct isa_ext_data {
     int ext_enable_offset;
 } RISCVIsaExtData;
 extern const RISCVIsaExtData isa_edata_arr[];
+char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_add_satp_mode_properties(Object *obj);
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8c052d6fcd..f31aa9bcc4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -563,7 +563,9 @@ static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     Error *local_err = NULL;
 
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
-        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
+        g_autofree char *name = riscv_cpu_get_name(cpu);
+        error_setg(errp, "'%s' CPU is not compatible with TCG acceleration",
+                   name);
         return false;
     }
 
-- 
2.41.0


