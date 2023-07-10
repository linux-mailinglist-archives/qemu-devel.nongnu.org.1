Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42074D589
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4d-0000To-QN; Mon, 10 Jul 2023 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4X-0000Dz-PX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4W-0003Gn-6I
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso2290092b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992374; x=1691584374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OS41ZtAr2+kmDkN+k6c4+K4LKBLzJWMZWSnhTcTuu8c=;
 b=Q8jYNnKQT+noAtIo7IGPOblAywf2KOyVlw8hMocSoDAoDPdeESsF/F3hJ+yJFsGRn/
 gn2nhfsLZv7mLPn66M9HHaeDmXTmS5S3OpFpKY+Hw+v9jVhVA2hOcy98Xq4RFAtPZWmu
 T9MD7yOFi2G+jVIOqhUZuMHIAzdcXrwZSYXQ7FJgMiZVelHYZDmhA2nYqeOFwVmD2tgo
 kanarg/akUO77/HotWArh86gdOoYCgz4GUYdCHjLWxKlv6q/tVz6k0ikdyD4jg55AAsH
 AWLjvkhbTEXpSvzF+QQ+H2E/UtwZXcsXwpApC3tknSS73vKkZWBkhAFR079F+bR8E0vw
 jqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992374; x=1691584374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OS41ZtAr2+kmDkN+k6c4+K4LKBLzJWMZWSnhTcTuu8c=;
 b=SxTgWyBTR2MWbJY3/iI0eplndnqTiCZOfOjvtprbKjTwl6VAJd/V16ysCqGDAnPbx5
 TukJS/9zD63RYdhcWzKyEJ5gKyTjxBTD9gIxvv6fjKczznzTsKbMM5HyuTXSuJx1uvSi
 DIq6eVNYveA4YCV+vM3n/rvlzCV9muzXVjnXR/8UINeZnJmAV1IcpE3/Yowv95r0aVNE
 r4QgvfxfS6Ok56HvnX3HzmW6hJM6QNWymMAjAozNGWv3wvvMvIPL2ibj0ctkXwe7NfrH
 ma7F8e4tTRYAlUHAONjMnN3Og2ScyKc2Pl/AwLe4aB1ErqiimN+87AsNJm2OFBFg+qbH
 MEtg==
X-Gm-Message-State: ABy/qLYWSDnRAocWeE+pu/O5pqlhf7Rkes2Syb09XO1zqajI+L48TjMg
 iNo+mdsTKfwq11J+QU3HuHxqUJZMeBHpNg==
X-Google-Smtp-Source: APBJJlEQeTqfQb0fM45wR+uqfIfmKpgippYBrs7f2EmFmYiW1GfHOUiRKwLJcgxIBmq+ANb5KSVZ/Q==
X-Received: by 2002:a05:6a00:1910:b0:673:5d1e:6657 with SMTP id
 y16-20020a056a00191000b006735d1e6657mr11949822pfi.7.1688992373916; 
 Mon, 10 Jul 2023 05:32:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/54] target/riscv: Support MSTATUS.MPV/GVA only when RVH is
 enabled
Date: Mon, 10 Jul 2023 22:31:21 +1000
Message-Id: <20230710123205.2441106-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

MPV and GVA bits are added by hypervisor extension to mstatus
and mstatush (if MXLEN=32).

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230603134236.15719-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58499b5afc..6ac11d1f11 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1311,11 +1311,9 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
-        /*
-         * RV32: MPV and GVA are not in mstatus. The current plan is to
-         * add them to mstatush. For now, we just don't support it.
-         */
-        mask |= MSTATUS_MPV | MSTATUS_GVA;
+        if (riscv_has_ext(env, RVH)) {
+            mask |= MSTATUS_MPV | MSTATUS_GVA;
+        }
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
         }
@@ -1351,7 +1349,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = MSTATUS_MPV | MSTATUS_GVA;
+    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
-- 
2.40.1


