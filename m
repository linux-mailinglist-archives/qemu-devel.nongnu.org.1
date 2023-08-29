Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4587078D035
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ox-0003GD-5h; Tue, 29 Aug 2023 19:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nY-0002Sg-Eq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:57 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nV-0004BQ-Ic
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:55 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57128297bd7so3168628eaf.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346572; x=1693951372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RKu2/5G+zSGtoRuicJK2UTVps/EcNkegXQWs2RCjrs=;
 b=oWlqfU2hZ+kWwQQlvK1SVEH/+RFgewXJG91jsLi2bQgXqwSOfylnYelmr9dIXF347j
 T+peIJGMLR1m0lI2P/H9eQraU60z3nzvFwwDDinyHhBU80gX6LNUiwweQaa5+jlR2LP5
 HF+5yfzT8rWUnFoEWq8GnF/Fr9b89/Kzjxgxqnsw+trpiP0bPIfoXmIe0OE3yExiWsrX
 qqPpq8km6EetFOfl6FaVoonAzoIba19AtNJ6/R7rN31MMQPl1j5dzXazbg5HZTjEDTWC
 s5GSSC8yxHXCBouXG9bcCHwHHJSb2kWvngKIx1PsM8WWL9MXioOKXmnobtUjEPD1rCtS
 7keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346572; x=1693951372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RKu2/5G+zSGtoRuicJK2UTVps/EcNkegXQWs2RCjrs=;
 b=LXWR4KiwAaWp5IMFHEVMQs0RbY2zQkOe3SeAoWGWI9LdAcYQZjS+wmOJTuw9a4CVaM
 QWOktV+CvmD1QWyS0e/U5O1myHYcLFL2nfxwdgGcpByfa6FdLtOylWKRbDbiPCjWZcWf
 m5ZQHw/lVxVEi5pRwxL/teGGYNFgge2gzQiDplTXfLX6rTMGc3AJfnnt6PlOqh5Xc8Cf
 RDYuyNw5q5DGvTWxy1XPuzOk5edLt3kOiJLRpyyzHIRuJdA8lpL+8S97WlXdo8MXwFRQ
 GN4oEtjjYQf6fxWLM1+IdjsIBTgr0WP+CH36L0gqw6o7tNnlj74LvpBimtvVl+CgSeIR
 JWCw==
X-Gm-Message-State: AOJu0YyJiMJvGb3nqvkE3J6oyBFM+qezd2vTfk6U5bMKDHRUuXXZLT9g
 t7Ywwn/9sp1R0G9cW1By67PLl4eMTSkyDQTPYUc=
X-Google-Smtp-Source: AGHT+IG38/WlVYgcPqjOb0ZTghM/dFfHd8DlLqah0bD/PeZEWnaz8ZqRg2E5POoA+2OWYVyxOAwljA==
X-Received: by 2002:a05:6808:14d5:b0:3a8:5207:1d88 with SMTP id
 f21-20020a05680814d500b003a852071d88mr528428oiw.49.1693346572019; 
 Tue, 29 Aug 2023 15:02:52 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 19/20] linux-user/s390x: Rename __SIGNAL_FRAMESIZE to
 STACK_FRAME_OVERHEAD
Date: Tue, 29 Aug 2023 15:02:27 -0700
Message-Id: <20230829220228.928506-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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


