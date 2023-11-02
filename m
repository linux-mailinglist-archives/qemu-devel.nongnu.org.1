Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 075107DEF7A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaL-0001mm-An; Thu, 02 Nov 2023 06:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaI-0001mN-Ta
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:54 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaG-0003Fr-M5
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:54 -0400
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-9db6cf8309cso83821466b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919551; x=1699524351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUxHOvYH+zMZG+QzWCNt/CyAX933tj7z0dZqD9bg/nU=;
 b=pLdD+kQj66xok3mm9VkwjI7urTvI+UckQXykVt452Oz1z3VruLKcGQlKitMs1Cz2aW
 bbEcnU5bPPe+m0qh0N1YBqQABXs+f+j0dhg+knUiQW6Aq09lReQBkDWZGWh52VxzI4yT
 o/FQhYbrWtBaL9689hCaW99t/fpSQz8BZdJu7j2GUAPA6BnDdYeUmajbJh9yDyQlpWpL
 lynlAdXdr9hA4tKpGI8D8ceiqM/uPc4SfqlNIZoBLbLHrAspsnUxwPB9WHUDTiMfwxUH
 pNvsMvG/3G0VVKs8gXTk26uK6JxR8MSq8Ai5i7tEHDobgRfE60NccbO4RdsjWoqsXkiF
 UYew==
X-Gm-Message-State: AOJu0Yxadry+/VSqX8PycNbufRbiBPtWigAjM9QRD7fvqq1Mt2trsh75
 g4CKe4xUYJ4k+MIuaX/+pqzUNFE2bU4=
X-Google-Smtp-Source: AGHT+IHWY4aMDNEiCyWN+jcmA+hhoDRq0S1e1YwZif1vctidX26ZnKIuAvlguCsz83VD6xvxQe4F8g==
X-Received: by 2002:a17:907:eab:b0:9bf:5df1:38c9 with SMTP id
 ho43-20020a1709070eab00b009bf5df138c9mr4161359ejc.9.1698919550675; 
 Thu, 02 Nov 2023 03:05:50 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:50 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/10] m68k patches
Date: Thu,  2 Nov 2023 11:05:33 +0100
Message-ID: <20231102100543.4875-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.41; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f41.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

 Hi Stefan!

The following changes since commit 6c9ae1ce82b65faa3f266fd103729878cf11e07e:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2023-11-01 06:58:11 +0900)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/m68k-pull-2023-11-02

for you to fetch changes up to a35c20961bb776ed8a4a7377f946b0f3149d3fe7:

  tests/avocado/machine_m68k_nextcube: Fix the download URL for the ROM image (2023-11-02 07:26:06 +0100)

----------------------------------------------------------------
* Avoid qemu_get_cpu() and first_cpu, and use properties instead
* Mirror next-cube bios to address 0
* Instantiate ESP SCSI controller in the next-cube machine
* Fix URL in the next-cube avocado test

----------------------------------------------------------------
Philippe Mathieu-Daudé (7):
      hw/m68k/irqc: Pass CPU using QOM link property
      hw/m68k/mcf5206: Pass CPU using QOM link property
      hw/m68k/mcf_intc: Expose MMIO region via SysBus API
      hw/m68k/mcf_intc: Pass CPU using QOM link property
      hw/m68k/next-cube: Do not open-code sysbus_create_simple()
      hw/m68k/virt: Do not open-code sysbus_create_simple()
      hw/char/mcf_uart: Have mcf_uart_create() return DeviceState

Thomas Huth (3):
      hw/m68k/next-cube: Mirror BIOS to address 0
      m68k: Instantiate the ESP SCSI controller for the NeXTcube machine
      tests/avocado/machine_m68k_nextcube: Fix the download URL for the ROM image

 hw/char/mcf_uart.c                     |  13 ++--
 hw/intc/m68k_irqc.c                    |  10 ++-
 hw/m68k/an5206.c                       |   6 +-
 hw/m68k/mcf5206.c                      |  15 +++-
 hw/m68k/mcf5208.c                      |   6 +-
 hw/m68k/mcf_intc.c                     |  21 ++++--
 hw/m68k/next-cube.c                    | 130 +++++++++++++++++++++++++++++----
 hw/m68k/virt.c                         |   9 +--
 include/hw/intc/m68k_irqc.h            |   1 +
 include/hw/m68k/mcf.h                  |   4 +-
 tests/avocado/machine_m68k_nextcube.py |   4 +-
 11 files changed, 172 insertions(+), 47 deletions(-)

