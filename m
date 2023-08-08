Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7623773B8C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:52:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOzo-0000Wn-VT; Tue, 08 Aug 2023 11:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTOzn-0000WM-0s
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:51:43 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTOzl-00030C-B3
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:51:42 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4475ae93951so2154420137.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691509900; x=1692114700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/8yucf72COLZmIoE+TDSCJmW+NOR7pmvuGmLoGLDx+o=;
 b=ew0ujJCHlQwUI4oRIxKpza5tIqj8hS9tKcPf+7z5DblJjvZo535Umk/+KqXqGroG2l
 vSguNlLIhczU6FCjco2BTsfmAFzDs+BY7XUtZsibRptBDKVHFYrFghp1K51WDbhEU2kr
 icCRIoFrQjx1RSKhYU58Zzwh8jusTlwWzlQKro1BPFvYM1haV/blY68ohMibnY8OX5wg
 5IfDEyPScOC6qqGTAf2xHrkbGZcyIVrjzjRx0k2K/ygz5x4r3yP9UbNxaXUX3c0XpM9Z
 OmMAArrcr/rfNq8SBQAYGnLJWMs3kLspTBHir5eI3AApdx55/G7uySWdRgYyb7UhawyT
 jY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691509900; x=1692114700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/8yucf72COLZmIoE+TDSCJmW+NOR7pmvuGmLoGLDx+o=;
 b=ltOJuNGV81gVlaL8sJXln3qUSD9VQGDeo+hRYZ1WYbSHCI99i2cJUiPDHnWM8hr0e5
 zyhBJJd9dv2dPqiV3DJXs+umGSz7ayp/2aQX5y7v+AAIA93Bf5aBgIrX12acdbQmP20A
 tzfq0VLiAMWsrhOI7S0pFwZ0wO05aiYTysX1IOViTp1thb7kTEgIJ5yLo9PQF0N93xMr
 Tp1YCZ5n86UEoG/l4V/HlxWAsm5tPBu7/q51wKLLO5zS9dg9Q/sExhivPlpi8SMsY3iw
 xK7SjPWaoShGROAPhBbNarnaXKEdPrwytCad13B3b90PSl/9Bcuf+60cjp6C4IArh9Uw
 1v9Q==
X-Gm-Message-State: AOJu0YwhxrC+kRc/AQTypAXrbbVpJc5zXLbdEUQZNts9wWbJ63EmBW/R
 nVzwwebBwEFXjw0faY6hUPKGp37JbUvvuCOGuDk8Og==
X-Google-Smtp-Source: AGHT+IFLQTOrCL4EFjj+I+2D3yq791qOSj/d6CE+UF/fZWw2zFz9cUEh/ynKHXFdVk0T99IfCGaNHw==
X-Received: by 2002:a67:fb04:0:b0:447:8fb5:c0c2 with SMTP id
 d4-20020a67fb04000000b004478fb5c0c2mr208412vsr.32.1691509899837; 
 Tue, 08 Aug 2023 08:51:39 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a67ca11000000b004409e21cf23sm2013324vsk.6.2023.08.08.08.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:51:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v1 0/3]  Initial support for SPDM
Date: Tue,  8 Aug 2023 11:51:21 -0400
Message-ID: <cover.1691509717.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

This series is a very initial start on adding SPDM support to QEMU.

This series uses libspdm [1] which is a reference implementation of
SPDM.

The series starts by adding support for building and linking with
libspdm. It then progresses to handling SPDM requests in the NVMe device
over the PCIe DOE protocol.

This is a very early attempt. The code quality is not super high, the C
code hasn't been tested at all. This is really just an RFC to see if
QEMU will accept linking with libspdm.

So, the main question is, how do people feel about linking with libspdm
to support SPDM?

1: https://github.com/DMTF/libspdm

Alistair Francis (3):
  subprojects: libspdm: Initial support
  hw: nvme: ctrl: Initial support for DOE
  hw: nvme: ctrl: Process SPDM requests

 meson.build                   | 78 +++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h                |  4 ++
 include/hw/pci/pcie_doe.h     |  1 +
 hw/nvme/ctrl.c                | 35 ++++++++++++++++
 .gitmodules                   |  3 ++
 meson_options.txt             |  3 ++
 scripts/meson-buildoptions.sh |  3 ++
 subprojects/.gitignore        |  1 +
 subprojects/libspdm.wrap      |  5 +++
 9 files changed, 133 insertions(+)
 create mode 100644 subprojects/libspdm.wrap

-- 
2.41.0


