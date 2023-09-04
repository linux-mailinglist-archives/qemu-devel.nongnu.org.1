Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96879175A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8vi-0001VM-Fh; Mon, 04 Sep 2023 08:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vf-0001OA-Oy
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:43 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vd-0004d0-F4
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:43 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so2355452e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831419; x=1694436219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6Qgqbn+d1/I+gSK8St7x7NRj+2INTDRnnggirvl8K4=;
 b=rjLbOf8dipYWQBszPzvkRe9wBVCtjJcGqNeF1e0ziUpFlwPgQzhdgaRXTVRXx/344E
 Wl9L4sCrHZJOElaMy7nvXQSECAkCpnDOB1qCZazq5NLZ4SWzR1ki2js3l5CL6RuF779K
 W3VXoaug2UxuQsPEtGjiWrgx907U8GEAFYw3HvU5YyBW4nmfVEYOFDrrZvgDpCqg6+vY
 mzSol6+/RhNfxsVCMDX0qkqqd2Fkxs9P0RjSDlP1/a09yUrwkx8TwlE/62Q1FDbeRlCn
 PbFQ1mEhwBybpSKVqSPcL4y5wWArn2MO4r+5vL0qX498fEMHTeKHei/KI8lJxj9cP6Hm
 w8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831419; x=1694436219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6Qgqbn+d1/I+gSK8St7x7NRj+2INTDRnnggirvl8K4=;
 b=YevuE4XXR5NUUc5x+jn5UclUkMSuEgmnc7C+nrDNGWxq+dv11fWh3iRyHB3Z5UiI92
 +0WEDMqGf2QYYlW9gtVK/ORn9b7KsqLo0Kn9sEb0DJvy57U54aJjiZOVBWVaBDwLhEhT
 b1kxeiZllHKOR2IOrO5Yr57NLSZdaJsjBXaEXtYA1w1yHrPKixR5i8cUETaP0yUbteMC
 46eTrsdSZrPIl0O4hzVzr2KS675BzrRU1LHZjLz1W5MK/sRR6AtePqfLPz3bMagz2XNG
 Y6yGUzG9vrMZgDttPx7PaKVOcRYqYmms4VeSJgmdFS6pJm85sQpW3xOeXV2V4opDRlql
 m+Hg==
X-Gm-Message-State: AOJu0YwxBXRhuu2FYkS9k+5cI8NVKAC0F9ChjrpC+Z/HwSMvzBoejLO/
 HQIIybcV7gTSRwYJkp3wJSx/g73hh/alOwKhNQY=
X-Google-Smtp-Source: AGHT+IHAvtxselt1b1hV5LdDZn5OMGkxc7bjsWnN+/jQkXccg9G0McaZkj4DLfPBkIFLocObukSlqg==
X-Received: by 2002:a19:2d45:0:b0:4fd:f84f:83c1 with SMTP id
 t5-20020a192d45000000b004fdf84f83c1mr5836726lft.64.1693831419642; 
 Mon, 04 Sep 2023 05:43:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 lg16-20020a170906f89000b009a0955a7ad0sm6087296ejb.128.2023.09.04.05.43.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:43:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 02/13] hw/i386/pc: Include missing 'cpu.h' header
Date: Mon,  4 Sep 2023 14:43:13 +0200
Message-ID: <20230904124325.79040-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Both pc_piix.c and pc_q35.c files use CPU_VERSION_LEGACY
which is defined in "target/i386/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 1 +
 hw/i386/pc_q35.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce1ac95274..f0df12f6fa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -69,6 +69,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
 #include "kvm/kvm-cpu.h"
+#include "target/i386/cpu.h"
 
 #define MAX_IDE_BUS 2
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 43413dd1ac..8ecc78c822 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -58,6 +58,7 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
+#include "target/i386/cpu.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
-- 
2.41.0


