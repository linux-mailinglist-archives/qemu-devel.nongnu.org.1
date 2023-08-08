Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E580B773745
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzu-0001QX-5M; Mon, 07 Aug 2023 23:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzr-0001OK-VB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzq-0006ay-Jr
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so3555815b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463777; x=1692068577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EwDdAjnwUPowWvaCh4C85jrngqIJ8regtvwyJyUpkk=;
 b=cmyfsx4s5KsAd/fy6+fkyMra+OvBCKCWoGbGe1umVDx6AI7ehKmP/KB73+umRqtfzo
 /C7XqRy4EAPpLkm/mAcSGPZxM2t0HCvHokJjpZ0LNgPXhMabkdKuG+UUD0KGT/CvMRpc
 j+CJgQOnePiAE+uTjS3i8uEpqGijSD9wVxRlKZKe+EUJjgtLJ9cRYnh7ScI6ZN1gjC9z
 C2ze8kCdjEjhyQeXeYWpCq7Oup9ChxRNCh5FWHEPeM/L9urfbbZ6f92runuZfH+7+tPL
 PKb2BfI7PLP99P51JIS3qnQk4KX+jnmLDKOpEGpW67qLjnyBxC06kdcXl6rEhyOMmG57
 1xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463777; x=1692068577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EwDdAjnwUPowWvaCh4C85jrngqIJ8regtvwyJyUpkk=;
 b=C9k1tX3eq0xQFODvVU77CspLew6aaGmoV2kEx+m8PjO8U9LpxomLPY6VwzvJhqtQyF
 R9TdIsKUYVe2m8BPN7hxDCk1LNglgHhecZ3JmkWn+1rH/0gFkx7zRzeyfiKg8eWR/499
 7Y3iU6ekCLJDbz8MtaKgLxz5b8cPP909QlEnqjDFFyV5lvts2z9L2Y4WfbJzUd8mnslw
 VIuO9naLQMYV++ELsDg6Iaru9CTykm7Dv8KlaFKRnlpZWprR3g4p/Ln/61FU64NBEM2j
 IzD7xO6C0RB1S2z4Dmf4E2c0h6dWEeiRLV8xFsVQACDZWMjvVX1DjqDwUhDyo7ZESn6i
 rHUg==
X-Gm-Message-State: AOJu0YzrJMN82kaheRDRnQTEQbqrQwuiqTracHCgUahmI4e+tU0mwgU+
 yLcLzswug+VhLKJkM/Qg8c/wxWOmXIiisekKlPk=
X-Google-Smtp-Source: AGHT+IHSS7BTUtqXqlWCSq1CmAV7VsW/fFL2K2R9UmXCpYTAAbUSzDJp3O+7uTM1j+lD5XB4b6qDzQ==
X-Received: by 2002:a05:6a20:1612:b0:13e:14f9:294d with SMTP id
 l18-20020a056a20161200b0013e14f9294dmr11430325pzj.58.1691463777057; 
 Mon, 07 Aug 2023 20:02:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 6/7] tcg/ppc: Disable USE_REG_TB for Power v3.1
Date: Mon,  7 Aug 2023 20:02:49 -0700
Message-Id: <20230808030250.50602-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With Power v3.1, we have pc-relative addressing and so
do not require a register holding the current TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 01ca5c9f39..63fe4ef995 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -83,7 +83,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_10)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
-- 
2.34.1


