Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C7D7BC7B0
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aD-0002pG-E7; Sat, 07 Oct 2023 08:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aB-0002p4-Kv
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6a8-0002jc-VK
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:58 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so5311476a12.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682335; x=1697287135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzK1a2suX16jXRtK99yMNcoH6cs1OCetOB1WLNV/G9A=;
 b=jgHCPAYqc0+Ai4VYfSXzoBQWlJhWjCiDMwVkOBW5qNTVb2E+8PiB8cftBJKlzTtn+s
 uSr06dCxVD5T1vS8fRLN8tf01r2sHdLGEGZuJ2yjiqSy4B5dLostOcoG/m2+roWyMfmv
 FJDp2imQ/l4I9C5tcQu6uwM2jlX4WuttksdJAe3ZjquYBdu7ilfm9W8QCcTrTIk79yDe
 t2D/xZLNyByL4Xef5TbK4sZLAmBzR1IWk4EWWRuX9vxpYeXVbFAtmqW2hTissjaQthAH
 wNGWxPUwVRmf3RRLQhLCLiamU7Qup7CrVcqsCxkWdon3bj2epf0fs9W1y6m9JkYNbuAS
 kwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682335; x=1697287135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzK1a2suX16jXRtK99yMNcoH6cs1OCetOB1WLNV/G9A=;
 b=rHfrcG0cRYt+oD2pLuv3oj6jPtlAfpaq6J5vlpTJA+vfJvLVQIbk09FL489lOKFlIZ
 uS/AKs/4G90AU+1OGgKP9GktC5i8MiDtz+DtFNgiBbYWuxbh4U4CKTbGwnlPT9Xg6tC1
 QW+AqujVQW/8bYDqjTsY/dzY9UCn3AXzQJNH0yl2PrBXxelk1Ij2iGJPVw5jGpcElEzw
 lNTZ32g3XpF6CCZSoTBdHVIKvfo6qx/m1nJbo0N4dgu4NBgZ1E7zOLjpK4KmdGsB44l+
 p9TDS+LCS56DpU3jh6bTCxtCcsZF1O3JbUfgfwwIT+S0E21lIYTFp21ZNw19mMxqqkhj
 cF7A==
X-Gm-Message-State: AOJu0Ywf0ZjJstF65LNaRtPh06Q2rmCTuDdh2TpGeGie5IiJXT6qJXYd
 k1vVUvjUAFuZzlWueAk21nRFfPVbHtE=
X-Google-Smtp-Source: AGHT+IHkDn9ANd7TAhZIxaXjpce8ujG7iuQSpY8rcU24g+CwN5N37NlkCbjIX1Sx24XSrVrvBfWl8g==
X-Received: by 2002:a17:906:5306:b0:9ae:51c8:ded1 with SMTP id
 h6-20020a170906530600b009ae51c8ded1mr8543019ejo.50.1696682334787; 
 Sat, 07 Oct 2023 05:38:54 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 03/29] hw/i386/pc_piix: Assign PIIX3's ISA interrupts
 before its realize()
Date: Sat,  7 Oct 2023 14:38:11 +0200
Message-ID: <20231007123843.127151-4-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Unlike its PIIX4 counterpart, TYPE_PIIX3_DEVICE doesn't instantiate a PIC
itself. Instead, it relies on the board to do so. This means that the board
needs to wire the ISA IRQs to the PIIX3 device model. As long as the board
assigns the ISA IRQs after PIIX3's realize(), internal devices can't be wired in
pci_piix3_realize() since the qemu_irqs are still NULL. Fix that by assigning
the ISA interrupts before realize(). This will allow for embedding child devices
into the host device as already done for PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

---

Note that this avoids the "PIC proxy" of previous iterations of the PIIX
consolidation series. Assigning the IRQs before realize() has been agreed upon
at KVM forum 2023.
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6d2f5509e6..a003923788 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -265,6 +265,8 @@ static void pc_init1(MachineState *machine,
         PCIDevice *pci_dev;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        piix3 = PIIX3_PCI_DEVICE(pci_dev);
+        piix3->pic = x86ms->gsi;
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
@@ -281,8 +283,6 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        piix3->pic = x86ms->gsi;
         piix3_devfn = piix3->dev.devfn;
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-- 
2.42.0


