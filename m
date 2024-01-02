Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782CD82164E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU41-0004lj-Lv; Mon, 01 Jan 2024 20:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3z-0004ib-GM
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:27 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3s-00077B-O2
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:27 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbbf5a59b7so4339660b6e.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160759; x=1704765559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzcEJzTW0FxXggtPi1Qrm/hCkn19peXK5YmTgg9HZqo=;
 b=VO745913dsuHX2SLsDvYLQNo6hJS46AwNkxsfMcQmrlkBf2kpVCNV/9X7Ksml++tXH
 kTDHSWDHItq8t3YPlFjPCGiLFGJrmoTbco5gtvZClfilow6S+1rpazuXlaev1neXFduP
 RPyJSBoP/If2rRyCelysW+NL4hmnB7LbMZqAqpZWBsH4rZZIMJkSYaTsvZ5Bj6dWwxwW
 Tr+Xi3fROCD00hBIFa502xxZdYCVQyuc7QaWiUusEWBOwT/qH7jTT2bt6cF2cTusR7SL
 ZSxlUtuOQw6lPsmytOkH5wG+zKKp5SL9bX27xAFmUDx78BrWZwL2DTc/yCbPXQ1Gq4xf
 eGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160759; x=1704765559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzcEJzTW0FxXggtPi1Qrm/hCkn19peXK5YmTgg9HZqo=;
 b=WfuQXhSpILCIG06tvq4kGfwkWIDJnyZG36nldmbcknUF/PBzfgPgTq7m9UdovqFtUC
 rLpM+i3W4IDuIfc2A257Pg8TlBHF97K+evQRyuifxXd+QKsIk17CgMMYxmhL/S+xQIJ3
 Yu3R/1JaIhgvpn3HLvhFF22dQUJ+rgO8Dz5mKTCv83sxLar7htAGuYnkQGjyGU7/IBad
 +H8aMs/3Vo7OPtcgSJ0ghExhp6IsToZR0ucK6s5Vvp2/9FKsMqXYSaTXLLGg1k/byn+2
 glXew30KmCZOUms49QOHtqctQVr9SPB7rLujq8x7BaYUCMQ96hTb/S7wRdR/NSRSQSU6
 iRWw==
X-Gm-Message-State: AOJu0Yycfm71EoX7sphSVHpEBYfeQ7IsQ5LPl/ClgCeY1mIPwybxtAY+
 drTKaYRhykGczQho0GBn2hAT4tG1EX27o/7b6wVVvPEY2cc=
X-Google-Smtp-Source: AGHT+IFQNcHWcw3KkJhcwY8+VfSAVyEyJmczxmS5MF1V39TwLfThdfJexxvi9KATckhMuXtPKPW3Dw==
X-Received: by 2002:a05:6808:16a3:b0:3bb:d7e8:d8e9 with SMTP id
 bb35-20020a05680816a300b003bbd7e8d8e9mr8161374oib.109.1704160759687; 
 Mon, 01 Jan 2024 17:59:19 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 32/33] target/ppc: Enable TARGET_PAGE_BITS_VARY for
 user-only
Date: Tue,  2 Jan 2024 12:58:07 +1100
Message-Id: <20240102015808.132373-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since ppc binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu-param.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..b7ad52de03 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,13 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
-#define TARGET_PAGE_BITS 12
+
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.34.1


