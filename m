Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C22807C5074
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgm-0008D9-SQ; Wed, 11 Oct 2023 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgk-0008BH-00
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:38 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgh-0007fR-Je
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:37 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bffc55af02so79468011fa.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021014; x=1697625814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zawTcP6zVPEQ87O8NTB4Qxv3jWF5guFODyudtyjxLaU=;
 b=p26hobocXcbl8QWHT/iWXdM4CUAcEz6+5+/gVE06ENLzymsnURHCplHVk8Mi7QtLCz
 pgvY0M0unJ6jLVDwjsD4/nwfI0f8BRXiuAsUkDqoRRerwvoqfrFOSacrXr3CvfNo56PC
 MTMwbLjTjT2ECkuQupw/+XOoJ1fW/7QOaOIzc6lzURY4NtglOHSzBuPFk4s7gcCJ9ysW
 REo4+NYJd5mNbgk24KqiX1Tbbxy2j4/ofwWdbErZTkBS2T/j52XYf9h+kyZmFoUmf3CT
 HeAe+47I8fy5KyrM+IT1iHeQPP7pv7grpYAYHot4BDnvxc9ef1EEgu9kXl8ocstpRZgP
 OiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021014; x=1697625814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zawTcP6zVPEQ87O8NTB4Qxv3jWF5guFODyudtyjxLaU=;
 b=DB/WJr1HBc7+YQUPjVJ0J8aSm6gB+JkRkwuHiiN4LT3kt1FxrEZWofmUNdv6/wJi0C
 QTx3mdN447hXg+6tnfs+lWkHUBdIUpdgX6i74h1jZv7ow7MzvZzNMd8j/Z9xD1D1uKSh
 3Zs2AZP2rHpTbs4FMizeFh6plqUTWhWT/DdNkwSyAtGgQ0jk4SQrOU+jFyjEoCKchoBB
 tTd7yC69BDAZSutN2k1B/KqIx9l4AnSy/O6jWTOuaCv0jZX6EuzJ0/jVuta7ea1ICPVe
 PbKEPu27VdYJQ2ZHelmqRRAhElsGEovvU3IQf3vp9K1wuM+AGyQN7YVEIphVJ458D3aS
 24sg==
X-Gm-Message-State: AOJu0YwTZDfOaC22tQVjBuSqE5eC12VIb/3NlUos0yRmG0LX8MO8Dwqe
 Bj1GTTVKX4jRacpI3ciTqwVA2BWypezbhzuU154=
X-Google-Smtp-Source: AGHT+IGG7zzirkyqSq5QKfcAL1iG58XT77mr23AtpwVXn6/W/nN96MODC7RkeYhqFyty+vo1GpYGPw==
X-Received: by 2002:a2e:2e05:0:b0:2bd:180d:67b1 with SMTP id
 u5-20020a2e2e05000000b002bd180d67b1mr17655466lju.51.1697021013967; 
 Wed, 11 Oct 2023 03:43:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c248400b004060f0a0fd5sm16443181wms.13.2023.10.11.03.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 288981FFCA;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/25] gdbstub: Remove gdb_has_xml variable
Date: Wed, 11 Oct 2023 11:33:22 +0100
Message-Id: <20231011103329.670525-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230912224107.29669-12-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-19-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index f7fd1bede5..465c24b36e 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -32,8 +32,6 @@ enum {
 typedef struct GDBProcess {
     uint32_t pid;
     bool attached;
-
-    /* If gdb sends qXfer:features:read:target.xml this will be populated */
     char *target_xml;
 } GDBProcess;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 705be2c5d7..1a01c35f8e 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -45,14 +45,6 @@ int gdbserver_start(const char *port_or_device);
 
 void gdb_set_stop_cpu(CPUState *cpu);
 
-/**
- * gdb_has_xml() - report of gdb supports modern target descriptions
- *
- * This will report true if the gdb negotiated qXfer:features:read
- * target descriptions.
- */
-bool gdb_has_xml(void);
-
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 3dc847f835..62608a5389 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -349,11 +349,6 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
     }
 }
 
-bool gdb_has_xml(void)
-{
-    return !!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml;
-}
-
 static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
@@ -1086,11 +1081,6 @@ static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
-        gdb_put_packet("");
-        return;
-    }
-
     if (params->len != 2) {
         gdb_put_packet("E22");
         return;
@@ -1107,11 +1097,6 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
-        gdb_put_packet("");
-        return;
-    }
-
     if (!params->len) {
         gdb_put_packet("E14");
         return;
-- 
2.39.2


