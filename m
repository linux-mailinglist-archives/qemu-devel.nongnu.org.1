Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E282E297
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:28:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVOr-0000WW-Vs; Mon, 15 Jan 2024 17:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOq-0000WE-5j
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:44 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOo-00062L-Mc
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:43 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6dc20b4595bso6315116a34.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357541; x=1705962341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUTQ4hAGbR/U7aTocUntatBO3/zQ0lq0rhjwH747sgA=;
 b=f6AahW0wUQhPT2VHMmsglHYA2w1bOVqn7Nh3iPnqYdU+tZBMHZLGjazGeygkeOLI7t
 KPr7mgDA7aHVPy/aF7hpC5y2YiI0VTycn4zLaAuwpq4DV+a927Ux3JvxBSJY1av36j9z
 aL/PI8KB0QrSAEbjVV7TRA95B7p/J7fe0aE2Il90tdHAgymE9J0OMMW/Fhc/0Tazr+3E
 4gB7hC3HjFjPc1RaG0zYnmILgFqN6U5/tS730SaDL+Eq5AJQQTy4S2el9yxYnfR5F+nr
 BBH8Z+YY2bvk/4DQlP9q/QWs1TqNmEidIIZgnOfL9Pwv+5z3DqYJNbWqWAqIqUUZO3+P
 U/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357541; x=1705962341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUTQ4hAGbR/U7aTocUntatBO3/zQ0lq0rhjwH747sgA=;
 b=KV4TtP+hQosyciWUjNlBxc+nnEjuZcmG7vJsTK2M1MALnPiXQKX/ANDW+SuWp1vopc
 BMwXQNBsD6FC55zq2+UX/NJqfvHxNstlSvgQleaPVN0ecMvC3OOP8OMk2i0rMh17hW3N
 Yle8nCdom5NZWL5IWsX9LxLzaEMWuRrQ2u+luNNeoHqx83ItLlv3Di905J6XzUJeDqJ5
 607FCM3xDCTtlpNFiSTtuHsO6hD/ZSZu1l/btOnCm/Tv0L5Yy8uLmRVOv1nGUqgXyEiE
 upaHu4OIcyM6GVJJnop1Y5vllUk8rrUQ/9PXoXvV4DznhdlgFAfsBqNDWZ4VE/Fj+zd6
 MgPQ==
X-Gm-Message-State: AOJu0Yzk6DoTnoKUbB/e57eMe+W0k2X887pQUzo66RpVxufso3uWgFia
 EVsrrf/H0Llowopa2J5IcXMdj2eQE2MSQ6piZJwwzjxWNRw1/g==
X-Google-Smtp-Source: AGHT+IHLSkXeGGHPTJ9mZYJAQrNvnSYEU1g5MnmGpN1tzp7afZew/vTaWaW8onLyTXZDB/TMpQoP6w==
X-Received: by 2002:a9d:7350:0:b0:6dc:379:b3f with SMTP id
 l16-20020a9d7350000000b006dc03790b3fmr7418994otk.46.1705357541202; 
 Mon, 15 Jan 2024 14:25:41 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:25:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 02/12] target/riscv/csr.c: use 'vlenb' instead of 'vlen'
Date: Mon, 15 Jan 2024 19:25:18 -0300
Message-ID: <20240115222528.257342-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x329.google.com
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

As a bonus, we're being more idiomatic using cpu->cfg.vlenb when
reading CSR_VLENB.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 674ea075a4..5c8d22452b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -683,7 +683,7 @@ static RISCVException read_vl(CPURISCVState *env, int csrno,
 
 static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = riscv_cpu_cfg(env)->vlen >> 3;
+    *val = riscv_cpu_cfg(env)->vlenb;
     return RISCV_EXCP_NONE;
 }
 
@@ -738,7 +738,7 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
      * The vstart CSR is defined to have only enough writable bits
      * to hold the largest element index, i.e. lg2(VLEN) bits.
      */
-    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlen));
+    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3));
     return RISCV_EXCP_NONE;
 }
 
-- 
2.43.0


