Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA1738815
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzEl-0001z6-98; Wed, 21 Jun 2023 10:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qBzEj-0001yQ-KQ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:55:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qBzEh-0006NM-O1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:55:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-666eef03ebdso2472268b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687359306; x=1689951306;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0Rf7uVhnkk9iY0zEaUMWCNAGIV4sHC6oNj06uJ9D1E=;
 b=d3gEagbF4u6TWuCoq7cbeWL5zSWMTw+EXMWVIU5Adunlx9+wbhKEzny5lBFhNh5Gf3
 dM4e4mr/YT8WqxH9UcmdXFlyMBclYoNXSv4ikp0n55grohZITN5IZKYL1xMCCWzxhLLr
 DkGsbkL1oHBgdOnWt/nNwg9Lt8Vjjs+igQIKmBYgHJZLMPe//wQY3tBjJ0hbkpEI/7TM
 4eWCuJodmBhVsJgwviyRPDysk5ojNRdQmB5KEKS9f62i95imhp32pOrJaWZzrPddhHLu
 53S5gEXx52fiWCftD+E8ATGOB0ayiseaneLBZtuy+99+F5wf1yS3ZrAFVheOV/XZvZyN
 zJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687359306; x=1689951306;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0Rf7uVhnkk9iY0zEaUMWCNAGIV4sHC6oNj06uJ9D1E=;
 b=IPVpLDGruQMbZXxsYjXA2+mEp3TUV5FX9ekhruA0550sD3IiYYWyVUjk3NmeB/rSZP
 ORhL1ESjiGIYQ4TDPAkAf20YeQskZD+CWlcgNgoKTrhtXOvKqvn9YiLCcSpSaIDCcMg+
 +8HRlfDRMmCsx2ACheq2ZMTd8f7kGmqyhWdro/32ywsIQDl1EVWAxHgOghd1dT22ZIq4
 gWJBLvezaN+JK5m1Me03G+Xzw+pr0UmNcYt/0TNMoJ0uUy7Qug3uvqS5sVyC9zy1pV0z
 PYjYeg7jjMreCY7WLo8pK66lEwjKgd3AS5zIqV6oL8WAnqLWxXFJpV1zjmw4jlfSWuA2
 m1eg==
X-Gm-Message-State: AC+VfDxfk+pzN3OaKXULRNMMsvUnP7EpBK/KNffrJJKPgVgpjreFPjRO
 yAlg0vIyWGjHqc8S6hWfa1GwviC98Ff97yNFsqg/lz5ZxfclhOA328x9JO7K8gs5ISYcKFb1LmA
 XwT9wIBfjm5EDp+KvpPw4jT+yLvQJ7sF+q/0MquclXp6oD4dOHYYfTbnKJOjTCuDpUrJ81eU/S6
 Ysmtwx
X-Google-Smtp-Source: ACHHUZ7CFLf2dLsam6wadTQj5jpYYPQsRbzfrCYZQESDHh5r6etUg8SeJuzWpu1WzJsKGg7YVvCw7w==
X-Received: by 2002:a05:6a20:734a:b0:122:cb38:636a with SMTP id
 v10-20020a056a20734a00b00122cb38636amr3810669pzc.33.1687359305644; 
 Wed, 21 Jun 2023 07:55:05 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a62a508000000b0066a4e561beesm356762pfm.173.2023.06.21.07.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:55:05 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 atishp@atishpatra.org, vincent.chen@sifive.com, greentime.hu@sifive.com,
 frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v4 0/6] Add RISC-V KVM AIA Support
Date: Wed, 21 Jun 2023 14:54:50 +0000
Message-Id: <20230621145500.25624-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pf1-x433.google.com
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

This series adds support for KVM AIA in RISC-V architecture.

In order to test these patches, we require Linux with KVM AIA support which can
be found in the riscv_kvm_aia_hwaccel_v1 branch at
https://github.com/avpatel/linux.git

---
v4:
- update the linux header by the scripts/update-linux-headers.sh in PATCH1
- remove the checking for "aplic_m" before creating S-mode APLIC device in PATCH2
- add more setting when we initialize the KVM AIA chip in PATCH4
- fix msi message delivery and the APLIC devices emulation in PATCH5
- fix the AIA devices mapping with NUMA enabled in PATCH6
- add "kvm-aia" parameter to sepecify the KVM AIA mode in PATCH6

v3:
- fix typo
- tag the linux-header patch as placeholder

v2:
- rebase to riscv-to-apply.next
- update the linux header by the scripts/update-linux-headers.sh

Yong-Xuan Wang (6):
  update-linux-headers: sync-up header with Linux for KVM AIA support
    placeholder
  target/riscv: support the AIA device emulation with KVM enabled
  target/riscv: check the in-kernel irqchip support
  target/riscv: Create an KVM AIA irqchip
  target/riscv: update APLIC and IMSIC to support KVM AIA
  target/riscv: select KVM AIA in riscv virt machine

 hw/intc/riscv_aplic.c         |  58 +++++--
 hw/intc/riscv_imsic.c         |  26 ++-
 hw/riscv/virt.c               | 297 +++++++++++++++++++++-------------
 include/hw/riscv/virt.h       |   1 +
 linux-headers/asm-riscv/kvm.h | 123 +++++++++++++-
 linux-headers/linux/kvm.h     |   2 +
 target/riscv/kvm.c            | 176 +++++++++++++++++++-
 target/riscv/kvm_riscv.h      |   6 +
 8 files changed, 554 insertions(+), 135 deletions(-)

-- 
2.17.1


