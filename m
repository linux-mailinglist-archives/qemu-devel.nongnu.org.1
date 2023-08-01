Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FF76BFA8
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKw-0004AZ-KI; Tue, 01 Aug 2023 17:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKt-000450-HB
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKr-00053H-5Y
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so6272329f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926919; x=1691531719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bh9naHn4NiF5F3e/lau9gZRCmWW1W7JeWXsrB/buMi8=;
 b=UogiiheJHAADm4UMrPE/AyrskvVO4HQVa5uOSEEmpS/FMuNlQ53n6euV3Fo1ISe2kO
 dG0f8cOQpJre7fbWRaQsJYSB4huiZDadgUnHbiAefaZMvgGFdKNxSiFNTb5wddJQ/DYw
 /CuqmGov2rV4bCiUZe79+YtybcrnpmIZJrryyLIlEDOxNuW157izUua0O51vKRYqHWfV
 P4tUCgtSev9aTBCtyU29/qNn4OHdwDDbh3yszQNdb31ifZriF5lpEI21jdUZIdqYdSaA
 x/4exdMXDCkQLJ3De3Egz7g3wFwij0hK6+DADUU2Rf4NarwcRyFXosMJX5Q2Dk8bqJl7
 IjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926919; x=1691531719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bh9naHn4NiF5F3e/lau9gZRCmWW1W7JeWXsrB/buMi8=;
 b=LtbUFHOZf56zTy+jSlJd2qBx/yx0QeyHKhDTG3pG+wl6Ae6bM2SyZio105kLmFacqM
 NI4avhzl9EXzg3TFHDT4FvLSP1Rkz5nWRKw4St6mRvrnzmqomiGyhZkGJl84O1iwzfAj
 zeWu/M28cCqCXWpVYlsE1kPug1/WcV/+ydYcZrEsRz7Bx3Eg5qYJI2jPW/G/90j7wK8D
 K4LBEHz5IIVsLE2+5LbtZ777zzbx/anHT7YeD8fzb3LxRIPzpCAQathNnIy2fvrGZmgV
 7ZNpnxnMPOiFbtHXMMhtMCpyCAUTz2P8FKaWShuJhR9kYPsQt6uV/Sm14P4Udi+8gcQn
 oyOQ==
X-Gm-Message-State: ABy/qLYqN7N6SbWK0MwyGnk5vsG1odne0NbIk1OkFY5cLHAeRckSAjGp
 NIyHrUgduQpCgzCMHPSzzQ4D/i+qs4DVrg9b3VE=
X-Google-Smtp-Source: APBJJlGpkB7qqlQchlMMZf32N0QIXxecUMS1ycAovzoHJ7nvFljvfnphYZIljhiTsWeQh5D4KsenlQ==
X-Received: by 2002:adf:fd8b:0:b0:314:3ca0:c8c2 with SMTP id
 d11-20020adffd8b000000b003143ca0c8c2mr3466166wrr.11.1690926919468; 
 Tue, 01 Aug 2023 14:55:19 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 y18-20020adff152000000b0031784ac0babsm15896468wro.28.2023.08.01.14.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:55:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Keith Packard <keithp@keithp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/10] target/nios2: Fix semihost lseek offset computation
Date: Tue,  1 Aug 2023 23:54:20 +0200
Message-Id: <20230801215421.60133-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Keith Packard <keithp@keithp.com>

The arguments for deposit64 are (value, start, length, fieldval); this
appears to have thought they were (value, fieldval, start,
length). Reorder the parameters to match the actual function.

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: d1e23cbaa403b2d ("target/nios2: Use semihosting/syscalls.h")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230731235245.295513-1-keithp@keithp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/nios2-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index f3b7aee4f1..9d0241c758 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -169,7 +169,7 @@ void do_nios2_semihosting(CPUNios2State *env)
         GET_ARG64(2);
         GET_ARG64(3);
         semihost_sys_lseek(cs, nios2_semi_u64_cb, arg0,
-                           deposit64(arg2, arg1, 32, 32), arg3);
+                           deposit64(arg2, 32, 32, arg1), arg3);
         break;
 
     case HOSTED_RENAME:
-- 
2.38.1


