Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB37B7019
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFH-00009S-ED; Tue, 03 Oct 2023 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjFB-0008WE-9x
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:37 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF9-0007Yw-H5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:37 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c4e38483d2so825815a34.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354294; x=1696959094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UMeVyhGh7jILbCVAmdOe0YZNMFUHd4nJ02rgDkF73Q=;
 b=asDp50JyAPWW0zp4lD/hG9ydWCNvT/jJt84D4Cnv5FbeCM7vaoT0VA/40gtm3Qxf4b
 ZkcT0TlvmvLalbNcBjuqkvUzHpUpz0CD4rK63NLIoFgrxkhFsA69QAAFaAW8IZ97JfD3
 rJ3TmROURGP4hNYElorWsgDehcIj0aUeWIkdlCi/xtV7eVAn9G170uLWd8Kc/IwK4zkS
 YaX79pPY1jsIIkQUWcgQ0q7M0wD/fMDrKd+pAH4TTMHmG+nkDkm942CD7SgxHpB3opUE
 nXqiSd/lrOeuNbw45agYJG4jeJiYzxpX745gdMETkIJn3uoNkt/eMEETWxpmeBSwB1YW
 xvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354294; x=1696959094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UMeVyhGh7jILbCVAmdOe0YZNMFUHd4nJ02rgDkF73Q=;
 b=MnOzxU2sFLg49RGHftQNBVLVMH24odf4Vbg02e/xg090FYEl2dTfz4FpMmxgSbCT37
 8GINvuRs35MQ0VW6P74urIUWKSUZOUJOSKCySg2cMrFHhtj3f0mCu/WJulYR6+zIFrsX
 JDZgiuq5JHyYvafW+/AwmOqpug/keecQcJbaScZJ/VriXSLHKbARw5qK2EW86xL1Y7WI
 7MpGRJEDMzjEFkx4V7fNAe1GORqMDsTKOZ45ThsfZuRIJPnjkG0u45Y05n5qIUd860gI
 te8drVp5Oy5lYlIhYtq3tzzk//h6jsbXiTTcD7j/kaQpzQy2ZbadHuVm+bBa5pY2jVpk
 BtbQ==
X-Gm-Message-State: AOJu0YwfHmgaxGw3Z+yi7M+X99NKOJMuYKFEVg8yBaYmOsBqT8jeS/hn
 IRzZ83jQNY6NYqRm3HS0WfogPg3b82A3Jqbn5aY=
X-Google-Smtp-Source: AGHT+IHN+M2N8uv/WLR0FSOkWKGVYsAXy246Sn5/aqOWaw84aG+sOinO7w699h5SvTvwlAd4ptsgmw==
X-Received: by 2002:a05:6358:9184:b0:143:1063:d1f4 with SMTP id
 j4-20020a056358918400b001431063d1f4mr99030rwa.13.1696354294316; 
 Tue, 03 Oct 2023 10:31:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 37/47] exec: Rename target specific page-vary.c ->
 page-vary-target.c
Date: Tue,  3 Oct 2023 10:30:42 -0700
Message-Id: <20231003173052.1601813-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This matches the target agnostic 'page-vary-common.c' counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                       | 2 +-
 meson.build                       | 2 +-
 page-vary.c => page-vary-target.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename page-vary.c => page-vary-target.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f82b78afa8..cb2dbd967e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -141,7 +141,7 @@ F: softmmu/cpus.c
 F: softmmu/watchpoint.c
 F: cpu-common.c
 F: cpu-target.c
-F: page-vary.c
+F: page-vary-target.c
 F: page-vary-common.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
diff --git a/meson.build b/meson.build
index 0760c29857..12df8fe0de 100644
--- a/meson.build
+++ b/meson.build
@@ -3454,7 +3454,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-vary.c'))
+specific_ss.add(files('page-vary-target.c'))
 
 subdir('backends')
 subdir('disas')
diff --git a/page-vary.c b/page-vary-target.c
similarity index 100%
rename from page-vary.c
rename to page-vary-target.c
-- 
2.34.1


