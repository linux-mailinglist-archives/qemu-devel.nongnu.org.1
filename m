Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9470D3AE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1LGX-0000LQ-Cy; Tue, 23 May 2023 02:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LG8-0000A5-5w
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LG6-0005I7-Jy
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f608074b50so12296685e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684822353; x=1687414353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkILo9SwujHxUBUp1ZR6EEs4lszUfK1/I8whdwDZtw4=;
 b=eYUkRmIuVeopkfcJ9LVh4LhwHPZS+6bZ4svQd24hcus0NHav5uY6o2S+goIp7tIdlI
 j4+v3OzHkpE427LcopqtoiiOmOGDJzUd2xLmnQI/jJROVLCBIpt0O8X1yUDvvFursZJd
 5AbleFBw3yyRURMHHya3sRBMnIyZDNQglIqpx+TNh1EYc+njTv3njw3FVl3NU4HYvGta
 UdjUFryrSiMvlbh8LXDkpGBA6u/MSO0TDQNP3nAmZJxeTyZGHpeA5SSjh+y4key518cu
 t5e3eG6Ms0IEVmQfp5Wg9obJFJIYP9lRYZYXV7BWX25SEBLE3xVqV+TaKeM7JIWfLXJ7
 A6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684822353; x=1687414353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkILo9SwujHxUBUp1ZR6EEs4lszUfK1/I8whdwDZtw4=;
 b=BbbMR/aHvE0i+Clj7gORiTR56X8cBh0M0HWEm0wke2jFmM483zMBUBqA+P1g/Xeb3N
 5vn8JyGgpCO/fEYHQHZuVSn/Xupthla26pkb9nikkZlLKOjZZ77qRT5toONMAA4Rz+m1
 XAuBLkGB57Ft36+RTBv7pbRqNeBWSYbsu1NtPKcxX4DC2wXr6H95ssqRMW9fNoZWicxW
 VPChUaCjrbQBL3IqP0wDK1abUH/73S/XdlqUue98qDOnoKV5Si6mlNr1VdurA6Y2/vpX
 Z+DT/M+rBeJNbj3UDUpLRMClcQ0d4hz63hf4jF2E8ftSTASvgns8DQKWGwWR0aZm+att
 1S+A==
X-Gm-Message-State: AC+VfDxBtBIQN8Y3IUjHDPlBr9iFu4y3EOm9gtX4GMIp1U7N+152wPGA
 UvhEfqvc5WcGiX0HpWMgBcKQj1pvcyNug9MWjww=
X-Google-Smtp-Source: ACHHUZ72kBDLXTDj7pjCxgoMEbwPORButIG5bB1St9qKebFYwl6XzS8F6qkENEz1LWLBnQN4OvS6SA==
X-Received: by 2002:a7b:c393:0:b0:3f6:a66:a36d with SMTP id
 s19-20020a7bc393000000b003f60a66a36dmr860850wmj.10.1684822352954; 
 Mon, 22 May 2023 23:12:32 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 k21-20020a7bc315000000b003f60a9ccd34sm1074830wmj.37.2023.05.22.23.12.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:12:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/usb/hcd-ehci-pci: Simplify using DEVICE_GET_CLASS()
 macro
Date: Tue, 23 May 2023 08:12:07 +0200
Message-Id: <20230523061207.48818-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523061207.48818-1-philmd@linaro.org>
References: <20230523061207.48818-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 4c37c8e227..345444a573 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -74,7 +74,7 @@ static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
 
 static void usb_ehci_pci_init(Object *obj)
 {
-    DeviceClass *dc = OBJECT_GET_CLASS(DeviceClass, obj, TYPE_DEVICE);
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
     EHCIPCIState *i = PCI_EHCI(obj);
     EHCIState *s = &i->ehci;
 
-- 
2.38.1


