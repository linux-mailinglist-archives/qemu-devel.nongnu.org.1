Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1A78F6C0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 03:30:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsyT-0002q5-9h; Thu, 31 Aug 2023 21:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyS-0002px-7I
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:24 -0400
Received: from mail-yw1-x1143.google.com ([2607:f8b0:4864:20::1143])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyP-0007W5-VR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:23 -0400
Received: by mail-yw1-x1143.google.com with SMTP id
 00721157ae682-59234aaca15so16504347b3.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693531760; x=1694136560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=96oDStEkTcK9mh6qUlrCVMfurdmTa5bB9l1cRASZKOA=;
 b=LadE7SANfCCsMRyFxtwlazml6O7pfTid44osCEUnQYbAkRE8RcISsYe1DKGx4+QXQD
 QHrYciXLev7dFmzHgu4hvssYCin/uSsHeL2FiwKNymdcsOIFPqIbsC7vAd3zsOqlR2OH
 4437tADRLhwG9mFvEng9TiSRVOsnobHtm8zNNCg+ls3ASmXqrEdcYTInwQrK+TAGWtXd
 zNJs9mZ0/X7R4AFzflWQpPNT5IzhBnveh07p+xpaSqXZgJrtIGucb334/2lRC+iDHuR8
 S9fhUsyR8aoAstvyOilPu5WibypcuVLCf48YoszWfVFYjOdfq+b5qdTBdQPN1iSIV/0j
 wxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693531760; x=1694136560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=96oDStEkTcK9mh6qUlrCVMfurdmTa5bB9l1cRASZKOA=;
 b=P2evuBTxrunKotyyCpOqiDxVs5eE8nlDzuk2Rpu31OcZ8NziYD2sjf4tQA5VlI2pDO
 Y9iRo2AtnwmhXg8N6XJ/BRR7wubSJnLFEEsMKuTim3DzNl+VkSJOhU+FOYhKKgbiBFbE
 3N8rUs1v7Mgy4JO+fyFH2MB9vAaGqZgYJhKCI5rqjrNGeJSnzIUbymRzhrUWGMI44jWJ
 aJooZgK/tT/vWH0pCMtf/yag6etC9ifYg7xYrvyHFJJeoHrQeeGzQMtuNYbMYvi3kEXS
 /P3IDp65lolkaz/ae4KvixpPTddwe37Ili4TvjuIqDFxmSNIC5yIyfHNcW2BuOb7s4D/
 RCHg==
X-Gm-Message-State: AOJu0YzQ3PHquB4AXZ7H2umL1J4za4IRRrT00/OeFu7zoEDT8ccYDHcn
 1mm5XZKNU/FYPIAAAdD2W1wq6fyxn6qF
X-Google-Smtp-Source: AGHT+IHhgRM1lPYrHzbBPEnE0k1U7QwkrUld4HN9k6VkBh/dH1y33w7R0uxT9Jg3Yt7YMQREM6Np9w==
X-Received: by 2002:a0d:ca87:0:b0:589:fc81:952e with SMTP id
 m129-20020a0dca87000000b00589fc81952emr1177260ywd.7.1693531760254; 
 Thu, 31 Aug 2023 18:29:20 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:29:19 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 0/5 v2] CXL: SK hynix Niagara MHSLD Device
Date: Thu, 31 Aug 2023 21:29:09 -0400
Message-Id: <20230901012914.226527-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1143;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1143.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

v2:
- 5 patch series, first 4 are pull-aheads that can be merged separately
- cci: rebased on 8-30 branch from jic23, dropped cci patches
- mailbox: dropped MHD commands, integrated into niagara (for now)
- mailbox: refactor CCI defines to avoid redefinition in niagara
- type3: cleanup duplicate typecasting
- type3: expose ct3 functions so inheriting devices may access them
- type3: add optional mhd validation function for memory access
- niagara: refactor to make niagara inherit type3 and override behavior
- niagara: refactor command definitions and types into header to make
           understanding the device a bit easier for users
- style and formatting

This patch set includes an emulation of the SK hynix Niagara MHSLD
platform with custom CCI commands that allow for isolation of memory
blocks between attached hosts.

This device allows hosts to request memory blocks directly from the device,
rather than requiring full the DCD command set.  As a matter of simplicity,
this is beneficial to for testing and applications of dynamic memory
pooling on top of the 1.1 and 2.0 specification.

Note that these CCI commands are not servicable without a proper driver or
the kernel allowing raw CXL commands to be passed through the mailbox
driver, so users should enable `CONFIG_CXL_MEM_RAW_COMMANDS=y` on the
kernel of their QEMU instance if they wish to test it

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (5):
  cxl/mailbox: move mailbox effect definitions to a header
  cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
  cxl/type3: Expose ct3 functions so that inheriters can call them
  cxl/type3: add an optional mhd validation function for memory accesses
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   4 +
 hw/cxl/cxl-mailbox-utils.c              |  35 +-
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 516 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 169 ++++++++
 hw/mem/cxl_type3.c                      |  33 +-
 include/hw/cxl/cxl_device.h             |   8 +
 include/hw/cxl/cxl_mailbox.h            |  18 +
 12 files changed, 863 insertions(+), 24 deletions(-)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h
 create mode 100644 include/hw/cxl/cxl_mailbox.h

-- 
2.39.1


