Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE780B8D0
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:09:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5c-0005VL-N3; Sat, 09 Dec 2023 23:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5b-0005Uo-4b
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:47 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5Z-0005Ex-LD
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:46 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2866fe08b32so2551761a91.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181204; x=1702786004;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfiBBeSb6qThhLoaGFhlUZSLIyOp5AA9AAyyshggxqw=;
 b=QMB3vl3tCzFsDgUHbGQ6Mvc6ZvXWxRdT6KQu024FpLfrc7MDwPGgJSgQWrYD1eGJ8p
 5XioGzttf30r3l+dsy/S3G5sTNWAwEtsKGCtIA2KiL3AdQVgEGXmVepMFQEt5uMuSseL
 gSPzy5zl0P6u+yf7WEvpxAplkSnEuM7TCNIa6PT8RRAkpHZKIIV9LeYVKtiU6RKKwLRT
 USK2z6CJ6+q+ilmyC0jjWg3LD+RQog7DpSyLcA4wQF/pa03OZ4WG6mtBJxIHSn9WoR/M
 j+Uf5+xEaQ6oxk+fapoTdg6aMZt+ewJvgiDoialz8VHy04Orv209ems1PLI7ZGoZzavo
 5JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181204; x=1702786004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfiBBeSb6qThhLoaGFhlUZSLIyOp5AA9AAyyshggxqw=;
 b=l0H8P1j98uEAATc3Tb8S8nW/eLyvOnQgoDnmUJvNZQwmUgs7iyglHtWD5A7zs22+XO
 /8wRMqS1hvetq80757y6XpLOxYcaU0caRPHvL+/BFflGLYIngjhpNjAPyYd0YYanhlLV
 i8yRnhXJB9voERfOJVydfPx0n9paVw1z6dvPXphaWRtfeFREbP1m3FUDoZnENPIXIgIH
 5R/f7XQRm0KIyA1fFfP5XKLKTQPKTzXQTymMGSGfAptZlavvsVdlaNiCnP6aCdWDkEbn
 O1X13c0O2gqCNo6mOgtsZ2T7yUOz/98zZlAkKHN3Od20RgD6p+QLz1uwPwuPGCI18/bE
 G/YQ==
X-Gm-Message-State: AOJu0YzkGbDIojLLHE6mgXSi7hBuN2zyld10YORZYCIg14klxJbkl6Jw
 aibtyoRQlBkVlivyKFo+qsLRRQ==
X-Google-Smtp-Source: AGHT+IH2nxqgW2XgeyhCU3SDIbdiBCFlsdymdmCCGexjni6ECfbt3bH/5v6H/KWZqd1YkXVOKgdLEQ==
X-Received: by 2002:a17:902:ce86:b0:1d0:3fb3:920a with SMTP id
 f6-20020a170902ce8600b001d03fb3920amr1369596plg.19.1702181204408; 
 Sat, 09 Dec 2023 20:06:44 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q5-20020a170902bd8500b001c9d011581dsm4093365pls.164.2023.12.09.20.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:50 +0900
Subject: [PATCH RFC v2 07/12] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-7-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Release VFs failed to realize just as we do in unregister_vfs().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 5fc146efc4..566aeb9e99 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -92,6 +92,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unrealize_vfs(dev, i);
             return false;
         }

-- 
2.43.0


