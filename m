Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0617747477
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNG-00049z-Sa; Tue, 04 Jul 2023 10:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMe-0003nP-Gt
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMU-0002zJ-3h
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d20548adso6297784f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482235; x=1691074235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOIzLPOnHecDCNWW1WAVm9BTrVEQSroQYADUt2FEwKw=;
 b=tLJM0vQsru0+TU+0rZ7SyswPc2vgJ3H4a72Qg9FG0tQi+6YnROEc3BpPB3APRt4pJn
 TfA/XghcUuNHaoGwW1bdvaUn4SxUo5+3/gU17iSqNyDk5xTJjE5j3bJvZqdacQtlfjZY
 ZN7nbzcEqOlKtTol12hja8+VEOYuPwj94YGDqaWm4uI9cKIA5q6KAtPFQrcm/cEqFY45
 v9GGllsTQrF8BAIeGnKpC++/Frx+JsRtxf1EAlnuN8uNY8WURZRdy+eOMFMzIHi7b+hF
 hwSghL2JaF14NUYjYOWRVAoCGsMkahe+CKaOuDKufjO66MO7rdk+T28p34aMM/c0nqi0
 cgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482235; x=1691074235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOIzLPOnHecDCNWW1WAVm9BTrVEQSroQYADUt2FEwKw=;
 b=V0TrID2xYqi1HicR+jA+fzU9HDd4n2WQIGJx6R/+m8FsszAGDnmxk2jJuGZ+rjWQ7b
 f3tMy88SAoiCT8sy1lM21OdJkg52u5NeJ42HXP6xtiCcBqk8sVM0aXk2tVqB6BLazRwH
 lcCYRrrPQaEd5aNG14zeD61B5G38aOuvJilMBnDkPbVROf7vu7PJ0n/r758CV0nWMdB5
 dc/7L/fbMuE9khhofhTZmMokKugL2dKHC9b16K3PHYqIYlVawgZCWZViYfwobmBew3qu
 8wpCXuQgMSoV6lJee8PlXMHC49Kiz9l4+pvSu/K2gjgmKO6Am+p+E1rCRYJxSrNeFn3r
 u9GQ==
X-Gm-Message-State: ABy/qLYfvNT2AAPy3zwIZ5SAuRGwoCRqKg4ejwRK2KDSKCish4sla8mv
 0KKKhaZ0zM3n8PNr5fMCxKCkDHYqit9+Hk72U+4=
X-Google-Smtp-Source: APBJJlFdvaKsNUvmmw6wYd4oiVzi3XwP9CuaqaPU2jQNs96EiTFtHpdeCOIH5WlU8tqOAF4dsEIDVA==
X-Received: by 2002:adf:fe02:0:b0:307:8c47:a266 with SMTP id
 n2-20020adffe02000000b003078c47a266mr9066354wrr.61.1688482235763; 
 Tue, 04 Jul 2023 07:50:35 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 h9-20020adff189000000b003143c532431sm3293979wro.27.2023.07.04.07.50.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/19] hw/timer/arm_timer: CamelCase rename icp_pit_state
 -> IntegratorPIT
Date: Tue,  4 Jul 2023 16:49:57 +0200
Message-Id: <20230704145012.49870-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Following docs/devel/style.rst guidelines, rename icp_pit_state
using CamelCase as IntegratorPIT (PIT is an acronym).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 0e5d5d0f6d..c741e89cb4 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -327,9 +327,9 @@ static void sp804_class_init(ObjectClass *klass, void *data)
 /* Integrator/CP timer module.  */
 
 #define TYPE_INTEGRATOR_PIT "integrator_pit"
-OBJECT_DECLARE_SIMPLE_TYPE(icp_pit_state, INTEGRATOR_PIT)
+OBJECT_DECLARE_SIMPLE_TYPE(IntegratorPIT, INTEGRATOR_PIT)
 
-struct icp_pit_state {
+struct IntegratorPIT {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
@@ -339,7 +339,7 @@ struct icp_pit_state {
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
                              unsigned size)
 {
-    icp_pit_state *s = opaque;
+    IntegratorPIT *s = opaque;
     int n;
 
     /* ??? Don't know the PrimeCell ID for this device.  */
@@ -355,7 +355,7 @@ static uint64_t icp_pit_read(void *opaque, hwaddr offset,
 static void icp_pit_write(void *opaque, hwaddr offset,
                           uint64_t value, unsigned size)
 {
-    icp_pit_state *s = opaque;
+    IntegratorPIT *s = opaque;
     int n;
 
     n = offset >> 8;
@@ -375,7 +375,7 @@ static const MemoryRegionOps icp_pit_ops = {
 
 static void icp_pit_init(Object *obj)
 {
-    icp_pit_state *s = INTEGRATOR_PIT(obj);
+    IntegratorPIT *s = INTEGRATOR_PIT(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     /* Timer 0 runs at the system clock speed (40MHz).  */
@@ -399,7 +399,7 @@ static const TypeInfo arm_timer_types[] = {
     {
         .name           = TYPE_INTEGRATOR_PIT,
         .parent         = TYPE_SYS_BUS_DEVICE,
-        .instance_size  = sizeof(icp_pit_state),
+        .instance_size  = sizeof(IntegratorPIT),
         .instance_init  = icp_pit_init,
 
     }, {
-- 
2.38.1


