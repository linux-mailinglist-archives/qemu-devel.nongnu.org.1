Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F143D780D9C
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:10:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05t-000516-VV; Fri, 18 Aug 2023 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoM-0006LM-6I
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoJ-0002w9-T4
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso695417f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692354870; x=1692959670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nNeiD6SgZeYmifVlEyYsY7DIkfofnE8mvMfwnBOhO8U=;
 b=Fd1Kz/SXmHsldOgVG5hyG8rn5EUdKsgOK65eZVoV+vpHCxr860TrAHeTn3sLLnk7Ql
 swLEitKiPTM1Tn9IxxQHkpaXQwPe7skI9QPDapLsyIGz3kcu1dG0SXkb3mm6xZpN3uPl
 BmGOMbK1+tabu+qH01qZsyNA69B73cF+BPNniucu5E5HG70CIKcVbJwCj64QqHHDei6B
 P4A8yYW4fTkIL+8ix/H40A2u8HeJoD+76RCHfiPUSNTXlP6zME6fEN7bP3UmW5gd+6ga
 HThuqLIomMM0bcA5Kw78JZLHFoFLZSg59Um6ZUn/Q6KZDoqjVuwC+ujdxKi1ja8AndnS
 J0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692354870; x=1692959670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNeiD6SgZeYmifVlEyYsY7DIkfofnE8mvMfwnBOhO8U=;
 b=F4/pVto/Sk3yYecBs76L30Htb885CTOSLpdqX/giAmpz7xeCrfqclbegMEstTUAcsS
 9Rp+JVtVwrbL7zkEj9Wh/MnG8todpJcPFp6Vfl6wpDnrH7DeGlQpcjSEW3es3e6sQSIe
 oeEd6zfOFJZxKiDrbBuAlf60XeVFz3JwsLkvgJvXGSa51pjijBdVvBBqvTGN/SeKJkwo
 bFxqsbs+0tjLrry3V7P4pIpeQUPt/4Ydt0JMFMb+RFcUksWXGmmkaEyqOCaMZwQGdnIX
 CGq4i7BAY1tMgRUfHP1SM8ZW5zf3hFrlGqJ0LPG6/cvm5Gz4sgrF+i1miJ5nNjQ2M3qk
 h7DQ==
X-Gm-Message-State: AOJu0YxC8qAN0+09+NVTFOM8Hhk7wovJr4iPxWKgDq3vQ/XrGIManKUr
 iI2UqdajS8/AJw6FEikieZ/XR0rzsnHA8uIp5LY=
X-Google-Smtp-Source: AGHT+IHV7IIjkFmiECTTmexMWdJ+vPgtB7EedLCR/iRE8Gt6mhXvJoFi30WSdWktYkIqceI6Qh9Asg==
X-Received: by 2002:a5d:6511:0:b0:317:e542:80a8 with SMTP id
 x17-20020a5d6511000000b00317e54280a8mr1530856wru.15.1692354869878; 
 Fri, 18 Aug 2023 03:34:29 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.41])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000008400b0030ada01ca78sm2323386wrx.10.2023.08.18.03.34.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 03:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/loongarch: Cleanups in preparation of loongarch32
 support
Date: Fri, 18 Aug 2023 12:34:21 +0200
Message-ID: <20230818103425.16271-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Jiajie, this series contains few notes I took while
reviewing your series adding loongarch32 support [*].

If your series isn't merged, consider rebasing it on
this one.

Regards,

Phil.

[*] https://lore.kernel.org/qemu-devel/20230817093121.1053890-1-gaosong@loongson.cn/

Philippe Mathieu-Daudé (4):
  target/loongarch: Log I/O write accesses to CSR registers
  target/loongarch: Remove duplicated disas_set_info assignment
  target/loongarch: Rename 64-bit specific functions
  target/loongarch: Extract 64-bit specifics to
    loongarch64_cpu_class_init

 target/loongarch/cpu.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

-- 
2.41.0


