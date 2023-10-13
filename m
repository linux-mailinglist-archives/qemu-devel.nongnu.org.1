Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692F7C8C21
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgW-0001UY-Hs; Fri, 13 Oct 2023 13:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgD-00014N-Ey
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgB-0005bw-Gb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso846407b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217026; x=1697821826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgo3sS5iUyrU0Dzdzk24htDnmRxHdeX5tUMGq3kg/oc=;
 b=Kv4v9X9Q4Do3lxi26xKka4Ss23qZ0qiM+hgcKc93YUCPeqLsHRNfB+rkVF1Cbs0JSL
 Hvph/Bva6mRCraGRK1J2d2ARvvi5SqLXFt5NityvZ75cMnLH7tPS+gZuLWvONWk+w0Li
 1DLgQMTnHdIteHeeUzcRfZo6GfA0dtoH5AIIMPaGR6TQkqYyPJDbxTbTqOxMHN9R8Nva
 ID5RlCUzn0jnQDz8PLYwO77TfInP6VEYljxY/eg7jRSD7CFtkqz93k3sx6QESfZ9mnyK
 qSXyDqfIDWAVeaKADC+q4JV1kcEYP3Bc4OWNr5P/UZAf/RFbUcul/ZUI9nFOP9ZpAP0D
 sMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217026; x=1697821826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgo3sS5iUyrU0Dzdzk24htDnmRxHdeX5tUMGq3kg/oc=;
 b=qn6PWHYElVrrxW54Fy2PpmlXbaV5rJQMoMtSB6S7A1cCrF9Nl+TzDw1JD/prmNG6zP
 +oL5KLnkNWA/dmpt/rkzsqVa5fxYbnj7TcMLzYroQIeIBBSQOfGT3UCEbnVi2C6IwAQ6
 tDrIlZZY0q80wk/4/F8tQsQA777AaLUhyjOERo5dT1i3yWCaBVM78ha7RK7nTjKfRy6v
 YldVEy/6j/ZX3RaX4tOVboTghwjNaZ1DtQ05PESfVJQiAa2e+0O0B+57pxZcNpVgjhFr
 7RCNutfbS2k1xK1oPRCqWN+MmnBm8tLLKRM9cq47KNtXiJU+U+GtUZ6U794V8vwDC3Gq
 aAuw==
X-Gm-Message-State: AOJu0YzRY4pOMHwNsmUlt8iR75g0YOJp5lEG06MFnJaBQRS6Ws/hH9RT
 f/1kyw3J3q3zPgdWFIaEkQ0bfSPs1JPlGipW7DY=
X-Google-Smtp-Source: AGHT+IHNBWbRHhkVTHBp/ZpTd9jnS8Z/giJKnVj29qbPpPTCoCywijxrtw3o7Un7XmgQo1uLsur+2Q==
X-Received: by 2002:a05:6a00:1946:b0:691:21:d9b9 with SMTP id
 s6-20020a056a00194600b006910021d9b9mr25707931pfk.30.1697217025784; 
 Fri, 13 Oct 2023 10:10:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 13/13] tcg/ppc: Disable TCG_REG_TB for Power9/Power10
Date: Fri, 13 Oct 2023 10:10:12 -0700
Message-Id: <20231013171012.122980-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

This appears to slightly improve performance on power9/10.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6496f76e41..c31da4da9d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -83,7 +83,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_00)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
-- 
2.34.1


