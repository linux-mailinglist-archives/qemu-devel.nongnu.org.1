Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E878D62B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLLw-00029M-T3; Wed, 30 Aug 2023 09:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbLLu-00028Y-Ov
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:35:22 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbLLr-0006AZ-Mk
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:35:22 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57354433a7dso2474063eaf.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693402517; x=1694007317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7zF6NG7YU8/932rrWkJUHHurexVmdOd3x5Kk8VojtM8=;
 b=AgdIQEZNVVp0GUTBgl4ke5LtyoLl0O5+begAtVcc56+LpWBizsmS8eqQ5e9qqJ9z1v
 GmnpNee3LSLVAIhYkcAhdwNeBNKH8+7SVLHq2YRfxIZESmPie2clIcGD6Ccf1YvIk2aA
 JMFJmzmEzVVNkpFvMVr9osoI2pUehZYG22aojh4piH90xpCVVeORXyhZo3PBCsVboHXO
 M+c85wSe+o4vpc1GuzESXv3B3tOmAXAjUojqRk/65ZmRsY/9ktEu2GrSOizgK6lHzeSC
 +NtWaMjORfh8aDUY9IDGFi5WCSah3p9c64yFpktWxRUpb8b88mRFQyPPFXho3WZy+II/
 pztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402517; x=1694007317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zF6NG7YU8/932rrWkJUHHurexVmdOd3x5Kk8VojtM8=;
 b=gDzcFvvnqz/aLCLuyOAJZqhZ1n/J2GUXTie3v+T8PSf+nag7JLrlPCRKqwCTTCJhtM
 vtpwuS9aiv/U+TX+fmlKxzpkhjYJna+TCfbpXHA6/5QpI6dm49mlzMeZPkkujlsEtDnV
 g86pvx9nAtGugV9bcW7xWgFfHCIyBjxbQWqEKx2JZshq0rX3ejNjeTRIJE8rQoowY6Yz
 ctz980/pdDOPyTrc3mMU00sQHzKZTVDxhMKeHi58B9TBFQw7V967Bj/X3pirFhzSKX0T
 K78GcY6UgwRkgV/SOOt789nOMSB/j0No1x+7uijYdH1qyywUcZYlIbn8e5VyRvB549zC
 T/cg==
X-Gm-Message-State: AOJu0Yw0xj2lQ2jM4jlmdbB0QQO0LfnBZWopln+yL/zlMKU99aGvbev4
 qb7ugjKvvRBICmDC7BPtPQryAuUmv5RaO17o7Ag=
X-Google-Smtp-Source: AGHT+IHQDlT6YW3R0RGBvOhuQkbsPHY03NxVfA/XdiyqziCgzw5dR5FeYIGWVI9cBT87NJMhfEcETA==
X-Received: by 2002:a4a:d212:0:b0:571:28d5:2c78 with SMTP id
 c18-20020a4ad212000000b0057128d52c78mr2017548oos.4.1693402516742; 
 Wed, 30 Aug 2023 06:35:16 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 125-20020a4a0383000000b0057346742d82sm5938997ooi.6.2023.08.30.06.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 06:35:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] riscv: fix --enable-debug in riscv-to-apply.next
Date: Wed, 30 Aug 2023 10:35:01 -0300
Message-ID: <20230830133503.711138-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
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

Hi,

This is the second version of the --enable-debug build fix for the
riscv-to-apply.next branch:

https://github.com/alistair23/qemu/tree/riscv-to-apply.next

This implements suggestions from Richard Henderson made in v1. Most
notable difference is that riscv_kvm_aplic_request() was moved to
kvm.c and it's now being declared in kvm_riscv.h.

Changes from v1:
- changed patch order
- patch 1 (former 2):
  - use kvm_enabled() to crop the whole block
- patch 2 (former 1):
  - move riscv_kvm_aplic_request() to kvm_riscv.h
  - use kvm_enabled() to crop the whole block
- v1 link: https://lore.kernel.org/qemu-riscv/20230829122144.464489-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (2):
  hw/riscv/virt.c: fix non-KVM --enable-debug build
  hw/intc/riscv_aplic.c fix non-KVM --enable-debug build

 hw/intc/riscv_aplic.c    | 8 ++------
 hw/riscv/virt.c          | 6 +++---
 target/riscv/kvm.c       | 5 +++++
 target/riscv/kvm_riscv.h | 1 +
 4 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.41.0


