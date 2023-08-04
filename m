Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9ED7704B7
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwl9-0006NX-O6; Fri, 04 Aug 2023 11:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl1-0006H9-0E; Fri, 04 Aug 2023 11:30:27 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwkz-0004PP-Ey; Fri, 04 Aug 2023 11:30:26 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1bbb4bddd5bso1623295fac.2; 
 Fri, 04 Aug 2023 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163022; x=1691767822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3/xofAUXf9srrGRAG4gcr5JOgWOYN0doTlFr9+WeQU=;
 b=Mj5SRFIOGKQCJ4FMaJm/deeClg9OFshSUODEwiSQIFQvcbwUqIgUnZOfcgAA/9R+ZN
 l+iNR5ximCwSVRRYMDBmF2zVL/NwXaHUT7DdZxiaEkdxVrrcyAm5A8fiduaUUlC2phvV
 3dsJ5og0MpZvcM6oK2tOM6eDbSBC0MEZZ09lGMKRCv6DwvQmuht4hch9hrbMxJcW1VUw
 b+hfUc+TSiFIX0vuGOwW4foJwaEwfHEiyIhlNafsVtyIUV+lDqkgjnzUpYMiBK25RRl7
 lA7xHKJFno/5DgA/k9ioH8XwJNKycs6ovFQY4PxkRAWNNtynn3cT1E1Y7DlYe1KxdtzO
 DEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163022; x=1691767822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3/xofAUXf9srrGRAG4gcr5JOgWOYN0doTlFr9+WeQU=;
 b=XPB8ES6098Tb92iiPPwEZHrssGUoa4EvsqCDGmofS8Ndx6t1W6RA4e1ZFhpUOjn29c
 ob0DZnI4E18ukuiOcncIlyqhYNyLZGkQZuEOPrT81o4bgP2tjAO+DIdUqlSyuRnXP2n4
 Z6+SAU0UhZvC47B7XceHu3F1di1FrVT5OqWGhIAULdVUfNmSKR4X7TdOh/vFspIM+jRW
 pfxoI0amy5oH8HqQrc4bb7Y8aOFPbTpgVoqHzuMJGAIUlI53JyuOB7YRx4Plhjhre3qZ
 esXx9EpwWTj2XfNIczdfa2jrdBgasil41g0e1aD12T9nOKWETQTyTmbcPVGOWbtxGlWk
 LI5Q==
X-Gm-Message-State: AOJu0YwVgk0Isogz5xTXiXvhzRwiRL5lbl6NXqicBGKmLconenx/pY/j
 GuYprIE7WbifyXLBlHBEHurua/39jwU=
X-Google-Smtp-Source: AGHT+IHbEcnJknPSlXF4KCn6PAPzI4+8cbzntclome/M1P1WgK+U1a6UPRmhB1PoxCKdIdq56A5WnA==
X-Received: by 2002:a05:6870:3321:b0:17f:7388:4c69 with SMTP id
 x33-20020a056870332100b0017f73884c69mr2516216oae.30.1691163022642; 
 Fri, 04 Aug 2023 08:30:22 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:22 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 3/7] ppc/pegasos2: Fix naming of device tree nodes
Date: Fri,  4 Aug 2023 12:29:51 -0300
Message-ID: <20230804152955.22316-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The board firmware names devices by their class so match that for
common devices. Also make sure the /rtas node has a name. This is
needed because VOF otherwise does not include it in results got by
nextprop which is how AmigaOS queries it and fails if no name property
is found.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <808ade37aa141563d1ee349254151672bf7a5d59.1689725688.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pegasos2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ed13a42a2..6475acfbed 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -739,6 +739,13 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
                                      pci_get_word(&d->config[PCI_VENDOR_ID]),
                                      pci_get_word(&d->config[PCI_DEVICE_ID]));
 
+    if (pci_get_word(&d->config[PCI_CLASS_DEVICE])  ==
+        PCI_CLASS_NETWORK_ETHERNET) {
+        name = "ethernet";
+    } else if (pci_get_word(&d->config[PCI_CLASS_DEVICE]) >> 8 ==
+        PCI_BASE_CLASS_DISPLAY) {
+        name = "display";
+    }
     for (i = 0; device_map[i].id; i++) {
         if (!strcmp(pn, device_map[i].id)) {
             name = device_map[i].name;
@@ -929,6 +936,7 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-display-device", 0);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-size", 20);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-version", 1);
+    qemu_fdt_setprop_string(fdt, "/rtas", "name", "rtas");
 
     /* cpus */
     qemu_fdt_add_subnode(fdt, "/cpus");
-- 
2.41.0


