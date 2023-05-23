Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4F70DF04
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVl-0003Pd-Ls; Tue, 23 May 2023 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVg-0003Jo-KE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVd-0004DW-Sg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso5247265b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850224; x=1687442224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVDQIGY4qsUIGLjKLkOyu6DlKk1Y53Q32bQuvC8FPMo=;
 b=Gfo5Mq9oqnvG3omtXeOo5euI8B5NPnOUzxpGpygWe7r8NYdvEYLwdzI4c8j5OwcNQF
 +spGaXgamHb8qNGjGnjCWqXqubCOPtmdidP9EmSxIl2UCiXCiJViio/SxqO//Sq3Lvpu
 GQvrsFvEpkmbL4ufW37cp/1HkBvxmJG5jqAELDP2OdVNnYbhnFYrwOUcUywEKl9LxKM9
 HRQWK79sogW7aPbxBXT1wen7d1Ldvz/pDUvsEvA4Q/68kmsKzf2w2Yk7JoRwOMyotHsO
 BblOIy1NlH8INx1smasl9PyqBIUPR7kNSyGJXghiwo+M+EL8Pj7gFDYYrojUnLx+grEF
 MDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850224; x=1687442224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVDQIGY4qsUIGLjKLkOyu6DlKk1Y53Q32bQuvC8FPMo=;
 b=WGlHmBBMU4TMWFmMeRRwxJdtuSmzpTVgUu1vHp5vSuNEwDz4pxycaFTO8c7l0DKf9F
 2JrAKRLwM3beWEIIr8924YSrQ9Dp+shA5GsgyYEXIQwAyIxnGfcNBxUf7pemEye4r7rs
 7wDhoPOOwA3Coin1pJ1sVGEIe3RDg3BGIU+48Y4tD0G5hj5wI+CYMsvcG5AFEjFeR+VV
 XmOSkT7CQFIerILoSY3b8LizQG3Xt2HSRtU4w0twzF7xqJoNEARm+sv6mQBHs7/xjkej
 ctFazD0zUHaYIneH+KGNLdolzHkQHz28oOHJTCLKYDXqVTVE4/2sKXs2gk0ZfcxekqGR
 hY9w==
X-Gm-Message-State: AC+VfDxtRcQlvjHA3MlzVccA4rpmjNIBug8/3ZpZPHvuAXmwSneVUWTz
 6DRWKc70d6CBv5+Ngvoz0RG1rN/rRL+S0LGKgCQ=
X-Google-Smtp-Source: ACHHUZ4sIK5mu79TEUIm0/Rs+5bjmIY/0nwW2hyc53AKQsE+skH5Gu/tRgVNLdPGcvDC3g4trzxc+g==
X-Received: by 2002:a05:6a00:9a7:b0:64c:9972:f74b with SMTP id
 u39-20020a056a0009a700b0064c9972f74bmr18915049pfg.12.1684850224642; 
 Tue, 23 May 2023 06:57:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 50/52] plugins: Drop unused headers from exec/plugin-gen.h
Date: Tue, 23 May 2023 06:53:20 -0700
Message-Id: <20230523135322.678948-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Two headers are not required for the rest of the
contents of plugin-gen.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index e9a976f815..52828781bc 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -12,8 +12,6 @@
 #ifndef QEMU_PLUGIN_GEN_H
 #define QEMU_PLUGIN_GEN_H
 
-#include "exec/cpu_ldst.h"
-#include "qemu/plugin.h"
 #include "tcg/tcg.h"
 
 struct DisasContextBase;
-- 
2.34.1


