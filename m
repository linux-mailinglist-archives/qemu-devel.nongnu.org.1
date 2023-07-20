Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14A75A46A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 04:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMJTj-00053I-Mx; Wed, 19 Jul 2023 22:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1qMJTi-00051M-2E
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:33:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1qMJTf-0002He-J2
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:33:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53482b44007so139668a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689820393; x=1690425193; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gMCSDqq9jfpuaPaJJfarYBWX/LwE9gEQbd0hO1guFQ4=;
 b=LObVdqL0NPkKOEnSTqjIrKi6ttwXBw+dJ1poHw+2yU5ueS7Ivrys07MHKkrEq9jjUm
 y7uYm1GjojB3Tc72JXj08+lxrC0P96Y5wEPLxAGFpUxKoVhiQOCDqCyooOWYZF39O3Yh
 B8mgLOqAVQS+Ze5zHvBuVsfUoXMv6J+Tfc/L4kcomT7XV0BajQTyz8tTpqPWGKuXjlmI
 CpjLsqgRnWhnq5kWOMXINMno7/zOPs+nVSfSMQ6/q5+pqT23jaDK6NIzKUCV6zYlEbek
 IioEhUDZPmgFOpElg1mLT0Sp6NRYjaL2s3yRdh0fohosQPnD+B5yWtM6ubC0kKAgTnfP
 /Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689820393; x=1690425193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMCSDqq9jfpuaPaJJfarYBWX/LwE9gEQbd0hO1guFQ4=;
 b=OixhKk77c5d6+qAdS/UjmbufoL/iTM2n8Q5jH8TdUes+EJnfufJIjyPDlee3Yq0Wo8
 ecNiz0qQYUvqlxOT4B6HY4D6PTq3lLgU/i+vjZXCk5N8fIIzEjRwxL5Mv4EBTqVD8/Ym
 s/5OeTXQXLlg8MFFDXL1BtzbGLbcC/FWQU2217MqWd8GN6SY/6IOiLubSMMml9dgm95w
 nO4IGyB7cfYIndeexITdevWAyMPY3InhgSUVShvqInLbiEXw/d6TDnLtiuvvJi/la88/
 NS8X9M7l4T4p1TLCEWqmAnwGVEyhEW9zu5olAreMk+3xeTddE21Rpyhb7WHI1LA56l/H
 eWGA==
X-Gm-Message-State: ABy/qLa7rV4afhtS9TKwql/NSXuTmfkh0QYlrQ/YFk8cToQBUHgGgIqF
 TfnmbmNvP07YYzsUZWfdihtm9w==
X-Google-Smtp-Source: APBJJlEupnB5i4UdFJEw8LKzn2QRPO99lTiXeZHRNqDSRMGM6rFu2zSqqPgHWPi9CvyrQnraFpTkCQ==
X-Received: by 2002:a05:6a21:329a:b0:134:37bb:89be with SMTP id
 yt26-20020a056a21329a00b0013437bb89bemr3697755pzb.57.1689820393252; 
 Wed, 19 Jul 2023 19:33:13 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001b9e9f191f2sm4692032plp.15.2023.07.19.19.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 19:33:12 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, linux@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 0/5] QEMU RISC-V IOMMU Support
Date: Wed, 19 Jul 2023 19:32:53 -0700
Message-Id: <cover.1689819031.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pg1-x52f.google.com
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

The RISC-V IOMMU specification is now ratified as-per the RISC-V international
process [1]. The latest frozen specifcation can be found at:
https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf

This series introduces a RISC-V IOMMU device emulation implementation with two stage
address translation logic, device and process translation context mapping and queue
interfaces, along with riscv/virt machine bindings (patch 5) and memory attributes
extensions for PASID support (patch 3,4).

This series is based on incremental patches created during RISC-V International IOMMU
Task Group discussions and specification development process, with original series
available in the the maintainer's repository branch [2].

These patches can also be found in the riscv_iommu_v1 branch at:
https://github.com/tjeznach/qemu/tree/riscv_iommu_v1

To test this series, use Linux v6.5-rc2 with RISC-V IOMMU implementation available in
the riscv_iommu_v1 branch at:
https://github.com/tjeznach/linux/tree/riscv_iommu_v1

References:
[1] - https://wiki.riscv.org/display/HOME/Specification+Status
[2] - https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu-20230719

Tomasz Jeznach (5):
  hw/riscv: Introduction of RISC-V IOMMU device
  MAINTAINERS: Add RISC-V IOMMU maintainers
  exec/memtxattr: add process identifier to the transaction attributes
  hw/riscv: IOMMU: use process identifier from transaction attributes.
  hw/riscv: virt: support for RISC-V IOMMU platform device.

 MAINTAINERS                 |    6 +
 hw/riscv/Kconfig            |    4 +
 hw/riscv/meson.build        |    1 +
 hw/riscv/riscv-iommu-bits.h |  749 +++++++++++
 hw/riscv/riscv-iommu-pci.c  |  181 +++
 hw/riscv/riscv-iommu-sys.c  |  123 ++
 hw/riscv/riscv-iommu.c      | 2546 +++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h      |  152 +++
 hw/riscv/trace-events       |   14 +
 hw/riscv/trace.h            |    2 +
 hw/riscv/virt.c             |  100 +-
 include/exec/memattrs.h     |    6 +
 include/hw/riscv/iommu.h    |   40 +
 include/hw/riscv/virt.h     |    3 +
 meson.build                 |    1 +
 15 files changed, 3927 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu-sys.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace-events
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h

-- 
2.34.1


