Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3657CB9EF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscWy-0000zc-6u; Tue, 17 Oct 2023 01:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qscWv-0000zL-NR; Tue, 17 Oct 2023 01:22:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qscWu-0000H2-1i; Tue, 17 Oct 2023 01:22:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so2395127b3a.0; 
 Mon, 16 Oct 2023 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697520126; x=1698124926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rIrLUYOqZLx5Y9wX/Wmf4J+RtYC/FYcx+XReZ+Z7moQ=;
 b=Ki9cHieCiwc5PoqCmieTyoE+3Q3T+CZqiYrMFG6o20tnVtv2sd3OVUyZe/m0iSatNA
 y+D3MicHM9AN4JLbOAu+UpqNvDUwoWdRH1T3YZNSlfrCQ3uep30MsMAnaY/sBf4KFPzg
 m+ry2bDQR6iFYKvsRsMF/ykiEQ3+CamReG9lEOdExUCfdjPHKh1nLtzPIA6saMp61UiF
 0iDDLGuKXfidpmmDZJ3jb0+T4dljq9o4zE/4dvWrWHY+cBp5QjEFJrSCCXnOWcRlF8jy
 fpK3prk9dK8mTm6EAJsqlXVeuNGO8RdLWJseQ7dJjvWj66GaDbibRIVQAonVQjHmr/SC
 Q3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697520126; x=1698124926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIrLUYOqZLx5Y9wX/Wmf4J+RtYC/FYcx+XReZ+Z7moQ=;
 b=iyGH0/563z5sg+K8JSRU0QpKnxJ0T8TTV3Y5PqqzLaZsnPn8t/D7opf1wYZsrojqQi
 ynSn8MSDV6Gho1iCd+X8odAgmDzxVAsshGJrxGiIHyl2Ovs0nUvTO3vo/E/IkNnUyqTs
 x5hWp6STLa00QAfywEF3D2sIb7dBzGdszoIzc+2NYgZE5GjS9Rv0PgLE8Ct62rbPwcW5
 +jVVCbMjyLPetBM9dExedq64GTM/eR3TsKo6DUuwvncYxpHRdN4rUfbrrlwhCWSLT9bL
 2rqKsNM3huYNwBT/ZjlsyLlp5NR1PXSPqbm/MbYlzS5aES7i0ckkdNksgCJpli5LUzOP
 pyjw==
X-Gm-Message-State: AOJu0YynYt6gXskrsXxPPImfG05WAFqj9aJqT+nfanGoBfm8ImPQAoOP
 0v+JGlhMeLLKdQLm/OklGHg=
X-Google-Smtp-Source: AGHT+IFtAK/5DIfdwEBM9Yg3RlxoNslwbJIDvYsgpuqsNQfkHhlStCd/qYN2GybV0WKkcxOMORWuww==
X-Received: by 2002:a05:6a00:1891:b0:68e:43ed:d30b with SMTP id
 x17-20020a056a00189100b0068e43edd30bmr1305801pfh.21.1697520126063; 
 Mon, 16 Oct 2023 22:22:06 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t26-20020aa7947a000000b006933e71956dsm477222pfq.9.2023.10.16.22.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 22:22:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: cbrowy@avery-design.com, wilfred.mallawa@wdc.com, mst@redhat.com,
 lukas@wunner.de, kbusch@kernel.org, hchkuo@avery-design.com.tw,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, jiewen.yao@intel.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 qemu-block@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 0/3] Initial support for SPDM Responders
Date: Tue, 17 Oct 2023 15:21:52 +1000
Message-ID: <20231017052155.173577-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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
decoding/encoding support, generally using libspdm [2].

This is similar to how the current TPM implementation works and means
that the heavy lifting of setting up certificate chains, capabilities,
measurements and complex crypto can be done outside QEMU by a well
supported and tested library.

This series implements socket support and exposes SPDM for a NVMe device.

2: https://github.com/DMTF/libspdm

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
 docs/specs/spdm.rst          | 114 ++++++++++++++++++
 include/hw/pci/pci_device.h  |   5 +
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  44 +++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  53 +++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 9 files changed, 444 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.41.0


