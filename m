Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BC78F5E3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqax-00042R-Sq; Thu, 31 Aug 2023 18:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqap-00040y-UL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqam-0002wG-1o
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee8af9cb9so13986155e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522606; x=1694127406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YH1ZsJfL6odLNAdY06q9TX6w45RtA1ESU5uhuRXFuvE=;
 b=GfTNNTLCOssgT8ThaAdd2nVWOSr/BgMaJcLSADuegdNXnggMm243a98KIbcTT1bI73
 5uVMbBa0QEy4niLsUVI1bevwSskGpXVzCZcWqihZ0fxqZA/JuZEgr8De78gTsk3+SrrB
 b0T63CYf4LFf0ZEMikRZUuZjqpzCUiMjiZ5rqYc52gs86v5cX3wlQEHL+b4hbaoRzdg8
 KL3VpHbuhjnpYX095tFK5hJBYLY6zmZ69oU/HA1RUP2KfXFHU8ZTD5lb/jqQ8RJkKAR9
 Itk1fCczb8N7dLVvDmx3yZmIX6ABztJ1U3ygym6JX2Vd/RtrPYpc2h9PDHxD+6IxP5yP
 UfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522606; x=1694127406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YH1ZsJfL6odLNAdY06q9TX6w45RtA1ESU5uhuRXFuvE=;
 b=d47EQgRtJvm0ATxKpu8N2BIsyYNs4yxJMQI4WtO9exKSwGSZyavcXMYZFJjIGI3gPd
 aAVeGcanWAfBPJoFqYgaqHti6ZOeT1+KSOOE81eAEWexODCLUoE51D/O6pzYbzX9eUNM
 aMW/LSECbJboGHCExJJwahItb2k8cITs8m14ZDIkIuVuVem2QVo6Wk3+qqDz9JXCRt42
 txoL9RROU1kB6hwZXiOmZRduTZFn17hlD+SZ/CPWoHAld68ERFkBT0EW/rbGuPehL2Mo
 Qh0lGB+CB0lhyWBrO6HTCQ9ZQl7PeHJQMJpiPqH29ZS9l1urGKFp51adZFIbjD3R4N+k
 bQIA==
X-Gm-Message-State: AOJu0YyxKDw6inJBjKqJCDFjHWwQjrQ6iXcmRGkXqBhSGxPvjnldMFz6
 60RHrYgXD6C5aH2ScQhOPTXppeIJZ5ZXS6LT5DU=
X-Google-Smtp-Source: AGHT+IEL+mhSXhbFq+F9N1bhyEew9RtmQ3FBiCLQXNaweT+w7NO4RfxYbbjkF3B8FnYTmkirHw7ZCQ==
X-Received: by 2002:a7b:cbcb:0:b0:3fe:22a9:910 with SMTP id
 n11-20020a7bcbcb000000b003fe22a90910mr468242wmi.14.1693522606141; 
 Thu, 31 Aug 2023 15:56:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 rn1-20020a170906d92100b00992665694f7sm1239358ejb.107.2023.08.31.15.56.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH 06/11] hw/arm/allwinner: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:01 +0200
Message-ID: <20230831225607.30829-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Fix:

  hw/arm/allwinner-r40.c:412:14: error: declaration shadows a local variable [-Werror,-Wshadow]
    for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
             ^
  hw/arm/allwinner-r40.c:299:14: note: previous declaration is here
    unsigned i;
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/allwinner-r40.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 7d29eb224f..a0d367c60d 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -296,10 +296,9 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
 {
     const char *r40_nic_models[] = { "gmac", "emac", NULL };
     AwR40State *s = AW_R40(dev);
-    unsigned i;
 
     /* CPUs */
-    for (i = 0; i < AW_R40_NUM_CPUS; i++) {
+    for (unsigned i = 0; i < AW_R40_NUM_CPUS; i++) {
 
         /*
          * Disable secondary CPUs. Guest EL3 firmware will start
@@ -335,7 +334,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
      * maintenance interrupt signal to the appropriate GIC PPI inputs,
      * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
      */
-    for (i = 0; i < AW_R40_NUM_CPUS; i++) {
+    for (unsigned i = 0; i < AW_R40_NUM_CPUS; i++) {
         DeviceState *cpudev = DEVICE(&s->cpus[i]);
         int ppibase = AW_R40_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
         int irq;
@@ -494,7 +493,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
 
     /* Unimplemented devices */
-    for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
+    for (unsigned i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
                                     r40_unimplemented[i].base,
                                     r40_unimplemented[i].size);
-- 
2.41.0


