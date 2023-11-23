Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2B7F56AA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 04:00:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5zvj-0001IE-Eb; Wed, 22 Nov 2023 21:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5zvh-0001Hg-Qt; Wed, 22 Nov 2023 21:59:01 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5zvf-0000NJ-Vj; Wed, 22 Nov 2023 21:59:01 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2839c113cbcso365012a91.3; 
 Wed, 22 Nov 2023 18:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700708338; x=1701313138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6qm69oC4CuPn37LAy9qRgF0oJTdg/Pe4VadNE/HUG6E=;
 b=MwE2poZCaBXTedxA56eEMudo6lmUlrRvJQ9yuyzKootcrLjtBRcyrZzEwwRe3ECbOz
 asiy18ePedQA5feChKSQg8/dLGwTbTNEHQtel2fdCASestCYh16+dJ66TCGRgChdiClS
 yXtHU8T4KP9gpyS2Y/iVz2Q/cf4nh26pr3ZbOvTENY1XiRJaM54O//FzEfVNypa4IC0C
 pjMaqr/BXzqq3LgHVK+75YKz+pl3YetGfvSVopaJVgtSAueJ/O9ZglFybRbek2ud7Bjs
 JhQJO9s7r+jfnYEzhV2lkQH5j3hjfh1Ar1SxfKo6Ismu4PyIM26/OxKw1vgaSWpcHPMg
 1zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700708338; x=1701313138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qm69oC4CuPn37LAy9qRgF0oJTdg/Pe4VadNE/HUG6E=;
 b=ZVIWiwRI9zxeHuuxhYcfOOwnu/iojb/56nEJ18hHLvRV6X3Fqn8c35mq3RQln6J02o
 BsnGxXxIYXwaBp8DkWNu/o6euWtnTCsuMAmz4qS6OyU6w65FiL8AcdPRlZxYG7f4TnaT
 q6JXENmxv77qBwcRBBxmXRNJDyDa2FrJmJUbnecl3j8gS38Kr/Y4SwmRCkL49q3Bp/PG
 wIq+yRmbypLbBHsvuYlwV17OztHaPBQCg+TeXHP3OvjZZTIF2aMFKPCzqIQ2JkfRWnYP
 +MdEoAQgs/9XmD7cw3VywVyDRD07A0KK/HT1hYsCaFXPt5u6c+jcGw4En2nGyg9wnIcS
 R/uA==
X-Gm-Message-State: AOJu0Yz4cQStiGv/yOZiKfqntlCA5wTyMch1cat1iNaRDCe2T4FASnH1
 Z4dJTbyqSjdQe4vXx8AqUCM=
X-Google-Smtp-Source: AGHT+IGXp/ok83m1wOsBRfyOdm17gb5p4f+HMN8/5iKt3qW65mKebxPZHOungyS67IDZyewnH6eLfQ==
X-Received: by 2002:a17:90b:4a04:b0:27d:1376:3ae1 with SMTP id
 kk4-20020a17090b4a0400b0027d13763ae1mr4689399pjb.0.1700708338100; 
 Wed, 22 Nov 2023 18:58:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 br17-20020a17090b0f1100b0027909a8994fsm476743pjb.13.2023.11.22.18.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 18:58:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: marcel.apfelbaum@gmail.com, cbrowy@avery-design.com, its@irrelevant.dk,
 jiewen.yao@intel.com, wilfred.mallawa@wdc.com, Jonathan.Cameron@Huawei.com,
 lukas@wunner.de, hchkuo@avery-design.com.tw, kbusch@kernel.org,
 qemu-devel@nongnu.org, mst@redhat.com
Cc: qemu-block@nongnu.org, alistair23@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 0/3] Initial support for SPDM Responders
Date: Thu, 23 Nov 2023 12:58:44 +1000
Message-ID: <20231123025847.2538863-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The Security Protocol and Data Model (SPDM) Specification defines
messages, data objects, and sequences for performing message exchanges
over a variety of transport and physical media.
 - https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pdf

SPDM currently supports PCIe DOE and MCTP transports, but it can be
extended to support others in the future. This series adds
support to QEMU to connect to an external SPDM instance.

SPDM support can be added to any QEMU device by exposing a
TCP socket to a SPDM server. The server can then implement the SPDM
decoding/encoding support, generally using libspdm [1].

This is similar to how the current TPM implementation works and means
that the heavy lifting of setting up certificate chains, capabilities,
measurements and complex crypto can be done outside QEMU by a well
supported and tested library.

This series implements socket support and exposes SPDM for a NVMe device.

1: https://github.com/DMTF/libspdm

v3:
 - Spelling fixes
 - Support for SPDM-Utils
v2:
 - Add cover letter
 - A few code fixes based on comments
 - Document SPDM-Utils
 - A few tweaks and clarifications to the documentation

Alistair Francis (1):
  hw/pci: Add all Data Object Types defined in PCIe r6.0

Huai-Cheng Kuo (1):
  backends: Initial support for SPDM socket support

Wilfred Mallawa (1):
  hw/nvme: Add SPDM over DOE support

 docs/specs/index.rst         |   1 +
 docs/specs/spdm.rst          | 121 ++++++++++++++++++++
 include/hw/pci/pci_device.h  |   5 +
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  44 +++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  53 +++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 9 files changed, 451 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.42.0


