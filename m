Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E06791755
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8vo-0001dR-Id; Mon, 04 Sep 2023 08:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vm-0001W6-1r
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vj-0004db-Rz
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:49 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso207589566b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831426; x=1694436226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAX70gb1DRp0U5HpIrsPRfVqNXXnjE75o2367gc+/Ss=;
 b=qes/yffyt7CA99mz2FaV9THd3U2bxKjGOZFjOTZTHb//avor3vmPF1K75fo7hDlGYc
 /1SddMKmEUk1919Q2ZSghDBEbQUA3fsY2IxCIMHhwdEhzOoi7HO0bEi0U+XbSNcVmqje
 EDy+LdP/6QF7QoBOzbuY3+9CITYN4T/O9F4uZs8cApnGgjsn2MMV0mxL2pNVTrBxW7oc
 28+aNuvbsWNiZU6pT/ssQ9pGR6q73YRxbeIhlGmTpJw67y0mG/KA0DoZshTQ8wYyhIDu
 xEFJw/ghqrxYgpp/Z6uT7hcqlBmvg+f+W5RYxRlTzNPanNFiVaZMZrRliq6C8PwZdjUa
 CWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831426; x=1694436226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAX70gb1DRp0U5HpIrsPRfVqNXXnjE75o2367gc+/Ss=;
 b=KD/txOuyURBmGv+t6QHN4+rTwEyJ7OnvCaFMQfxVOMR1/Bcu7jYhEGdSa0R12wNvil
 5EOmhJYBMUN6fr9g5DW2lPqMDWPVRSvoqHx4hbKvo0n6nSOKuNO1MSwQV7iXCXeSws71
 2hzpSRcSC1tA5jMFL3rWTsYcs99lPm54X5trTA0QFQWIBmlFqY32AyyBjFmcEgYe5lQy
 MdBwtfG0uBNMN012/O4/uCzZA6LUiC0PoGiZB8IYbVLurbvO3h5g+vZBB14rko64osI6
 /Tg3Tl4ya52795Gi1+UgJGFNeD04CeEbdMG1lu0vpaOqD2so9oU/Fo3/z3jq32oRTDKf
 tSQQ==
X-Gm-Message-State: AOJu0YypSiohchJkULY0xNuZAQeLzropmLmfWrHiEsSk22CO4ygrboYk
 /jtZOnp9eKEEp4yN5Exwo39ID3/GVcD4zmvh8dg=
X-Google-Smtp-Source: AGHT+IFkSqJnsshKBauxCddr+GUPT4A6KXmj88c6crUPHo9OljUs8uCyfcujmDG6A70sYs/Xauvxnw==
X-Received: by 2002:a17:906:30c1:b0:993:d5bd:a757 with SMTP id
 b1-20020a17090630c100b00993d5bda757mr7133775ejb.19.1693831425876; 
 Mon, 04 Sep 2023 05:43:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 pv9-20020a170907208900b00993470682e5sm6063351ejb.32.2023.09.04.05.43.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:43:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 03/13] hw/i386/fw_cfg: Include missing 'cpu.h' header
Date: Mon,  4 Sep 2023 14:43:14 +0200
Message-ID: <20230904124325.79040-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

fw_cfg_build_feature_control() uses CPUID_EXT_VMX which is
defined in "target/i386/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 72a42f3c66..7362daa45a 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -24,6 +24,7 @@
 #include "kvm/kvm_i386.h"
 #include "qapi/error.h"
 #include CONFIG_DEVICES
+#include "target/i386/cpu.h"
 
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
-- 
2.41.0


