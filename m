Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE170D3B1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1LGV-0000KU-MA; Tue, 23 May 2023 02:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LG3-000084-Df
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LG1-0005HY-46
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-309d3e8777cso2206946f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684822347; x=1687414347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COK8ArK9HCGV7dddfTJnezNiZomsbkwCtC2egyZo1Mg=;
 b=Yq3/SmwS4ficbNhmaVHY92cqgGJxycWoEDAN0RmwiKiWSlLO2G22aYs++YYfZdxd1Z
 mRgkISUri+Q6vwNFoV4CYDXTJXHWLLPeG9zXLop/2FzB0bLmALSYLYmxpoKfHkEVd05f
 rh5MispZtv2jMlgniLg1sJTmqtsQ+2Sh8ICUmCcBvDelVFZ9IUqXqjvc5Av/rhyvDGXA
 CHJEk3sIAwnvYT65vAWpLb9zWU1oOs1gdUpxzodcQN2uJr6dVnUoUKq2rMNfc5YkbgEE
 B45v1bDoJ6HXvoKyVkyAjk3TEKW8NW6bZZ6yv9jW8kPC7+v/yJaiSv5vdI/qvSJ0ObaE
 WdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684822347; x=1687414347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COK8ArK9HCGV7dddfTJnezNiZomsbkwCtC2egyZo1Mg=;
 b=XBxovRV1+i8vEHxETvfXuwApW+KBiqlCY4SXp8WZ3kwCzx6xSmm28oXv1xFHnxeYWc
 t1CsCcXV+Wke5CtlJt1ICVEJWE60BDg4F+vaPivMoR0YHJwsXLyWMlDQn1LV1MQd3yzL
 asg3psC8GIxGji+DsEt/1teWcW+VkC161eSZcUAgZBV1e8CECZbC6HQhWJNDTCgDwlpg
 4maUhl+XcZ7+cJbl/NYElvX8DRZV6HXq2eG4iF+RPNVQIOCWPrhz6rbuZjNKnZbHYI9c
 GL2UtbveXN/hWtdr7wkxaHd/xkmgS9fhqRvrXPCV4cc1swed85GyIb9B5JHKxUnLBDPA
 bSpg==
X-Gm-Message-State: AC+VfDw647fqI7bhhZrdcStdsSmILi+gJSLImJYpX+vL9/+/tmEYFMlv
 uAl089ic7PcZBIxq1M9+9oDAisD4Fbusf62Gc7o=
X-Google-Smtp-Source: ACHHUZ4NNg4+HRofy0XfFyG51ERFZNsg+mUP1EW8DabtBX+aOHR9k5C5wE/nZXBq9uXfU1sBpUdHKA==
X-Received: by 2002:a5d:4204:0:b0:307:7d1a:20fd with SMTP id
 n4-20020a5d4204000000b003077d1a20fdmr10396367wrq.12.1684822347356; 
 Mon, 22 May 2023 23:12:27 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 o9-20020adfeac9000000b0030647d1f34bsm10031319wrn.1.2023.05.22.23.12.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:12:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/pci/pci: Simplify pci_bar_address() using
 MACHINE_GET_CLASS() macro
Date: Tue, 23 May 2023 08:12:06 +0200
Message-Id: <20230523061207.48818-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523061207.48818-1-philmd@linaro.org>
References: <20230523061207.48818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Remove unnecessary intermediate variables.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1cc7c89036..a2cb6071cb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1444,9 +1444,7 @@ pcibus_t pci_bar_address(PCIDevice *d,
 {
     pcibus_t new_addr, last_addr;
     uint16_t cmd = pci_get_word(d->config + PCI_COMMAND);
-    Object *machine = qdev_get_machine();
-    ObjectClass *oc = object_get_class(machine);
-    MachineClass *mc = MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     bool allow_0_address = mc->pci_allow_0_address;
 
     if (type & PCI_BASE_ADDRESS_SPACE_IO) {
-- 
2.38.1


