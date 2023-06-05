Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59D723160
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd7-00025r-4X; Mon, 05 Jun 2023 16:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcr-0001xX-4H
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcj-00045f-Qi
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-65299178ac5so4817540b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996176; x=1688588176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtgBRGxv4LHPMzETUNJDv9zePk7Nq2QT5FVC8r8aRSI=;
 b=khWtX/Cx5Mwl3P5pZnNM2SPo/0tGqQChHLciwte8WMqqtFdbDDJ9zl1hxh9Zy0wii7
 ioCsIW6eHb4vxEV88kZnvxQ1n4i91rV9jUYgJDwBKlFQ08Tanui9+vJWRUBuIpuvlNLg
 WXUD6ciEUA/D1nusaCkfRE0fvntZf00pY9CvIMO7KQGLpQZw9oMtC1oMF7TyRqM2rRc6
 doUP3AmU4K/3Et+lv8ToN0fmqwHd4oX995H8/cBUchTauN86jgqn6JnfCo4r5B+glt6E
 Xn1bJt0qfs2r3bnQq3SHuKccuXXZ2WmjYO/lq7v+hP4jkVgiIEL3+lvCSWzHtIsEVsoL
 MHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996176; x=1688588176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtgBRGxv4LHPMzETUNJDv9zePk7Nq2QT5FVC8r8aRSI=;
 b=TV8zce+TeY3IqOPynRrbOVFGU+pQF6k2jDgqcLK+3PjEgVcFUFzqZAKq0w89Iep/xM
 +0pWrGxLDmWieBHuZuEgwuYqbTIabATTEftJJJEQ1gXC3FFIxMUnxbz4ARQXphd3Q/qr
 d+rSKP8pYSsKLlAW/4F/EYYL2qAfNBjWiLgALIm98C8rODVXl7RAMADgEPH4552RCJ+G
 hR34vQ/t2RDxo8bbMRAmeSEJecIEpS5pWoRQZQS7O5sS15IJaLOGi++r5H0X5iHS7Lrg
 +jTd0lAyCTM0cgtSfW4fThqUuyVST7qIa2VfEN8+RsAEgBdTU6MN6eR49eTyp4aHhcF5
 z9Vg==
X-Gm-Message-State: AC+VfDxaXpkzW3PmFDBwCKHoGR9b+WcMfb9ocuQ0f6DcshKLCHL+Vhhf
 QpqEARbJe4FiAY6VfhxRmdIOW+48/4qEAxMQ04A=
X-Google-Smtp-Source: ACHHUZ5KBL2aiSaus0P3gYCULv28LZK0oRKC5k22BwfHEy6muBoJ55WTYd8ZV8pYOO8aMGzvUurkJg==
X-Received: by 2002:a05:6a00:1405:b0:64e:bce9:3229 with SMTP id
 l5-20020a056a00140500b0064ebce93229mr1036186pfu.9.1685996176605; 
 Mon, 05 Jun 2023 13:16:16 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/52] exec-all: Widen tb_page_addr_t for user-only
Date: Mon,  5 Jun 2023 13:15:27 -0700
Message-Id: <20230605201548.1596865-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is a step toward making TranslationBlock agnostic
to the address size of the guest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3b1b57f6ad..ec0902c532 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -31,8 +31,8 @@
    addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
    type.  */
 #if defined(CONFIG_USER_ONLY)
-typedef abi_ulong tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
+typedef vaddr tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT "%" VADDR_PRIx
 #else
 typedef ram_addr_t tb_page_addr_t;
 #define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
-- 
2.34.1


