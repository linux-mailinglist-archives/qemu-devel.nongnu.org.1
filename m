Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5D7DD0B8
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:41:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqr9-0002YM-72; Tue, 31 Oct 2023 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qxqr2-0002QG-0x
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:40:32 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qxqqx-0003hY-S9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:40:31 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso238843e87.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698766814; x=1699371614;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sooZYBsZY9M2ZoGuBReyumQl0pKaz5JVreKdWYqqkKI=;
 b=wRei2EWRnjrujWZF/5zHfj3Z3ZT2TkqtB2QEXcgDjCPP2zXrwP+wSY0g3ZUPUF+vzE
 02S4LG5ExSoZMDTGCLXneA0itX8VsvQ65pK1StVMsI3NSTIHXu9F1OmK5aSZbVTSICG5
 xdrvl+oMwPU8Wan3bvguoaDxFERo/10/O1tG2FL+tHVrBWiN6/IW4rkcIMnNJAVagmVQ
 FURhywExzyohWruyPV+B37jZuq6w10nxVssLqj5v5r9bKmFqqt+CanejDQ7iLdB1BJ9B
 TSA9OCG0d1QwsX4LG0gDaQHFAaF4kZq/Q60K/kkP7gWr/tCJY/CppeF6XGO+2jYV21/6
 Vjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766814; x=1699371614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sooZYBsZY9M2ZoGuBReyumQl0pKaz5JVreKdWYqqkKI=;
 b=P/k8JRfYcgrq9fxmNU7XlhYNAh2uvcd9aa9osPl7ms1j+nbBXGj3AzSfM4Z9c6zNpd
 GhLihkKkufbrdv8RMitSGDwpuH+i2OHlrGnOdhGcBDNMHevVP3FlCgLA3qn5cOcHE0ti
 vHqY6pkPfLUalGoh9ckyo16yiT1F7iOgnGYOXdmH5JgKlAinhn7Hwgla8lKVGDcU5Rfx
 6TYVLM3GL8dW02Y6AcvKWT9MVAZZLz7u2zR+v6tGTZMnlEnbYy0V3XslNPejM+d/9mbn
 Cv9cxYOMm9N22JgvBsTawNNQl7Od4x4i1mGYU6WUAFEy1no0vCxnXfVZUnkoH53YGEVI
 2Ghg==
X-Gm-Message-State: AOJu0YyUZonSflgl9kiHdM5IuYdxfFKU4UDAY+R5xYs0SUpeNTfGc0cg
 GnlhN63hK714WIZUgWmdMQcxpLXs+++Iu/m4V387QA==
X-Google-Smtp-Source: AGHT+IF4GDp0r+kkVnA1KZE0IHIcasPX64Me7Az+Pw/c9TnKrailNhdNs4jnWlOV2ZvEsTvHzVg0uQ==
X-Received: by 2002:a05:6512:401d:b0:505:783f:bc65 with SMTP id
 br29-20020a056512401d00b00505783fbc65mr12005010lfb.66.1698766813847; 
 Tue, 31 Oct 2023 08:40:13 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c458c00b003fbe4cecc3bsm2094613wmo.16.2023.10.31.08.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:40:13 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v5 0/5] Support discontinuous PMU counters
Date: Tue, 31 Oct 2023 15:37:12 +0000
Message-ID: <20231031154000.18134-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=rbradford@rivosinc.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Currently the available PMU counters start at HPM3 and run through to
the number specified by the "pmu-num" property. There is no
requirement in the specification that the available counters be
continously numbered. This series add suppport for specifying a
discountinuous range of counters though a "pmu-mask" property.

v5:

* Added more R-B tags
* Make "pmu-num" property directly update "pmu-mask" removing the need
  to store that value.

v4:

* Added more R-B tags (just missing from 4 & 5)
* Added details on how to calculate mask
* Use custom property for "pmu-num" in order to give deprecation warning 
* Special case a zero value for "pmu-num"

v3:

* Use env_archcpu() in csr.c
* Re-added check to enforce deprectated "pmu-num" below limit
* Check that standard counters are not included in mask
* Remove use of MAKE_32BIT_MASK()

v2:

* Use cfg.pmu_mask wherever cfg.pmu_num was used previously
* Deprecate pmu_num property (warning, comment & updated documentation)
* Override default pmu_mask value iff pmu_num changed from default

Rob Bradford (5):
  target/riscv: Propagate error from PMU setup
  target/riscv: Don't assume PMU counters are continuous
  target/riscv: Use existing PMU counter mask in FDT generation
  target/riscv: Add "pmu-mask" property to replace "pmu-num"
  docs/about/deprecated: Document RISC-V "pmu-num" deprecation

 docs/about/deprecated.rst  | 12 ++++++++++++
 hw/riscv/virt.c            |  2 +-
 target/riscv/cpu.c         | 40 +++++++++++++++++++++++++++++++++++++-
 target/riscv/cpu_cfg.h     |  2 +-
 target/riscv/csr.c         |  5 +++--
 target/riscv/machine.c     |  2 +-
 target/riscv/pmu.c         | 34 ++++++++++++++------------------
 target/riscv/pmu.h         |  5 +++--
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++--
 9 files changed, 83 insertions(+), 29 deletions(-)

-- 
2.41.0


