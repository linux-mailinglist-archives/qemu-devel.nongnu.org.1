Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267AB796DBE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2Fg-0006Av-NI; Wed, 06 Sep 2023 19:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Ff-0006Am-8d
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:03 -0400
Received: from mail-yw1-x1142.google.com ([2607:f8b0:4864:20::1142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fc-0006a9-TB
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:03 -0400
Received: by mail-yw1-x1142.google.com with SMTP id
 00721157ae682-58d9ba95c78so4135957b3.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044079; x=1694648879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J4nG8OGAmHGIu2LAdsS8Gsh+p3EeoyBi8CsqSTMWnPc=;
 b=kL8ZQjjqfroHBOdkvOAIMisYkYhhMKO//W5lOEpa9rE+1Jt6pVDrG9Zwe4BaOkVShN
 HiWhaDHYq996D46tJiwR2x0vrwKoKum5356cmHuE4posUm0Vn6cOS9ONxZcZL7OU713T
 uG3OSXlWZet5q1uxMqEdC3XmmDLlCvb34h23YKXpXebB66Ghx/D8pS/mcHCo3ZLH8f4Q
 sYNzEjhibTTJ51qWCj2u7cBHlj3bPmmfOoxyP4lUBE9iQ7PxzNSRXyIcZVlfZ0vVf2nn
 MFo4UKMEKH07AdRTx2iWX5OAlL0vUKWs5y/p6TSWBeINOklG3JeOe64OKnOlTkA25xQw
 vkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044079; x=1694648879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4nG8OGAmHGIu2LAdsS8Gsh+p3EeoyBi8CsqSTMWnPc=;
 b=QzkEHu69k4KMGnqotuVILd5RAJpYU0N7FawL2JuJfZY6XaoVZPX++JN1GlOnZQBffy
 AIRTdGNfH9RAjJvOR+pB/PzZXUVrwlQokN2iTXCdsXonT006kLJRJvraXX5jehoN9zLI
 5JqHXTna8Q2vEwJ5+Tuhq0tF9VtXgCwxRgalviXjYRzNY14Z7HBRmekwON72LJJtmz6Q
 OINO6vdawdi+8yAiSp+y7XKlV4hDs5fewLUPdWNi3DdxtS6qVXbSfbY15P2JpPgC7Q+r
 oZyjkNgMg45psEcBgD1+VkiZc83XiU0PkSV0/IEa2c6ZCWPvsPW9B+rt+oUIwu1RtrvX
 7YsQ==
X-Gm-Message-State: AOJu0YyoLjFEzAFApZ4imzBA2i7MmmMNfrE0KklfvoNTz7Q5wxs/hvWx
 PHKPZearqPrexxKMoEl0d8qKfPPDmXSM
X-Google-Smtp-Source: AGHT+IHNvSjGbR2p4qbJK2NnbStjC57wh6s06URj06y93LD9nrT9T7veSbE7+WSF9cr17bT6hWq7hg==
X-Received: by 2002:a0d:d341:0:b0:58c:b8b4:2785 with SMTP id
 v62-20020a0dd341000000b0058cb8b42785mr17413200ywd.45.1694044078966; 
 Wed, 06 Sep 2023 16:47:58 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:47:58 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 0/6] CXL: SK hynix Niagara MHSLD Device
Date: Tue,  5 Sep 2023 20:15:11 -0400
Message-Id: <20230906001517.324380-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1142;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1142.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v3:
- 6 patch series, first 5 are pull-aheads that can be merged separately
- cci: added MHD back into main mailbox, but implemented a callback
       pattern.  type-3 devices leave the callback null by default and
       report unsupported if nothing implements it.
- cleanup and formatting

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

This device allows hosts to request memory blocks directly from the
device, rather than requiring full the DCD command set.  As a matter
of simplicity, this is beneficial to for testing and applications of
dynamic memory pooling on top of the 1.1 and 2.0 specification.

Note that these CCI commands are not servicable without a proper
driver or the kernel allowing raw CXL commands to be passed through
the mailbox driver, so users should enable
`CONFIG_CXL_MEM_RAW_COMMANDS=y` on the kernel of their QEMU instance
if they wish to test it.

Signed-off-by: Gregory Price <gregory.price@memverge.com>


Gregory Price (6):
  cxl/mailbox: move mailbox effect definitions to a header
  cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
  cxl/type3: Expose ct3 functions so that inheriters can call them
  cxl/type3: add an optional mhd validation function for memory accesses
  cxl/mailbox,type3: Implement MHD get info command callback
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   4 +
 hw/cxl/cxl-mailbox-utils.c              |  51 ++-
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 514 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 161 ++++++++
 hw/mem/cxl_type3.c                      |  32 +-
 include/hw/cxl/cxl_device.h             |  13 +
 include/hw/cxl/cxl_mailbox.h            |  18 +
 12 files changed, 873 insertions(+), 24 deletions(-)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h
 create mode 100644 include/hw/cxl/cxl_mailbox.h

-- 
2.39.1


