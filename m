Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CBF7CEC18
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0w-0003yg-9b; Wed, 18 Oct 2023 19:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0u-0003vt-3a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0s-0000KC-Ig
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so5808204b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671901; x=1698276701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDEeeYBNH4kaMPDKd2bpL06m4MGoDecFzYDq6oXSWUM=;
 b=E5bVMljhVaac6oapoai8D5VZEBpg26aWN1S68fE3yZUQ0RD+n1Bf9iMc1dvGu7qV8l
 gu1u39Wv2w/DtUPYs+LqpvvNq57ITlRX3zHU9P54F3TcYm02C5wNURCYc/RN89MlKsIk
 cg/CBqfwl1V9bqG8qM0u4+DNpYc+0m3Bnd29FZuRIG5St8FXkDjD51lYCYPYezSvXFJ4
 UqiRbN6tpI8tNnmGhp+enM84QnW1PY8uC0B/S8xGW1hniJQ8nbMtwa7PdbtLK+Ka07l3
 4gZdqhsbsjgNXy+KD8pyKtvwls/Cq87fTuicF4X7NycNE8Y60FzFF7bzveWH6UBKleiF
 66gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671901; x=1698276701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDEeeYBNH4kaMPDKd2bpL06m4MGoDecFzYDq6oXSWUM=;
 b=I902sHxOSE6o3rIU/vgEutM/lZ7Wvhy3ZyJQFNfJcn1j0pUJrxfPW1eTrMd7qgTlq6
 2boNkShJRgltEO/LDTqUwBSioW0nrwn2kW0uLONiIiEXuW8+LAcFibArr0U234u/niBC
 bVmlj7kMHEe8hMe00g22kP6MjlgQKV2dx1bTVosMTWT3l1N2pdh9ZTjZ6j4Xcmv17MpQ
 Kwx1l2KXktdmCqisX3O2XBMBC/xmkvhVyGuV4uGoNEYQ+riINfm4TpQdAyBteQPC8oWK
 bB7r17M2lQzr9nkIjhQ0pfCGKar84KLkyhr29GphRzoW3VP8OzdGc+6evC0hjthaH/qr
 lkLQ==
X-Gm-Message-State: AOJu0YxGncnMAdGveoWyhbxdwVZsJUVmcVbQZWyRcRSqeSCspJNE3twX
 Eg3ojonoGfBkBrGzLmKSKKRnpjSymcovKwxiH3w=
X-Google-Smtp-Source: AGHT+IED1UtoC8RdGH8IuHBQr76tuTFXTZA2lO2yyYcZvJ0cWlBAUTu2hxAsDWTceSDptxyRuvZTBQ==
X-Received: by 2002:a05:6a00:189f:b0:68f:c7c5:a73a with SMTP id
 x31-20020a056a00189f00b0068fc7c5a73amr655931pfh.16.1697671901235; 
 Wed, 18 Oct 2023 16:31:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/14] linux-user: Exit not abort in die_with_backtrace
Date: Wed, 18 Oct 2023 16:31:27 -0700
Message-Id: <20231018233134.1594292-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

This line is supposed to be unreachable, but if we're going to
have it at all, SIGABRT via abort() is subject to the same signal
peril that created this function in the first place.

We can _exit immediately without peril.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b7a2c47837..84a56b76cc 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -713,7 +713,7 @@ void die_with_signal(int host_sig)
     sigsuspend(&act.sa_mask);
 
     /* unreachable */
-    abort();
+    _exit(EXIT_FAILURE);
 }
 
 static G_NORETURN
-- 
2.34.1


