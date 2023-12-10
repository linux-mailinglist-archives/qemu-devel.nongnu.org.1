Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADED80B8D2
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:09:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5P-0005Qk-8M; Sat, 09 Dec 2023 23:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5N-0005PW-RV
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:33 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5J-0005AP-VU
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:33 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d075392ff6so25769395ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181185; x=1702785985;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iv90WaRou0lXociQaWAWD/OIM+n6G23jcqxCvEIaQPg=;
 b=KYstAUyEECluK2xr2twcCwQcJ2nfkzRmV6nPLzznzT1CZhMoTM15SUG1i1LPTRax9F
 4fxzf4DK46pZ5XBiyvl1EtqzHfg+R4dNj+1i6K0tAWfUWh5HhSBtVm62apKxpHlrMFEm
 sHEbBd7rvXZygZcfuIRTVKWEuUUd23vWADLbccME1+rqPU45I+avdrn9C2NcEhap5vE8
 XIiVC5F81BoP1h82HH0F35ZUlHqdU3hiykYbeCkifUf9EsFyfRzE8f+QWvpTDvIE1S+j
 BRlDia3c9wv8kxMyPCGSbPfoaNM1GVQRFVN5uFjeT0P/Tu2XakJq+U7zNxo7Yi/Wh97S
 NHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181185; x=1702785985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iv90WaRou0lXociQaWAWD/OIM+n6G23jcqxCvEIaQPg=;
 b=PzrgjkmhypEKlpi5W4woTQ/tMzcgSgdQLMOTPAeBmoMc8i2wyGdO/Jw2PUYotoMhGh
 Pd26yIkvxeBP2iF2ZDIUPtM2TaHtcPgBdrmzbsFeZQWGrz3X+aWsIvIyk9dl2ZCgYVTj
 heWOfly286N0YRsPOzlw8peNodl+btxcKrwYHT9oT28hwvODA+EQZ3aJ2VcNKICE3JXH
 /iK5S2P2Bbc78MrLqFqDTDEANys1K+QIRBIJ82eIum898/ON/gNFzrojz9adxpotDEm4
 Zluuv37a4TzcLnU49lq+sAl5KienLZa8r4MkofXLVYfhd3BU9y8P21CLRiS7zBSMcCyG
 pNKg==
X-Gm-Message-State: AOJu0Yz88Cox7YegN+QME1y9eO8olrl6QjP/BALnbD9kDk9l+q3KxctG
 wonalpATYv95PqNo6fgd0tarmA==
X-Google-Smtp-Source: AGHT+IGWvYs4ko5XbnNBhpN9wRXc37oUzw8EsOD/HEcIMy9qbQWZPPOzeLOl8AaWK1XPjc9rLQF3og==
X-Received: by 2002:a17:902:e849:b0:1d0:6ffd:610e with SMTP id
 t9-20020a170902e84900b001d06ffd610emr3244427plg.48.1702181185163; 
 Sat, 09 Dec 2023 20:06:25 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 o12-20020a170902bccc00b001d0696e9237sm4089152pls.118.2023.12.09.20.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:46 +0900
Subject: [PATCH RFC v2 03/12] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-3-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
index 31e8f413a6..5a93cc1681 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2377,6 +2377,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
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


