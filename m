Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F57D26F6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtB-00074C-L2; Sun, 22 Oct 2023 19:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht7-00072q-I1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht6-0006hW-1g
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-694ed847889so2136243b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017378; x=1698622178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yydutm4GC4YL//fMbFA0uGJAc/KbeYkkAz+lArCCg2s=;
 b=Y8n9AWN/Fu9mq/YGI8mLzQGXm816Of2pxmZsVQa2XDhknRJDEjeH+/sEgvl6zS9QJO
 dAVajUaK1vrZuXRXA3kTb6eW2TAQgKcqsLJchtkjUEpR2mD0/VkcNZ4I9FqyGWlYkeQc
 pEiHakPBBxOX/5L/UphSCS33+vRorMSHJVKzzHXUyUrdEJsRcAoUSIclnV+E+WnPBEi/
 Yx+Tjktb0N8j4lGISm9r/w/cgaMuLDms0lVdxQV49snufOtdTdpz68PHy2pUfCg88xRp
 384hO8fRNFS2lCCTjfaqQ2xNYogZADIvcLhn5zttR7snjmrE6ReG+BEKGghQDB2VeDYi
 0L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017378; x=1698622178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yydutm4GC4YL//fMbFA0uGJAc/KbeYkkAz+lArCCg2s=;
 b=AavzDMecnszQ++dsiYbqlUYi3oxYaqDKMxScUoYmO8ict5pwwEKpWxkg3MDo/YVcFX
 ze2JiXN2DqZAH+bUMa7ozzXLzDK8wM0/mSkDhUVSdAPcDLLqG/PMHUfLs5gSx8+gOIEz
 h3WHvmtHRL2gI2qyrsDxe8uZGTs0B0wRRhVMs2m2dEqoD5/QindcYvZ74a9ZWrKFQcat
 MCUXAcUAn+MkaLT/XnDI6kRL6ZuDZ7Jt8N8TKSKkagLnqtZzUj72u3TNbhG1/E/K9r+i
 HX04oGov7Xk66UUGiETgkViDD+wX50LGd0KYfmVN9s1Wv0VZyKd7hQg+UJHUgjBjCBs5
 56YQ==
X-Gm-Message-State: AOJu0Yw2B/Ye+gzOw1UwpE3S070+uxnIGedx+gDa97C5W7+GLt0NdfN8
 /LUSCY1oEVnMxPM2qd1V1G1gsMkJ4TLfFKlLBpM=
X-Google-Smtp-Source: AGHT+IGZ1BCmGH761syHNlKmvuKZ6xnwkK2WiLT78c22naS4BeCBhNj0lMQr0BeHSeYhXA9Ro8xbAw==
X-Received: by 2002:a05:6a00:1514:b0:68e:3bc8:17d1 with SMTP id
 q20-20020a056a00151400b0068e3bc817d1mr6277978pfu.29.1698017378714; 
 Sun, 22 Oct 2023 16:29:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 05/94] configs: Enable MTTCG for sparc, sparc64
Date: Sun, 22 Oct 2023 16:28:03 -0700
Message-Id: <20231022232932.80507-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


