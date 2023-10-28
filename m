Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A837DA917
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFr-0004jv-Dd; Sat, 28 Oct 2023 15:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFY-0004im-Af
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:36 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFW-000471-Js
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:35 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-357ccaf982eso10907545ab.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522333; x=1699127133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zCJMFAqdf2iFGNb4zrA/FuyIMECuUh8qss+ekAKVh8=;
 b=rHWgRTTNOOV3IwTl//jMU/IzPx1vH8gSFQ64l2x0NR32KamLOx6CU+X54rtfp53b4+
 /Opk+Z9Bh8izUlP+aQ2aORxZqtdmt4Y6GXDYQ3NW+dVsonRoM4YDyXHyNZNs0grkXaHw
 sRMIQcLO7Vcz8jsMgPMx8YTR048Qghk5oZfXc8pxn7TZFjwiqe21KOQG+x20HKxFEHT8
 E678PNwJTkLRvaCCyp+60eX3tTxw1/iwjxM5n1ErXDhw6T4mqMu7YRA1W5spU+1k2xHr
 Gea64ykywyA8QLa2fOWrmUOJYNvGU4Pz187l4bChMrlquJwu914bnjX8jK4SFpl25SED
 dEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522333; x=1699127133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zCJMFAqdf2iFGNb4zrA/FuyIMECuUh8qss+ekAKVh8=;
 b=b9Klhq36ykYDG8POXdawyoPhozXIgAi20R6rNavP2buhrO6tqq+JIuxBq2BwPb9cse
 ml5DiGnl0eU3nnJsJXHO3D4ApOZHEgm9NaRrNK7a5f1WZFmkHAlpJKdYwuyzMu+pY3K9
 pmOulEg+g99KkMc3zKqjSnuvaHAcBqFgfAuJWt+bThcqncFeXZDaupW5dICKUYNECM35
 z+13Zsn7dozQejqop5/coVw08s2fFsg2Abz5tZS7iXClbkLsu7EDQf6Jj3NZ4o65zaYp
 O2Yd+uvxvGI4FwR4H7KVAmqLbjImA8mIwWs4qEAXDI04NAg8kMsSNgd0YXa7kGvf9eaa
 SjDg==
X-Gm-Message-State: AOJu0YwvDnqujlFKEHSe3QJTXeKFLndqpWmTe8KGVcDGI2qNbStRaOsK
 RVU382q4+gMawec5MX+vMAI2DDfWNqU9Uj1bAjg=
X-Google-Smtp-Source: AGHT+IEzBD2f8WGNP2BB2Wx+hsgKqSVrBVVLwrRF7oMW7RCSDn6Y2Y/K8jARFtDp4dLAZHZ6pwg2Ow==
X-Received: by 2002:a05:6e02:1e07:b0:357:43a5:acf8 with SMTP id
 g7-20020a056e021e0700b0035743a5acf8mr8466783ila.17.1698522333376; 
 Sat, 28 Oct 2023 12:45:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 10/35] tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
Date: Sat, 28 Oct 2023 12:44:57 -0700
Message-Id: <20231028194522.245170-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
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

... and the inverse, CBZ for TSTEQ.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 55225313ad..0c98c48f68 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1453,6 +1453,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         break;
     case TCG_COND_LT:
     case TCG_COND_GE:
+        /* cmp xN,0; b.mi L -> tbnz xN,63,L */
         if (b_const && b == 0) {
             c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);
             tbit = ext ? 63 : 31;
@@ -1461,6 +1462,13 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         break;
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
+        /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
+        if (b_const && b == UINT32_MAX) {
+            ext = TCG_TYPE_I32;
+            need_cmp = false;
+            break;
+        }
+        /* tst xN,1<<B; b.ne L -> tbnz xN,B,L */
         if (b_const && is_power_of_2(b)) {
             tbit = ctz64(b);
             need_cmp = false;
-- 
2.34.1


