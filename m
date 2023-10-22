Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDC7D215C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW4-0000Vb-3l; Sun, 22 Oct 2023 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVy-0000NL-32
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:42 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVu-0001Uc-Ro
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:40 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1e993765c1bso1704004fac.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954437; x=1698559237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=AlYg2q8I30aJZ/PSwhKyohGf+rU15DlOLc2vH78s/BIcKZGv1/MEhMV2p2MrpUgpst
 wGoJrldnNB37f5bx4O0OS9gFL/XWaGUlHh7FWZaqywPUo5Wg4sezhDVa7z2VPYcfPUg9
 I09NHvaFdJq0M+6cYBFl1HV9pVhMUwVP01F5P06xBdJzZBvTm1aJOXA9koXKtwpajTKT
 MV1x++hvb+PxRuy5vsmhmILsHqxIpnL7HxU6THgsOzUBCPr8O0qrqQEzg0IQLZhQvCYj
 LEsfR+pX72cUQf3vb8cIHnRXzaP9o4w/OzoPc5L67DhXZVCmxBBMZS4kIWu4sDROok/F
 nHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954437; x=1698559237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=hiN4U+2N+sM6LvNq0Hgvfs6E6gwsKOb7QOXzV/QEiU0lIvDtD3MytUqUDUOHraV43l
 rUtVtDDNcvzeof9QcnLuriSPZ2byKNIZ8DG33Vy/7U9HaEHiaqXvq80taupwLPH5+rZh
 uIa88Suw3n//L92AfKomndyol07QKz6v8Htzaakm3vESBYuN6SIgNg6RRj0WD7dsmwaa
 rEYmhNCu2XAM5FVvk+DNLxT7FuUsTbROn38459CrDskUw3AWj1DcfW5tM/kQVXQ0QMKK
 V5dJ1B+73aY76K5OvupwC+fuJfaWjviqpbDJZBpGfYDxcbmFVpWwYFk85PnHr5VI5iVS
 Igjw==
X-Gm-Message-State: AOJu0Yw7bxSO13wllQ7aqicBgLMnKL58QonvkWqq37cs4p//tD3SonxQ
 zLwbI3rXQJGz5wnMGL6K02ibVdgIAyOi5jl9fB8=
X-Google-Smtp-Source: AGHT+IGrTU6dTl1otmoatNFeF1L1rlkcObhXCnq6CgVUYp69A59lti1sDyNTv8YOy0BQhPhghTpirA==
X-Received: by 2002:a05:6871:b405:b0:1e9:8780:a0e with SMTP id
 br5-20020a056871b40500b001e987800a0emr5123477oac.28.1697954437329; 
 Sat, 21 Oct 2023 23:00:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 05/90] configs: Enable MTTCG for sparc, sparc64
Date: Sat, 21 Oct 2023 22:59:06 -0700
Message-Id: <20231022060031.490251-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

This will be of small comfort to sparc64, because both
sun4u and sun4v board models force max_cpus = 1.
But it does enable actual smp for sparc32 sun4m.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/sparc-softmmu.mak   | 1 +
 configs/targets/sparc64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 454eb35499..a5d9200382 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d3f8a3b710..36ca64ec41 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
-- 
2.34.1


