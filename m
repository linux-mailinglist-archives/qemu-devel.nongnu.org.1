Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9B9740971
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOjM-0002dB-TT; Wed, 28 Jun 2023 02:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOjK-0002cp-Pe
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:32:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOjJ-0002k5-1A
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:32:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so504900f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687933958; x=1690525958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w/a5B7ueBaDGLM1E0Zx9Ja1fFo71IXXbChenEJIm/yg=;
 b=hywqkcIu+gV8llYI++B+InjuVQB3qyh59ZmIcFNpihTwVEXl21bIK/ChS1hNLm9nap
 ywhfBOcoGWrX6DIVhBwgs9z7p3gVuODDu/ZAPJ6i9LjwqZFvQfLsdB9jMRZRJ1ebbuHw
 1XaCY/lgHQjJl7XUfBUxtOvjicYwMafc5ZZbHMWfEzDU/pguYFIN/oxcT0YTrLiSqKQz
 n6l2eWAd3yuLqHOQv6xivOuLG0Fc6sawyZUPOBzXG48Hz5cpDJ/DJzm6wuNQAECAyA2I
 YBVSiCFZQ0n9rGoPIITAtEHm76o1VJ2wAurYNjCZSuZfGTxEnE9CPhcL3qbnCzwfDKk+
 R9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933958; x=1690525958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/a5B7ueBaDGLM1E0Zx9Ja1fFo71IXXbChenEJIm/yg=;
 b=kB0P803ejilFAiv+oE0oiQsrM0VAeOjI5Fmy74nDZJ8ljuVx5wxyWGJpFaAH0CQYUg
 OpOzq9afIkHGBln3flMoLOz/u2jSLkz0zL8QfHsDgvss38eGTV2Ug/pwEuIVOT22uhbp
 g7hQSvc2SSZIn1j0boQlzmnXtjuRH9JYyjr0hBe/jfiC+4JtGPp0nKEZse+vZkB4OHb5
 7vkYM0DBs1RG3hkRBGMDO/M7Y/IJcQn2Krxdr23Ny/ByMe0iNwyihFRR0MCtnYtNYpIN
 IiPXWZD0fw159/zZRUCANgpICj3q218DU6xRN7ZQaJhxmIctiNe4Pk3r2A0ArACW7e8s
 mgZQ==
X-Gm-Message-State: AC+VfDzZVjoDcKCqlxQi1GexVqjEDHrpEgcp7uyfZPS/Vjljus+rRurx
 MHef2xxx5wwqj1fmcUnqIaacSVUr7WheYrZX1ts=
X-Google-Smtp-Source: ACHHUZ5yNOYbXUg3lpxqEkLwKCMwM4uCRUNIcJvDz+m2hlxkmSWPZunGsc69p1aC9joP9jL3NAtmKQ==
X-Received: by 2002:adf:fa52:0:b0:313:f5ea:44f7 with SMTP id
 y18-20020adffa52000000b00313f5ea44f7mr453961wrr.35.1687933958187; 
 Tue, 27 Jun 2023 23:32:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 cw8-20020a056000090800b00311d8c2561bsm12365018wrb.60.2023.06.27.23.32.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 23:32:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] target/riscv: Misc header cleanups
Date: Wed, 28 Jun 2023 08:32:30 +0200
Message-Id: <20230628063234.32544-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

As requested by Daniel in [1], these patches are extracted from
my "target/riscv: Allow building without TCG (KVM-only so far)"
series and cleanly rebased onto Alistair's riscv-to-apply.next.

[1] https://lore.kernel.org/qemu-devel/59b5b342-8940-5ac1-0cec-8c136c4916d8@ventanamicro.com/
[2] https://lore.kernel.org/qemu-devel/20230626232007.8933-1-philmd@linaro.org/

Philippe Mathieu-Daudé (4):
  target/riscv: Remove unused 'instmap.h' header in translate.c
  target/riscv: Restrict sysemu specific header to user emulation
  target/riscv: Restrict 'rv128' machine to TCG accelerator
  target/riscv: Restrict riscv_cpu_do_interrupt() to sysemu

 target/riscv/cpu.h        |  5 +++--
 target/riscv/cpu.c        | 20 ++++++++++++++------
 target/riscv/cpu_helper.c |  9 ++++-----
 target/riscv/csr.c        |  2 ++
 target/riscv/translate.c  |  1 -
 5 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.38.1


