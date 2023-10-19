Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A07CFAA4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSqe-0007nA-BJ; Thu, 19 Oct 2023 09:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSpt-0007Dw-SC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSpr-0002RL-17
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40839652b97so18075615e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721189; x=1698325989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4X88wOUQa6zr6g57q8/o5tsEiz+eiENj+Rc3sNCEBhE=;
 b=ieurfPqSPhbeU3IyU695RebG5w6isZgt/UTfLoYS5adu5rFIJLbGaqg/HqvQor7MrA
 c9nb1nOssdZjVY+Y5Ig25eVmZmmSLg7oL58qF5nVE24r/kpQZVg9/fUmJrlIMEV69UTJ
 7ollaqiNqDv+bPYt3L3GN/TrR0t9Np8wZis0vCCGp95wURO0rfmcQ7++r9LPyMxQZD+w
 Ew5NhKYqZGjffImtM4bPHzFvcnCcbNvgQIUljUzhhCTNtVSGSUADNjUPJxh42fR01A9E
 5WikemkVE20eknXIQJIi5TxEQQKkTnYNGbNsOnj0dLUduD9NNN//HSoBWhnxOMWIKfS1
 h30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721189; x=1698325989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4X88wOUQa6zr6g57q8/o5tsEiz+eiENj+Rc3sNCEBhE=;
 b=j+l5rlKr0NhI3oH3lPMfo/r//rtIbQ2YLZJiyXCmrofmz4hMTph9da1Tdw1aykcawH
 n49Zy5eqBLGczkCWbA2yHPVLRGIvYpB38pkV8y1KJgyFlzfdgHsLuvOlRD4Z9NNpMRbY
 xzSk1qemQ7ZCr5TFs7mnfLgejV06f8fNeMQdHQ48CUopPUiIE2FG/WjxoWhcyw1e0bMg
 jnfRDNj4EmomUNzXZn8tHaijNAbhG+2l+uABcgZx5RY46r7bSBEBi9q1OjMU6BFgBpxu
 YMS5xdhbrLXvJ1rtJ4goFugXVzfSWQf4nc474+nYilyiku+jnoNy2AzTX4hAZhIMtEWV
 Qh5g==
X-Gm-Message-State: AOJu0Yw7c4mYeEy5Boa5QeaxRQ6N1HarkmzcX68gaSj6fVHRRNdkY+tX
 jIJjfxWBRkMBc9S0utuAaTbbUzf2KmIuxva6OILceg==
X-Google-Smtp-Source: AGHT+IG44x5FteodFPQp+nUpsm5JrRtMGgUWoBgj5d4HEaodCALiECrtFdkdrQZqHmT4A/BCrJAv6Q==
X-Received: by 2002:a05:600c:3309:b0:401:b652:b6cf with SMTP id
 q9-20020a05600c330900b00401b652b6cfmr1725138wmp.13.1697721189006; 
 Thu, 19 Oct 2023 06:13:09 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adfe486000000b0032415213a6fsm4444972wrm.87.2023.10.19.06.13.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] hw/ppc: SysBus simplifications
Date: Thu, 19 Oct 2023 15:12:58 +0200
Message-ID: <20231019131305.19157-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

This series replaces a sequence of:
- sysbus_init_mmio()
- sysbus_mmio_map()
by a single call to memory_region_add_subregion().

Since v1:
- New "Realize SPAPR_VIO_BRIDGE device before accessing it" patch
- Added R-b tags

Philippe Mathieu-Daudé (7):
  hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device before accessing it
  hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
    pnv_xscom_init()
  hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
  hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
  hw/ppc/pnv: Do not use SysBus API to map local MMIO region
  hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
  hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region

 include/hw/ppc/pnv_xscom.h |  2 +-
 hw/intc/spapr_xive.c       | 12 ++++++------
 hw/ppc/pnv.c               | 26 +++++---------------------
 hw/ppc/pnv_xscom.c         |  5 ++---
 hw/ppc/spapr_vio.c         |  3 ++-
 5 files changed, 16 insertions(+), 32 deletions(-)

-- 
2.41.0


