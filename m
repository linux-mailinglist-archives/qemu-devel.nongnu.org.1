Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E36977784
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 05:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxFJ-0004uX-Dt; Thu, 12 Sep 2024 23:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFG-0004mo-Od
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFF-0008GH-8N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2059204f448so15873385ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199116; x=1726803916;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BRjBowTwtb659ZbVk9eSUPoUW4j3xXhVBm+o7M+tERI=;
 b=GKUt5NmcNRd/bGY0CpyslkvFL/vDJ7SAqpr6kdBGN5T6D3zFzOxh1Zf+vKW1J0n3W1
 WPAQIXovUZztq+YJCXi614Yd2ozGn3nN89Cppxu4iDQKOdlpBGFIucdb1ud3b6JnVhY4
 lh0wd1hVuFqM1aCjw9ZTH0odZwvUqLwTY5iDeUKchwLscq9jGCbyPqqBLMg2bsw/NWbA
 QL4CHp7zUGyUEniye0w1Dtef+O8Pp77TsJ3XIAAQPMBgTXpRYe548jlVFe0ZwGzK0hjQ
 TDpw/WALm/deYxxJvVeomEQMX868XcPMCclzeFTf0QB8EV25IcWgOTpf0RhnZvbbjS/Y
 Sbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199116; x=1726803916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRjBowTwtb659ZbVk9eSUPoUW4j3xXhVBm+o7M+tERI=;
 b=NIKoKG7cZhKTH3XTN8i35/bCDoL7s81x8J/DKFeL8TpHEyBSZzcvLtLeIdek53SoxW
 llHoKNo64ffaadTOvk0MzHVD4eTgQjiWDXTQqbkyvGOnhDDUsu1EFSkIY1p6anMRMMCY
 vFWKtZ2Vf16AFLTd2VhH0dfRPgHDOT4hZFhSPVc8zkiOv6M+qxICdoUnHdZ9Hv1PXklK
 wgFR4vQBEPNCGbg5g4DiDi1spzTSPCRLbJX9kWrSj3I0IbZiIiZE9UIC+Mnt0U4v35Gt
 b/jjjycx22zq7Z5Wtjajn7OIBcXPmXzM1c7MIzKmJrgu5zOULt9VOzFCdjgYjsRnTpci
 PLog==
X-Gm-Message-State: AOJu0Yxzo5Z2pZ29VVKGjUZV9euK2M6JtJ9emWXylD8sbhcLU0BQG6tP
 3P7L4Q0rELFxMTq9uh+u05YzcHRenX6hf54IdLJrY4obghO1MYc4l++bQQPRufc=
X-Google-Smtp-Source: AGHT+IFTdQaF/CVROQMJItjrEcrwMuMRU6w0ITH5Q2mx98f38rcKSS0oXuUy7d5ejAWHvrVttjB5ZQ==
X-Received: by 2002:a17:902:e5c9:b0:206:b8b7:84c with SMTP id
 d9443c01a7336-2076e4247edmr66105495ad.47.1726199115860; 
 Thu, 12 Sep 2024 20:45:15 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20778d365b5sm14487645ad.200.2024.09.12.20.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:45:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:35 +0900
Subject: [PATCH v16 07/13] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-7-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.46.0


