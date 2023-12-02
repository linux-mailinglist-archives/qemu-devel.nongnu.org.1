Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2C801B50
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:03:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwM-0004Qi-Tr; Sat, 02 Dec 2023 03:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwA-0004Pg-Nj
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:18 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kw9-000564-8p
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:18 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b8b00e44ceso492125b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504076; x=1702108876;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TZILP9ZpP2XzCcOVK4GZRYCbHpA7EhX2b/3i1rkHZjc=;
 b=j1jSt+C1xAPPBor8m6JoLGjIGoJSVoVmT/GAADhXc6eK9jOrrH4M9dzS7oNepJwFcB
 vV8mxO2b6t7yMsbBgG/KZWnduaY6ZY5nf7s0OZByxSagQkLHtU69MP5nUC41kdUt86U9
 9AFBCxowYzWWKQPIM/4Imt/H4R80c6thjWfdqVgBsI56Wpi0yECYfwdgw2IQuws/yKMI
 ED3xkitafNde0uDObS9CAcBy8jYcYJiAzGhzCvnXL31Qwitvt0wwx92JFd/1PLngwySt
 q1d50xcO1FhmAQbmWwbkrgaropsGrHvdxxwRwWL369VwHfwFqHV1B104E4sXojG4iYYZ
 Jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504076; x=1702108876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZILP9ZpP2XzCcOVK4GZRYCbHpA7EhX2b/3i1rkHZjc=;
 b=AapdpBpMfq+dMk7HhLPuC4NxhfLz282DGZr5SC3OLgjEwLPnmL3ltp0rzg5TSf0gOJ
 vm1D4h0GvZVbItPsQ6wA7YBJWpPJ9AzazSuv8z13KH+ECwNVS5LP9oSQX2AI/iHpwOpU
 X+5E55ZBR6jNs5aAACX8Pm1ioJhctbZBRpxZa//bcl9CRHOuSg8bktZmwWHV+GMUK3tS
 qeKNFBVBRg+P/Hy7CnyWOVK4sg8rdGE38PuOqECq1tsQe9t7w6H/dHSA2L2xf5MM6Iv5
 jSZ/odNnbpid5B4yQd1rTO1OBl+/FZnmUPwI8xmaIO/PHFfDZHftYMARdGIoNqjVYJgh
 vh5w==
X-Gm-Message-State: AOJu0YzWDmZRB9+ed+8rOCq3SY4Gp4DvzrWHlQ28qlFHV46ge42616W6
 9qRpQZlUuoDPD+MMCtvHniIeLg==
X-Google-Smtp-Source: AGHT+IGcqEGLFmwEespOAWOTPKGgwXLLsPfsj/OudGsQRbK7uajSv0WBOCUjS3hWBjUErdiNoq3nlQ==
X-Received: by 2002:a05:6808:6489:b0:3b8:b204:b32b with SMTP id
 fh9-20020a056808648900b003b8b204b32bmr724560oib.10.1701504076000; 
 Sat, 02 Dec 2023 00:01:16 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ei11-20020a17090ae54b00b002864f7464a0sm3094593pjb.31.2023.12.02.00.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:32 +0900
Subject: [PATCH 09/14] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-9-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 67d8ae3f61..54d9e0f4cf 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2419,6 +2419,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar && pdev->rom_bar != -1) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == -1) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.43.0


