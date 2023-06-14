Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1EE72F202
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCO-0004jK-MQ; Tue, 13 Jun 2023 21:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCN-0004ix-Cx
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:23 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCL-0004WJ-Su
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:23 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-75d54faa03eso153769585a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705680; x=1689297680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3NDatt4G6nrXGp9ohuD4jZvCNHQXNpbq6lmcld0Bwg=;
 b=WBi/iPBY2gUrCztST3PLvNe3rfAvk/qcKUc0W8mstm/SM5yyCem7SGvMGXB2TVUd3l
 TC1llTz6buBbu6kKegDjGk/4JNSwdJOnAxS4i08GEgnUFD6DVwWR8v1Kyktb9s2Zgl6M
 lTQRTMP19dm7PRxttRbQwNEq70XuDR00NHirgsFRIbolddCVmRy9RoZngTFv2FrlBfN4
 twNf86vfLp1hiN0GaWdc02Yx8mijoEWZ6CqC+84HzbbXCDhokOJNkNgnfmP9d9f5L791
 enRzbUpahw76ngACU2sNn5XXo5Oxy4ID+FpruzG92lkM6/tn2Mb3Rj49KQ3yAm6B+Mfi
 xwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705680; x=1689297680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3NDatt4G6nrXGp9ohuD4jZvCNHQXNpbq6lmcld0Bwg=;
 b=YilsZj5x6bGmf9rtH+XzQt6ifZck1otesgXdy8sSQy5TcNi9Pd7ZXJzsATRS9FzgUJ
 JzwMbZngQAd9UAjl43k7VhsqfSsrs2wl02SfoXZsELXbZVzAsrGKjQ36aQSLIsKD0wHr
 EFIFg87NGtvu98D5VfMJL1j5cU1pqQ8IehYsJB8ZeqRrNVf08do9BCGvE0JS+PXZMCmA
 f8w/cXq+OVQ3tpVv6+Dxf4MjR8WipbvnrXpK7wbPOl/a7s5DnMcjVJGitCdxKjCmSZtj
 gNxkj09AbLzZ/LSm1S/dury/e/fOhjSBLc3ExPXndTjvfMOWCaHAx9uQimFzf1NNEUXc
 wXCw==
X-Gm-Message-State: AC+VfDxbbu3S3/RqgvWiI5pQX4zV+PMB2SA4hzldPg6dhyx/qOeYxNNH
 +ZeLxtCzKATjVZAY3OZQqGPgeijiPlauIA==
X-Google-Smtp-Source: ACHHUZ6Y8/CSWRF2MqlTZmPEWDFsg7E5fm/6RPFdnXH383XHjNaB3jWijpnkKYlfAGNSlNzIhihXhQ==
X-Received: by 2002:a05:620a:2218:b0:75d:557e:320e with SMTP id
 m24-20020a05620a221800b0075d557e320emr12711066qkh.33.1686705680644; 
 Tue, 13 Jun 2023 18:21:20 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/60] target/riscv/cpu.c: validate extensions before
 riscv_timer_init()
Date: Wed, 14 Jun 2023 11:19:28 +1000
Message-Id: <20230614012017.3100663-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x734.google.com
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

There is no need to init timers if we're not even sure that our
extensions are valid. Execute riscv_cpu_validate_set_extensions() before
riscv_timer_init().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517135714.211809-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 89a1a25812..9f2c8fa7c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1294,13 +1294,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-
-#ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.ext_sstc) {
-        riscv_timer_init(cpu);
-    }
-#endif /* CONFIG_USER_ONLY */
-
     riscv_cpu_validate_set_extensions(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -1308,6 +1301,10 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_sstc) {
+        riscv_timer_init(cpu);
+    }
+
     if (cpu->cfg.pmu_num) {
         if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
             cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-- 
2.40.1


