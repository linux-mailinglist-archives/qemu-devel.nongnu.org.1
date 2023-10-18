Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51187CDEC4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Ih-0002OR-OC; Wed, 18 Oct 2023 10:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Ie-00020C-Ce
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Ib-0004xI-LJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:28 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9bda758748eso822338566b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638403; x=1698243203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6bLxBklXqCA6pp1eqkZHUbqa8cn5QQGHgcnGcbF5xE=;
 b=pr7rXlRzw/5V1Q8g12Xg/OAdV/9ZNftxz898sD/B9jJ7X6WoLormgH5nXixN+UsR6Z
 GIvO3XGw/YhZR5cCwhLFYMtPx3lYPsf5Ea8NYLNiz1lH2UTBpJmeRR2MaQkW7GdRWByl
 nv+e01OmDT9zDQa3br6Za8NN9ZT8NNK+MouAvsfQ7n5xQrS7UnjtBuuH1iuwY0epRMCE
 KNV7elM11EfAlp4vzL0dq3oyiZqz/XB9RZALSCKzOTQ3Jida1xZAjeVvSdJX6Kbcpx9Y
 gZW8QrgX1t8koH+ME19XZlQSCkTW7fvI20ZR1kBNQxpaWXp+POe73fh6TLigakgzygR/
 GQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638403; x=1698243203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6bLxBklXqCA6pp1eqkZHUbqa8cn5QQGHgcnGcbF5xE=;
 b=ZXA08am9Zk7DoyoStUV2CTBet+RPiPFHSMMUiEAbIC1KB6jy8w079M2ZS867XKWuNJ
 AY78LMw9T7Pq6/RjjOI7Y5PAQFKJnOJJvslvkb3E25TOaMexwN/jxKtCOGOy35gqnx17
 yx7nAhp89dYkWIebqSEKrp6lNS7fwerVUqKmsa9aJcViC9N+7UAtCAdfucN8qRYM+FW8
 5XJY8zwjFH9fmB2mwTMi4Fw6CNBMSkPSqF7OfmxzTrLBN6Nt910KTWzMBBM1ks17QyM3
 J0nfnd0kcL0WZwrKrez6bRnB1ijrYEW5RLXvT2P0erMI6sXJDhRFux4T1cgIh9m/yMiG
 KTdw==
X-Gm-Message-State: AOJu0YyBCK1hqiaEOdzYbfQ3eKPPBtu4dYBHBO/Ls2i/CLmnbojoPoNf
 OZH3duJPDbSNzYORw5qJzZx6DgL+URGdg+G3R68=
X-Google-Smtp-Source: AGHT+IG/ucOvbNZk25CI+4yODJyfXOga1fSUDEHRF7sTPE9JfgKk8U9UNOU1bSXC0MxcoyckUGUOkg==
X-Received: by 2002:a17:907:968c:b0:9bf:30e8:5bfd with SMTP id
 hd12-20020a170907968c00b009bf30e85bfdmr4613711ejc.48.1697638403486; 
 Wed, 18 Oct 2023 07:13:23 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 j14-20020a170906104e00b009c5c5c2c5a4sm1738187ejj.219.2023.10.18.07.13.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:13:23 -0700 (PDT)
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
Subject: [PATCH 11/12] hw/sysbus: Ensure device is not realized before adding
 MMIO region
Date: Wed, 18 Oct 2023 16:11:49 +0200
Message-ID: <20231018141151.87466-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
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

sysbus_init_mmio() should not be called on realized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 35f902b582..ce54e2c416 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -192,6 +192,11 @@ void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
     int n;
 
     assert(dev->num_mmio < QDEV_MAX_MMIO);
+    if (DEVICE(dev)->realized) {
+        error_report("sysbus_init_mmio(type:%s) but object is realized",
+                     object_get_typename(OBJECT(dev)));
+        abort();
+    }
     n = dev->num_mmio++;
     dev->mmio[n].addr = -1;
     dev->mmio[n].memory = memory;
-- 
2.41.0


