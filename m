Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB57CDEA6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7IH-00005S-Mj; Wed, 18 Oct 2023 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7IF-0008NQ-Ck
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7ID-0004tJ-Pd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:03 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso11718461a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638379; x=1698243179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZILeqkGygukHiY0i/7/5ShUVzUpektIiLzkPM1b17vA=;
 b=GkvykVO/tpHPvHE39Kpi/Oa26nVqZBjh0pXar1Fe2u5CtkYEPfAUmQhV/sKMxzMMbE
 AwncAyRQ+utZ6TRkm7B0OwFZs+RMGHDBa4bah5atk6XMLalzA1rC+fEu6b/GK+6CO4Sa
 oiXEsHxFL7no8m9UIj2Wy2yogukyESlDajKRoPMg1nOISR0z7RMhx8EE4r9JnjvgX9Q7
 rJ0Um92lT2ZN6TW++r6jK/f0rfiKQkrVrKOmkqE/bNnaH3ADZgCalwO9haLe5R4eHjPy
 LlrrNCt0p9At7ybG+K5GWSiAbcBcK4jhJs3lhZC1cUv28s4zefnKlZPuZJDa2W7Lkvch
 KzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638379; x=1698243179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZILeqkGygukHiY0i/7/5ShUVzUpektIiLzkPM1b17vA=;
 b=X/Mrk8oQLVGxfhGQo5UV5C/Y9xY+w8ymkEyuRugXJdLVONQD7n5Fz2FPOHovOfkeBK
 bqYxtwnQYcIKKNeFRdxbxP5n5mVAvFYMH0wf0y70/mK0MMzhaajglh/NFYaaTJuuHfwB
 PV6RiurGuS7Axgu2NW03fX5x3gPItQCbUxj/Ahpjr47p6OALGoRLvgvRpfmMAlZjjaU8
 QXIT6oSg0YsTJxnDKxNLHkTaF2V3hLpgO+n8OVITnhfvk29VpBV2/gqp6u2ho8Iy2GfK
 8MUIeP8rvdOt2oLozPeav1uYNhqYhFZRPla0vXEnfauUeJblkdF9NSNUkDpz9C2EQNUb
 hFXg==
X-Gm-Message-State: AOJu0YyBRDG9s2LrfcfMWBgwjH6axKbQioRzj+RIOLaNkuckMIBnMb9z
 9lhZfTZrups2NAsLbI2fy8b5ZJYhDH3K1ljiyw0=
X-Google-Smtp-Source: AGHT+IEW66Yc9NUizlK38UliDOpJLfQ0tfDVH9jsBsCmZlBTOOHR3JKdFzEM6HD+/x3NMB0x3GjLKA==
X-Received: by 2002:a17:907:983:b0:9c5:844f:a7f4 with SMTP id
 bf3-20020a170907098300b009c5844fa7f4mr4019629ejc.35.1697638379616; 
 Wed, 18 Oct 2023 07:12:59 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 me8-20020a170906aec800b009928b4e3b9fsm1773362ejb.114.2023.10.18.07.12.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/12] hw/isa: Realize ISA BUS sysbus device before accessing
 it
Date: Wed, 18 Oct 2023 16:11:46 +0200
Message-ID: <20231018141151.87466-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/isa-bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index a289eccfb1..f1e0f14007 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -52,18 +52,25 @@ static const TypeInfo isa_bus_info = {
 ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
                     MemoryRegion *address_space_io, Error **errp)
 {
+    DeviceState *bridge = NULL;
+
     if (isabus) {
         error_setg(errp, "Can't create a second ISA bus");
         return NULL;
     }
     if (!dev) {
-        dev = qdev_new("isabus-bridge");
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        bridge = qdev_new("isabus-bridge");
+        dev = bridge;
     }
 
     isabus = ISA_BUS(qbus_new(TYPE_ISA_BUS, dev, NULL));
     isabus->address_space = address_space;
     isabus->address_space_io = address_space_io;
+
+    if (bridge) {
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(bridge), &error_fatal);
+    }
+
     return isabus;
 }
 
-- 
2.41.0


