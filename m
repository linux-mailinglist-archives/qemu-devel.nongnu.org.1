Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BAB7DA601
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwf62-0000Qw-Pt; Sat, 28 Oct 2023 04:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5z-0000Ot-JG
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:03 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5x-0004B6-Qn
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:03 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5afa5dbc378so11223937b3.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698483300; x=1699088100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzEX189KVTjI8umdVpphtXoW9g5QfPnPZYDjQfxNTeg=;
 b=hnqu/4/2qrVq3DD5SaGKNXpGMYTwuiXnwC5KuZT7I3d7LzaQZR65qQGMFSM/62gdkL
 piy62qLrgF0NIs03BXb0jBW9TXHkj30KANPux2WCTc0hmW+fdDBFh+nIAMd1dgCEW0bv
 vjzs5AJ/ImLFgr4ibd5HoD+DQOybE089JHSINkUC5C6ZA88IqKK6x1PtWlIurPM9SddF
 THC5RiFsMLyKo+0FkgpUgpUGKeh/Onl5hhYBqVeAHTvav/Hd5hjIJCP2+WL4zVI10WUv
 5i2ws1ICIqc1asIzCrOrX5+FQPUcictpV1i7sQ8bnWvYG9vhh/eBUL5tWkeUwYeeHD/W
 XkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698483300; x=1699088100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzEX189KVTjI8umdVpphtXoW9g5QfPnPZYDjQfxNTeg=;
 b=Awe0e580PeKLJk8OANhLOaOR+6pJ3qDM9ydrdTqfbwi/DuMr/N+bIhuzzs0sj8domc
 2Jb/HICJ5g6eNKVNIlXOjD5dP+ZzSYC+bz5xvCOyAgBdRQiGBm+q04InNes54XLHvFOE
 EecQQjjE6QXaHbrjAmbrL7wl3b4quwFxxUEiEdZUBKdvA4qq0xVRm7zPCoJLmqB6/Hp5
 neEurhV5x3RUtQN3+Njt/zYEV6n1b1PwONy/JeqJgC5aih3DJGU3wkc9AqsdKpEN0s6H
 cdGuUkhqE6tSu3KyiTR+fejv0M+Pq2+2c28NDYqqLj3jPSWeOsRbqUYs3UqDL/zFoQGZ
 diMQ==
X-Gm-Message-State: AOJu0YxSzoFvTllk/rubFa+HUBzO03QtYpRh8qihBuEhiH9qJyVzDbJZ
 ZOi/M+yrZ3qX/RXgyBkbGEyp7ZxvTisdPTVIJnY=
X-Google-Smtp-Source: AGHT+IHuxVCbbSYLW67ZpfDg3+vp2/NNGbo6AfbK4XP2wbCeHQd0datokS61iCeeinhwyslbH/UMKg==
X-Received: by 2002:a81:8b48:0:b0:5a8:d790:87df with SMTP id
 e8-20020a818b48000000b005a8d79087dfmr4141462ywk.19.1698483300200; 
 Sat, 28 Oct 2023 01:55:00 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b00594fff48796sm1604325ywf.75.2023.10.28.01.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 01:54:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 09/12] target/riscv/tcg: handle profile MISA bits
Date: Sat, 28 Oct 2023 05:54:24 -0300
Message-ID: <20231028085427.707060-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028085427.707060-1-dbarboza@ventanamicro.com>
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
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

The profile support is handling multi-letter extensions only. Let's add
support for MISA bits as well.

We'll go through every known MISA bit. If the profile doesn't declare
the bit as mandatory, ignore it. Otherwise, set the bit in env->misa_ext
and env->misa_ext_mask.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 910360ce37..6ba27b824b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -828,6 +828,19 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if  (!(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        g_hash_table_insert(misa_ext_user_opts,
+                            GUINT_TO_POINTER(bit),
+                            (gpointer)value);
+        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
+    }
+
     for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
         ext_offset = profile->ext_offsets[i];
 
-- 
2.41.0


