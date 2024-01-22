Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676148375FC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 23:17:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2aU-0004qx-SA; Mon, 22 Jan 2024 17:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2a0-0004nD-Ki
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:44 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2Zz-0005uo-63
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:44 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d7354ba334so17575515ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 14:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705961741; x=1706566541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzHL8aJDpNvMBJ2WBWw1qBXQpPaYiy2l39AZTY8wyvQ=;
 b=iuKOMvdXhVRrMPHY1vS1xuCSkKWfzDw98+EhppFz+AKMyNcnodpVhefWAMXzKhn+RZ
 LlZu3CtLvrNe31qdC11aBlM4EEdF5GPZKg5WfVFgUFQ1j2RChEIv0RE4Qx01RTLTZFr4
 BaqyNGM9iMZEZsKs1IMN9r+PjlcRbDyiTmtPeGVspr6TmSL5+sXp89EinOsxeAlX+xnm
 w6tO7buYiFneFgaR4CmVkxkzW7OXk1gkMez7Zs5gqcx8Llmcmrhf70bny0aQFmBIekca
 R986YN2BjMfaLBcKoFGEuQsAqXS+ilk+A8LrYdhGB6BkC6S924lTonqXLoHt/1iH7BM2
 YBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705961741; x=1706566541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzHL8aJDpNvMBJ2WBWw1qBXQpPaYiy2l39AZTY8wyvQ=;
 b=SI04tuuJHQjnT/eyh0a4Fq15RmEeW2b2wYibHTr6SgrV/7R3nWc2YsDBPc+d3uercO
 Xz1VDNEL8zGMZBvQ+PaaEsu9qyVgMNQHvHy/3OO/ehSLPCk2uCPeTwyJObawwUPm42u2
 qrVyqesb1qxIbMDcz5BJSuAs+B9/XkYM9s0kSyWHMEVbItAygMa2a/yRiemc89SBSqqg
 sgvdWUQBK9IsKz5nBLBz+KBk9QGaxQsKXX5H0oymVpBNvYtzK1e4iLldtOxzAT9MJCMZ
 G002QBKCV57cYlzOvGSGkcFuxJgnw5rHHH4eF2Pj2pBSATfrvoT57rFen45wq5t8eJZ7
 CA7w==
X-Gm-Message-State: AOJu0YzF0oWLNgy6EQbA5dwoChP/d7oTqSPqVqx+lQh8XQArX3+E1ccx
 6KXNMrHnxylFgNdEZopIwXrkx8HoolJHHcvNcrjcGyUg/RtWSpA4OA7Bers9Req5nZv3Ys9mL6R
 B
X-Google-Smtp-Source: AGHT+IGzsf37BmxGv7KeuB1LO0dV+L3lL+X9Y8JQx+fmpMyYbXTJosc/Eamursw+m9Hv82BYymEMdg==
X-Received: by 2002:a17:902:650e:b0:1d5:efcb:3cd1 with SMTP id
 b14-20020a170902650e00b001d5efcb3cd1mr4636841plk.81.1705961741183; 
 Mon, 22 Jan 2024 14:15:41 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d7338977e6sm4029104plb.223.2024.01.22.14.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:15:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/7] hw/riscv/numa.c: use g_autofree in
 socket_fdt_write_distance_matrix()
Date: Mon, 22 Jan 2024 19:15:24 -0300
Message-ID: <20240122221529.86562-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122221529.86562-1-dbarboza@ventanamicro.com>
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

Use g_autofree in 'dist_matrix' to avoid the manual g_free().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index d319aefb45..cf686f4ff1 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -167,7 +167,8 @@ void riscv_socket_fdt_write_id(const MachineState *ms, const char *node_name,
 void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
 {
     int i, j, idx;
-    uint32_t *dist_matrix, dist_matrix_size;
+    g_autofree uint32_t *dist_matrix = NULL;
+    uint32_t dist_matrix_size;
 
     if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
         dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
@@ -189,7 +190,6 @@ void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
                                 "numa-distance-map-v1");
         qemu_fdt_setprop(ms->fdt, "/distance-map", "distance-matrix",
                          dist_matrix, dist_matrix_size);
-        g_free(dist_matrix);
     }
 }
 
-- 
2.43.0


