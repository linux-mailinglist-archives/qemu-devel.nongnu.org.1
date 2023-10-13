Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8A7C811C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtP-0001Fu-Uf; Fri, 13 Oct 2023 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsp-0007BX-Mi
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDso-0001d6-64
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso1574046f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187056; x=1697791856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUfJ6AHujyC3dcM/py8cIm/lScQp8ijzvZQxktNYUpY=;
 b=IqG2LHdSr/o39Dmkb5/xWfEW1P9DdmjmAfhfhusdtg9sXPWth5YpAay4nEoiytv0Th
 6r07RygCrZpCKtskQsJwUh1eep9oGpfsI3nbmlRTvUrfzaZbRk8aP53WmJNoPVdMBoYw
 ckPWduzOPTf/aXIkFmvBZnnL4lUCbWVYJWmm/kOZZA1knAWx2Z65ZbZMquhhPajw/Pt7
 nAD9I4Ax9wrQC0jhxHPMh4DRMXiZ/ONoO7fdVaRNpgwnVSmVVMICjDVJcvNwkOFFJngB
 hRsk/k+7SfmFRY5dLjbJ1ocL3JOI/W89Unz/KXszpNPYIvjbSvqBzhrivoWXxrLWt5Cs
 juiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187056; x=1697791856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUfJ6AHujyC3dcM/py8cIm/lScQp8ijzvZQxktNYUpY=;
 b=iCivj9mxyGISxd1fPtl9tdQujhjr656bdsEayioKgcnTGtYDQwHT3dTf8o0RL3Heqd
 025MPZRTwW1J4P2NspNX0uxkFXleY+gI+FFyCkrQwZXUgp+bzfWGnw5mp/A9bpM/WEsE
 9jXXLUJAKdgVWYeTMDbSkHQiIcG9j5jMgHSgbR1lf8XFbHL4cUDGHqK1oNzfWW0cN+Ag
 zpTqmQ4H3UOSUQOGlB59KAyANVWXdNmL2LjAWAs17hUWXFAfvI1kGLQx/KtBBvkGmUMm
 lmIRpiCnsCq2/fljo82IM5z6QG0deIwRozISQsTYdKvta3RBoLj4ebhesSDHlsQ0W8AQ
 EZxw==
X-Gm-Message-State: AOJu0YyrkrkT+6xYhv8hR8KkOi204F8HNMir+k4PoOyjO08p6fx2W1NL
 FYqjXOGzo/SqggXqVckv2BaFzEkiSETqEG61Vc0=
X-Google-Smtp-Source: AGHT+IFPqO0PBgnQhzbvzIP/KLvb+bopmB+ksS2uAmlG7JA8kawgNdA0y7PgQu4c0qXt6xNZixgSbg==
X-Received: by 2002:adf:f0c2:0:b0:32d:9718:b32a with SMTP id
 x2-20020adff0c2000000b0032d9718b32amr2213734wro.0.1697187056529; 
 Fri, 13 Oct 2023 01:50:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:56 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v3 77/78] tests/unit/test-char.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:45 +0300
Message-Id: <59e97c228ba7294798a95e40f2fb20691fc537f1.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/unit/test-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 649fdf64e1..6f5a2c4108 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -70,7 +70,7 @@ static void fe_event(void *opaque, QEMUChrEvent event)
             h->openclose_mismatch = true;
         }
         h->is_open = new_open_state;
-        /* fallthrough */
+        fallthrough;
     default:
         quit = true;
         break;
-- 
2.39.2


