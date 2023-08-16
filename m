Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808677E831
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKsN-0002Vm-3R; Wed, 16 Aug 2023 14:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs9-0002RO-70
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs6-0001MV-O8
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdcb800594so26810285ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209033; x=1692813833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6RKu2/5G+zSGtoRuicJK2UTVps/EcNkegXQWs2RCjrs=;
 b=bQltoNZaHlNUSc7opy6R6T72e2EPzhHuQeZvpoXENAdZl2btIX6J4+VWQKP0uJV/jJ
 9Ef72YMrsq1i7MQ8Dvl9JZgyJ2MP3MgW1bR5QI3T56OVRgGJmso/f+SOMRzPwAx0LXSy
 FZCfaCvL2WxmTig/IrikyO/0tZwqgwZwsY11NWwf2t3zD5xG1SYexQMAPLFscpjPiA6v
 200Y30ZG+2af9a970JRRrOVPKJCwbNZLdT6O21s48rrtkni/DcUTt+r/mWWtXx9wrKeb
 PLBNFwfUP9KBZoe3eRMdC6J5y/YA0isXKtaXC9NtytAL+pjDDdEPvqNJL5QeFFmZwbpw
 KGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209033; x=1692813833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RKu2/5G+zSGtoRuicJK2UTVps/EcNkegXQWs2RCjrs=;
 b=kt87e9/nJrVciXNj/l7YYI8bCpI2vmyoAXK/+feVviLF9prpZQtnzdDT8MKo6XZHlN
 cyp2BIzsZxwztHYjdHrak2gdsf3h2I0cYI+ktWR1OOSfCvyjtRES9Qp5X6lsEVIm3vAP
 UMhT8jkN32bVzALySpodU/CWmbq5JQMYMUa4kt8L3reyJa8qYoSZaZMbIkcvv8HuCrtN
 pbJr746zYRwyq7X+XogWKMOUpvYjCOmb/C4278lUYfR9vdlC9LhHJZgcNrpEqArbHr8s
 GQg8WP5WFLzBdfPxwogc3HQOSJO8cViaB1b4EkAtmcFmQyXzh8iGxuSEu0AJDtZV9Shi
 ENTg==
X-Gm-Message-State: AOJu0YyGLZlE02nUV44iRFhWS383jnmm2jjgVjHtv4oGqtgAwLwoMgrT
 winBo7BloFHsYIWcFV9YPYR6mj+eJ2LfzagHqQU=
X-Google-Smtp-Source: AGHT+IH5SgWpgueCNma6S3fmjsYgRJKTo461es4IhTYhTBkz5rK8FtAQlM0Ef7JidCHNcA5y1535Fg==
X-Received: by 2002:a17:903:120f:b0:1b9:f9a1:85f1 with SMTP id
 l15-20020a170903120f00b001b9f9a185f1mr2819242plh.19.1692209033464; 
 Wed, 16 Aug 2023 11:03:53 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/18] linux-user/s390x: Rename __SIGNAL_FRAMESIZE to
 STACK_FRAME_OVERHEAD
Date: Wed, 16 Aug 2023 11:03:37 -0700
Message-Id: <20230816180338.572576-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


