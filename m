Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F198E785B3E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpHh-0006q1-TT; Wed, 23 Aug 2023 10:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHX-0006pO-Pq
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:29 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHW-0007cG-2K
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:27 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ff8cf11b90so8988419e87.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802584; x=1693407384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCK2VK8xRH2D9lhMRhXp0tgYAA1ZvGcHBcKuN6vO5TM=;
 b=KTGplDGqi2ppZYDvJqr8S/TDHTwHpwrqV1kwV5e5zcNcpp6BdYAmJHQtRxKpA25EYS
 oYqnnS8O+H2QbwsOH9cZ8KvdwTO3RP8xwEqjWzRPK7AhakO17DKlvOudwuuOq7rSNfSQ
 p/hLhkoxFUWWUQ6KP5Du5mAZAunm0nAsntAal04AnibwCI0kmTNziGW7gWywEwliZKgZ
 Z/NG+QfppITAg2fmhYEDQRVYD89/C6/APl1VyuerEGTWnLbfuumNuzZzfw4wRZX+V6Gw
 +bdGAAFSQqteXiWhyZPMXafIySLWVSbRB256CoFhT/LZ5YtqPdKgc8E3ur9hE5/WJlOf
 YGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802584; x=1693407384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCK2VK8xRH2D9lhMRhXp0tgYAA1ZvGcHBcKuN6vO5TM=;
 b=A0HkhpbaFzGATkPXnYbeaExU1Q1upvsexilaDDJYUeTOi4S1+qZuA13gnN63x2ntBA
 SSW+2uznBP/YHUSKQGhun5mNo3tEFrNbqyAuC+1ltBYsXT09nHsB3MrTGDyGGqRU8X1O
 p/3iHfOHpjDiID8zLVnXYYJiVi8kcws3RBFCgNmo0N/IDNjsbK92mImgu0YFKCFQYDRO
 uLvTCUjTobi8duv4+cwB3dI86OjXHux6xAIX+PVGpLdGELiAmhFXEdwAfMiPE08N6mJl
 MA1uO8NNJVMKDyBUltULoM1lvn2ZXjp/iHCOyCWW9ujO81w5lKX4ljodZeHTxYhvlb7i
 izeA==
X-Gm-Message-State: AOJu0YzxvzF20333whcFup4A2HkxrfS6h5UmjpKijfbaEAEH9F02X1CA
 Ws7SAqGZmbMrzusNoC/5TZ4qVADcmZzEgPjkJ1Bjqg==
X-Google-Smtp-Source: AGHT+IHgsOnnrHLP2+LPv8OnJ680iZ3yYk5wOEpbWBRs1CwzjgYN6eycKPGZTg/S/dUySe0UsBOOOg==
X-Received: by 2002:a05:6512:3241:b0:4fd:f889:b9d2 with SMTP id
 c1-20020a056512324100b004fdf889b9d2mr7928402lfr.38.1692802583919; 
 Wed, 23 Aug 2023 07:56:23 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 v15-20020a170906564f00b0099cbe71f3b5sm9808961ejr.0.2023.08.23.07.56.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:56:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/8] tcg/tcg-op: Document wswap_i64() byte pattern
Date: Wed, 23 Aug 2023 16:55:41 +0200
Message-ID: <20230823145542.79633-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Document wswap_i64(), added in commit 46be8425ff
("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 94134981a9..65a2e5462e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1926,6 +1926,11 @@ void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_temp_free_i64(t1);
 }
 
+/*
+ * wswap_i64: Swap 32-bit words within a 64-bit value.
+ *
+ * Byte pattern:  wswap_i64(abcdefgh) -> efghabcd
+ */
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     /* Swapping 2 32-bit elements is a rotate. */
-- 
2.41.0


