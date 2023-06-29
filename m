Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240874256A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqUS-0005ok-2b; Thu, 29 Jun 2023 08:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqUQ-0005oZ-GF
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:11:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqUP-00009k-2h
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:11:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so5970985e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688040667; x=1690632667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=crVt0PUYaWefUp4ycq3idc+nQ4l4Rcdpxjf5x3ai73Q=;
 b=sC+6e+eLn4lpngTFneI7nXuDTHPgCw2uYH4qwwSbunP5JybT0ZLKUKcONsePMfd+qH
 sbCBTX1IUce/wUXfmxHRXv9H9bHj4y5JwOUrD4pDEosmmpDm/+YLNKN0FU3jIiAGx8fb
 32fsHJUjTUCgMG2hLlwe+lISsreEXCPKE7BrxU4SVNsarwTA6ZSeNFCbeMX8dEbYWvfo
 tMfhQpzpajbG1VSKWuRdY/u7SRkNpRWIGvFQNAHyrcS+dWD2n+7tpeDZMox+J95XdCAf
 RMFwapf8GHDw8Rzqcw15pOHLtLs5me9YMvRtosSVaZsDqj70Adhc3tkzhajh2NkbTl7/
 ibiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688040667; x=1690632667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crVt0PUYaWefUp4ycq3idc+nQ4l4Rcdpxjf5x3ai73Q=;
 b=ePkAHAu4LaC1ch5DUJnvkqKA4p1C7EsJXX47aFw4Ihk7gdDuDr179RAIq73BiNkHy+
 CKYhuhE4jpaPIB/FIL7HCDJXfBiZUBxD3/PMGb/WsZupwRyWjdSILqO7AiAonUZb03WW
 lCSqrdySatZnWz9rW8jDl1tYTEz3RNd23I31w8vKOmj5bU7ad8PgxhGojwvs0GKVMmTX
 +nMm8K1K9fxzpDjrXGxoHEpfhsPt8IHeGurBIqqA8rHLA4brjyHan5A3DLk/WRNzooJ1
 VjT3V+IJ5g7uPQ3/QDA5hrzaI5dD3tfVzW6lXiw/uGlvrQFhvqRNG7QTAUwAHlsUsoo8
 Bcpw==
X-Gm-Message-State: AC+VfDxH085grQ42CANCbcjiXdJHvS4MEFgkkhimuJrU87+p5cfKLBEX
 Q0mgh0vkCr1+Lt/hhiI/Q2/ZmXg2yRwj2evEH6U=
X-Google-Smtp-Source: ACHHUZ54OJ006myM+UTc9PK+F53fyO8rEC2DUGalkNGm+/29rqP+dsyzycaE72XW3yrXBzr9iDK9+w==
X-Received: by 2002:a7b:ce94:0:b0:3fa:99d6:4798 with SMTP id
 q20-20020a7bce94000000b003fa99d64798mr8601752wmj.37.1688040666824; 
 Thu, 29 Jun 2023 05:11:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a7bcc84000000b003f9c8c6bf53sm16308043wma.13.2023.06.29.05.11.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jun 2023 05:11:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/riscv/virt: Restrict ACLINT to TCG
Date: Thu, 29 Jun 2023 14:11:01 +0200
Message-Id: <20230629121103.87733-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Do not assume !KVM == TCG, restrict ACLINT to TCG.

Philippe Mathieu-Daudé (2):
  hw/riscv/virt: Fix 'controller' typo
  hw/riscv/virt: Restrict ACLINT to TCG

 docs/system/riscv/virt.rst |  1 +
 hw/riscv/virt.c            | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.38.1


