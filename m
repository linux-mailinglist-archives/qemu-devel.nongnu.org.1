Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533E47829C1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:00:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4Vu-0000AZ-BA; Mon, 21 Aug 2023 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Vr-00009p-Lq
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Vp-00011C-6K
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee769fcc3so16203745e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622803; x=1693227603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KgBR8gQV2lgGU70zxpW1e+QFtxeVXReDbInMcX6UyB4=;
 b=RrvIkp+oz3+a3NM0iQB2yrUoZRJ2+fxxuVy5pGou836MiU48d75g62nDrAvQVIVl74
 phkM/5VgytiJdmBNJTm6xnyCBV0V+VExd0CAzcaoEENelw/U/j8aCuWyLvhc5qG6Y5Oo
 gYnzPCus+VA9sSgDCf2txxS0H3XYTDbzm0rkaWC9EvP8zQ8e1L9UbAngIU3DXvCVkFRB
 t5jlmMjAda2nHMyFZQ+ORjRmOXNaWWBqOqkXsBwEYTGLPM5OSB2wU7jq/q/+I3GJl6db
 N3xJGNBL3Gisl5mo3cHB52fq6fNGQ6qt4ce/yWxoOn0UaQo+Yd4rPMwCONdCp3wGhBOB
 mj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622803; x=1693227603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgBR8gQV2lgGU70zxpW1e+QFtxeVXReDbInMcX6UyB4=;
 b=VFIW4Eti1rP5kdw5keJikFD5uJM+4GowhTYV2solmo7zJLPPeWR49Wb7Vt2R3I2CRp
 PcXNxv6HH/j3dFHCL+tnEQN1LxZWzb84QmtlNf4WVU/H2kPM+/skkUBcYGEWBuKcwam6
 eR/BCrLNvLyyLVuHvr8yPYQxl7Q/Bq32Bn4athHyZdc1mXIfeA7bCBL4nlv3zkQTm9eH
 VwPT5ajn9+0EHBOQyp2bIREVcbytjSfteEY30KeCx7QTUe31QWGQMkcXvBf/Dfs/TMjf
 81OiMiO8a70y0I30gNccwhWP2PpMmDZjX/Kw8ivhTcjRz1fAUtztMt0phCKKbmttq7Sm
 0Tyg==
X-Gm-Message-State: AOJu0YzMKYi7JRJKUJjRqAmEMiY4t7W9thjMYNxkIwAmJKuBQSjGwPVN
 rfsS20bf7CtxC9uFtMoZ0YZV2WT4MtiVSVIiIjg=
X-Google-Smtp-Source: AGHT+IFyK8teZuCDXQaxWJAg158rjWrDHYZSc+7aSSGwEN+MHkHWfZoYRhW8629wGDhotCRfnLX//g==
X-Received: by 2002:a1c:7907:0:b0:3fb:be7c:d58a with SMTP id
 l7-20020a1c7907000000b003fbbe7cd58amr5040747wme.26.1692622803316; 
 Mon, 21 Aug 2023 06:00:03 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05600c225300b003fee83ae4a3sm7216401wmm.9.2023.08.21.06.00.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v3 0/8] target/loongarch: Cleanups in preparation of
 loongarch32 support
Date: Mon, 21 Aug 2023 14:59:51 +0200
Message-ID: <20230821125959.28666-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Series fully reviewed.

v3:
- Do not rename loongarch_la464_initfn (rth)
- Added R-b

v2:
- Do no rename loongarch_cpu_get/set_pc (rth)
- Rebased Jiajie's patches for convenience
- Added rth's R-b

Jiajie, this series contains few notes I took while
reviewing your series adding loongarch32 support [*].

If your series isn't merged, consider rebasing it on
this one.

Regards,

Phil.

[*] https://lore.kernel.org/qemu-devel/20230817093121.1053890-1-gaosong@loongson.cn/

Jiajie Chen (3):
  target/loongarch: Add function to check current arch
  target/loongarch: Add new object class for loongarch32 cpus
  target/loongarch: Add GDB support for loongarch32 mode

Philippe Mathieu-Daudé (4):
  target/loongarch: Log I/O write accesses to CSR registers
  target/loongarch: Remove duplicated disas_set_info assignment
  target/loongarch: Introduce abstract TYPE_LOONGARCH64_CPU
  target/loongarch: Extract 64-bit specifics to
    loongarch64_cpu_class_init

Song Gao (1):
  target/loongarch: Fix loongarch_la464_initfn() misses setting LSPW

 configs/targets/loongarch64-softmmu.mak |  2 +-
 target/loongarch/cpu.h                  | 12 +++++
 target/loongarch/cpu.c                  | 60 ++++++++++++++++++++-----
 target/loongarch/gdbstub.c              | 32 ++++++++++---
 gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++
 5 files changed, 131 insertions(+), 20 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

-- 
2.41.0


