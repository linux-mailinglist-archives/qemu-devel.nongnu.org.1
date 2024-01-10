Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E956F82957E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPa-0001NF-8O; Wed, 10 Jan 2024 03:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPX-0001Mw-IG
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:07 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPV-0003QE-SJ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:07 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so3505735b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877084; x=1705481884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWR5Ypu8TnZM5lwAhE4e4xNVESu7XYKOpcBKQjC2Lsg=;
 b=WIgNEcSLykVX+RYZlR7IJFJ56448WBFjuwHWIeW53l5Xhln9SOLZfCdsQDdIDZsmlH
 kgc3JeOK2KRFsvNbZWMlCjSMHbcf13jgPiE4PleT5VAmtZOsb3PfzX14Y8mtOgQc0DPX
 krCpsXUo8r+UxdSs/8Hff0lXU9HRfUpQ/cGBZ5Dk/rej1PzOuYQ5pvwOCzcqtWGN0woO
 +u5LfH9yvIECoTVBPwNePSLfqX4jNkiPlsSkIm6d9Lcq4Sh8tqMxIbDBJaobiJD5e1/Q
 ihms2ud0bA1fdDNKfz2jnUOKA/3bSJSKqEgGiuc2nY1ibduZpzTFNF/3SGrO+3gUHJ3+
 y8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877084; x=1705481884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWR5Ypu8TnZM5lwAhE4e4xNVESu7XYKOpcBKQjC2Lsg=;
 b=FmvwxKMDeac/ir0aEahHorDgbiutRkFRiAPteSaOlYkaWGpcFsqRNWT6IGHBywLsMN
 L1XohN7AScZ/ugx8lRA7XCeiPhsTJtgs2Rn1gE3hgLVEik3bN4j+3YuuibYhs+MrFuiV
 LW7PDY7DNrqk2XKpE2WOQMDwYGY9jEBEVRx4YUkYX3DMi4bB5PQVCF0u1Ou2sOnnEtKu
 Zp4a6WftcSkihuywpklOJMiDU1bTWlxH3GMcOT3JKmh8OViuGhtff6btO1O66ZPcmmuS
 wZtqVwpv7SElcDgMRqjJeecT0Cig01Ah6IAOtAeTLgHTiWt9eLcLO6Hj41NpZIq6DKdE
 1W3w==
X-Gm-Message-State: AOJu0Yygg5+lbTkqwGNjb6d7qDAaqp34KdQDnsGYWTducmzm+ljXEYVD
 Lkq1cFthhhz0iRxkvRE5JATJ8ZS708m7bt8x
X-Google-Smtp-Source: AGHT+IEifkHvedUN016FYxaIsG9OaMpUi9r8z+2v3iFTfA43DDd2RYX1ntwVIO792Vu6ls5WcgwyjA==
X-Received: by 2002:a05:6808:1821:b0:3bc:9f3:aef7 with SMTP id
 bh33-20020a056808182100b003bc09f3aef7mr1005165oib.105.1704877084604; 
 Wed, 10 Jan 2024 00:58:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/65] target/riscv/cpu.c: fix machine IDs getters
Date: Wed, 10 Jan 2024 18:56:34 +1000
Message-ID: <20240110085733.1607526-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

mvendorid is an uint32 property, mimpid/marchid are uint64 properties.
But their getters are returning bools. The reason this went under the
radar for this long is because we have no code using the getters.

The problem can be seem via the 'qom-get' API though. Launching QEMU
with the 'veyron-v1' CPU, a model with:

VEYRON_V1_MVENDORID: 0x61f (1567)
VEYRON_V1_MIMPID: 0x111 (273)
VEYRON_V1_MARCHID: 0x8000000000010000 (9223372036854841344)

This is what the API returns when retrieving these properties:

(qemu) qom-get /machine/soc0/harts[0] mvendorid
true
(qemu) qom-get /machine/soc0/harts[0] mimpid
true
(qemu) qom-get /machine/soc0/harts[0] marchid
true

After this patch:

(qemu) qom-get /machine/soc0/harts[0] mvendorid
1567
(qemu) qom-get /machine/soc0/harts[0] mimpid
273
(qemu) qom-get /machine/soc0/harts[0] marchid
9223372036854841344

Fixes: 1e34150045 ("target/riscv/cpu.c: restrict 'mvendorid' value")
Fixes: a1863ad368 ("target/riscv/cpu.c: restrict 'mimpid' value")
Fixes: d6a427e2c0 ("target/riscv/cpu.c: restrict 'marchid' value")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231211170732.2541368-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b07a76ef6b..53b82cc581 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1570,9 +1570,9 @@ static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
 static void cpu_get_mvendorid(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    bool value = RISCV_CPU(obj)->cfg.mvendorid;
+    uint32_t value = RISCV_CPU(obj)->cfg.mvendorid;
 
-    visit_type_bool(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
 
 static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
@@ -1599,9 +1599,9 @@ static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
 static void cpu_get_mimpid(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    bool value = RISCV_CPU(obj)->cfg.mimpid;
+    uint64_t value = RISCV_CPU(obj)->cfg.mimpid;
 
-    visit_type_bool(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
@@ -1649,9 +1649,9 @@ static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
 static void cpu_get_marchid(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    bool value = RISCV_CPU(obj)->cfg.marchid;
+    uint64_t value = RISCV_CPU(obj)->cfg.marchid;
 
-    visit_type_bool(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
-- 
2.43.0


