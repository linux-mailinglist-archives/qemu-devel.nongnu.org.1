Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E86927E3317
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs3-0003d6-96; Mon, 06 Nov 2023 21:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs1-0003TP-4a
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:13 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bry-0002qc-Al
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:12 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5bd0631f630so3808837a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324268; x=1699929068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOnk9201xiCayooS+4YKfa6TnjfgucXfscxWsmCsESA=;
 b=WPK+o4eH8Os9Ygg8vrIjuQJ/8sEUYaXYi+WyUbRflcrFpDBLs75pzQn55bweRu3bY2
 bkq0MdTpMINrtVm4+VUQo5tCPsRIaYay9/91TW0095ocnEmTrYz/NXiJstIFUK4eqJKp
 jBh3wVQLZzSPd+EOhZKVKqzPIZvJUQhE8d/FfvfrXP4rzELWJsA67vFo7QIPYRL02BQu
 hb2D77qHR87kbP8019VRos1L/wq6TpVDeHttRrnDpLMn76VJ9QT7HyHWAv404UYf+rfU
 VhbWZ5Rk2KYDHnUy8rcFOQTgoLsmBn6Puk8XFj/OX8SvNmAjVm7xcaWyZxdhuA9BEKSH
 Knvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324268; x=1699929068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOnk9201xiCayooS+4YKfa6TnjfgucXfscxWsmCsESA=;
 b=jxgUhVqDtyOg4uXtk7+QE8NoFyBC+uFPb/uvebft64F5+FXOV/4lNdLe4ukTF7mb0K
 KPSH9nU+c7EQehnzEshznC4H57nf3IEOZa1y1qw/Lm8zPzkRIoGKuSVeweSGRIhF9n0V
 uIBjxnSuzK8uA5XE131pd36at/TJY1iw+B1tQp766LueGYmupHfNic1YIuSMY1oLtB1p
 omg1dzNwV/qAD4n1JSqbK1wRPNmtbHojpbM/O7YVAjiNU9kX9MQS7MyWhZQHwQlfwbE+
 okvC65UrO2exWnp9uUB724UP1MSFFt95ChBjGutzFEVLO+v5pF6BMXgjksemaJSxdGsZ
 FRZA==
X-Gm-Message-State: AOJu0YwY9iZuhgoD11EDmq7Do7GgmnwAgnK0pxR/kPkX8tWtoRyMmEGe
 aUtqub5rEt+oL7nt0VfkgSQeUmaBOTUAww==
X-Google-Smtp-Source: AGHT+IGelTIswmNI13z+mllvSu6rhAi89zGdilpxKt/GeUJN9RKYA+hb+1JiVNp4icF3OFd2dDi+jQ==
X-Received: by 2002:a17:90b:4a48:b0:281:cb6:a0fe with SMTP id
 lb8-20020a17090b4a4800b002810cb6a0femr1951562pjb.13.1699324268635; 
 Mon, 06 Nov 2023 18:31:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/49] target/riscv: pmp: Ignore writes when RW=01
Date: Tue,  7 Nov 2023 12:29:17 +1000
Message-ID: <20231107022946.1055027-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Mayuresh Chitale <mchitale@ventanamicro.com>

As per the Priv spec: "The R, W, and X fields form a collective WARL
field for which the combinations with R=0 and W=1 are reserved."
However currently such writes are not ignored as ought to be. The
combinations with RW=01 are allowed only when the Smepmp extension
is enabled and mseccfg.MML is set.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231019065705.1431868-1-mchitale@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 4dfaa28fce..162e88a90a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -123,6 +123,11 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
         if (locked) {
             qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
         } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
+            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
+            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
+                !MSECCFG_MML_ISSET(env)) {
+                val &= ~(PMP_WRITE | PMP_READ);
+            }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
-- 
2.41.0


