Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F10088295FC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:13:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURx-0007dy-1Q; Wed, 10 Jan 2024 04:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURm-0006FG-2R
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:26 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURk-0004wU-AN
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:25 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bc1414b48eso4372738b6e.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877223; x=1705482023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCQbSlI9RnIdZmdRFjrUmnCmAmNWg3RiTI9uMVnz4NQ=;
 b=TvvC9CazWgOP/VJlBPco39PiKRMXragfoIQ5GmbSqOVYtvwKMLrBskfTYHfoj3NqIs
 8UJbZSGkD8qnJ1ePW7SU9sN7QnbquWrBZeWlTpfspw2HJ+mJsLa/QDoQm5/PHrYQgIzP
 s4uxb4WjC0RSFQU1rGxJxRUGVQkrsFGQf7/s3wCfC9nj+EoWbQQNZ1w5f10stvMjv4nA
 G9lGA9e61gDxxBGYiYpnIkmiBD8oOt6hnNt6Weh/642qPdmi4usePbCsBjYaurCj8ry3
 pMqk5gWzIEmQc0RcrpbB2p6pyyuI6RNV4+LwF8T9S1ALzwwgzVhg+7fc1ELmzA7JkNI3
 U5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877223; x=1705482023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCQbSlI9RnIdZmdRFjrUmnCmAmNWg3RiTI9uMVnz4NQ=;
 b=Bsart5Kmn/9gel7DsGp8IrNwEtOxGJc7JrZgTXfTWw8wk6kIJcyFMFvVWwq74y/ibr
 YtIp2Hzo+5Qe+CapViieRO5sNJP4elFGtOg5Y/ofo7/1uq5MJaRcJp5urQA8U8cdbAZs
 f7VfzIuRI10RlRCISZGPPPl/bgmr0ywcIJnk/wA7nLd8cejj+YAnS+JlugOtwCOxQlw1
 zcXCQoQD7Ud7kCpEkSTNHu0cimVCSADNufWzLBQKE9Zs4xGtDvxUWZzUehR7asPeUBVa
 hNbYhgVVFGKYRR58jbsHRdf1oTgQtnmn+DVVmhA7Ic4EVfaTA+w5SqtKgta6GbDF18km
 yF3Q==
X-Gm-Message-State: AOJu0YwposNYJTHgOqoYu3Ytsn00n3fhB4+cipoHe0PIWLj2ZOj1L3w5
 z0dTcNs9vkaB6BUz40NqlN7mg7NK/3lotrzO
X-Google-Smtp-Source: AGHT+IHqcIJvrfuhBP9o5sXb5nhM2/e/Sf3mkLrBGLdMPZ6ApD2RaSMV/tn9WziBGNoavH3ZtbbiGQ==
X-Received: by 2002:a05:6358:3389:b0:175:723f:f68c with SMTP id
 i9-20020a056358338900b00175723ff68cmr748075rwd.54.1704877222227; 
 Wed, 10 Jan 2024 01:00:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/65] target/riscv/tcg: handle profile MISA bits
Date: Wed, 10 Jan 2024 18:57:09 +1000
Message-ID: <20240110085733.1607526-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x235.google.com
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

The profile support is handling multi-letter extensions only. Let's add
support for MISA bits as well.

We'll go through every known MISA bit. If the profile doesn't declare
the bit as mandatory, ignore it. Otherwise, set the bit in env->misa_ext
and env->misa_ext_mask.

Now that we're setting profile MISA bits, one can use the rv64i CPU to boot
Linux using the following options:

-cpu rv64i,rva22u64=true,rv39=true,s=true,zifencei=true

In the near future, when rva22s64 (where, 's', 'zifencei' and sv39 are
mandatory), is implemented, rv64i will be able to boot Linux loading
rva22s64 and no additional flags.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-14-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dd8f49b2a6..9fba3e8143 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -946,6 +946,27 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if  (!(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        if (bit == RVI && !profile->enabled) {
+            /*
+             * Disabling profiles will not disable the base
+             * ISA RV64I.
+             */
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
2.43.0


