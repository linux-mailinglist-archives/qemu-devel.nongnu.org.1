Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87076B8F4
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrYy-0001jY-SK; Tue, 01 Aug 2023 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrYr-0001h3-7d
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:45:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrYp-00042z-DY
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:45:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3178dd81ac4so4314303f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690904721; x=1691509521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f0+coTLzDrNM167uzJa6E+m7LPT8bGvKfu02ozqr8PA=;
 b=S67VyW/5FImcd5YByTwxj6oPF3BARzyghoE0YeL7UPDFC6lPwnCPvy8Bx9ZynDYPM0
 V5HXTsvOICOotS4wqseYr8abqV8A0CWQlqJv2KAT7nn/ZYPuxt0m5cdq5jbiexjGOA45
 SnNbWOTYrNJbs7cXJjwt7dLa5NsKeFNFxJNM6Fe1rl+sdmV4Wi8mIV/bDZ2PQgaC6Dmr
 np5uJYX/qXRWZwU9JKwtB0lGmzEGHWhRkAWhypaAVZ51JxBSCMkMqg/PRS0k0ZdFtY9r
 UiYSShKBLSNVHzRqzMjNiKtOhHVpokXcEIV/0dskTuUY3zUJoUXTY26bwAW13r806dO8
 jH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690904721; x=1691509521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0+coTLzDrNM167uzJa6E+m7LPT8bGvKfu02ozqr8PA=;
 b=I+yD8KtZLdfd86p23av6WSlZ61wpua+2bBziR4cut0hkeHU2lOec+srx2jFNIBLpcN
 1663e9U1AYllbKBOZSVTU1gmm089SVcMwntC9IQACNE1Z4ygNlJhCUqeCHZx9UDyf8C8
 9RqugVxwHtmXcS8DGMEhyt/XQu5ueQR4buoF9vBNgh4sD6GRu/sofD0XbqzXdUjy20CR
 cxKrtKJ7nre2HcPv7PpSFikrsmOZ+McqMPlna2qpLLUh84fQJHpvopr7f8Ge0zoBQuD0
 p7m2o8wFD74lSraNZlSxeTjrNKs2fGudGmWEQNxoXMN4QZU59IurhBYeTb5wbvPhskiy
 QgoA==
X-Gm-Message-State: ABy/qLbiMGQmTmEJ9mgvLtY7YwLMraH7C8A3L7i5VuU35Nk+ZDDhAl23
 6AFWpQcdxil4LpUYX3bLgK+H7F3jdd0mHjrAfHQ=
X-Google-Smtp-Source: APBJJlHnFr8CWySk2SFnaM+E99csADtjcDPOONeJD8tGjfhm1JNLDzH6/jbFNldrrtxJ3nrrkiI9bQ==
X-Received: by 2002:adf:d84a:0:b0:317:61d8:3c7e with SMTP id
 k10-20020adfd84a000000b0031761d83c7emr2647688wrl.26.1690904720992; 
 Tue, 01 Aug 2023 08:45:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d6a86000000b003142ea7a661sm16368050wru.21.2023.08.01.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 08:45:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Packard <keithp@keithp.com>
Subject: [PATCH for-8.1] target/m68k: Fix semihost lseek offset computation
Date: Tue,  1 Aug 2023 16:45:19 +0100
Message-Id: <20230801154519.3505531-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The arguments for deposit64 are (value, start, length, fieldval); this
appears to have thought they were (value, fieldval, start,
length). Reorder the parameters to match the actual function.

Cc: qemu-stable@nongnu.org
Fixes: 950272506d ("target/m68k: Use semihosting/syscalls.h")
Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Same fix for m68k as Keith Packard just sent for nios2
---
 target/m68k/m68k-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 88ad9ba8144..239f6e44e90 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -166,7 +166,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
         GET_ARG64(2);
         GET_ARG64(3);
         semihost_sys_lseek(cs, m68k_semi_u64_cb, arg0,
-                           deposit64(arg2, arg1, 32, 32), arg3);
+                           deposit64(arg2, 32, 32, arg1), arg3);
         break;
 
     case HOSTED_RENAME:
-- 
2.34.1


