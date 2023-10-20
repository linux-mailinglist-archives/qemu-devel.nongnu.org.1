Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263D7D1943
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 00:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtyA2-0003u4-IF; Fri, 20 Oct 2023 18:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyA0-0003tm-W7
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qty9w-0007Re-I6
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c77449a6daso10989455ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697841598; x=1698446398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CUgxWJvoCV75ts5pYI02r9ovyh/2AeM8pLq0WxwIt9Y=;
 b=JkSW6ZR6YEZLo2gj9yAktbsn8l0EQ6UL2cBsPJPDCJK3lRQ3QWdITnw+dPWEJEE4TP
 MzgoqaaQtxv8rMHxkL4lN88mvqscKNFFW9LFaJPJLLT8KggEoyn7z6rMN5EK5UrYBT0B
 hm0evazbuIm7+CjxuAnC6+X5006f3oDEIQRzU8GnME2gjxBiJSWuuXJSR9wukPRReX6w
 NTV8Ja029LbPPfPE6B3Qd7Y8GTNqbGEGwpEyxEp9/cyJ3WUI5eKWLSFsXfuAHQWKySaJ
 4krv5dlwxX6rfznCiCZUXM1KFyH4Eo7O18etg7ZDx60ZRh8dsJhK3MAME6DiFg17F8Mo
 4F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697841598; x=1698446398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUgxWJvoCV75ts5pYI02r9ovyh/2AeM8pLq0WxwIt9Y=;
 b=Nly1Zo2rLejPCM07tQBdiPU4oaNFLDUI5yRWydmT+LRQjJiUu5vhWOURkzLHge6UHN
 27HcvJkrPVHDTESeCq5zXYIY9lu7T9Bk9B16M3HTmGYVA5cGDJulf4x4B4CNbzJD1anv
 HuNJ51smNUxcanZNSL7F7ls+55RRtVdmK2ZUB734zLo5uQB82U4TNdzDinwnfyBjIUzs
 MKILglCzX7e2ouLKjSiuFUhHwTLe6K1iJaPHDLs9/XHomfLn71suqOHmKSb+ab2kKOXY
 Jm4XcAaeDPgOVUYOBfjASbQG7TxsQLcYdqqUoILnnsPSZp+JBxCL0J60VMGsLkTnGW8O
 o6mg==
X-Gm-Message-State: AOJu0Yzy3ama09AT2mm4Oz0hhxmOIQXISH7l0+qOphAtVLVGjfuGJWVi
 P6xUlHy9nEfSfoQyXrkLWPZso8EyQvcUrPtl/6o=
X-Google-Smtp-Source: AGHT+IFWMA1yMKSGt+8l9aRRNghPbYnWWt4wNyV4ug3+3WMYmaFILrmehmJna3RGGr5PCSVRVYiKnw==
X-Received: by 2002:a17:903:4111:b0:1c4:3cd5:4298 with SMTP id
 r17-20020a170903411100b001c43cd54298mr2892462pld.18.1697841598568; 
 Fri, 20 Oct 2023 15:39:58 -0700 (PDT)
Received: from grind.. ([177.45.186.249]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170902704100b001c61921d4d2sm1992373plt.302.2023.10.20.15.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 15:39:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/6] riscv: RVA22U64 profile support
Date: Fri, 20 Oct 2023 19:39:45 -0300
Message-ID: <20231020223951.357513-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Based-on: 20231017221226.136764-1-dbarboza@ventanamicro.com
("[PATCH v2 0/6] riscv: zicntr/zihpm flags and disable support")

Hi,

The most notable change in this new version is that we're back to
enabling/disabling profile extensions during the property set()
callback, instead of doing an extra step during realize(), to give more
predictability on how profiles can interact with each other.

In the previous version profiles would be committed based on a fixed
internal order. This time they'll be evaluated via the common
left-to-right ordering we're used to in QEMU. This means that these
two configurations are different:

-cpu rv64,profileA=true,profileB=false
"enable all mandatory extensions of profile A, then disable all
mandatory extensions of profile B"

-cpu rv64,profileB=false,profileA=true
"disable all mandatory extensions of profile B, then enable all
mandatory extensions of profile A"

We're also adding an user warning if a profile is disabled. Between
implementing profile disablement (disable all its mandatory extensions)
versus not implementing it and having a flag that does nothing if the
user set it to 'off', we're choosing the least of two ills with the
former. However, given that it is a very niche feature that is hard to
use it right and very easy to do something silly, an user warning is
appropriate.

Series is based on top of the zicntr/zihpm implementation series since
they're both part of the rva22u64 profile.

Patches missing acks: 3, 6

Changes from v2:
- patches 1 and 2 from v2: moved to a separated series
- patches 6, 9 and 10 from v2: dropped
- patch 3:
  - use the set() callback to enable/disable mandatory profile
    extensions
- patch 6:
   - handle profile MISA bits in the profile set() callback
- v2 link: https://lore.kernel.org/qemu-riscv/20231006132134.1135297-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (6):
  target/riscv: add rva22u64 profile definition
  target/riscv/kvm: add 'rva22u64' flag as unavailable
  target/riscv/tcg: add user flag for profile support
  target/riscv/tcg: add MISA user options hash
  target/riscv/tcg: add riscv_cpu_write_misa_bit()
  target/riscv/tcg: handle profile MISA bits

 target/riscv/cpu.c         |  20 +++++++
 target/riscv/cpu.h         |  12 ++++
 target/riscv/kvm/kvm-cpu.c |   7 ++-
 target/riscv/tcg/tcg-cpu.c | 118 ++++++++++++++++++++++++++++++++-----
 4 files changed, 142 insertions(+), 15 deletions(-)

-- 
2.41.0


