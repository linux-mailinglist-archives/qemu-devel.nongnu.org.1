Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A67F66AB
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:52:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Enc-0007ri-Um; Thu, 23 Nov 2023 13:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6EnW-0007qa-Fd
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:51:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6EnT-0008FC-O4
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:51:34 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cf6373ce31so8601215ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700765488; x=1701370288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1YNp+4Cx+kEVtJDx/e1YmWMjcChTvtDhDJ8J5a420Fc=;
 b=OD3Ke2s0DvdhWX9x8LD0PXk6zS6O39k5YbP37ItTOSbzyAGY8Kru/AFEjS0Jvlhron
 rgngRAekDcZbT2jajiOrSQx1x7Wt7nnMIQY8dFshTZOszdZ7EHz5OX5HpGJAo/62RBVX
 sT7BKF4pLescrWgggTjuTpE3359XTJnhJyXYE9V3HXrwv7kCno9vawxkid4dGwyvgdtX
 SyRyYL3Gm60Awwj4KhSGT46MOsC9h5g7lry8+hkI4xr/grTksLs9JyY8R4+FnDeNfI2e
 kit3qsRymAm2QxjD778MWRDQ0gm/SX7qWeyz3lja7smdp1yrWFJqMRsl0tvPRfR8OX3f
 +i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765488; x=1701370288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YNp+4Cx+kEVtJDx/e1YmWMjcChTvtDhDJ8J5a420Fc=;
 b=xUBvGPbXR3LUE2INJGGoI1K0H9YZOCnaxtW66qWQFmiKs/U3DZmxiAExxQsl8sOmBJ
 T5vAM0p/OUBNqugJ1Mhk8aNXuuxxLbHUIXzwa4cqitpb1iLnhJffNEGK2/01FW6aAcfs
 xpLGGJ6tGdbYDWjBTpZ4EUml33pfGtLK/lYSweKcqfpyaVmExcr/6HdiFlgkCGWu+KpD
 T/E+1zLW43BuPixkJBvIldY7Dda8jYTl8GEteAi1hA7/rNLW+65kKCdRHblBkgxj64CB
 sX2Hk7g9OaBhwsfRz1NwnM5rRZs+wixIF3FWnshg3RTfuer0voRr7Yqu9Imd2Qcbunot
 p42A==
X-Gm-Message-State: AOJu0YyozE68sy9yw6PSdjOh3vm46FD8hFm6adOeJUSLLyLBU8zVPjnx
 gLszxLcjjVI2Ix16BdiGi87Vby1BVB2IBrPpbZU=
X-Google-Smtp-Source: AGHT+IFCCHA9THkU31k54JLok3/Sf9L0tW5h+mKD1OGiDWx4dXgH0Ao9J9CpucKQvI4fbNCWupJsxA==
X-Received: by 2002:a17:903:2347:b0:1cf:837d:1e59 with SMTP id
 c7-20020a170903234700b001cf837d1e59mr4249364plh.25.1700765488370; 
 Thu, 23 Nov 2023 10:51:28 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001bb1f0605b2sm1662638plz.214.2023.11.23.10.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:51:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v11 00/18] rv64i and rva22u64 CPUs,
 RVA22U64 profile support
Date: Thu, 23 Nov 2023 15:51:04 -0300
Message-ID: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

In this new version we added a new function, riscv_cpu_enable_named_feat(),
to allow profiles to enable named features.

This doesn't have much of an impact for this current work - the only
named feature we're using here is zic64b and the default block size
values already satisfies it.

The reason we're doing this change now is due to the incoming RVA22S64
support. A new named featured called 'svade' will be added for it, and
'svade' is NOT enabled by default in QEMU. Profiles will need to enable
named features to support RVA22S64, so might as well implement this
capability right from the start.

Series based on master.

Patches missing acks: patch 10

Changes from v10:
- patch 10:
  - add riscv_cpu_enable_named_feat()
  - enable named features during cpu_set_profile()
- v10 link: https://lore.kernel.org/qemu-riscv/20231103134629.561732-1-dbarboza@ventanamicro.com/


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
 target/riscv/riscv-qmp-cmds.c |  44 +++-
 target/riscv/tcg/tcg-cpu.c    | 367 ++++++++++++++++++++++++++++++----
 8 files changed, 524 insertions(+), 53 deletions(-)

-- 
2.41.0


