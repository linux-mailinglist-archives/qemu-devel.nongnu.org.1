Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1EF736643
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWnJ-0006BL-SD; Tue, 20 Jun 2023 04:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWnB-0006Ay-Ba
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:32:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWn9-000852-HS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:32:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9875c2d949eso537213666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249965; x=1689841965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHeaAAV3ecaC5191lrrTDI3ODMtZRKyKR+rtQqyfdog=;
 b=iUJ4og1PJgdDP6JnKHhDGXUT//pbRS55dQgwdlVQtEZpmnboLcwkfCsd4/3IIMQ0dn
 GZplQoJWfNw0blvx+00gBvsyhl4XAMIP2Bk0cE6cPVUdu4uH3Qs3YWxMZGYsZKierlkG
 nE+mtGIEIO36AG6pUNQudPmEzXcDV6ppGefdT/gqVG4hvo42QOVgSJX9nMv+GcHNqC9c
 7sb8TbGyBYaxpB5W2MKsfKWQc9Yhx8twrfolQY8N8x2yjx46VR6VaG3sus2Pj1niLYMu
 zmh8pDLQv6KP5E1N8fND45TJhadTsU6n3ZpJTB9yFYclY9lwHrtGIdZAUl7DobIESibO
 LfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249965; x=1689841965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHeaAAV3ecaC5191lrrTDI3ODMtZRKyKR+rtQqyfdog=;
 b=WvZnWO3yZSso6RPKw7uNpSs/jHF/tRu+u3PHp1Je24+0GB/7jayu43r9ZLst6LgZBQ
 5IbxSsLrl60v9TcR5/I+HrTXqkoPDywIVhTGUhjm3LzmEMPij0H3LY/bN8B6g4glg7Rw
 /++AXr9LLFa/QchIZt6DcD+xHUBespNiwXmBkT2hbm6FP6AzaMDQ3SaYBKu2L32W/Ugz
 NupnkV665y+PPnOo/fOhywcRpmxZubwi8ZPg7Zo+ilcjdZo8LOdSuSwZvaLIBV2Wclyv
 dEO5aPshBnTcO2WhPdZPycKAJ8vG4d4Vt5Q1G1rcMflcgzk0ASoyKL9m6YXhYv9kMrVh
 ErdA==
X-Gm-Message-State: AC+VfDxAStgr/lyzQh1psq77jdVLIPIkUoHlmREYXsAypjW81FZ44FB8
 UuZgIEqGFNtAxTLCWG4tQQDOwWqk2+TzlLBrYdy8Pw==
X-Google-Smtp-Source: ACHHUZ4UQEVkPGp1WAPzNmVO4iWeLfrCmRjmykMSyJoyHLqFKHxkyJYu5Z2v6NfXdbp8+JrvuiJMEw==
X-Received: by 2002:a17:907:7fa4:b0:977:e916:9b83 with SMTP id
 qk36-20020a1709077fa400b00977e9169b83mr14118889ejc.8.1687249965484; 
 Tue, 20 Jun 2023 01:32:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170906355300b0098921e1b064sm784307eja.181.2023.06.20.01.32.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jun 2023 01:32:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] hw/i386: Rename 'hw/kvm/clock.h' ->
 'hw/i386/kvm/clock.h'
Date: Tue, 20 Jun 2023 10:32:28 +0200
Message-Id: <20230620083228.88796-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620083228.88796-1-philmd@linaro.org>
References: <20230620083228.88796-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

kvmclock_create() is only implemented in hw/i386/kvm/clock.h.
Restrict the "hw/kvm/clock.h" header to i386 by moving it to
hw/i386/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: No other arch had to implement this for 12 years,
     safe enough to restrict to x86?
---
 {include/hw => hw/i386}/kvm/clock.h | 4 ++--
 hw/i386/kvm/clock.c                 | 2 +-
 hw/i386/microvm.c                   | 2 +-
 hw/i386/pc_piix.c                   | 2 +-
 hw/i386/pc_q35.c                    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename {include/hw => hw/i386}/kvm/clock.h (85%)

diff --git a/include/hw/kvm/clock.h b/hw/i386/kvm/clock.h
similarity index 85%
rename from include/hw/kvm/clock.h
rename to hw/i386/kvm/clock.h
index 3efe0a871c..401c7e445b 100644
--- a/include/hw/kvm/clock.h
+++ b/hw/i386/kvm/clock.h
@@ -10,8 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef HW_KVM_CLOCK_H
-#define HW_KVM_CLOCK_H
+#ifndef HW_I386_KVM_CLOCK_H
+#define HW_I386_KVM_CLOCK_H
 
 void kvmclock_create(bool create_always);
 
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 0824c6d313..34348a3324 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -22,7 +22,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/kvm/clock.h"
+#include "hw/i386/kvm/clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 6b762bc18e..8deeb62774 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -32,7 +32,7 @@
 
 #include "hw/loader.h"
 #include "hw/irq.h"
-#include "hw/kvm/clock.h"
+#include "hw/i386/kvm/clock.h"
 #include "hw/i386/microvm.h"
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 715c063eec..85fe41327c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -46,7 +46,7 @@
 #include "hw/ide/piix.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
-#include "hw/kvm/clock.h"
+#include "hw/i386/kvm/clock.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "exec/memory.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a0553f70f7..9e6602dfde 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -35,7 +35,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "sysemu/kvm.h"
-#include "hw/kvm/clock.h"
+#include "hw/i386/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
-- 
2.38.1


