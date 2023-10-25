Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38E7D78DF
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnZ7-0000v1-83; Wed, 25 Oct 2023 19:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvnYp-0000p4-Fi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:45:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvnYm-0002DS-2Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:45:13 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ca816f868fso1948855ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698277510; x=1698882310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qZObEWmH23gEf0gD4A/JJEaF5amqjvfqII7QlJTB6lQ=;
 b=IHhrz8yBjr5AWpH5hjpeWB1rkR3a9KCQyt5nEl/WBvi/f+tqs8SGFRX4b+0Q/opfHU
 +tO1ED+naJ1UZk5IGA2830wJKI1Bg/4EFqVbH+9s3/WpH8r0Qb/rX20XeqG5+ar1XKbH
 foORfqbNLnB/5RJPqSQL8xUesUaCN7L2zdTZf9ifg1PFSNOONvmMIZfI3/lhKwXPMTkE
 ChbwwxFjoKEv6Z7xalgwSJ2eXzUn4JLRfo8UIlRa9pp4npRtlWQTTVVhgYqSVBLlcvvr
 NqXtMIuwm/sBdq19r+Wt7x7j0qgzuuM8NXKQBBsNHJ0o7JwBQnwi5x6qUWxZhQ/aTmYF
 yFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698277510; x=1698882310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZObEWmH23gEf0gD4A/JJEaF5amqjvfqII7QlJTB6lQ=;
 b=m4iDAaBNSCYLgbAzgU3eHop0L5/boBRqQU63LCwC7yGlYu964DIbG1Zwn0F22UDnVF
 8KwHJZgpAAViy4TYfty4EBDGXuivJ6qAtle17NrUJwRLqOJuwcpp2tqNBTy1S9YEJB2B
 mwfucpEibGg0zTsrxOZTHgyEahjZLHqtfyL9Jt3QGvjbTeqhmeC391gOCyUl9DZ5Ebod
 8ksyAVGgmAmrhPQqBuIs2kC00JjNdcE0anmp9PLd86xaeRcrQfzDhaYFbtA2tsK+6sDx
 C1I0we4XOqtjDekuhvYaIvk1NJMDRDUoYlvhVV9CaaeQg62bXLFVa5N0m2RZTMpB5tp8
 0uGw==
X-Gm-Message-State: AOJu0YyUvc/ZGvdT3Dzz4sp1+iyadOMKpb/kIQg698exACLDVJpErrgO
 w7O9AzAJet99nxz4A4mVqQO/9Wn4GxpdkDZ1bUA=
X-Google-Smtp-Source: AGHT+IF/aELhfU+TJ1KOnGJ414hi8HoVm3rPk5iVjp71D8prwcZ6tCvHzfwYSr3DHOkKU0YMlxgFWg==
X-Received: by 2002:a17:903:22c7:b0:1ca:8e79:53af with SMTP id
 y7-20020a17090322c700b001ca8e7953afmr15828685plg.3.1698277510328; 
 Wed, 25 Oct 2023 16:45:10 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 w14-20020a170902e88e00b001c736746d33sm9738654plg.217.2023.10.25.16.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:45:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 00/10] RVA22U64 profile support
Date: Wed, 25 Oct 2023 20:44:49 -0300
Message-ID: <20231025234459.581697-1-dbarboza@ventanamicro.com>
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

Based-on: 20231023153927.435083-1-dbarboza@ventanamicro.com
("[PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support")

Hi,

This patch contains a change proposed by Drew in v4: document in the
code, in the profile description, our reasoning behind assuming that
QEMU already support all cache related named features/synthetic
extensions.

It also contains a new patch (patch 1). This patch adds support for the
zic64b named feature, which is a fancy way the RVA22U64 spec found to
mandate 64 bytes cache blocks. QEMU already assumes a 64 byte default
value for them, but in v4 we weren't considering the use case where the
user enables the RVA22U64 profile and then happens to change the block
sizes, i.e. a profile violation.

We're implementing it by adding the flag and, if the flag is user (or
profile) set, and we're not using 64 bytes cache blocks (meaning the
user changed the block sizes in the command line), send an user warning
and disable the flag. zic64b is an 'almost extension' in a sense that
we're not adding it in the riscv,isa DT.

I am aware that the existence of these exotic "named features that
aren't real extensions" profile-only flags in QEMU will raise questions
(How will the kernel detect it if we're not writing the riscv,isa DT?
Will it imply that if all cache sizes are 64 then we have a zic64b
system?). We'll add zic64b and any other named feature in the riscv,isa
when/if it makes sense. For now we just want to get RVA22U64 out of the
door as feature-complete as possible.

No other changes made. Patches based on top of:

[PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support

Patches missing acks: patch 1

Changes from v4:
- patch 1 (new):
  - add zic64b support
- patch 2 (former 1):
  - add a comment in the profile definition explaining that QEMU does not
    implement cache  and we consider all cache-related named features as
    always enabled
  - add zic64b in the profile definition
- v4 link: https://lore.kernel.org/qemu-riscv/20231025135001.531224-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (10):
  target/riscv/tcg: add 'zic64b' support
  target/riscv: add rva22u64 profile definition
  target/riscv/kvm: add 'rva22u64' flag as unavailable
  target/riscv/tcg: add user flag for profile support
  target/riscv/tcg: add MISA user options hash
  target/riscv/tcg: add riscv_cpu_write_misa_bit()
  target/riscv/tcg: handle profile MISA bits
  target/riscv/tcg: add hash table insert helpers
  target/riscv/tcg: honor user choice for G MISA bits
  target/riscv/tcg: warn if profile exts are disabled

 target/riscv/cpu.c         |  43 +++++-
 target/riscv/cpu.h         |  15 ++
 target/riscv/cpu_cfg.h     |   1 +
 target/riscv/kvm/kvm-cpu.c |   7 +-
 target/riscv/tcg/tcg-cpu.c | 275 +++++++++++++++++++++++++++++++------
 5 files changed, 296 insertions(+), 45 deletions(-)

-- 
2.41.0


