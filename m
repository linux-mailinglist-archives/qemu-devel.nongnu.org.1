Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7A787B4B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIcB-0008De-2E; Thu, 24 Aug 2023 18:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIc9-0008DQ-LS
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIc5-0006Oa-Rk
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:41 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bd0c953fd9so249204a34.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915336; x=1693520136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqQrvTRLw/XodZhUz0KVC8yMX5hiac5W7HG7fn4bR4o=;
 b=mEW0a9sg0rp/sLz8X1T+XG4w5urcbFG3HBrAsSzT6C2WRpguWq8SGEXVaiXunSuDx8
 7HDjR5mDeNXGR5Q1C2QyhXAOpX09IM/P1AzDrCwS7LHY+wNrewNF2uZPEIuhO1FjrglE
 h234yKFpur01qRSyYOF/sddGqec9kf+22KjQdKsBpBuo3Jvzc/6bTvl9tDd0HCSBRfGh
 Z1lFBenKkZnSRV809q6pvA6uRZ01vQQr0SsXNHWBOvHXzTU8IRHZG9Y8OKpwkfNEtDk/
 Ev9LCsVENFcYGg7S0cNjf5h4oIQB5NmlnLIHQyZ6i42n5TQioPxYg+0f3B1RByy1voTu
 bWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915336; x=1693520136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqQrvTRLw/XodZhUz0KVC8yMX5hiac5W7HG7fn4bR4o=;
 b=RNl5c3UjNJFaG7i0AJbXevFboUUnmjgvP6P4Ipg7wAVJeZdQhy0jFgHYBJfJNABtC0
 7KLg080Kku+CuBCQ5yNwlvAtpaIjzZwSRz3zvfb6HncQRaFO+1fhHiPjXX9/sDHqaxOk
 8xyLHj+AJjdPPccmwY2/0B21X6UdsgfP9wg38pWIDs2Hxe6LO9guQwS0KqjNREZ+o3wN
 IwchiU6MiAEA1iURnYrse1v27+78lAy/9K2n7rpQ89nMoEzutGRT94wBfMSLva6N08Zn
 AmyyZY2DT3mSLSYfMiN3qOqsQFv/W8t2QjNmg/84pkQzychqLhY7gs91p/TIq+7qYtXh
 /p7w==
X-Gm-Message-State: AOJu0Yzs3Ek51AvjUfVVzYBc1X3RgEg4IYU7y8xkADmTMLE5KMzgIcd4
 OPpfJodPwwczZKpLqMYKHXfcieSiSQiZnsVGjOQ=
X-Google-Smtp-Source: AGHT+IE1S0QhoIMYGCqLXcg4mpZTMzeNJDwnRuOKgpl2vBnPQ2Cq49bWSoDL7iPwXND6249Xu985vA==
X-Received: by 2002:a05:6870:d60c:b0:1be:feb0:33ff with SMTP id
 a12-20020a056870d60c00b001befeb033ffmr1203906oaq.6.1692915336575; 
 Thu, 24 Aug 2023 15:15:36 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:36 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 19/20] target/riscv/cpu.c: honor user choice in
 cpu_cfg_ext_auto_update()
Date: Thu, 24 Aug 2023 19:14:39 -0300
Message-ID: <20230824221440.484675-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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

Add a new cpu_cfg_ext_is_user_set() helper to check if an extension was
set by the user in the command line. Use it inside
cpu_cfg_ext_auto_update() to verify if the user set a certain extension
and, if that's the case, do not change its value.

This will make us honor user choice instead of overwriting the values.
Users will then be informed whether they're using an incompatible set of
extensions instead of QEMU setting a magic value that works.

For example, we'll now error out if the user explictly set 'zce' to true
and 'zca' to false:

$ ./build/qemu-system-riscv64 -M virt -cpu rv64,zce=true,zca=false -nographic
qemu-system-riscv64: Zcf/Zcd/Zcb/Zcmp/Zcmt extensions require Zca extension

This didn't happen before because we were enabling 'zca' if 'zce' was enabled
regardless if the user explictly set 'zca' to false.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae8c35402f..e07b2c73e7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -196,6 +196,12 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     return PRIV_VERSION_1_10_0;
 }
 
+static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
+{
+    return g_hash_table_contains(multi_ext_user_opts,
+                                 GUINT_TO_POINTER(ext_offset));
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -207,6 +213,10 @@ static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
         return;
     }
 
+    if (cpu_cfg_ext_is_user_set(ext_offset)) {
+        return;
+    }
+
     if (value && env->priv_ver != PRIV_VERSION_LATEST) {
         /* Do not enable it if priv_ver is older than min_version */
         min_version = cpu_cfg_ext_get_min_version(ext_offset);
-- 
2.41.0


