Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF07057F3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0ex-0003On-QD; Tue, 16 May 2023 15:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cT-0000gz-J7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:02 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0003mp-3j
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae4f28454bso401915ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266348; x=1686858348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k62oH3YiaxNUbwFSA39EGQkVtGdW8K0k9LWPenWZTMA=;
 b=RKAXd0wYtIZON71lvjZHeleJ5sGh12TC4jaw9ldIAH5wCrxUuNqnvrpHhN8UzpS2Zp
 h1PLPI08Eozcy41JUc41iCLo+hnmK23+aLDl+guXpkgvI/HheFfnoGYxwVA/ztoxqHtB
 hoS6theMXCpFYZukFLRxOovTpby291DpZSQhq8X1ch9VjTAf0goKNwGA+vLHXgP01yrO
 lc5yF+U8wscwHV1E/GyLOraBSysJmsCtqBKjevCkbjLImdYvRlRlv1/ai8YcozbyrdlS
 ckNrbrYwVf6BH0HQDgcw8+TmbtPp4vG0HLdIc3RqulC1qD3WG7KcFX8nqj3XhbOZBFg7
 /VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266348; x=1686858348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k62oH3YiaxNUbwFSA39EGQkVtGdW8K0k9LWPenWZTMA=;
 b=hCZbh4E+r5HxrksDR8cLIV42+N3Gx5rot+urZUsbou86jTIJcX0yNtleuhuxlCGJO9
 e6g1kJiYTYwFCeTx72D1gGaY4eHHAH5bRL6QolP1APAisZoptzBn9MbZTGpHMeiP2w7E
 MuoHErOqAtiAV1d7m/tMwgLsMZsS2QfgGxZ8Ype4kBmuboIoBzg5k32LpY9wQhVGpZP0
 qxmdVSWCGMQJQthT4mTc7RU9Kz3t6w8bqfPSONrCyJvqG48ZO3HaO0LXSN8F1EGdiU3N
 Cm0gqgXQXh2UOh7sEaH8uDCw/8vXSpQBKb9u5XTKGVBhM3Xsx5O37YCb5y4MNOrK+kNO
 ku2w==
X-Gm-Message-State: AC+VfDy7Rc056vFlM70tDlYff928mAG2bDOFUXYSh8D3sb3X8G0CtUsr
 qYSSP24LNbAZW9+IiclOWXN+0hwdizdpX2tl+ug=
X-Google-Smtp-Source: ACHHUZ4sad5xkbvvCIPpd6EluPLFCsjiV5syykc2kLBnsoK7hh3MM8qBn72L6/7pNhCpRbh+TT533w==
X-Received: by 2002:a17:902:c102:b0:1ae:436c:b064 with SMTP id
 2-20020a170902c10200b001ae436cb064mr2166470pli.8.1684266347859; 
 Tue, 16 May 2023 12:45:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 69/80] tcg/i386: Conditionalize tcg_out_extu_i32_i64
Date: Tue, 16 May 2023 12:41:34 -0700
Message-Id: <20230516194145.1749305-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Since TCG_TYPE_I32 values are kept zero-extended in registers, via
omission of the REXW bit, we need not extend if the register matches.
This is already relied upon by qemu_{ld,st}.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 647c31fa23..aed5bbd94c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1323,7 +1323,9 @@ static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg dest, TCGReg src)
 
 static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg dest, TCGReg src)
 {
-    tcg_out_ext32u(s, dest, src);
+    if (dest != src) {
+        tcg_out_ext32u(s, dest, src);
+    }
 }
 
 static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg dest, TCGReg src)
-- 
2.34.1


