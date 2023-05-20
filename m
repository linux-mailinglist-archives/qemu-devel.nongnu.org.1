Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EBE70A5C2
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 07:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FPO-0007Kl-SD; Sat, 20 May 2023 01:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FP5-0007DP-BX
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FP1-0007bZ-Ez
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3078a3f3b5fso3931347f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684561513; x=1687153513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KPXfjzpgnUnJ+Ee8FGyGU5PT2PYy9bLcVqwty/Mu0pM=;
 b=Dnz2plYFZml0O3yiwpZx1EGdqBt8yOEnk2d7diFjU5vaTepF36k1HmsJtaz/qqvZrN
 jtm/ZFDLMOnUHh+rQLFayybsshVlvYCnJGgqps0ZqvJ6foTIHnJwxiX1dJdX5eLfuEqd
 njcBQM9AcatDe+Pmfjf3fD8kmOiJcn+S82bPeNeZh0n9ElwgEhKJAGAD2EADNj/yAfu+
 5THTUe3Raa1+qIFH6gi3cvhacIIj/T6SSkXnwd5gtc/biS2B3jQ6/eDRDnkngWeRfEMf
 qBRTHir6v7LYIHzEkFF5SNtWnFdXfSBHqxj5kGZ9hU0Vh4lNe6hDdLSAcovR0uxFV2/L
 qKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684561513; x=1687153513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPXfjzpgnUnJ+Ee8FGyGU5PT2PYy9bLcVqwty/Mu0pM=;
 b=cytNoNVGH+FjMOrI66deTKCt5lrn+kKU0DWX6ETPytC67fYqIOU5q2yCVKWmjDwjFq
 3xFwWyac6SigPug5UmT87Z2kohTltIm+P+pCofOHnxcJULBjFVyEBZhzX6EiVDvaEaqK
 iCMGThDA3zvmASkeB+Xm3uH4RdNbcNiTUbesh2wJr9ULXILWnHMgnzSBWFosMjK3ZtDD
 lZFwumxbSTcWtaG+XMpYTa/CQjTxYNOqIegRCLIm9oE63jQvAeWm8lYpea6xTi/Uj1A+
 yuVMQJ+uwZhlP+jnEjNg0Q5f+8mY3DTNW2Ci3HhlNuANeSAAB6ZPSUlMQW1tJuElzPgD
 zSZA==
X-Gm-Message-State: AC+VfDwv+326zGY61U6OhJ1arim7p9F3aRdlWpDfIEO5EaEyBrObmBTM
 yibR0wbPiWZcmEGlEm995/MLM5BcoHnwHQ52VjQ=
X-Google-Smtp-Source: ACHHUZ55a40q1IxRIUR9v8HNNTTLN1tCbGBVHpqg9tdZz8WQiu0FJnZacv3D9Qdd/61azHwJFFJUVw==
X-Received: by 2002:a05:6000:1109:b0:304:79c1:725d with SMTP id
 z9-20020a056000110900b0030479c1725dmr2953422wrw.45.1684561513260; 
 Fri, 19 May 2023 22:45:13 -0700 (PDT)
Received: from localhost.localdomain
 (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a5d5390000000b00301a351a8d6sm879335wrv.84.2023.05.19.22.45.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 May 2023 22:45:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] hw/riscv/opentitan: Correct QOM type/size of
 OpenTitanState
Date: Sat, 20 May 2023 07:45:05 +0200
Message-Id: <20230520054510.68822-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi,

This series fix a QOM issue with the OpenTitanState
structure, noticed while auditing QOM relations globally.

All patches are trivial to review.

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  hw/riscv/opentitan: Rename machine_[class]_init() functions
  hw/riscv/opentitan: Declare QOM types using DEFINE_TYPES() macro
  hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE definition
  hw/riscv/opentitan: Explicit machine type definition
  hw/riscv/opentitan: Correct OpenTitanState parent type/size

 include/hw/riscv/opentitan.h |  6 +++++-
 hw/riscv/opentitan.c         | 38 +++++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.38.1


