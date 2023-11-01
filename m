Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5B27DE6CE
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI3E-0002rL-3g; Wed, 01 Nov 2023 16:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI3C-0002qs-58
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:54 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI3A-0000mq-Lc
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:53 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d9ad67058fcso200700276.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871370; x=1699476170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLO3dp+mWG+xJnWmyXtKFLploomzW4poqdousI7nZAE=;
 b=eV6XqYChAKDpehai4FzslHcj4dEZGZY4OUDgN4L2CWpS8xL3dKfLNoOrJstM9f/wp9
 J5Qn69KIYF3SPC6m9HUABcjfc370lHdv9RwqOeZe+6piC95zjmNCJ4rd21+pbDDhB+t5
 fRh9tnNqU0rrhGllvqy9C1+DitBm5e1TPzrgiNRbmwo7rHJA6fhcK5e/aHttAUkNo1sg
 y734ienMLOhrV0IttBfvY0FS8GvWtE2ISOzwOjHhZ0v3iLpmc8tiZrAcf2X6w+c7YoY0
 2AjRKQ/W3+D09UFFRVFyV++TBZjoEzYzI/HrP7oVsAEJRGOOj6yV7qZbVJAB93V7km9B
 6OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871370; x=1699476170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLO3dp+mWG+xJnWmyXtKFLploomzW4poqdousI7nZAE=;
 b=LR9FaIZDn7OxtKpYaN6+TrRqDWSBtaa79NqlVIXhY2Y+VXNm3EX93afUN90FeeJxA5
 w1g5982nYRzG+20HW3QP2uqlDpgPzER/jg6e0wo5NxATdaZwtelOjvNQf20mB+Rgf05V
 KNC0Km9mUEnAhRGI6GI5VyuTkqk4wXp3A5F2s9ztKAw6EtsCHNhTa45jaJLss7qfmgCe
 R5mYaSRQi48vD3+m6iUD9HoTxa0qsaRvhZLc758jFeBpTJyUyKwwMXg/FfVRcxJGisym
 kNIxTi5+NFCBFJE9n0dspr5nGMn7WVAZw4pZV/vnZjlGSX0dWoJPRFFcpKqkhM2AcxHs
 XexQ==
X-Gm-Message-State: AOJu0YzUTEDQhSYqYL2v043WbCXMsraAuNfIV/Ntk6CN/NldFSzwSgPW
 /DyeZlFCpViuWBrpGK6BQDTfw9VRuVWK25gCUG4=
X-Google-Smtp-Source: AGHT+IHdHaWs1RxI5DnJ2sdlPwxejSCNHiujB4TZFYpWZDKpjP/Dc65sxZjUcP4RLbGqEmV28Oz6Vw==
X-Received: by 2002:a25:ec03:0:b0:d86:5844:a897 with SMTP id
 j3-20020a25ec03000000b00d865844a897mr15878999ybh.5.1698871370537; 
 Wed, 01 Nov 2023 13:42:50 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:50 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 15/19] target/riscv/tcg: handle profile MISA bits
Date: Wed,  1 Nov 2023 17:42:00 -0300
Message-ID: <20231101204204.345470-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb2f.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 707da775a0..4b3e20545a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -862,6 +862,27 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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
2.41.0


