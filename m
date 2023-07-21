Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB475CFB2
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMt70-0002q3-3m; Fri, 21 Jul 2023 12:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMt6y-0002pq-L0
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:36:12 -0400
Received: from mail-yw1-x1142.google.com ([2607:f8b0:4864:20::1142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMt6w-00056D-Uf
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:36:12 -0400
Received: by mail-yw1-x1142.google.com with SMTP id
 00721157ae682-57712d00cc1so23610387b3.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689957369; x=1690562169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4rQeMRhVWs0eiVqTBZAihMyI0OBjLqk1MiSDA6bw+so=;
 b=GxoaygpJp4E71e5V5mMh0Kl+CGi7YLTC1mvll0v6YWmm+tCnStH6BXxjbKvxXTBqrm
 UgkqW0OTlO5ZUmR62MOHprzWHaThMLbwR+XvLtUmYhyEE+ahm/BJY1Tlchj//PricvC/
 5UPSfIq/v2+ajTgyDK18T3qZOfCdf5WqaVP+abqlnbyJSWisqt6QZMycj4fg6/ShiOi7
 L8LgzV3muOYA+sGvNJ5sP5rwlftTD3WCshVlkPiueBDR59aTPFoRKWu8Y9wU0T2oOYwX
 TQbPT7bHRN595duFohjfbNDoZapzfICKjeVcX3THVMJVMnYlHW4mhdLrGcQ2O6uHswYa
 2p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689957369; x=1690562169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rQeMRhVWs0eiVqTBZAihMyI0OBjLqk1MiSDA6bw+so=;
 b=PVz3gSbLvc+BmnQR70N/zMdIoJGsEemxuWfi0TOMJouQGNUHTs/G7IsHx8YdSHD2lE
 UHKCNgNNy66tLImviezCazECXVRS+EvcrIFjR/0DuzTrq4G79MJ2rKy5/VmqFgHQrbbn
 rr04D9W16pI9tBjivS/ho8uHUhGjzOpyZdJxFruBQjq+HEDqqfemAE3K78bxm8jCpKk6
 7fm583B/7Dv9siW5IGtCJcyOC6xlt1djPRmJqOR80pkYzyd7N7E7ocUsTEWonaw4iqh2
 VP6ApYYDWIghBED+bOJ2iKyhjXKPkbCuNVSyQoh5BAjKpT/k0rjvsW5UOH25w4vhchFX
 XRlA==
X-Gm-Message-State: ABy/qLZBNCCZ53W1sQylS5/+fXCfY0FG//vNHzEDKplPH4dHSfi59RTd
 jsZKsKgMnrfrVnzvDFPqWo++/d3gx123
X-Google-Smtp-Source: APBJJlHUwggFGGQBNgvYjfw2hrMIRSMQZokR92BRP0PjgSI962CclfYmAsRmDEbH7rHCELzioUlPAg==
X-Received: by 2002:a25:8e0d:0:b0:ced:ab16:15ee with SMTP id
 p13-20020a258e0d000000b00cedab1615eemr2050006ybl.17.1689957369466; 
 Fri, 21 Jul 2023 09:36:09 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 09:36:09 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 0/4] CXL: SK hynix Niagara MHSLD Device
Date: Fri, 21 Jul 2023 12:35:02 -0400
Message-Id: <20230721163505.1910-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1142;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1142.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Base repo: https://gitlab.com/jic23/qemu
Base branch: cxl-2023-07-17

This patch set includes an emulation of the SK hynix Niagara MHSLD
platform with custom CCI commands that allow for isolation of memory
blocks between attached hosts.

There are 4 total patches in this set:
1 & 2: Modifications to the CCI interface to allow the addition of
       custom CCI commands to an existing CCI command set.
3: Minimum MHD cci support for a type-3 device
4: The SK hynix Niagara Device

The changes to the core device and cci interface are very limited,
and this provides a clean way for developers to add custom CCI commands
to a device while retaining the possiblity to upstream the model.

This device allows hosts to request memory blocks directly from the
device, rather than requiring full the DCD command set.  As a matter of
simplicity, this is beneficial to for testing and applications of 
dynamic memory pooling on top of the 1.1 and 2.0 specification.

Note that these CCI commands are not servicable without the kernel
allowing raw CXL commands to be passed through the mailbox driver,
so users should enable `CONFIG_CXL_MEM_RAW_COMMANDS=y` on the kernel
of their QEMU instance.

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (4):
  cxl/mailbox: change CCI cmd set structure to be a member, not a
    refernce
  cxl/mailbox: interface to add CCI commands to an existing CCI
  cxl/type3: minimum MHD cci support
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   4 +
 hw/cxl/cxl-mailbox-utils.c              |  90 +++-
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 521 ++++++++++++++++++++++++
 hw/mem/cxl_type3.c                      |  67 +++
 include/hw/cxl/cxl_device.h             |  18 +-
 tools/cxl/cxl_mhd_init.c                |  63 +++
 tools/cxl/meson.build                   |   3 +
 tools/meson.build                       |   1 +
 13 files changed, 866 insertions(+), 5 deletions(-)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 tools/cxl/cxl_mhd_init.c
 create mode 100644 tools/cxl/meson.build

-- 
2.39.1


