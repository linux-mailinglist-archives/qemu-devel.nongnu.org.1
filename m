Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825047BE781
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 19:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptqW-0004D4-Pf; Mon, 09 Oct 2023 13:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qptqJ-0004CC-MH
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:14:56 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qptqD-0001CX-Uk
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:14:53 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a645e54806so813736666b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696871686; x=1697476486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KzU0IA4oHgcBoi9bCTt4xxer7uMuIwqY1uCrBxn/OHo=;
 b=mTS2vlp59Uj0L4kzRupFz0gTlag5puXv4DenymBTW0v3ksYt1tiUypbxlIXPg4ttz9
 C/sONIuNVyZTAanFbOkK3i47eiH/tQU2E2IjzWJWuK8XSm55NgEyguIXNZ9x2AHPpCnW
 Pu+de7tbvx1c2r09yjDvl3w48S4sEE1VucIJbsaINBOvJvEw1XNVPolGGS1RgsHjBwxB
 +FGK31Y8wcVTinbo2gqs9Lv6G/8MNufcdTO5Z+ALzv0xZPfeok5ukIS+JKtGpa2RPch6
 eEb+XcgDFcquN45yNzhsarBjf4b6BFoZ0oUOvlNEiS9hlDQFt8BY+ig1YXg3zGtOVFZT
 q+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696871686; x=1697476486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzU0IA4oHgcBoi9bCTt4xxer7uMuIwqY1uCrBxn/OHo=;
 b=tVbcjA0KPNpqNuVmbI/ChkP33Wf855eAoSl2ENxNheXCJpa45o30q3elK4bqPz0FLT
 PHnfm3k8DqhSv+CQNeik9x549gv3MKFO1Sc35xgJOHtxJiDPb9LiVEQ7BXNLzpmFs91A
 Q8Nh9AbLHeBlea/olcCb+5wv1ZTpHKoV01ei4rcqsbfzAilDPgYfQHbbR9snejJsxxfK
 /kwAO4wQYmbeYena+OTo31FuNZxrmian+v26woC1jP/tEQuVTQ6X0wuJBEU6SDX1aQER
 D+W3m1QPBa2sksZSnxNQK/P2kOsJPgjE6e8wehbjJhArynfvMr3fuzcxRgqpJCmu4YBH
 LmHg==
X-Gm-Message-State: AOJu0Yzey+jW21w50reWl+3hDKomEvjXyBrUyLiZtU+1vmjUwwzRD8uD
 3BxuZYYebE7MZSjYZIroi7LvDcmyc4IQ+W7+4ME=
X-Google-Smtp-Source: AGHT+IGeReqrfLFBXoWt5PCnL+Lr4ljqQYX93ifwaq2r2Dai5aJehuV/bgbvw9WLBJogupy86n2FRQ==
X-Received: by 2002:a17:907:7711:b0:9b2:a96c:9290 with SMTP id
 kw17-20020a170907771100b009b2a96c9290mr14187130ejc.33.1696871686501; 
 Mon, 09 Oct 2023 10:14:46 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 p26-20020a1709060dda00b0099bc08862b6sm7123316eji.171.2023.10.09.10.14.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 10:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 0/3] hw/mips: Cleanup in preparation of heterogenous prototype
Date: Mon,  9 Oct 2023 19:14:40 +0200
Message-ID: <20231009171443.12145-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Prepare few MIPS hardware to be integrated in a
heterogeneous machine:
- Restrict MIPS-specific HW declaration to target/mips/
- Replace MIPSCPU by ArchCPU in common HW

Philippe Mathieu-Daudé (3):
  hw/mips: Merge 'hw/mips/cpudevs.h' with 'target/mips/cpu.h'
  hw/misc/mips_itu: Declare itc_reconfigure() in 'hw/misc/mips_itu.h'
  hw/misc/mips_itu: Make MIPSITUState target agnostic

 include/hw/mips/cpudevs.h           | 14 --------------
 include/hw/misc/mips_itu.h          |  4 +++-
 target/mips/cpu.h                   |  7 +++----
 hw/mips/cps.c                       |  1 -
 hw/mips/fuloong2e.c                 |  1 -
 hw/mips/jazz.c                      |  1 -
 hw/mips/loongson3_virt.c            |  1 -
 hw/mips/malta.c                     |  1 -
 hw/mips/mips_int.c                  |  1 -
 hw/mips/mipssim.c                   |  1 -
 hw/misc/mips_itu.c                  |  4 ++--
 target/mips/sysemu/cp0_timer.c      |  1 -
 target/mips/tcg/sysemu/cp0_helper.c |  1 +
 target/mips/tcg/sysemu/tlb_helper.c |  1 -
 14 files changed, 9 insertions(+), 30 deletions(-)
 delete mode 100644 include/hw/mips/cpudevs.h

-- 
2.41.0


