Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F2781193
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39f-0004fR-GO; Fri, 18 Aug 2023 13:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX396-0004BW-MK
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX393-0001Yf-LA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so1425635a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379220; x=1692984020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mDtd+c+3Qy7qT1cETD4DvUtfqEuVRT5+UyNPPIyLIv4=;
 b=qpwnE4mkPEKdVpb9GfEb+T/p4S1qx1egCYbKC6hPYyE0tTIq2cE1UvOTlb+OTPwAOX
 EKNe8tcmmr11KCaQMkg9qUbUisKGzW5HdrnP0Ljs9DnlSpJpButOoziHP+gDkw36e3wJ
 8LCrVlJ185bkxNzJi+fKsuzhi/U8v9ojlfeVvTb6/rmNUb+40zZLtsMriRzs0zuzuDkd
 CT4oxH6+O7rCqEZIfj8wAQxHKw1fGceECn+hrojNopX/quzGVi/gsZzezz/6t8wt118z
 hfKXZRQnOBjySWLlhxUAE0oE2NDJW1AWjZ+2NsjPZtXcFQS2ajZQBONkiE4ceGegI8r4
 9SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379220; x=1692984020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDtd+c+3Qy7qT1cETD4DvUtfqEuVRT5+UyNPPIyLIv4=;
 b=C3gJ7XkgjaEE5DO0PZxfUu0kQ1PA5yyvm+piyRb7tAQsrdEPq+vR/7kXw7s3Dx1rf7
 1KoagNFI2rJ9axEpR1sqk5hVIi81zw1OMP3dAVaoPyE8zuyg7p2xfhekFrzxZUaBYkik
 TD1Q3WYlOnLZuiBFkLIHcxvo58d6uG5vBoMWU6NvaOmgJ6uOY3xyAGDmvSOhl+f8B6x8
 /xICvyYW+6ibTu50bcnfTZLAPOngxPjA3vJX5E9BbI/oFMOe2/PT7PTxLJMO/tmoiRIz
 aosOdRQ8zZFeGmoFIeplIfMy2sojdTSthZOLHIuQX2tdKBteBDdl5yER8S4H8ar9FHgL
 MNFQ==
X-Gm-Message-State: AOJu0YxIYpwulBulvk+tM6bUXuySKTm5kxaIwqRebGp/OZcpM1Meqc81
 vgAFOgz/HPNCLCibGCCHOQCAmD0PlHST2/lUUl4=
X-Google-Smtp-Source: AGHT+IG2F0evyq2bw60x7TibF5Zp1hwCx49M7j7w9ISAYvWu/6u92buNRXU7VBiZcg1WBUtgmOyZpg==
X-Received: by 2002:a17:906:305a:b0:99b:4a29:fb6a with SMTP id
 d26-20020a170906305a00b0099b4a29fb6amr2580541ejd.59.1692379219750; 
 Fri, 18 Aug 2023 10:20:19 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 dt9-20020a170906b78900b0099bcf9c2ec6sm1398869ejb.75.2023.08.18.10.20.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 0/8] target/loongarch: Cleanups in preparation of
 loongarch32 support
Date: Fri, 18 Aug 2023 19:20:08 +0200
Message-ID: <20230818172016.24504-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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
 target/loongarch/cpu.c                  | 62 +++++++++++++++++++------
 target/loongarch/gdbstub.c              | 32 ++++++++++---
 gdb-xml/loongarch-base32.xml            | 45 ++++++++++++++++++
 5 files changed, 132 insertions(+), 21 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

-- 
2.41.0


