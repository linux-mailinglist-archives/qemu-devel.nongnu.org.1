Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD5F7B3D91
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWS-0000Ja-32; Fri, 29 Sep 2023 22:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWJ-0000FG-9d
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:52 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWF-00022L-SX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:51 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57bab8676f9so5497027eaf.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040146; x=1696644946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri0JhH0bqEd6DenOKDhZabd3UHTdrfzqwpuOkMZwzx4=;
 b=kInwXAHCv5tsaUDiTlfkdACIWJcOWx97RZA/UVcc/Ycs35jln+FRAgwSbNdjoqQIHe
 EjsoHRxYR3m5grjHrQZPaA47Dc52EKOwGy209tRT/F0BdkRIxrhNAguSz4UY66MOfLnn
 lCQJJp7xAYmVS7Gx6Oxg2zcLXyDhY2ZoqlrJG1GDLm8QcMNE4iBA/cxhpGyuqaKx4WH+
 j07J0bHlMJW6LiF3bX4MrylDTQH52zRv+XuLmVhm52SFtzyXCvoZ/uwq5rf4euSxIzq/
 j5Lovp82Db3edm3OyCwyC6dzEa8Zqnw7DjMMBryEZTXbTb8DO0DCPv0ns4BYTEdZ4T+q
 oYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040146; x=1696644946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ri0JhH0bqEd6DenOKDhZabd3UHTdrfzqwpuOkMZwzx4=;
 b=LoqIaon5sJLBFmhfHD3FiN4UuRF41kSCgJTuh9GfFt/6IzyTdfuC6foatT1n8rPQOO
 mOaL770V+sqTMMMt0kMKFeYc2DJUMEA5X7iebKlYW38CcZ2+7kufXJu22E+MVrIZTi25
 1aOKHKE6T0B/kyX9l84a2AFZ35aloPQG4Hkopkf8rQh8wVFrJie2MofTzCelNtu/5aHp
 5e3KYhOFJbqWN25qnV1/0rH20/MrpQleDrshhzXoUKuGvm+rFYoBMZIdhXavXqirTgtU
 zLGoQBy9ox3hYzr2KOSmFnULWb6YCOo763IBX1ToKRXNjFAPd3aqTnXQCWELBBZzhv4M
 sanw==
X-Gm-Message-State: AOJu0YwDgMRi9BAO8E9IyxTaVMHFagvBWmwo3qk0jZ9hFTKSuy4mkPmp
 Lx1lm/01o0FdERQo+X7JHNuvqimlN2RNDIsC23g=
X-Google-Smtp-Source: AGHT+IGBvEbr0LxykD3PM2ItSolQ93F5KLvMYzoE0vhoNsm5vDJQzve8q6EiGztwYreJdo0uvLlNFg==
X-Received: by 2002:a05:6358:7e07:b0:142:fba8:dcfc with SMTP id
 o7-20020a0563587e0700b00142fba8dcfcmr7210418rwm.16.1696040146581; 
 Fri, 29 Sep 2023 19:15:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 17/19] linux-user/s390x: Rename __SIGNAL_FRAMESIZE to
 STACK_FRAME_OVERHEAD
Date: Fri, 29 Sep 2023 19:15:27 -0700
Message-Id: <20230930021529.987950-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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


