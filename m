Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C27CDC31
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5vn-0007KD-T9; Wed, 18 Oct 2023 08:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56N-0003w0-VL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56L-0001A6-Ka
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so68790785e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1697629955; x=1698234755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ImLTGIUdc27WQDyZGTUT/EY9Io7N8OOwkJv7jhNP3uI=;
 b=LxCT41RzKnrsS6h+9MoxFYBsOIG355GaLFzn8djqsaDxodJIk0PJaKBnunXLIsQmQL
 iOot7IVUcPUWy1B8Olasb1lg/3rjiRonSMk0F9q1LEd+Sxkurjm0gXfkGE2wxIHYiIjI
 MD9N5yJxm0Isuawu4uE5lIdV687TopaydPAc5z/nyJv+VClA5U0IWjNhRtX1IhK6GRQi
 gKrV6S+XYYZPns7jbI0pDrjAkf3rbOc5QF9Qcwva/JADZv9hSH4xaCBE6lCMnxLBf5Iz
 oPm9AL1yvuBRhWKn7KjFdb+J6z80K1vHNyhRcqSO00whM+zGgPgBcW8oGFL6A4CPm1ZT
 UlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697629955; x=1698234755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImLTGIUdc27WQDyZGTUT/EY9Io7N8OOwkJv7jhNP3uI=;
 b=D8UALbhR1TsspsDi4Pf9Swsw6EPKkqs0ZozqPH0n5Hz/kvJlcee0JbbiG64KyaJQxw
 KCLpIXwt8wpZZT49YzwjHXrMZE+RjtfQdqii/h8rkRWXTPeR9XX+NE6V48gJnr9m4hIw
 mNEArBwez688+yAloA/cYJBVRRNw4ieOJT/eyYV4EV2sju0BUKLs4uGpqFqePRpUvEhH
 5Oh5Xp6FUgC+kv0SAeymTJr+M022KWI8xkd5W2PhGVSqe22Gle7chrKzGRE0Tt8N/QaJ
 Rn38zFrhNfTf4lRzDEfIX/RSTMZob0mbNE4dsFRcK+MlSZq7yQsRaXD3syNYlrm9GJ10
 lNCw==
X-Gm-Message-State: AOJu0YySO5B8btl6xdHfz1KVgQ6XSAOWPwovlmKg3QqLYdxI+V9NNgJ/
 4VcE3vEQodKpDZ/lZHTEUu+mUrPiFC2rdmCFM1NPYw==
X-Google-Smtp-Source: AGHT+IG7u4Hfi5Tw0ARZmsNS41naOrtOuPbDZ+aGZ/85Ej2ACVex57Wkz0IkgPm+9/dcHl134M9Kbg==
X-Received: by 2002:a05:600c:1f94:b0:3fe:2b8c:9f0b with SMTP id
 je20-20020a05600c1f9400b003fe2b8c9f0bmr3710389wmb.23.1697629954639; 
 Wed, 18 Oct 2023 04:52:34 -0700 (PDT)
Received: from fedora.9e.network
 (ip-078-094-000-052.um19.pools.vodafone-ip.de. [78.94.0.52])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c489100b0040776008abdsm1455303wmp.40.2023.10.18.04.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:52:34 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 0/3] hw/i386: Add MTD controller on ICH9
Date: Wed, 18 Oct 2023 13:52:28 +0200
Message-ID: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=patrick.rudolph@9elements.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Oct 2023 08:45:43 -0400
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

This series implements a feature complete MTD SPI flash controller
as found on real ICH9, adds cache coherent BIOS MMAPing and implements
a few SMM bits to allow x86 firmware build for real ICH9 to operate on
the flash controller to store (UEFI) variables or do firmware updates.

Patrick Rudolph (3):
  hw/isa/ich9: Add SPI controller
  hw/isa/lpc_ich9: Implement SMI_STS for APMC
  hw/i386/pc_sysfw: Do not create BIOS region if MTD is present

 hw/acpi/ich9.c                    |   5 +
 hw/acpi/ich9_tco.c                |   5 +
 hw/i386/pc_sysfw.c                |   6 +
 hw/isa/Kconfig                    |   2 +
 hw/isa/lpc_ich9.c                 |   4 +
 hw/isa/meson.build                |   2 +-
 hw/isa/spi_ich9.c                 | 448 ++++++++++++++++++++++++++++++
 include/hw/southbridge/ich9.h     |   6 +
 include/hw/southbridge/ich9_spi.h |  80 ++++++
 9 files changed, 557 insertions(+), 1 deletion(-)
 create mode 100644 hw/isa/spi_ich9.c
 create mode 100644 include/hw/southbridge/ich9_spi.h

-- 
2.41.0


