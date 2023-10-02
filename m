Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0D7B5575
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKGX-0004bh-P0; Mon, 02 Oct 2023 10:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnKGS-0004ZN-DE
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:51:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnKGQ-0002ip-TJ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:51:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1936717f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696258273; x=1696863073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=co5h75FftertdJKnoFFL8Po50NhDEPJsEDtaOs3GItU=;
 b=RhXPDXKqmyEdfeOrsShlhkUPZdRV3XqJCCOvvXCLvJI0ffjkHYTcqOLfeIri5yU+0b
 WQmNgV6bYmQVHybzjisnVXGXc2GqpfHOvG/G/acJpJfdODW44F6O9kMBF+EQkdWt8Cqn
 /8Z6IlSfOl8mmf5NjmWznU6L2Llfd3Aufd4Z/sLGV6nFUK+2nHMGv55JHrEe/3eGz8qY
 tUTJrGzYeNJVi+8qgUlRWFL4OXHThtmO2+e8KlUG9gatA8/t02eUNBwAP4nAKzxserkL
 HhmsDk6rI4exvW5C6tU7iTetmex+XFuRLTboI/cxYkYEX2TxXPKZ2qaxqNXxGFDmayX4
 nAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258273; x=1696863073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=co5h75FftertdJKnoFFL8Po50NhDEPJsEDtaOs3GItU=;
 b=Pk9kRY0qpbbE77P/djw+HNN5E0EuiaTVPYDlfWQPINMNmD12X2TMcvGKJ2W+S/OVdw
 nyTVT2SHOb7/Jrl2dUNuRghbJzfeHcxaGOrXmAHnBBQe2VUognjg2PcI2ExCq52L4ry4
 F4H9hvcLexZ4JJtbIESzcMS/AZefpYu4+suh0dMDGSZKcd7lN5qEL4HYd+p56RtMGsbz
 Pht7fch8vfKP1cxSVQa2yzl5VJQZtu1wDeR7R92aONBnxfteo6mxV/lAlrpkJDMnkvgl
 oD71VGkttR0nArXFyDrE9UbfASQ6d9oiSZ09ctBc/V0qia4aaMBueoMAkbLGENnsbrvB
 hNnA==
X-Gm-Message-State: AOJu0Yx9tmyttpX2HV+ZNGRFqe1D7IP24wXL0IVT57zH0EVgdRrypzhz
 2hBB4Q+FA6YwLJl0flSxsPofLdxi6GELjwgnK1NhTQ==
X-Google-Smtp-Source: AGHT+IGjhdEfVK+Aetp0PdU+ZgDYNN4tvOtgDVVq/0X4Na1s1zwTfkp8DubsSk876Np/ak7J/TKAtw==
X-Received: by 2002:a5d:4b83:0:b0:314:c6b:b9a2 with SMTP id
 b3-20020a5d4b83000000b003140c6bb9a2mr9949011wrt.13.1696258272952; 
 Mon, 02 Oct 2023 07:51:12 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 11-20020a056000156b00b0032485046055sm10464117wrz.5.2023.10.02.07.51.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:51:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] tests/vm/ubuntu.aarch64: Correct comment about TCG
 specific delay
Date: Mon,  2 Oct 2023 16:51:03 +0200
Message-ID: <20231002145104.52193-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145104.52193-1-philmd@linaro.org>
References: <20231002145104.52193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Wether we use a software MMU or not to set the SSH timeout
isn't really relevant. What we want to know is if we use
a hardware or software accelerator (TCG).
Replace the 'softmmu' mention by 'TCG'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


