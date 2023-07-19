Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4067758CC4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLz58-0001sm-By; Wed, 19 Jul 2023 00:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4h-0001oz-3y
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:46:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4e-0005Ll-0g
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:46:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b8ad9eede0so52126095ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689741962; x=1692333962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkXpiV0ODkR9G7SXm+E1E/jpmRUvrtArcp+hdZJWblE=;
 b=bx0G+OPtnTkkP5Z6F6Nvjwlv2S2k5xyubbMtv98wh0HZGEBf5Hu7zfM9Qcl/UP47cA
 teGnILDWV21nhfo+fun+Hocw+E3Ysad+9d4Fye4EkTYN2u+CpAPMmX9fHvBZh7W0Vd5U
 WbVTdL0BrpTn6b0+H01IpDAjuElHWDrbSTX042FVFyYsQy4UjK3euvXbKcD3hCnN1/R0
 YobcKROqO/6tiJ/kK2K/xhvXnnaqdg6SitNgiyK5jjpj5MYlGnuB4HadM3OWPc1MdatT
 MTcDduqFk0FFk9om8Fm5npP72JVBzJSoVby/a48fBFia9hbMpz+kojcfLUZfklGLZqKh
 OuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689741962; x=1692333962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkXpiV0ODkR9G7SXm+E1E/jpmRUvrtArcp+hdZJWblE=;
 b=VtFljxJNX/L/xCKwCHr+VbFMzsH4rM5UbIKnZOauSHK9gN0+PrQLPSzQ1RK69EhnA2
 GapCcFaWMdaitN298B9kLqMSW51js/+bzuheGwst7tdPoFTFRLDHE1bwU9bvMX4T/67T
 tA7hvEoQDVtrLX3J6nD+nObi8TNCTAH73hnHxrBTpO8ukPJYa/MJh8Wa3xzY6cwqTnm+
 a9lKFmtJlm1MD7SZ+G3lcgj+rqA3sAdAYXbztuEVNhqhkYaYLv7eVvtp2eEj4p9oYsRG
 fqdIx/M/Bt8RhKuMfIw2LhAW3VEu71zUVFDhG89LefQtpk2iEmaV1C7WKuQylc/58ehU
 4Z1w==
X-Gm-Message-State: ABy/qLaEBT/z3wzgVWMihrlqhpu+0dLgWZXM57CepY64gW+DdSQLtLXl
 Q0vBkqEgXrmUgs5U8cog8G5iS1thAUj8meJ3
X-Google-Smtp-Source: APBJJlGHZp938sjw7dnm3OnPxh7LEW1KQnOjPvcVj9IRs+666JY8cKLYcXwxenzUtR/0cvxPU4YILg==
X-Received: by 2002:a17:902:be15:b0:1b8:4ee8:8f24 with SMTP id
 r21-20020a170902be1500b001b84ee88f24mr1605657pls.20.1689741961724; 
 Tue, 18 Jul 2023 21:46:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b890009634sm2731080plh.139.2023.07.18.21.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 21:46:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zhao Liu <zhao1.liu@intel.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 4/5] hw/riscv: Fix typo field in error_report
Date: Wed, 19 Jul 2023 14:45:37 +1000
Message-Id: <20230719044538.2013401-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719044538.2013401-1-alistair.francis@wdc.com>
References: <20230719044538.2013401-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

"smp.cpus" means the number of online CPUs and "smp.max_cpus" means the
total number of CPUs.

riscv_numa_get_default_cpu_node_id() checks "smp.cpus" and the
"available CPUs" description in the next error message also indicates
online CPUs.

So report "smp.cpus" in error_report() instand of "smp.max_cpus".

Since "smp.cpus" is "unsigned int", use "%u".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230718080712.503333-1-zhao1.liu@linux.intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index e0414d5b1b..d319aefb45 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -209,8 +209,8 @@ int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx)
 
     if (ms->numa_state->num_nodes > ms->smp.cpus) {
         error_report("Number of NUMA nodes (%d)"
-                     " cannot exceed the number of available CPUs (%d).",
-                     ms->numa_state->num_nodes, ms->smp.max_cpus);
+                     " cannot exceed the number of available CPUs (%u).",
+                     ms->numa_state->num_nodes, ms->smp.cpus);
         exit(EXIT_FAILURE);
     }
     if (ms->numa_state->num_nodes) {
-- 
2.40.1


