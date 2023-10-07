Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A97BC79A
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aB-0002oN-Hy; Sat, 07 Oct 2023 08:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aA-0002oD-Bh
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:58 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6a7-0002jU-Lo
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso565163566b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682334; x=1697287134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YASwfFdHYaCXC89A/pWkmcUw1AbhKq8L9jnJIbHajvA=;
 b=Xgh1TNh5xYUFbT1Ag5a3UYVdGcaLQ78BwjK+eQXUZ+/B9lmHWeHtNyokur1UYjDu5n
 6HZsf1fJdHaw+bNDnQYyV6BJo1RVlve5GXTYZ/R5q1grxK7DeBz9FSwbea0DW4KRusk6
 8KPwJ+cTTIeiTfkWvjs8oCwPBFqOZxTjwMe5q5WrhPvDyBUaS1frxc837VT4vP6Cftyl
 vCy0lAmNiKyyB6/PjXLsVlhqOk0jrIH3/SWq9JZSBs+oeSc2697Y+eBLOMjCPgn3L2jY
 q/SRHU7afXJWxC2k/vbaHVmQdmVBHDPug/TN3b1b4lfQw96vfZYD7hTP8apNzYDHWBMz
 e/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682334; x=1697287134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YASwfFdHYaCXC89A/pWkmcUw1AbhKq8L9jnJIbHajvA=;
 b=o6ApE4OEVe/2uMoXzeJ6S2Ymht+IUqdEneWnUfNgXqQQJSX/iQVhChck1OCV4rgwzy
 437AJg9AEhZWSbgYKyjlvXzyHhuCRIKk2huUdW2TPXEbX2gmrT8wdIEWiLhK9mpLA/Xv
 S78ZvuKwbpjbA2F1rJNoJ9MoGcuNTyuqhSdhwv4GGIoUr2WKql6M72wUiXD9VGV87is/
 bpGLUOcI5BXXhMjHk7f3BwH5wZ5U/dibaJy1bCNO6Fa6lxoetA1XMX2W/2iU5PlYji7j
 81Q547lFoPKqmHhFgevh7g18xa+98oqVYcGQav9+b7SY3upT+6exdNnOik5Y/29T4Jf/
 YSAA==
X-Gm-Message-State: AOJu0YzG5Xhst8p/FTJxQZzCzt8xlSa8IRoWESzoZlZCbTkZ854daAz8
 vncuSrax3oDRlBdZbn16pKqqbbUG5KI=
X-Google-Smtp-Source: AGHT+IHgLlAPGoUzdu6ZPNMeeb0uq9Yiy2+Nvo6vkjhgBeNBWQwwLx+thLlqXf8K8dGfH9h3xhg9QA==
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id
 hx7-20020a170906846700b009ae62ecf4a1mr9183965ejc.33.1696682333537; 
 Sat, 07 Oct 2023 05:38:53 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:52 -0700 (PDT)
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
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8 02/29] hw/i386/pc_piix: Allow for setting properties before
 realizing PIIX3 south bridge
Date: Sat,  7 Oct 2023 14:38:10 +0200
Message-ID: <20231007123843.127151-3-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

The next patches will need to take advantage of it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e36a3262b2..6d2f5509e6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -264,7 +264,8 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        pci_dev = pci_create_simple_multifunction(pci_bus, -1, TYPE_PIIX3_DEVICE);
+        pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
             pci_device_set_intx_routing_notifier(
-- 
2.42.0


