Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDCF72F1AC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDe-0001JW-J6; Tue, 13 Jun 2023 21:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDc-0001Cf-Dm
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDa-0004nf-LM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-65055aa4ed7so4949823b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705757; x=1689297757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcBQtjZOfEudMVxhU0D6rO6KALLJb3P53aFFq8QEYoY=;
 b=cc7ikvEhos3/RJVX3mwL1v1qy2pMPnVg8z30+Q/sN85vU/NRUbqXFD35Yr1+rljAyS
 BnZYfulGNjErwsmmf69AnY8ucbwc+DEIvOzAKbt36EyhROL5arOWF9hoNbFn4EePt9Iw
 bIYI7oI7KkDHXFfMASAIpQ1iWXlNTjqbMjh94iOnDSzEH2Yybx2Hj5T11Gi6OHzJM2AG
 eBtR+q3GFwDu6cQnMh9pBgrfBjhhRsUPO3xcz5yAwJGehhBtptFGHsMOtWygaCirjNIj
 TiRj7Qhr9ajwSmYr5NshF1dMRPv6PjFQ0VvXgjeivyfw94EU+5MdfIQABxwiAXa+Ksqz
 ed5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705757; x=1689297757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcBQtjZOfEudMVxhU0D6rO6KALLJb3P53aFFq8QEYoY=;
 b=fHTbZK9XbGu9y7Lrlje0nTRc52OPn+PagH3Iy/5F6RWorDhAp0XLWH9d6WuLe7ZpBn
 +eCIxFc/yU03YxpJKzcKTN14azDLdnr853BE+kW74YLO+ViYllx68CzL+0BE8YygpyXl
 mjJn2gkMsCRhPp7A1As3D1wx3v0xKfvQoIQmD3ZpMqWd9AXWIUj3RF1wia1XFN1+T2NM
 h1y63nvnF0IuTR67hpxAPVNSI6HF16i4unQJEg0WrIR4y9b69u1pf8Yxa+PD/dFNTqsH
 nimgbp5lqjOa0rFFlysZyhITSnbu0sOwiTQZp14UepICR7i7f1Yet9RAt1rctPEx/TME
 KEKw==
X-Gm-Message-State: AC+VfDyh9Pexhrr/n5wUnihDYArDk2kw4vE8udWjFPo64/FSJ+W8d6Jb
 J9S79sOq0weE5DfqLNEvOcKuipGJCobBLQ==
X-Google-Smtp-Source: ACHHUZ61lxWKLhkeF/4h2GXjlrc0kPdF9YAwtVWuQXacYWjfZsy3OtGIxId5MhT7JcZBw5Lw01xnfg==
X-Received: by 2002:a05:6a00:168e:b0:64f:4d1d:32ba with SMTP id
 k14-20020a056a00168e00b0064f4d1d32bamr867174pfc.5.1686705757017; 
 Tue, 13 Jun 2023 18:22:37 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yin Wang <yin.wang@intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PULL 31/60] hw/riscv: qemu crash when NUMA nodes exceed available
 CPUs
Date: Wed, 14 Jun 2023 11:19:48 +1000
Message-Id: <20230614012017.3100663-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Yin Wang <yin.wang@intel.com>

Command "qemu-system-riscv64 -machine virt
-m 2G -smp 1 -numa node,mem=1G -numa node,mem=1G"
would trigger this problem.Backtrace with:
 #0  0x0000555555b5b1a4 in riscv_numa_get_default_cpu_node_id  at ../hw/riscv/numa.c:211
 #1  0x00005555558ce510 in machine_numa_finish_cpu_init  at ../hw/core/machine.c:1230
 #2  0x00005555558ce9d3 in machine_run_board_init  at ../hw/core/machine.c:1346
 #3  0x0000555555aaedc3 in qemu_init_board  at ../softmmu/vl.c:2513
 #4  0x0000555555aaf064 in qmp_x_exit_preconfig  at ../softmmu/vl.c:2609
 #5  0x0000555555ab1916 in qemu_init  at ../softmmu/vl.c:3617
 #6  0x000055555585463b in main  at ../softmmu/main.c:47
This commit fixes the issue by adding parameter checks.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Yin Wang <yin.wang@intel.com>
Message-Id: <20230519023758.1759434-1-yin.wang@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/numa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 4720102561..e0414d5b1b 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -207,6 +207,12 @@ int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
     int64_t nidx = 0;
 
+    if (ms->numa_state->num_nodes > ms->smp.cpus) {
+        error_report("Number of NUMA nodes (%d)"
+                     " cannot exceed the number of available CPUs (%d).",
+                     ms->numa_state->num_nodes, ms->smp.max_cpus);
+        exit(EXIT_FAILURE);
+    }
     if (ms->numa_state->num_nodes) {
         nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
         if (ms->numa_state->num_nodes <= nidx) {
-- 
2.40.1


