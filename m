Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 807DD7AF470
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlE4p-0003vZ-AT; Tue, 26 Sep 2023 15:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4W-0003sX-0q
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4G-0001IC-E6
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-69101022969so8556821b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695757798; x=1696362598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HzPBEmuEnok55WOWRA9FMNohz7o4qWWWHNBCcutHt+c=;
 b=lULAwm91trXsNBFb7JywlD5/7Wmb4+lCk1fA7HFofDwyPgNp/2wCo3aEb0YyM4lOJl
 jJS3ICvuJ2xiGykikc7JBq6A2bxJMDVDAXDacHJIxT2R9PoVsQflCX/DOh0SY0WasxDL
 44sjrCo0cMpiNZBRZtZz9qjPVRUbErHiPacz9iM34LuyNdM5roKcWAFhVIe3hCzoGI7a
 mLx7CGdNGSEKJ/MOlosoQVge8C3XlL9k5eCAkU7NQFYdfpwrFcs4O3nOkJeDEMLoOTA8
 sk2ll/NHBZp8T8+cy+Wg7EMIVX81YQw/08luSHylP7PV1IblnBYGiXkRPq1xp41tubdi
 EY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757798; x=1696362598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzPBEmuEnok55WOWRA9FMNohz7o4qWWWHNBCcutHt+c=;
 b=ZFI8Uct58by8s50y+kHsIPLccuZteO+amm9Zh3DxMKJiUohWCoU7nUmzOe/5YFsGNw
 2IbCF2ZfMaE2aJnULJmwemKUFHUR7Iped2j2h5+PriIzOo4X8OmyRsq7G+EWEbQb9rZm
 TpMQtOzZU5hwRnc0Jpj877tINLsKKrltdUfeYtbRBRn3S3zkN8LxYldtezQHy7sHx8uU
 QMyB0ZoQNn6sJJV3FQkGD8TELl3GCyQWNCB7/Aq549AuyDJ7BzudG260GAlWizwo00Yc
 8vN7XeQKldr/DhVRWqX5MCjlWaQ6cpWH+IdT0QUliFHoN/ZmZyVd3E5g/q1I6N2cCp4X
 6XnA==
X-Gm-Message-State: AOJu0YwJz+CMQecgmRP1CphXfe+oI+0+AZPgDsTVFGNICjdwYVkAH7Mr
 kF8BKvCO6nGjpacreuZz8ffeKRhOSW7PCokDQTg=
X-Google-Smtp-Source: AGHT+IEr9VSemQDt/lg9p7TTpFR3ePJmlUs2RpicUkAVLtzuV+x+TrRLHbpV6AVtotPk0A8hU4PhpA==
X-Received: by 2002:a05:6a20:2589:b0:15a:f4e:620d with SMTP id
 k9-20020a056a20258900b0015a0f4e620dmr11581743pzd.4.1695757798362; 
 Tue, 26 Sep 2023 12:49:58 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902f68600b001c41e1e9ca7sm11386010plg.215.2023.09.26.12.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:49:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/6] riscv: RVA22U64 profile support
Date: Tue, 26 Sep 2023 16:49:44 -0300
Message-ID: <20230926194951.183767-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Based-on: 20230926183109.165878-1-dbarboza@ventanamicro.com
("[PATCH 0/2] riscv: add extension properties for all cpus")

Hi,

These patches implements the base profile support for qemu-riscv and the
first profile, RVA22U64. 

As discussed in this thread [1] we're aiming for a flag that enables all
mandatory extensions of a profile. Optional extensions were left behind
and must be enabled by hand if desired. Since this is the first profile
we're adding, we'll need to add the base framework as well. 

The RVA22U64 profile was chosen because qemu-riscv implements all its
extensions, both mandatory and optional. That includes 'zicntr' and
'zihpm', which we support for awhile but aren't adverting to userspace.

Other design decisions made:

- disabling a profile flag does nothing, i.e. we won't mass disable
  mandatory extensions of the rva22U64 profile if the user sets
  rva22u64=false;

- profile support for vendor CPUs consists into checking if the CPU
  happens to have the mandatory extensions required for it. In case it
  doesn't we'll error out. This is done to follow the same prerogative
  we always had of not allowing extensions being enabled for vendor
  CPUs;

- the KVM driver doesn't support profiles. In theory we could apply the
  same logic as for the vendor CPUs, but KVM has a long way to go before
  that becomes a factor. We'll revisit this decision when KVM is able to
  support at least one profile.

Patch 5 ("enable profile support for vendor CPUs") needs the following
series to be applied beforehand:

"[PATCH 0/2] riscv: add extension properties for all cpus"

Otherwise we won't be able to add the profile flag to vendor CPUs.

[1] https://lore.kernel.org/qemu-riscv/35a847a1-2720-14ab-61b0-c72d77d5f43b@ventanamicro.com/

Daniel Henrique Barboza (6):
  target/riscv/cpu.c: add zicntr extension flag
  target/riscv/cpu.c: add zihpm extension flag
  target/riscv: add rva22u64 profile definition
  target/riscv/tcg: implement rva22u64 profile
  target/riscv/tcg-cpu.c: enable profile support for vendor CPUs
  target/riscv/kvm: add 'rva22u64' flag as unavailable

 target/riscv/cpu.c         | 25 ++++++++++
 target/riscv/cpu.h         | 10 ++++
 target/riscv/cpu_cfg.h     |  2 +
 target/riscv/kvm/kvm-cpu.c |  5 +-
 target/riscv/tcg/tcg-cpu.c | 98 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 1 deletion(-)

-- 
2.41.0


