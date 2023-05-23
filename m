Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C699770DBB4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1QS9-0003rv-9P; Tue, 23 May 2023 07:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1QRv-0003qZ-44
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:45:07 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1QRs-0001sN-Fl
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:45:06 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-38e3228d120so4237278b6e.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684842303; x=1687434303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4o3dohaZtkA0+W3204WlEGitdPVAzfsTfJ7xms/lWk=;
 b=VU0FQUP/Mcuxl7wACRxLWqyrzpmvLfd3eGv6G9E/vdm5t/p7PaR0Ca+X4Igw/X+qry
 R7YdEig+J6vVib0V+SPj25jbgt26NeE//j07hZdPvwW3yJ1j89pyikdC2UzSXg6mJeqb
 +n+j9A53chyanW5aM5+czcHm4ZqT0njymcQO857VkgcNwjzTZXC3W6H7pbeSWFNDcLdr
 LYMNtGtoZgsFWY7nEOC7fbHLSrRsHi+/sth9VbdC+CVOxnU3iyGMOEz0GiN2DQGGabVB
 zudQ6a8b7MTkIDOr6YOe3BR/JdJap6nxk0T9EyckyPtz/lWyu+A499xqIk2Q5iwVOq3S
 0ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684842303; x=1687434303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4o3dohaZtkA0+W3204WlEGitdPVAzfsTfJ7xms/lWk=;
 b=O8vRlT/o/BVWqcqCCgn8gPY/pCC1yjWGweorvtJPcZt9O7o7c9OFma906Cww6KOCEE
 /9Yo4ebawBkXCHhRppjsNCrewyRCQ7KWxC4FlGW+H05rGVFGx33TmORPFITlhIkwEv5U
 U4GiQQRde+ZNp9CZ50/7LVcgigKaCpp/39zy+sYjBsRv7MXiLMpbwOgXPpOpEwskV8Jo
 84ZxSF1QfI8l1ay4A7Cn2LGKRpXWWnrU7h25IUvBTSRvwuKOjsB2hmln94LsmlPnGV2l
 1vji086C5LqpNoofdwzMEnjAKFD8kEwSNYkKvjgXAx+5c3Yu+2ErXdnLsaHwTtH5It7/
 ghpA==
X-Gm-Message-State: AC+VfDzi0hPqQZ/6u7+DaUb7CMGx2xlrb2dI24SJ/YwkcAWIoUTIithf
 hQSIVh04K8UYbPSGuTcNA3Y9emKGvusVKu5gO+9mo+MWAZ7FOxEQ0QFmCvwxJJIeZ6d7fX6NDG4
 1XTLzJ9YphT3/RpFY3JGrX84c+soxQKznfeCVnSNi398fwp+o/jB8QIfD1f6Sbs3O0fGdHmI5Xd
 qT
X-Google-Smtp-Source: ACHHUZ5E2R42SZoMGp9iWdBJVJ1lEWdcLltsL0rvfaDB+miOobmApRWafghhOunog0bD3Bree4cApA==
X-Received: by 2002:a05:6808:1c3:b0:398:15e7:529f with SMTP id
 x3-20020a05680801c300b0039815e7529fmr2234079oic.46.1684842302674; 
 Tue, 23 May 2023 04:45:02 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 e3-20020acab503000000b003924c15cf58sm3799772oif.20.2023.05.23.04.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 04:45:02 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, alistair.francis@wdc.com, apatel@ventanamicro.com,
 palmer@rivosinc.com, dbarboza@ventanamicro.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH 2/2] hw/intc: riscv_imsic: Refresh the CSRs xml after updating
 the state of the cpu.
Date: Tue, 23 May 2023 04:44:54 -0700
Message-Id: <20230523114454.717708-3-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230523114454.717708-1-tommy.wu@sifive.com>
References: <20230523114454.717708-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=tommy.wu@sifive.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Originally, when we set the ext_smaia to true, we still cannot print the
AIA CSRs in the remote gdb debugger, because the dynamic CSR xml is
generated when the cpu is realized.

This patch refreshes the dynamic CSR xml after we update the ext_smaia,
so that we can print the AIA CSRs in the remote gdb debugger.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/intc/riscv_imsic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index fea3385b51..97a51d535b 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -350,6 +350,10 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         } else {
             rcpu->cfg.ext_smaia = true;
         }
+
+        /* Refresh the dynamic csr xml for the gdbstub. */
+        riscv_refresh_dynamic_csr_xml(cpu);
+
         riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
                                       riscv_imsic_rmw, imsic);
     }
-- 
2.38.1


