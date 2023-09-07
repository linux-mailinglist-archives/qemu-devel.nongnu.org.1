Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C14BE7972B0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeZ-0005e1-PF; Thu, 07 Sep 2023 09:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdk-0003tz-6A
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdh-0007SV-Qj
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5QQm0oilMjeexogAgNze3HLGFf4cWGHlkML0hXaL90=;
 b=FYi+k/lQIC1kMy/9WLSSaMgkjoS7ki1VD2yUs7gJwHoWnpv7DKs/1VOPG6oz8An0AuTozu
 4/0KhTIp1LlOxYGUMSVWa/61Ck0hNG2H0IpaKMSOdvDx3m6cGO+SewToTTyNv68Hgfvqst
 f5dlS7o787S5Uc9GbnfWU9xrPcvrYkc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-7tOSXF9xOECLA_xICvG19Q-1; Thu, 07 Sep 2023 09:01:38 -0400
X-MC-Unique: 7tOSXF9xOECLA_xICvG19Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba1949656bso11289741fa.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091695; x=1694696495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5QQm0oilMjeexogAgNze3HLGFf4cWGHlkML0hXaL90=;
 b=CWhMN9EZn8UJrQDXgIXEBo1lAe+TOPTdCxOaGN9tCkzKOuJ2tTmoh0QI4YjvqlgRCm
 KphjHkE3k6TWYgtYGuq3MC1TWtx1RJc2KdAA6Z3+9WvZ0rKB00FCBlgU2VEZr7Klk3Oi
 aZJgJf7dq8AospLfuHclAiSnYmi9Sq5x2pfWBr5Zz91YvJ0ONAtNu2Q4VwCigx5/7zfR
 YMF3WkHyWy4cMRqgNKGxGOoUDDg7q2/3hC7GJtnU83C425uGUxhoFVsRC/AG6n3wkZp3
 POXNpTcOF+jKq5kONwNmlVJumh5WirEP/evsDwl0SZYdlExFmtQCcD/pl9Ain8hRU6br
 7emw==
X-Gm-Message-State: AOJu0YzM98Ie56hSLouEpWhvN+XGOizgfDM/5ZtAh1bZwNIPrMM2ywAk
 5vWQamXVpQyQUoUn/LOvQQqmMTvaNwmlWckyYeshIMT17DJZ0JtySVl3zoa/Nff3oH7B9fRQdv2
 0GAlUaM3rs41LzG/TnGQGunaDyJMmLsI9b5l0JcsME4MRAew5/vS7KvpPRPKWLtfSsFv7xylSpN
 E=
X-Received: by 2002:a2e:87cd:0:b0:2bc:d097:2b72 with SMTP id
 v13-20020a2e87cd000000b002bcd0972b72mr4796096ljj.48.1694091695510; 
 Thu, 07 Sep 2023 06:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Q7BFQOh5+plnqBPbuOFINJU5aPGkpsA0EMlL3US6VloZV1INGkBu8PHpKUOp6gTgB3lhyQ==
X-Received: by 2002:a2e:87cd:0:b0:2bc:d097:2b72 with SMTP id
 v13-20020a2e87cd000000b002bcd0972b72mr4796079ljj.48.1694091695189; 
 Thu, 07 Sep 2023 06:01:35 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a7bcd99000000b0040210a27e29sm2454449wmj.32.2023.09.07.06.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/51] hw/i386/pc: Include missing 'cpu.h' header
Date: Thu,  7 Sep 2023 14:59:47 +0200
Message-ID: <20230907130004.500601-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Both pc_piix.c and pc_q35.c files use CPU_VERSION_LEGACY
which is defined in "target/i386/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-3-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 1 +
 hw/i386/pc_q35.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce1ac952749..f0df12f6fa8 100644
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
index 43413dd1ac4..8ecc78c822b 100644
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


