Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E775C7C5D57
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeRM-0001IX-Pj; Wed, 11 Oct 2023 15:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRK-0001IH-KI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:15 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRH-0006zb-JG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53406799540so390274a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697050809; x=1697655609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6MUwrIZuL3QLaIXRnF54jX+sS97LzvHV1xQT7hr7ns=;
 b=GTc0IaJ3fDiq6zFHk/F+wNyH/wbBZWB7Gkw38ngZDVgHCF6ACC7kAaQq2b5/L+V3OV
 A1ZmIUidkDawk+TTHm9KWdwQOpoyIVRGo8q5O7hi4BLQPmuXRrL1RHUW3nYXrtqL7+Mh
 8DF7ZD02nz7iMTm9CWU3v8+JWMKzPqZql7REOhXtJgGsSNuHS69XfopogbRaT/9C6y4t
 +ikqrQRUqUDSl+Cp/wNBKjwEa0NWMT85/P98hBzl7WminmdS7C9VOqZpr5MY+MtHc0ba
 mu1t6QDJnWwblfQGxu2T7LobuusmsMkyXPVebh4PvZkTRm6nnh6yWg8B4rxWhmVmCiPT
 PjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050809; x=1697655609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6MUwrIZuL3QLaIXRnF54jX+sS97LzvHV1xQT7hr7ns=;
 b=TezE6qBdk0IZsgQrE91gLAj689XpU7kNM/jj5ChaaHH6QP3U4emNic6XNwTM7N/Kc7
 oLqzG6xPyKMAt6AoRvKZcxSDUBhkoWsdXDwZOSVUslMxOVoxFxqKkbzuyYWI7wBaqZKW
 Wlh38eewrjoUqy/3P6fpAmPNgB8zv5PH19hKsIdQTSadjShGi0H1DkjFv/0eLth2Wa6N
 cf7i0ukXi9EFxuxKIe+/vzTamm/NufiGABL6aMjOGK9wYSX+4XGg8TXL0tt3GKtiIHUX
 r1S1+kNXA4Ovj7R2f7Q3y6q6w4SCwc5TSzm1FYzF60zkcUaREk3lFYiZLFJMadUlHjMT
 w6rw==
X-Gm-Message-State: AOJu0Yxj1eao+pwib0iZ3LAxNoX1rCCY2nA3l4Z9ChIUMcA+TLYImePH
 hLCBrvIqoN7xSF0C9MsA4H1h4junoZ4ssY+LDEM=
X-Google-Smtp-Source: AGHT+IFvmK7BxN7REfSS4ExEi+kHgPfKfbQbmi7NlvAB8ZtDYRyFT0pwCfSucgVQBQsM5UaTBXr+lg==
X-Received: by 2002:a05:6402:b0f:b0:536:aead:3486 with SMTP id
 bm15-20020a0564020b0f00b00536aead3486mr15614316edb.40.1697050808830; 
 Wed, 11 Oct 2023 12:00:08 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7c14f000000b0053448f23b33sm9148637edp.93.2023.10.11.12.00.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 12:00:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/4] hw/isa/lpc_ich9: Access memory regions via
 pci_address_space[_io]()
Date: Wed, 11 Oct 2023 20:59:52 +0200
Message-ID: <20231011185954.10337-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185954.10337-1-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

PCI functions are plugged on a PCI bus. They can only access
external memory regions via the bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/lpc_ich9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3f59980aa0..213b667f9b 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -707,8 +707,8 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    isa_bus = isa_bus_new(DEVICE(d), get_system_memory(), get_system_io(),
-                          errp);
+    isa_bus = isa_bus_new(DEVICE(d), pci_address_space(d),
+                          pci_address_space_io(d), errp);
     if (!isa_bus) {
         return;
     }
-- 
2.41.0


