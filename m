Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63C72F214
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFI-0005XI-7z; Tue, 13 Jun 2023 21:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFF-0005S8-Cz
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:21 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFD-00050u-Hm
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:21 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-54fd6aa3b0dso37374a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705858; x=1689297858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0hO3OutD+wDj/+AHKx6cyQ6HNhdwZkx3uVs9WxZzxs=;
 b=WKlhxE9L8PiaP5vfZiNBycVgx8k5UWrd1/PPLp9SFQ47kAlDG4WqiPV+JZauB1AlU6
 QtejE6WaUNfYuJig4G/q46UPz98GMOxhDgYryN7u+tQW3k2vYHw0pTaJ+fmY/PylmXd2
 kY+6QH3PV34tSS34sIuwmhCU2VEbV/pXHFzP8EHIfq+j/wI8Q4k/HaRLYH0jC0SyfnPY
 0fNSEVoxaz0KKfBB7Ehf9bOmIRHjh49gCEPMxRWIPVl1xwW6CH/MklysaKOZjNEwcuaq
 jLtNUjpDhzm1NCTWWLvcSnDFnsj0eOFA7tkfkHCJnu1e8P4SS4zP+0/PYbDQfMMF4Bti
 43nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705858; x=1689297858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0hO3OutD+wDj/+AHKx6cyQ6HNhdwZkx3uVs9WxZzxs=;
 b=aobr+6kXgT2YcLPGvJoTr5CkdFbEM5Jfx8vgRouI/zUMiFylbZGUCkpfNvsnSDVLz8
 Gz6Hbk6jrWzWth4YF0Qr76CRDNp3ORWrKJQfUhv85rpClYe1luYvAlZ5XdCwg6qy7cSd
 RX3VorjkXKLrFiGJI+y/oSVUwXjUzPcCnAJ96wtTgv2eI5kInEcQ8qCxoE00NES7PZeZ
 Y0ikoWaGP5NVwycz4cjGlu/FLfOSvYFfjsuDMr4XmEz8ZzZkf1SDS7n1JwKdF9L2bwmm
 +EnW7KNEmdu1RzaLIrqkoSLVhkHdPoeUxWFxpDj1p8gplV5KKG/D3RxsOEjcoeGLQEH0
 CzOw==
X-Gm-Message-State: AC+VfDyXUOs6nRV80m7W+hv6+uLu3hzA0xgaTqrL+ycEcmWJka+amEzG
 NjUqHBhnhiaFvQ7XPfQTsMRbXzex/MIiFQ==
X-Google-Smtp-Source: ACHHUZ6xmtd3U1n+8AZcqakhbKhOyQXie8HseRYhfrf6JDMrnw3Q82ZhgrSjH6rqHoTtcK6te4h6og==
X-Received: by 2002:a05:6a21:3984:b0:117:d4d:15fb with SMTP id
 ad4-20020a056a21398400b001170d4d15fbmr284800pzc.10.1686705857963; 
 Tue, 13 Jun 2023 18:24:17 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 56/60] target/riscv: Fix initialized value for cur_pmmask
Date: Wed, 14 Jun 2023 11:20:13 +1000
Message-Id: <20230614012017.3100663-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

We initialize cur_pmmask as -1(UINT32_MAX/UINT64_MAX) and regard it
as if pointer mask is disabled in current implementation. However,
the addresses for vector load/store will be adjusted to zero in this
case and -1(UINT32_MAX/UINT64_MAX) is valid value for pmmask when
pointer mask is enabled.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230610094651.43786-1-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 523311b184..90cef9856d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -134,7 +134,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
-    if (env->cur_pmmask < (env->xl == MXL_RV32 ? UINT32_MAX : UINT64_MAX)) {
+    if (env->cur_pmmask != 0) {
         flags = FIELD_DP32(flags, TB_FLAGS, PM_MASK_ENABLED, 1);
     }
     if (env->cur_pmbase != 0) {
@@ -146,7 +146,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 
 void riscv_cpu_update_mask(CPURISCVState *env)
 {
-    target_ulong mask = -1, base = 0;
+    target_ulong mask = 0, base = 0;
     /*
      * TODO: Current RVJ spec does not specify
      * how the extension interacts with XLEN.
-- 
2.40.1


