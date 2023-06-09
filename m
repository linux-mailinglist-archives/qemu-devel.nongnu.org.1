Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF30729766
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZgK-0007sA-Qa; Fri, 09 Jun 2023 06:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZgG-0007eX-WC
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZgF-0001fl-3f
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4e01fso15736085e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307757; x=1688899757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iI5ptmUqgf+ZHh9E8VNQoCOoxRYRE0F/uCzecezl5/c=;
 b=GngLhJ1U7E6czmZno7bgq8DmPuWAn3zV+Gs4MpfzZRD8IWnZLneZb3mA/YXtu9p1AQ
 4SXJ9KBjU0w+BbopzHxyru9jWPjNst0yImMsDyWcga58HDov2Twurnmfx0AoVb5K/umJ
 F1J7B6zmNBIoCqjD2eSLAVSClIH5QVLLVUt6PS8xoyFgaIc8ET878c07lJbDv7pFfDK3
 qE9N+axzFT1uNvjsWsPB4B3FxqCwaiswf1L+jf3STaie/UPU7VgwjmPGnycOrIXy4jX1
 19OQupDMNeUoS3DH2sLXWTHnAO2bEnwItH27pDzH1sw1EHqp240EnCBINg1CFdGrxu+H
 Xigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307757; x=1688899757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iI5ptmUqgf+ZHh9E8VNQoCOoxRYRE0F/uCzecezl5/c=;
 b=dxona3YokWl0IFdTanmHps2tjtLQMj/eP/2nHa1fkfVdI2daunLvbMxIAWU8kngRCS
 x/nmyUgtsbAaZ8N7a20Hnn4m0cU1xWh98Ahln4asSsaZBSDz9nVXxR3953HVOlVOjVXf
 4cHaqi/awJzfZGZf8Uks+dvvkhQleWjdOK1Sta8jr8F9uXjJTr+m2i11xAaI/JFKirwG
 stX1DaCgAVBrSBcOXm3Vw+zzI08idVt4L7bJ6kHGA79WZD/M283o8kH1XaPE1dJbtQlZ
 It/Imn8rB76nx2NKV9FNRbMMhDj+57m7guKu0x5yAL9mVlUdCTs1WHo+YlmE0y8M2tLe
 +5Ew==
X-Gm-Message-State: AC+VfDzDb3Y2sQIF8uYToi9ZJ1dOimVeesHfrjaLKDAE2no9TIFrylvI
 xuCfid2L6RKo/scIR9mGVzKkCkpu6Q15ktvmQRZxVw==
X-Google-Smtp-Source: ACHHUZ4AzjH78VEapdVj80ScH8vveLxzQCVVbdH8DQXynbQtFCs22Lh5JKEWKUwsmYr2G1RKOX2odw==
X-Received: by 2002:a05:600c:2901:b0:3f7:39ed:c9a4 with SMTP id
 i1-20020a05600c290100b003f739edc9a4mr937814wmd.30.1686307757574; 
 Fri, 09 Jun 2023 03:49:17 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a05600c224700b003f60a9ccd34sm2273519wmm.37.2023.06.09.03.49.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:49:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/22] target/arm/tcg: Define SME set_svcr() helper in common
 'helper.h'
Date: Fri,  9 Jun 2023 12:47:13 +0200
Message-Id: <20230609104717.95555-19-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

SME set_svcr() is called by handle_msr_i() in translate-a64.c.
To be able to restrict helper-sme.h.inc to SME-specific files,
move the set_svcr() helper definition into the common helper.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 1 +
 target/arm/tcg/helper-sme.h.inc | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 4e431c2116..5471d6e5d0 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -558,5 +558,6 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
+DEF_HELPER_FLAGS_3(set_svcr, TCG_CALL_NO_RWG, void, env, i32, i32) /* SME */
 #include "tcg/helper-sme.h.inc"
 #endif
diff --git a/target/arm/tcg/helper-sme.h.inc b/target/arm/tcg/helper-sme.h.inc
index 27eef49a11..b53b691f70 100644
--- a/target/arm/tcg/helper-sme.h.inc
+++ b/target/arm/tcg/helper-sme.h.inc
@@ -17,8 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-DEF_HELPER_FLAGS_3(set_svcr, TCG_CALL_NO_RWG, void, env, i32, i32)
-
 DEF_HELPER_FLAGS_3(sme_zero, TCG_CALL_NO_RWG, void, env, i32, i32)
 
 /* Move to/from vertical array slices, i.e. columns, so 'c'.  */
-- 
2.38.1


