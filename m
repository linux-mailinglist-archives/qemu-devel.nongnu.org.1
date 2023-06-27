Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB173FDE3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9kZ-000481-2U; Tue, 27 Jun 2023 10:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE9kW-00043i-UY
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:32:56 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE9kU-0003fy-P1
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:32:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9920b4d8a89so115552066b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687876372; x=1690468372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZH7thsC3n92/7WslOHqKTBqWIGtsrU49vkIr/rMBeI=;
 b=UoHa58zSTWPBSIx6vApGCo0OAQ+mQUW/b9EAqRNecCLGs6jqISpaZZuPf7U9FXlTB/
 0c0s3J3tMNUnJ8Tdfnhw+QTIdiiWs6WK4cUPpysDYybjSZnTRnjED9X7zY984KIpWzYj
 xX1Di6K8kHUUhpHYNIsq/LMc52eq5poT8e7SQiQVw8Iq43x4QqfGGVp2NjXQKtWDjlVC
 LrPhvm8BxzQE8ifqoMvxw4+1gOLYKFAZVtSAUCgqAL+dkIxbH/yeOxGIVArFiKf2pKel
 HSnHSGA8mgdM7I8jxGOFQXk24bixKdYbRBVNzJ0SYRT5CapGRdI6c1/D7fouVNxPO0vH
 q3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687876372; x=1690468372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZH7thsC3n92/7WslOHqKTBqWIGtsrU49vkIr/rMBeI=;
 b=XfM5cDCPYvcI2biz0jGUZ6PRTCSAIYDjrZMeWXW22FdwkeKM3mCOClGoSZIXw+aOAF
 YkpD2iufe/d61caqk5dWRtWoEYNH3qIl4ixOmKJy8q2LlQjYF74qqGeTwSMqDEK/WgVe
 kmfx1DCwG9BJpKcyTtb1S31m0VtOPXF3wNkrF5mhENimAeD8MrOcr9K6wMPiWSjP8Efy
 stOsGxmHL5VwcccVlS2xyERKMNRK1k1FeKweu1e8fv/wa0HcUr1QWfRHtg3G4bcmYrmv
 860G40IjAXWUwtsGFJMLkXVeV1+R4HFiozodA3+2XGBxmxZBheRF175Axs+usfhkr5Tx
 4V5g==
X-Gm-Message-State: AC+VfDwLFZDKiy2Re5tD/I1lzMgd9ofhmkllCguns40mFtAEfah8knYM
 T4CxK/6UGlE4H6KOFlfduBqwhgzTckmfVRJImc4=
X-Google-Smtp-Source: ACHHUZ7A7HzUwbIUXCeSoeL4VSwApVbanU7CI9HLUXoKxMKjvySy9wU7+TO1DpVnoPIGZMuZDvdqmw==
X-Received: by 2002:a17:907:7f04:b0:991:f6d0:9bc1 with SMTP id
 qf4-20020a1709077f0400b00991f6d09bc1mr3527179ejc.66.1687876372145; 
 Tue, 27 Jun 2023 07:32:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a1709061d0100b0098e1116737csm3915190ejh.24.2023.06.27.07.32.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 07:32:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/2] target/riscv: Only build KVM guest with same wordsize as
 host
Date: Tue, 27 Jun 2023 16:32:35 +0200
Message-Id: <20230627143235.29947-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627143235.29947-1-philmd@linaro.org>
References: <20230627143235.29947-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Per Anup Patel in [*]:

 > Currently, we only support running rv64 guest on rv64 host
 > and rv32 guest on rv32 host.
 >
 > In the future, we might support running rv32 guest on rv64
 > host but as of now we don't see a strong push for it.

Therefore, when only using the KVM accelerator it is pointless
to build qemu-system-riscv32 on a rv64 host (or qemu-system-riscv64
on a rv32 host). Restrict meson to only build the correct binary,
avoiding to waste ressources building unusable code.

[*] https://lore.kernel.org/qemu-devel/CAAhSdy2JeRHeeoEc1XKQhPO3aDz4YKeyQsPT4S8yKJcYTA+AiQ@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 649de244c6..a3ab614235 100644
--- a/meson.build
+++ b/meson.build
@@ -110,8 +110,10 @@ elif cpu in ['ppc', 'ppc64']
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu in ['mips', 'mips64']
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu in ['riscv32', 'riscv64']
-  kvm_targets = ['riscv32-softmmu', 'riscv64-softmmu']
+elif cpu in ['riscv32']
+  kvm_targets = ['riscv32-softmmu']
+elif cpu in ['riscv64']
+  kvm_targets = ['riscv64-softmmu']
 else
   kvm_targets = []
 endif
-- 
2.38.1


