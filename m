Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7D670F653
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:26:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1nZE-0004iS-Cb; Wed, 24 May 2023 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1nZC-0004iI-7D
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:26:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1nZ7-00016s-7R
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:26:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30959c0dfd6so735432f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684931162; x=1687523162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wh4OJkoX4lxoEYI9VN4kdX8ETxqPDRRE/Wr3N220VXM=;
 b=h9Yn8NLyZRsmea/M0g0+T381Pw3o8KykUXtzY68ZK9x5+wuD8c6gCEYpmSzUEbB/rY
 +VyNJo74T9eFbmi9pTIAwDl+zXLQl0Pv2YK2LaoJpFO7pZrIm5XObpO6B3spP4pota/+
 0f4LGPwrbVONMsdIz7b6yyZEjO9pTmCK5C8HE8WwTx7ZkYhIpsmbxkTRj0dSYcuPbsoE
 Rfn+SyGV5eOj+uf5Z+UYCIsrAVGmxKimW5TEnqAvtS2iUuJMTGDCt9Jnd85BEV84LaRg
 rQandSNX940eY+18zk6DKSkU1rsiX8A9bcemhGE5DQASlTjfJikjChs5XvtBrUfiljy2
 b7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684931162; x=1687523162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wh4OJkoX4lxoEYI9VN4kdX8ETxqPDRRE/Wr3N220VXM=;
 b=dFO8lkQ76GiIyWjg+HfiHbbdqmx28Qt0xh3jWzyjFt1SV4aHDkv9toezut8/7Ijlwp
 mkE4Z3V65bsZIJZc6LSlwhc+XITwZl0WA4ryf3/356YW3cq7NlOFhva4aDWmCX4eC8YN
 rEATDxd8GpeaTD1CZqx7EuEUZjDKoTvrAt74eS6TZjEHayYOS+r8Lm+IUwe62zV+jFD7
 SzERAfi+OwubTP3bXifp0GQ1IriFzwJIR6/VTzcl4qnogQ4EybFKjQaugAPDKUqvJJeI
 ehRkNeCAHt6yxKDC6G4EnNwPpNkFv1WNwRhmeQyJ5ZHYbDhg5Oi/Xal0KmsJV4Y3s87W
 FIjA==
X-Gm-Message-State: AC+VfDyhNZcYgwEb5Z2S0vG6rIOIPqLXwoc+EEteW8zzD1AqwTs77Ke0
 21mgHtivIw4R+f0kP+ntTfhK/xM35+wXA3MRFI63Iw==
X-Google-Smtp-Source: ACHHUZ5h2FC338hHYaQiZjWXuW6l0BKps7/lh84dZhfD0cPnnfyEXRuZC6Y2LlfBlsZMLOaS8tD49Q==
X-Received: by 2002:adf:ee44:0:b0:309:421a:192c with SMTP id
 w4-20020adfee44000000b00309421a192cmr11599720wro.7.1684931162066; 
 Wed, 24 May 2023 05:26:02 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a5d56c4000000b003062d815fa6sm14302536wrw.85.2023.05.24.05.26.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 05:26:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/mips: Use MachineClass->default_nic in the virt machine
Date: Wed, 24 May 2023 14:25:59 +0200
Message-Id: <20230524122559.28863-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20230523110435.1375774-1-thuth@redhat.com>
---
 hw/mips/loongson3_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 25534288dd..216812f660 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -406,6 +406,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     PCIBus *pci_bus;
     DeviceState *dev;
     MemoryRegion *mmio_reg, *ecam_reg;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     LoongsonMachineState *s = LOONGSON_MACHINE(machine);
 
     dev = qdev_new(TYPE_GPEX_HOST);
@@ -456,7 +457,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
         NICInfo *nd = &nd_table[i];
 
         if (!nd->model) {
-            nd->model = g_strdup("virtio");
+            nd->model = g_strdup(mc->default_nic);
         }
 
         pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
@@ -619,6 +620,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->kvm_type = mips_kvm_type;
     mc->minimum_page_bits = 14;
+    mc->default_nic = "virtio-net-pci";
 }
 
 static const TypeInfo loongson3_machine_types[] = {
-- 
2.38.1


