Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149DA7FA7A7
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:10:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6C-0007Uh-Gn; Mon, 27 Nov 2023 12:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f63-0007Sa-Jq
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:37 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5y-0004d3-E7
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:35 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c997447ff9so27099201fa.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104908; x=1701709708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uozfwdg6qaLITswlXPk9OVCRz1sYyYvlqurNNgsUApU=;
 b=SQBdXuM1ODmWaIcoB+fL56b2Gc+hwaSl/pKdp5DuxFS42DDEgmctMxEwTHpF0s+iMv
 MSbSO/WIB2HB6PyT6Uo9/eQ06WaLzuAKwa78XY+RmA0VJEY/hB54phXDqx7BWU2GwAwL
 6osgq9emVsNF6xJyNzyd/5ZafSWRmog4J+UDrzQK0OyXrXf0zV69rJTRQonca3JR3zFv
 L4ThvKxkyww7wgX4pNSiaXeTdjgeZnZpRZC99lpo26wpfePn7yXRdep5ljTK1vPy2Mi2
 NQjiYnxdKlSqz5R68zr8HR+HdvuN6A0efn9gP8ddMNkMutbgDp6VlcAb47azwM+NDDSp
 B7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104908; x=1701709708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uozfwdg6qaLITswlXPk9OVCRz1sYyYvlqurNNgsUApU=;
 b=uaLkqtuXPIhv1d3jYJWfScqLu6JNscaDTfY6wKaGWMNO5K92KgLNBR+GIoXqZdpJAo
 M9W5iEnLR7v0SYox8l7EifAnacnJHW5S5YYGDvxvS8+n2cLZKGaDq9cRYoSeD/nK2l6G
 FyVcNz5UFbuCTI74FkKzblf36mLRkiUtmmvb8ew/UlkF/vA5aQ9nH4i9JVcbUpgvMB0d
 6kQp87Pv3Lslq6McEXCZK+Ryyv3LAsz6jQHfEV84nbK7nCVG8vV5w+Zu1hEfsAFTnmkk
 DzAbPn9yXr/UiMHxNaWrlf3XEx9vp2/r/0aHCa2xlpZoTETcO53pwl6hsxXTnKTI33AB
 0rVQ==
X-Gm-Message-State: AOJu0Yw5vmjGNmW7FDwBtvELLiTX8kBuh9m2tX08/7JsabTAFguKMKeA
 +WDWdwQ0fRuUDkxSmxJA9g+/UenwZcwvfK6PYKo=
X-Google-Smtp-Source: AGHT+IGp4ZQVfd/vNJckmtH3M66uhvbZt1CK33a8sn7LxBSEE7JTWWMBK8MN/EnF/A1rdQ9pJalbOg==
X-Received: by 2002:a2e:8ec4:0:b0:2c5:380:2a10 with SMTP id
 e4-20020a2e8ec4000000b002c503802a10mr8451966ljl.25.1701104908725; 
 Mon, 27 Nov 2023 09:08:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] hw/virtio: Add
 VirtioPCIDeviceTypeInfo::instance_finalize field
Date: Mon, 27 Nov 2023 17:08:15 +0000
Message-Id: <20231127170823.589863-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtioPCIDeviceTypeInfo structure, added in commit a4ee4c8baa
("virtio: Helper for registering virtio device types") got extended
in commit 8ea90ee690 ("virtio: add class_size") with the @class_size
field. Do similarly with the @instance_finalize field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231121174051.63038-2-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 1 +
 hw/virtio/virtio-pci.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 5a3f182f998..59d88018c16 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -246,6 +246,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     size_t instance_size;
     size_t class_size;
     void (*instance_init)(Object *obj);
+    void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, void *data);
     InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 205dbf24fb1..e4338795423 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2391,6 +2391,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size = t->instance_size,
         .instance_init = t->instance_init,
+        .instance_finalize = t->instance_finalize,
         .class_size    = t->class_size,
         .abstract      = true,
         .interfaces    = t->interfaces,
-- 
2.34.1


