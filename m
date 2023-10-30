Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 837807DC1CF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:21:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZe3-00013l-7T; Mon, 30 Oct 2023 17:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdx-000116-Fh
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdq-0006Vk-77
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:52 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso11868395ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700665; x=1699305465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri0JhH0bqEd6DenOKDhZabd3UHTdrfzqwpuOkMZwzx4=;
 b=N6K1GqicBzZwrIiMM4NtJLYYV+8l5BX5zHxV0isdX9KU/YGANjjmq3VRCQnpPanJST
 fymzqAUh7Z7ZOwDUygQPceb2VvukYlJG9Uld4dkhBMFnDl7fG5KCbVCNpKidRex7xxmc
 COW4+XxJX0OYO0f89PnAwqyVM7DxpEYMb4kutM/QlHtaIMN9YLFo1Ggwit8Wdx1kClNE
 Csl+f0fxmuDCCyznq4JCRMMaIE49VvrlT0ynnlHdQwYRQzPmlTGR8YJZDZlCL844old3
 3V/+8J19CaHYOHlU0pi2GKjO9InB5hwDsTPhXD6K3iQOihfUH+Q3CQGLJasRUKsZShy9
 FRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700665; x=1699305465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ri0JhH0bqEd6DenOKDhZabd3UHTdrfzqwpuOkMZwzx4=;
 b=EAeSzcjyvZXbH4NPfiiwJnhBSMfBq0vUqfyp6/g4P1+YNxlxBz2eB2pd8XBnxe92+3
 Px8U2EmPqW/KbeSUbsp2LPlhQ2nIhOxzfIwM8+J+B+lkNUXVvwUdAEZuA1voo0CfFv3s
 rjh1VPeyOjraJPY+siXPVjKsUZWMxjxn9eb1CcJgI+fYe8BKBAS5QioXdWTUDk44Ngy+
 uxhSvFR+h8gZxlI5QVGM4M8NtQfy8936sKpLqFgZ3vVz9A/a38SmaQbr8VE6gXBJTdpy
 ySDGhmGZC4P2R+ZhGJl2istKgFXRoDFWzin4DrhwnGURUCPpQ4MDabl9gqp6RVLkq5yF
 I1Qg==
X-Gm-Message-State: AOJu0YzrtXMbZMg5QGA4f7ZtW/5WXKWRVBGOo9z7uWyZd4S9/LPbBXAY
 uqvPFF7a/1/Ro3WFX/yDTGY0UZz4JXUjIsor7U4=
X-Google-Smtp-Source: AGHT+IGvJXEmdjM7JE3KkUNEzk/JSlDUYiEwxSjIgJWaOaHQrhMdhJDayr5gSIp+yulS5OFopbdaIw==
X-Received: by 2002:a17:902:c714:b0:1cc:40a4:9179 with SMTP id
 p20-20020a170902c71400b001cc40a49179mr2811904plp.34.1698700664713; 
 Mon, 30 Oct 2023 14:17:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/21] linux-user/s390x: Rename __SIGNAL_FRAMESIZE to
 STACK_FRAME_OVERHEAD
Date: Mon, 30 Oct 2023 14:17:24 -0700
Message-Id: <20231030211727.165090-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index f72165576f..0f8b8e04bf 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -26,7 +26,8 @@
 #define __NUM_FPRS 16
 #define __NUM_ACRS 16
 
-#define __SIGNAL_FRAMESIZE      160 /* FIXME: 31-bit mode -> 96 */
+/* Minimum stack frame size */
+#define STACK_FRAME_OVERHEAD    160
 
 #define _SIGCONTEXT_NSIG        64
 #define _SIGCONTEXT_NSIG_BPW    64 /* FIXME: 31-bit mode -> 32 */
@@ -63,7 +64,7 @@ typedef struct {
 } target_sigcontext;
 
 typedef struct {
-    uint8_t callee_used_stack[__SIGNAL_FRAMESIZE];
+    uint8_t callee_used_stack[STACK_FRAME_OVERHEAD];
     target_sigcontext sc;
     target_sigregs sregs;
     int signo;
@@ -83,7 +84,7 @@ struct target_ucontext {
 };
 
 typedef struct {
-    uint8_t callee_used_stack[__SIGNAL_FRAMESIZE];
+    uint8_t callee_used_stack[STACK_FRAME_OVERHEAD];
     /*
      * This field is no longer initialized by the kernel, but it's still a part
      * of the ABI.
-- 
2.34.1


