Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF038A8B14
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Apr 2024 20:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA19-0007a2-Du; Wed, 17 Apr 2024 14:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA17-0007Zs-MS
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA15-0003GO-4h
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4187c47405aso261875e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378495; x=1713983295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXSzECYTToI5yG00Nu/fEQEka/0Hmt5e5edwX0HsJB4=;
 b=hS22Pnlo6JPfnRRjInc5jTfb/KhHFpCuxJEjkRS5ayDoVioPvTSm0SXu6nGPFYQDTp
 w7GMtboIUZ2yYOUFUfA7BGE467eZUtq7f1JM9Nuz0ootiNpgS9vL3+sQNJ9OIyFhE+mY
 gBWCnqxh5vdy8SeAth15+/BP/uy/HOZzktMfZIK2sejlaelvZFPKirnWUTa7Fughl86i
 UT6QwTeorpdhpVxNf3wVkuPbHQrnG4Qv2lQIM9kvX1VQtvQo31AogAD+ium83Gjoetp7
 dcz5F9A7uAXgiU/5hiHQm8qM/jhCIP2su4wq2El5YRrvAdwfX1aW+oUJeUhqpsAYHfAF
 a43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378495; x=1713983295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXSzECYTToI5yG00Nu/fEQEka/0Hmt5e5edwX0HsJB4=;
 b=nrsHYHmF6bl9ktGfeCdRrSPr/q0xE+9uIBfxAzyv0FGrmcsHlncQz/1K7gn45QrA/p
 Agh0sUWtaQU1QKcltN1YJdhDIa79OuOyKBXT/WJZkwwMLY+otdV5sJXbzomTwzdL0Fxi
 5xQlSp7+OBv4iD8AxOpMKiRGxamAzcxQ7cgiMKz0K+ePWgFxBOr+pym3syzeU/oOpAOi
 fviZKYBsZVZarWLDYgoPgmLzc5NIBJeXyTTMwdQxOx2gRz2Tm2uAzEkK/x+WDZbKmXie
 9V8CI2xBsYc5ge8uUHJoMgbjxuwLhKoyZX96r+hx/rB06r5BuGYUQPGFHKVewmYkJqgA
 Qdjg==
X-Gm-Message-State: AOJu0Yyp643HOwTPToBgbtH+Ttqj1hNjfPIksCRihBuop2Q7IQfosy3T
 5WxwHw4tBmWsRWtgptyaXEVzFNQjAz+iMl+W/Ch00Lw+x711Z4W1Ayn+8Wym+YpG+bCpfKCrdCA
 4
X-Google-Smtp-Source: AGHT+IEeh7ccTtHKsN1NYAZ+Tqqia38G0hVrDEgAAhyLJoy0beTmHggJMEwEepp+gD3Kz8x/52msSQ==
X-Received: by 2002:a05:600c:3581:b0:418:41a7:d032 with SMTP id
 p1-20020a05600c358100b0041841a7d032mr328663wmq.13.1713378495644; 
 Wed, 17 Apr 2024 11:28:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a05600c34cf00b0041897c6171dsm3648880wmq.16.2024.04.17.11.28.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/21] gdbstub: Simplify #ifdef'ry in helpers.h
Date: Wed, 17 Apr 2024 20:27:46 +0200
Message-ID: <20240417182806.69446-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Slightly simplify by checking NEED_CPU_H definition in header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240322161439.6448-2-philmd@linaro.org>
---
 include/gdbstub/helpers.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index c573aef2dc..53e88d807c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -12,7 +12,10 @@
 #ifndef _GDBSTUB_HELPERS_H_
 #define _GDBSTUB_HELPERS_H_
 
-#ifdef NEED_CPU_H
+#ifndef NEED_CPU_H
+#error "gdbstub helpers should only be included by target specific code"
+#endif
+
 #include "cpu.h"
 
 /*
@@ -96,8 +99,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #define ldtul_p(addr) ldl_p(addr)
 #endif
 
-#else
-#error "gdbstub helpers should only be included by target specific code"
-#endif
-
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.41.0


