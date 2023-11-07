Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F07E334B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9W-0008Ti-2R; Mon, 06 Nov 2023 21:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9T-0008SJ-6C
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:15 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9R-0005x2-Jp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:14 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5b99bfca064so3408610a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325352; x=1699930152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGxp+u7pgV6arVD2QDQulhnMp/bdkqauCxtRBcuTVJQ=;
 b=VdYuHvb0t5IxTEtPwKCoBQuiDsg/dwReBl7Y1QigLcU6jfMPrFnEvEZplOdmR42LkR
 7YVaj81yO9iyiYnCinHunqqI4iC7B3Jc6Qy90WKUwjDnqKky5sj7jnRrK+Xs/6q0XF/+
 NDoHD2BE4JFwM8TeX6d7Pzbnss47va/Kjy4OxLlmdClJMm2YabfNk9BvHGx8cJEIslMV
 jO1jgIDSkeapn+rZ/XLgibmwC0PuOBDk1SWGOB1W3du/RbzOTPzKzetjuCNL/OsJbkrZ
 Ng1cYa4nnEoWlZ9XQ6wGulDfVPPQzl3W9+enrF1EinRUHh9x5Du7bhCs2N6azgq2zxK2
 vUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325352; x=1699930152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGxp+u7pgV6arVD2QDQulhnMp/bdkqauCxtRBcuTVJQ=;
 b=kwC9bzEXXKar8xNz5DujasgU5ipaTxwbVS9O22ENMX62OGlbYxR3v9dmfK4lGGA840
 WQbUl65nCWWxckahCvJ+NI11YY9CiW6vm95aBIUyZmU3jbM1hKahmac9bM18U8EZI2+P
 2b2u2dMyq0ln2yNGhxWz17NeyOxgjukuU8KP+uXs1MU6FPd61V+xYi1YWsB1q5GQ2juo
 oxRXWiQCVnFweFvaq2vvHXMqBvMSOywuRJdS4AY/boB0AJ1zJ6IQisNxYtVgsYXdA5uA
 eoMoFeIFDDWSB95Sonyatdp5pxHfMYYl0HslP0ehPwobSLSQRQ8bl2NxsPCwikbiu5Pc
 JJnA==
X-Gm-Message-State: AOJu0YxllCs/CvH4G/v0VigmkPKRjn3zr9jMkNBTSfUSs7Z/uL0ZMs20
 wGMj6wGKZ9F2AFnQdKG8+drpYRZjHyO+k4CA+W0=
X-Google-Smtp-Source: AGHT+IHKCc3zPm7hRtcdLWHhF8DIcPChHKzK65CaZNGlDcSDT+7Lor5dbQDT/Cwn3M8xaTNpggn7dQ==
X-Received: by 2002:a05:6a20:8e02:b0:17b:4b61:a8f7 with SMTP id
 y2-20020a056a208e0200b0017b4b61a8f7mr34187315pzj.9.1699325352242; 
 Mon, 06 Nov 2023 18:49:12 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 35/35] tcg/sparc64: Implement tcg_out_extrl_i64_i32
Date: Mon,  6 Nov 2023 18:48:42 -0800
Message-Id: <20231107024842.7650-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Build fix for missing symbol.

Cc: qemu-stable@nongnu.org
Fixes: dad2f2f5af ("tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 19d9df4a09..a91defd0ac 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -529,6 +529,11 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
     tcg_out_ext32u(s, rd, rs);
 }
 
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
 {
     return false;
-- 
2.34.1


