Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B050925682
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 11:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwAU-0006r5-2F; Wed, 03 Jul 2024 05:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOwAO-0006pM-Ci; Wed, 03 Jul 2024 05:20:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOwAJ-0000dV-3B; Wed, 03 Jul 2024 05:20:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fafc9e07f8so10617935ad.0; 
 Wed, 03 Jul 2024 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719998437; x=1720603237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NudA2bhXuzFAzawwdhUAK7Y2RKTZD0qNB2Y5Jdgr6hE=;
 b=Xk2VIJuBGlC8tgZ4i7ZgfJ5du0MlsDC+c93Y4jtKVlZuCDHdGsPLWAmX6L0NW02CK1
 aNVuUa+E6kccMTg9lTPDJ+uIzCZrwlrAZQ0LZytqnq/jcvWhWujoyUJHjwHlSZeXqVO1
 6+XF173bGwxgnZarSpV7yj+TbiUaj0tc1dnBTRciyx97IH65Mg4jstKX43KLApE0A8HN
 TMEQ8U8OjdZFe5Qh0H6wDe7XdrDjXXO5J7ihDtDSZra/wxTuZlFb2UyU/dnGE/0vha6a
 nNRvWtSUil061Z7bZij7xtUST9lsIdGBvJhKigglsYFP2eJYq8EUbcxNDLmXXGX+fujA
 jMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719998437; x=1720603237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NudA2bhXuzFAzawwdhUAK7Y2RKTZD0qNB2Y5Jdgr6hE=;
 b=T5MWsFTaRaRY9VQCLgEzoYe1H2ikJscpeE7txsZO3fT0YHEx1clfakATLcNH7SxeRE
 AkUP9j3y/zHpsYE5sTOqT4wbx01zQit7ztSbw0AE4FSxXi9/ODqX437UW7+7uPfBSSj0
 2EuNBtES08AHnfIK4E9V+MZViiQZzz/U0j/ROtgS9UN5jSsuQuaIeuZL1NoOhhTKnHiU
 76EG2XafmL8cos8dmPEvf1d7btl3drGh2qUVgw4NEB/C1zNaWeEBUKZzBJ4dF0akZ7Cm
 c39qTyhPAPnTOSN6RBzmi89BhVaiUG2JpMzC+Mk5q4hotmpEZ+5ZpYQXCqznKOQZwJcg
 2Q2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHsr/9Er/bui2gfFrWVSjb1/jWYzJjf9Zv+VY0gv8KUAI7bU8tJaIxv1f+xTXB4IgzdGNeGmg/qNdrT4vLRot8b66zfO3Fh95YZyTbxYusGBklQXM48rZ5GhwvQ==
X-Gm-Message-State: AOJu0YwT0wGyqYOEcDfwF1GkPUIhk0bOehzVTqwpGy8YWjYDWFoN2W0X
 KXQil2Qm11svhp4Q//+iAC4a+72FAMn2ydrOWxebRVZvXuFWl5F0
X-Google-Smtp-Source: AGHT+IFWISOGU+SXRGwU97x58vgVmAYCDTXOVz2nVpCO5nbjsaHts8TfcKkCVC0XDwK8kh0E3jhFRg==
X-Received: by 2002:a17:90a:d490:b0:2c9:74cc:1c1b with SMTP id
 98e67ed59e1d1-2c974cc1d03mr1483051a91.7.1719998436914; 
 Wed, 03 Jul 2024 02:20:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c95ca64649sm2905596a91.13.2024.07.03.02.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:20:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: its@irrelevant.dk, mst@redhat.com, hchkuo@avery-design.com.tw,
 wilfred.mallawa@wdc.com, jiewen.yao@intel.com, marcel.apfelbaum@gmail.com,
 lukas@wunner.de, cbrowy@avery-design.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@Huawei.com, kbusch@kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>, alistair23@gmail.com,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>
Subject: [PATCH v8 0/3] Initial support for SPDM Responders
Date: Wed,  3 Jul 2024 19:20:24 +1000
Message-ID: <20240703092027.644758-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v8:
 - Fixup i386 failures (thanks to Wilfred)
 - Passes CI on GitLab: https://gitlab.com/alistair23/qemu/-/tree/mainline/alistair/spdm-socket.next?ref_type=heads
v7:
 - Fixup checkpatch failures
 - Fixup test failures
 - Rename port name to be clearer
v6:
 - Add documentation to public functions
 - Rename socket variable to spdm_socket
 - Don't override errp
 - Correctly return false from nvme_init_pci() on error
v5:
 - Update MAINTAINERS
v4:
 - Rebase
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

 MAINTAINERS                  |   6 +
 docs/specs/index.rst         |   1 +
 docs/specs/spdm.rst          | 134 ++++++++++++++++++++++
 include/hw/pci/pci_device.h  |   7 ++
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  74 ++++++++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  62 ++++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 10 files changed, 511 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.45.2


