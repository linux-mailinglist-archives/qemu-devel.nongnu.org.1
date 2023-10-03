Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4809B7B680A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndeZ-0006Iq-E3; Tue, 03 Oct 2023 07:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qndeW-0006FP-BY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:33:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qndeI-0003aw-DO
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:33:24 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690d8c05784so580453b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 04:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696332788; x=1696937588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NiZ7vJqvElQzqKDhp/TtLIR/cDrMrpjxKuhehjSYWBI=;
 b=Pwxv+qMiu7VTK6btsyKfYKUjWaT9ZkcFCWkwBOF106pymLBlub7eX2oou8EQ/CKQbP
 W68R9vxpK7RgH4mRfhX5dirbNvOqBlmxhz1Hdh5lMJjMMQnhtkOsjTl0rqH6RwBniwk4
 4ChQcU4u6jN7Xwc0jpmSeIOBJNJY7sKLIdmKRW5WBSjLkvyO34W4c6rETKH+gvRZMYf3
 2YH3kXFPJQOp1ipWtfp8q9hwF2uHUHTd9oDu8pJVZPP5lfE+MdRPrrqlIQLdqqHQkEQQ
 5n9QoWDyiiYyG0IuGu7S3SVTPPv6mYZK86ZfUb0527vNRa8zdchkneYqm7/EC/LjDcJs
 p9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696332788; x=1696937588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NiZ7vJqvElQzqKDhp/TtLIR/cDrMrpjxKuhehjSYWBI=;
 b=K7esXIVvV63RSHfoxC1baOgsTs1cIbFkc0ZteEPoxDrrvImQFetMAT4BDIqf1uG6Nz
 0elHFKTD1+ucwC/t5XZWtAYWGL6rvg6z9LG040HOMcSjuemMqxhD//D+vikCkFIrhmuj
 An6ThnvwRmd/QhqO92IGtOD4jONZDnoofafViIoA+S/a2HHpr1Qd2PI4nTdRh77HEq+p
 5I9jKpJy5wJSfN3t2N6LSVE66jqWjDOltxMNipBaxNU1hyxP/lwAJ3okLicOQW4DuCLS
 BW57rM5xWMn1P1t1DdQ+3SGG43j7/U5BoQZQ9RyiGZZCfCGGp+MAqBHkSYsNjJvQ0vGd
 e2Dg==
X-Gm-Message-State: AOJu0YzlOGG6vZmLykNRD4Lgny6fHCkKhNnFKKO16zdrjdKR2TjzylPi
 tcFAGcyG7zYK07uH3gPpfAJaBWaQfSphHsJnrKE=
X-Google-Smtp-Source: AGHT+IFOIJgilFKvwa7fW1McAvy8goxOogSkQqCbMQp7R6ZVDdBEvHDvvHaVUx5LyMsLTGnW/68x4A==
X-Received: by 2002:a05:6a21:7189:b0:161:5bfd:a879 with SMTP id
 wq9-20020a056a21718900b001615bfda879mr10877961pzb.28.1696332787854; 
 Tue, 03 Oct 2023 04:33:07 -0700 (PDT)
Received: from grind.. ([177.94.15.124]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902b60c00b001b850c9d7b3sm1285506pls.249.2023.10.03.04.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 04:33:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] riscv, kvm: support KVM_GET_REG_LIST
Date: Tue,  3 Oct 2023 08:32:57 -0300
Message-ID: <20231003113259.771539-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Starting on Linux 6.6 the QEMU RISC-V KVM driver now supports
KMV_GET_REG_LIST. This API will make it simpler for the QEMU KVM driver
to determine whether a KVM reg is present or not.

We'll use this API to fetch ISA_EXT regs during init(). The current
logic will be put in a legacy() helper and will still be used in case
the host KVM module does not support get-reg-list.

Patch 1 contains error handling changes in kvm_riscv_init_multiext_cfg()
where we're using &error_fatal and errno. 


Daniel Henrique Barboza (2):
  target/riscv/kvm: improve 'init_multiext_cfg' error msg
  target/riscv/kvm: support KVM_GET_REG_LIST

 target/riscv/kvm/kvm-cpu.c | 100 +++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 5 deletions(-)

-- 
2.41.0


