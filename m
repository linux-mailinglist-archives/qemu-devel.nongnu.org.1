Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F782F914
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:59:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqW7-0004bV-7X; Tue, 16 Jan 2024 15:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqW5-0004b0-8x
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:37 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqW3-0007ac-OQ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:37 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28b6218d102so8374576a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 12:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705438713; x=1706043513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMz09xcYNz3keGI4UWTDb3bB/98jmD7E1p5KuCSCWqs=;
 b=dceBJQkbEffYybJrELBa3oYy/1sZJbkXL9taFcSVI1pozLPv32MCn4HDO8w0BqDejA
 8nw5gUTJPsrqrILjAszxvbGOhdPu54zuNhSYNJt/xRzT7KrFDmKDChSvxYjq/McPfb/Y
 T7QOQS9CkLb7XukaabNvXutXWWBtM4sJSKb7JOgu534/TwfocFFzSvMDyfWLQJ+LZxGp
 3a/KBFQaT+Zmctb9QRdRPeoCu1wJAfnzF1qQNvoc1C004R4DttJhyYeoMCU3h4X/tsJW
 jv825xKB4Npb2gvletnaWRsu9uLYJj1oqaj4akbk8Aq9GDwdoAgHlby66npMlJWdQLUE
 DJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705438713; x=1706043513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMz09xcYNz3keGI4UWTDb3bB/98jmD7E1p5KuCSCWqs=;
 b=lzvpIosspmTsHjDPLP6aPln5/LTbphb3HO1XuXPGln2Mon9+Jc3kEX0r852FlSx3fa
 RN4hYD8XaZHy+TilrXFFaRTPoaS/pXvEuw8TbnEzVnJZOfxcTbfjhed7YhWH1gaLUq1z
 jofdQMJy/oSlYGuwfDuRjp9F9FhI30BR5ccR1PnGnwRMlFyIqSbVGtKkpgI/lDBqYXmp
 1B0kKB60BDiNEP7sRmREiODz45vPV5OcBg++gsACs2kx/AVpc7FspRKhK8EweJ3aSbEx
 CgZzFrnTARxzfD2eq1YRUd+Mjot2OX4XcjXwYaKQi/V+n+XNyNj6DKfY1rS8oiSU9ZS8
 kg0A==
X-Gm-Message-State: AOJu0YxwPpHf7PbzT7jBisQx9nPOveWT9Rn+fPn9rHnhXFRBKmzT6p9x
 P8GxZF9uFOcqQCJ+l+H5RW0wdw7IhrKs4wNbdyzio+2G4QoO4A==
X-Google-Smtp-Source: AGHT+IGi/0Gwglkh7KSOvzb1QqD9dmOpWYO/5OE56ZYiu8APMgVHF4pwpUdUwaPtwEYddThP6tO6nQ==
X-Received: by 2002:a17:90b:ec7:b0:28e:aaaa:34e9 with SMTP id
 gz7-20020a17090b0ec700b0028eaaaa34e9mr662276pjb.51.1705438713683; 
 Tue, 16 Jan 2024 12:58:33 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 sh2-20020a17090b524200b0028df5c748e4sm11326949pjb.44.2024.01.16.12.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 12:58:33 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 03/13] target/riscv/gdbstub.c: use 'vlenb' instead of
 shifting 'vlen'
Date: Tue, 16 Jan 2024 17:58:07 -0300
Message-ID: <20240116205817.344178-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116205817.344178-1-dbarboza@ventanamicro.com>
References: <20240116205817.344178-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102d.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 58b3ace0fe..5ab0abda19 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -130,7 +130,7 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 
 static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
 {
-    uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;
     if (n < 32) {
         int i;
         int cnt = 0;
@@ -146,7 +146,7 @@ static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
 
 static int riscv_gdb_set_vector(CPURISCVState *env, uint8_t *mem_buf, int n)
 {
-    uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;
     if (n < 32) {
         int i;
         for (i = 0; i < vlenb; i += 8) {
@@ -266,7 +266,7 @@ static int ricsv_gen_dynamic_vector_xml(CPUState *cs, int base_reg)
     RISCVCPU *cpu = RISCV_CPU(cs);
     GString *s = g_string_new(NULL);
     g_autoptr(GString) ts = g_string_new("");
-    int reg_width = cpu->cfg.vlen;
+    int reg_width = cpu->cfg.vlenb << 3;
     int num_regs = 0;
     int i;
 
-- 
2.43.0


