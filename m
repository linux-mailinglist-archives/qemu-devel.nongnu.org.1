Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75027ADAE3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkn3R-0000Pe-7O; Mon, 25 Sep 2023 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn35-0008Ks-8X
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:59:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn2r-0002F0-V7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:58:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4053cb57f02so53748485e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653924; x=1696258724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA5XRXF9P4Vc7lxXG3kZOc85Dy3uKGzfeERYzP/OVsE=;
 b=I+G70JjcmXENIil5PRNrRGwmqRNcqksI8R06GqOngS5TSDOv5iS6VAr1lFwITYB5a1
 uT04bOQYPJjP70uW17+b8IJsT/s1vCAH2dG8SXzvoriWInXShBqVV+7bbRnC/M7CryJV
 53kPkchIQ+FfFKJr4VT/hT4jublNi7XxvokFmEwoeO12KKRSg6VkOpnB7RiPy1vUxQEC
 2qFyacPBnpVVkBg18gyars1xwtxYhe+i7DLtHppK/HBK87TiiAxqY5nWsVwbEVc9u+1P
 PrL1QpHhFkECC7vEocAD7t3WrBm+lN6KcbiO/+QVpRhCNWA7IedXRMXQ19gDhuyBoS7I
 CScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653924; x=1696258724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iA5XRXF9P4Vc7lxXG3kZOc85Dy3uKGzfeERYzP/OVsE=;
 b=P2izQaal7RcVful//9F58O61mXUm/NIiIUvYcpAFOTE/KDaYYiSDU0RzmA3gobi2jH
 QSqxusnByaWByV3Win6dX01gHrEoDyhWteenlXZPv0TT9jiQciBFt4OjFnVc9rF48uwi
 Snx5VDkWx4/WfWZKIw5xrMo5NQuvwqgp22BaAAB2zmvDiyGNK/IVhjKaQwSZmBnnF5Fl
 HSrdYQLtMCgTl4sfb0MhLv+6ujc0PnnSQPx4gCz0pLg03eET1AqfchtE766r+LZT5x7N
 nFGdjgZvav3a70FokS+7GS6Qbtqfi/OmQ0i64/n1rW6n6YIueRUZ1GBVLIEBJmiXttu9
 En8g==
X-Gm-Message-State: AOJu0YziO/bMXRGP1EYx8NSwE2psIjck2fLkk8Brf5Dk+9c0zGbf5TNo
 Oc5gr7opDSQ6/3/essb8FpBGXg==
X-Google-Smtp-Source: AGHT+IH3kX1Oj1brSObUdZXhVcwKkHsBnlT5ud9YZVQ4HToc2ifB5Aq5Z+XMQhAyrNqM10SDBgeeJA==
X-Received: by 2002:a05:600c:2057:b0:401:bcd9:4871 with SMTP id
 p23-20020a05600c205700b00401bcd94871mr5623754wmg.21.1695653924058; 
 Mon, 25 Sep 2023 07:58:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o13-20020adfeacd000000b00317f3fd21b7sm12170189wrn.80.2023.09.25.07.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:58:42 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B38181FFCD;
 Mon, 25 Sep 2023 15:48:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 22/31] target/sh4: Disable decode_gusa when plugins enabled
Date: Mon, 25 Sep 2023 15:48:45 +0100
Message-Id: <20230925144854.1872513-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230824181233.1568795-3-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/translate.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index c1e590feb3..b4dee34c9a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1816,6 +1816,18 @@ static void decode_opc(DisasContext * ctx)
 }
 
 #ifdef CONFIG_USER_ONLY
+/*
+ * Restart with the EXCLUSIVE bit set, within a TB run via
+ * cpu_exec_step_atomic holding the exclusive lock.
+ */
+static void gen_restart_exclusive(DisasContext *ctx)
+{
+    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
+    gen_save_cpu_state(ctx, false);
+    gen_helper_exclusive(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+}
+
 /* For uniprocessors, SH4 uses optimistic restartable atomic sequences.
    Upon an interrupt, a real kernel would simply notice magic values in
    the registers and reset the PC to the start of the sequence.
@@ -2149,12 +2161,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
                   pc, pc_end);
 
-    /* Restart with the EXCLUSIVE bit set, within a TB run via
-       cpu_exec_step_atomic holding the exclusive lock.  */
-    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
-    gen_save_cpu_state(ctx, false);
-    gen_helper_exclusive(cpu_env);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_restart_exclusive(ctx);
 
     /* We're not executing an instruction, but we must report one for the
        purposes of accounting within the TB.  We might as well report the
@@ -2242,12 +2249,22 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     if (unlikely(ctx->envflags & TB_FLAG_GUSA_MASK)
         && !(ctx->envflags & TB_FLAG_GUSA_EXCLUSIVE)) {
-        /* We're in an gUSA region, and we have not already fallen
-           back on using an exclusive region.  Attempt to parse the
-           region into a single supported atomic operation.  Failure
-           is handled within the parser by raising an exception to
-           retry using an exclusive region.  */
-        decode_gusa(ctx, env);
+        /*
+         * We're in an gUSA region, and we have not already fallen
+         * back on using an exclusive region.  Attempt to parse the
+         * region into a single supported atomic operation.  Failure
+         * is handled within the parser by raising an exception to
+         * retry using an exclusive region.
+         *
+         * Parsing the region in one block conflicts with plugins,
+         * so always use exclusive mode if plugins enabled.
+         */
+        if (ctx->base.plugin_enabled) {
+            gen_restart_exclusive(ctx);
+            ctx->base.pc_next += 2;
+        } else {
+            decode_gusa(ctx, env);
+        }
         return;
     }
 #endif
-- 
2.39.2


