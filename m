Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA47E1F4B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:05:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxPD-00069c-67; Mon, 06 Nov 2023 06:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxOm-000644-K1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:04 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxOk-0003gS-Ly
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:04 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c5629fdbf8so53865771fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268640; x=1699873440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPtEnXMJWXTavrW+hTGrjLz6IdGpJzROhuSvymabGIo=;
 b=p9co09EvtEhyV+0iMFvP8l/SD6Zri4nNAVsabpDWHywl4jXrqKB48H3ttuYAKNrMFy
 LQ1VkvMJEYiEWlOMZauNo763B0962SlMVQ+YqXHuA/6lhz6jBZ+/3QUZRDM4ZSXTYnMC
 ESKPz+t+8v0S+8t+UVtw4tYcmJeTf7rIPB4exwjgWSBglgYwktNRwX9fTubURCf+eOSK
 CBjmG2kMoFf4rlH6XFR2N70fhK3pjbqBv7KulUNcm+UoiLVD7V5D/xH2CIxL37ghkM9b
 aM8QVK4xi0qHMsZGSCaDzwMEAsLl5arOzatiiOGbvYtXpsvE0b2boP12YIRhiWTgbyAv
 cu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268640; x=1699873440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPtEnXMJWXTavrW+hTGrjLz6IdGpJzROhuSvymabGIo=;
 b=cQKIiiJR+59ECXpAZ1n2HK0RNKAkQA62zB5X+NZDqp9zX3NJ1BYrcI4P/cDOK1765T
 X7nIRQ2PMsA9fTjSxFfZPaVkrstjSY61pNRJtHXLO20wjHhItdlr/POLXZ2P3aeNlBA/
 wjKu8klrUDOikdLuAAx5bUZzvYkHiEgsxddE9svYbjS3x3SC/aUPzFTslHK9e1juwU3P
 sYL2xmRholJAq9kiHQS4EvGsxG9/QhMajkrBe37KAlhTnkX+IQmrgbHX/SsAWzlruQwI
 OuYVHRz/DtiUbHr57JjibYvJhskVHhS/KLs84MRVYRsuOyJofXug/n5Crkeq2rHCqhS5
 c/cg==
X-Gm-Message-State: AOJu0Yx3w6NTJ0irz2b13kz8ndkZ6YoMVugBUQA/7xv8JndIOAY48Qtx
 yGvmvZ08XezwpnNEOhMxwfkeOX/tY+zB/ytgXfI=
X-Google-Smtp-Source: AGHT+IHnmaFN+GKLxd2N49xPwJp/PkOfW8YFcpTs0zHKDnkUPvcBfxvj2jLWyUiBIPgGTifMjl5zjg==
X-Received: by 2002:a05:6512:1282:b0:505:6ede:20a9 with SMTP id
 u2-20020a056512128200b005056ede20a9mr26978590lfs.65.1699268640437; 
 Mon, 06 Nov 2023 03:04:00 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 l10-20020adff48a000000b0032fdcbfb093sm19447wro.81.2023.11.06.03.03.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:04:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/60] tests/vm/ubuntu.aarch64: Correct comment about TCG
 specific delay
Date: Mon,  6 Nov 2023 12:02:35 +0100
Message-ID: <20231106110336.358-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Wether we use a software MMU or not to set the SSH timeout
isn't really relevant. What we want to know is if we use
a hardware or software accelerator (TCG).
Replace the 'softmmu' mention by 'TCG'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231002145104.52193-2-philmd@linaro.org>
---
 tests/vm/ubuntu.aarch64 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
index 666947393b..eeda281f87 100755
--- a/tests/vm/ubuntu.aarch64
+++ b/tests/vm/ubuntu.aarch64
@@ -25,7 +25,7 @@ DEFAULT_CONFIG = {
                      "apt-get install -y libfdt-dev pkg-config language-pack-en ninja-build",
     # We increase beyond the default time since during boot
     # it can take some time (many seconds) to log into the VM
-    # especially using softmmu.
+    # especially using TCG.
     'ssh_timeout'  : 60,
 }
 
-- 
2.41.0


