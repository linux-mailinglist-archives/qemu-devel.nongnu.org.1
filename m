Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50972ABCC
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhv-00051W-Nk; Sat, 10 Jun 2023 09:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhu-00050z-A8; Sat, 10 Jun 2023 09:32:42 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhs-0007iC-QR; Sat, 10 Jun 2023 09:32:42 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-39a3f26688bso1143922b6e.2; 
 Sat, 10 Jun 2023 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403959; x=1688995959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SS5SIfljW2U2tVVAfvgmmyBDLj4jl1IRKgCv7ghd2sE=;
 b=GqC63v0Cleyj0uC30954lkiVnCDyMf622HuZL2lCQPJ2Bw8WOPd0jQDMcsGCvAacz0
 rfUcFM047O30Ss9+mLp9XJzGLVxHtNnHzVp8OPCh4is8e1s9Knoxg2mVEXwfGb6TSDtU
 sP/5iqBeZx9Ju6OXthkTB3UxziPMmA3vc1zu31pCb4xoMwT+UnPVlL52qGQoaYTXLobJ
 Tn60xgLQWwvk6yYL0hQlFhMb8fQUp9Z1mzcGks4EWlnifJ6P12QVQoKrPOolLskSHCIC
 XjGfXw0GYO1puMbuZz+i3Ctks1+k6sZ4/GrN6v1zZyHyS9pAkEqWJtPnKQhZGxdkiCw1
 ZaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403959; x=1688995959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SS5SIfljW2U2tVVAfvgmmyBDLj4jl1IRKgCv7ghd2sE=;
 b=ZwEJx+dKpHNYSVd3iupGm7lcdOwKhGlTy5rwQByyZefIkoCqXfv+6w6FXPuAqJGDY/
 doppCak/fi6WhvPLxs6MNGBMSQN6oNH9FwE6iVELy38MFLMlbua7nATEj4VlGmPCMJ6/
 RPodP4q7cWR8TZuxnTkEo+OE3E3Mgu+Wa9RCUHa6tiIue/CypRCeDM4BFf/M+3LbY792
 UkjGrP4xnfsNQlSVGCGTbx7x48eC4ech23XcPPYi3UzJGS6zyb3Yga+VAvBFY6z0cOkZ
 puJciZcQF2wvELsb5pRJAzHeXPfGfLTUEUE3svbE5SBQEiv15x4E0VIUrXHaQF1k6a+z
 L+fQ==
X-Gm-Message-State: AC+VfDyVtbF56WcBaSsy5H1ZTMZKejdf7vNSvUO5L57WduIDw3kq98HH
 LRX1VL2++OGVohXWCYgjoQ3dGpq0uXk=
X-Google-Smtp-Source: ACHHUZ6ekPdWo9t6jYNKI4ta9jeqVdzXeDCZkq9Plfirz8nYr3pFXKTrNKnRjBveXc9gkRoUJzbooQ==
X-Received: by 2002:a05:6808:14c5:b0:39a:c41d:fb30 with SMTP id
 f5-20020a05680814c500b0039ac41dfb30mr999967oiw.39.1686403959020; 
 Sat, 10 Jun 2023 06:32:39 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:38 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 sdicaro@DDCI.com
Subject: [PULL 24/29] target/ppc: Fix decrementer time underflow and infinite
 timer loop
Date: Sat, 10 Jun 2023 10:31:27 -0300
Message-Id: <20230610133132.290703-25-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

It is possible to store a very large value to the decrementer that it
does not raise the decrementer exception so the timer is scheduled, but
the next time value wraps and is treated as in the past.

This can occur if (u64)-1 is stored on a zero-triggered exception, or
(u64)-1 is stored twice on an underflow-triggered exception, for
example.

If such a value is set in DECAR, it gets stored to the decrementer by
the timer function, which then immediately causes another timer, which
hangs QEMU.

Clamp the decrementer to the implemented width, and use that as the
value for the timer calculation, effectively preventing this overflow.

Reported-by: sdicaro@DDCI.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230530131214.373524-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 4e816c68c7..d80b0adc6c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -798,6 +798,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     int64_t signed_decr;
 
     /* Truncate value to decr_width and sign extend for simplicity */
+    value = extract64(value, 0, nr_bits);
+    decr = extract64(decr, 0, nr_bits);
     signed_value = sextract64(value, 0, nr_bits);
     signed_decr = sextract64(decr, 0, nr_bits);
 
-- 
2.40.1


