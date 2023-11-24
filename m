Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA047F8538
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 21:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6cie-0001nk-O3; Fri, 24 Nov 2023 15:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cic-0001nG-La
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:06 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cib-0004zz-3a
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:06 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2839b922c18so1767213a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700857442; x=1701462242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zol07WndEtzA359SFbV4aOY0NN/F9L7ZSgrocBATYoI=;
 b=ACnox5ifnF8JBuAG2YNXiFhMoRfrkUdZBcavIDrvBYVkpgrH6TWQh8x+6KvuCZk1Xw
 F2NXVVL9wNK9OsA6vdwqIvETYqsDIoICWJsCxVqLMFEHKWOokR/QhO2CBBdG0lezWNRI
 6jUmapVfIHLFLCcNvdGQWjiRaUIQKs7afQQTjjHjgk3yvjN+jP0F69HvLIDFmdvcdvgf
 4CkQi5ettSunDx8mpxNsbxdxl6qHNoEZl6si49/Lmtmzhe3uf8qHgn4lZvT+/ZNgGpx/
 yYtDHIZk/uyZVwDSe3TIKXcd9Cibhh1AZfpIpzPSfaxHQAJ7VK9HV/KaUAIvi1Gg8v3y
 mRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700857442; x=1701462242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zol07WndEtzA359SFbV4aOY0NN/F9L7ZSgrocBATYoI=;
 b=T0fcXRZj/Kq2l/irDcmkuihlrHS0P9R0FF53/FaxqZRrrrbwS3Rs+f27+tA4bXvJ/7
 VAFlJiDnupXwLOOt9sQ4G9QkFEihSTRpeapCVh/obZZpKUaINWcqOq++NZn3zK6QO+H6
 +W6tiveiGvFkTlgbzPPzwV/QlVwLgDbJ7apUkpWLdFafClHP8DkiP4iB18tlrdINXTyI
 Ifs5C79Tv/TFYfavw0TbtYI79eptLUQpRGoS/PzOypENgc7m+BLGZZm/zpbp7CnoquWZ
 HzwYxRDi6N4HGFkqdL4mDOyBvbrND9W2yyBFdWmI1csC8a0daKPe4xaWr/01ecSBGwLc
 y9EA==
X-Gm-Message-State: AOJu0YwDbQD0q9Al1Zul36EGyoAfZqRnQ4rg35vQ1y7vscAh5h5In637
 uDeZOmUUWGqhXT03rnW/VJzrWJsUfGaTxes9oTg=
X-Google-Smtp-Source: AGHT+IGvKmSnCzHVzn0hyr6eY3b8N2SwT40+294DxW6DCX19i3TWyqsj4Rp5Ujp1uuWvijgAFzMIJQ==
X-Received: by 2002:a17:90b:3e86:b0:285:93f0:b2b1 with SMTP id
 rj6-20020a17090b3e8600b0028593f0b2b1mr2739488pjb.38.1700857442589; 
 Fri, 24 Nov 2023 12:24:02 -0800 (PST)
Received: from grind.. ([152.250.131.119]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001c59f23a3fesm3548267plo.251.2023.11.24.12.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 12:24:01 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v12 00/18] riscv: rv64i/rva22u64 CPUs,
 RVA22U64 profile support
Date: Fri, 24 Nov 2023 17:23:35 -0300
Message-ID: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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

This new version contains naming changes suggested by Drew in v11. We're
also eliminating riscv_cpu_validate_zic64b() and open-coding it inside
riscv_cpu_update_named_features() since it's not worth creating a helper
just to do a single assignment.

Patches based on master. 

All patches acked.

Changes from v11:
- patch 3:
  - rename cpu_validate_multi_ext_priv_ver() to cpu_bump_multi_ext_priv_ver()
- patch 6:
  - rename riscv_cpu_validate_named_features() to riscv_cpu_update_named_features()
  - remove riscv_cpu_validate_zic64b()
- v11 link: https://lore.kernel.org/qemu-riscv/20231123185122.1100436-1-dbarboza@ventanamicro.com/ 


Daniel Henrique Barboza (18):
  target/riscv: create TYPE_RISCV_VENDOR_CPU
  target/riscv/tcg: do not use "!generic" CPU checks
  target/riscv/tcg: update priv_ver on user_set extensions
  target/riscv: add rv64i CPU
  target/riscv: add zicbop extension flag
  target/riscv/tcg: add 'zic64b' support
  riscv-qmp-cmds.c: expose named features in cpu_model_expansion
  target/riscv: add rva22u64 profile definition
  target/riscv/kvm: add 'rva22u64' flag as unavailable
  target/riscv/tcg: add user flag for profile support
  target/riscv/tcg: add MISA user options hash
  target/riscv/tcg: add riscv_cpu_write_misa_bit()
  target/riscv/tcg: handle profile MISA bits
  target/riscv/tcg: add hash table insert helpers
  target/riscv/tcg: honor user choice for G MISA bits
  target/riscv/tcg: validate profiles during finalize
  riscv-qmp-cmds.c: add profile flags in cpu-model-expansion
  target/riscv: add 'rva22u64' CPU

 hw/riscv/virt.c               |   5 +
 target/riscv/cpu-qom.h        |   4 +
 target/riscv/cpu.c            | 134 ++++++++++++-
 target/riscv/cpu.h            |  13 ++
 target/riscv/cpu_cfg.h        |   3 +
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/riscv-qmp-cmds.c |  44 ++++-
 target/riscv/tcg/tcg-cpu.c    | 362 ++++++++++++++++++++++++++++++----
 8 files changed, 519 insertions(+), 53 deletions(-)

-- 
2.41.0


