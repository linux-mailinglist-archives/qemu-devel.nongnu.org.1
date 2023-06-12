Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF072D47D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8q7v-0001am-5n; Mon, 12 Jun 2023 18:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q7s-0001a6-IQ
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:05 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q7q-0007dX-Pc
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso879138566b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609299; x=1689201299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SqhlRkXOcH7EyYnTn68FA9nqTZvBqxPLUfNCO5zF92Q=;
 b=kEDhXScOIvT6oF80U+aW5oGYOdkhuJLcJBS+Ka1GseFVbpXV9ynDLbXIos63othYHc
 vNtmWjCJ5jALFQogj9a3n3zQm5Sb2wjHeMNZ56I2utscXxHiGqyegt6ZpVJ+kcD7QzTI
 Xx/yJYeZP6X0TMDb/p0OFzyt5opv7NcljMZk14S603kiZCRdaBLx+4rgzbHh31NwT+6Z
 k7RZRVAeQEQDOsmqba2YNDFeqxjZFktA18K49+C1abWV7HNcysDOPtfg01P1HiqzG6l6
 6ancD0RQWuy8psvXWV+5zqtwH8u6tXzBS8SSrBzlqrE0ih24vKXhMHv2Ft3ITKSCTsW3
 CicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609299; x=1689201299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SqhlRkXOcH7EyYnTn68FA9nqTZvBqxPLUfNCO5zF92Q=;
 b=AUQrkTOs/Hg/Cf/xrkYMXh/DvrmqmzcJBCrKa2VYUQWXh8gtVoqjaQdFtrtiJkfYwT
 kZqLhXwqOXWHvMbe9se79v/dyBg+rLvOvqyukLRjYFVGcpaskQkVC3n58G8kP27Fl5um
 0Pr/J22pxfufPZ1bgYtKPZRBxjLynribC4JB0xGSuKbM3O/zw3+3PjyHuwybIiOTDDD6
 K67q25H6uI9OQnSrgeDe/4HjR8LIKzBMVHetBxkei1xTcMLjm+SqRVnfYBLbi2oXAMQI
 hZEgOcITr8QDtKRw4SLI+9NzR4f3VUiSzYo9I0xsXXSWF8u46H6JlqBHgh/oXwgUQJDx
 IYQg==
X-Gm-Message-State: AC+VfDzLzTV8MgAVwFj+QbZTSbbJWyJHHnnULETcTq1yf8+3hAetUBzg
 ipZhBTZOG6E9j0TpA10hcUswbgcKO2pvPGMixRAPEw==
X-Google-Smtp-Source: ACHHUZ6tvjjdYqziZiisvCNEZ49MXs0honVwholivrvFRCGS8NirvnfWmz8/SbhQO6gLvGBGQnj5jw==
X-Received: by 2002:a17:907:36c8:b0:978:af67:c7ea with SMTP id
 bj8-20020a17090736c800b00978af67c7eamr11761566ejc.41.1686609298809; 
 Mon, 12 Jun 2023 15:34:58 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a1709060dc400b0096f937b0d3esm5802572eji.3.2023.06.12.15.34.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jun 2023 15:34:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/4] hw/arm/raspi: Use named constants in BCM props
Date: Tue, 13 Jun 2023 00:34:52 +0200
Message-Id: <20230612223456.33824-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

v2: https://lore.kernel.org/qemu-devel/20230612115950.5002-1-sergey.kambalin@auriga.com/

This is a respin of Sergey's patch but
- split in multiple patches
- removing redundant comments

Sergey Kambalin (4):
  hw/arm/raspi: Import Linux raspi definitions as
    'raspberrypi-fw-defs.h'
  hw/misc/bcm2835_property: Use 'raspberrypi-fw-defs.h' definitions
  hw/misc/bcm2835_property: Replace magic frequency values by
    definitions
  hw/misc/bcm2835_property: Handle CORE_CLK_ID firmware property

 include/hw/arm/raspi_platform.h       |   6 +
 include/hw/misc/raspberrypi-fw-defs.h | 163 ++++++++++++++++++++++++++
 hw/misc/bcm2835_property.c            | 112 +++++++++---------
 3 files changed, 228 insertions(+), 53 deletions(-)
 create mode 100644 include/hw/misc/raspberrypi-fw-defs.h

-- 
2.38.1


