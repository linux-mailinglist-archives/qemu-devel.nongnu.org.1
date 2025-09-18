Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F839B57629
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Sep 2025 12:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6I5-0003ZJ-7k; Mon, 15 Sep 2025 06:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6Hz-0003Y9-Kz; Mon, 15 Sep 2025 06:18:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6Hr-0007gG-Ug; Mon, 15 Sep 2025 06:18:25 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58FA8uML006344
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Sep 2025 19:09:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xaI2KenS6q6E7iB3V1ZG5UGfMQv+qfK+9G24Jw3H4nE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757930943; v=1;
 b=mBE6OLoDL+PAfA0g1RCZqkMYJRKem+Q80Lyz7n5bpAf6woAEud6vHXIKPm16AhyE
 s8Hd1yCTAKQL01BNAEKSKPD62zvLfU4oMmJB70+nGgItoCwLZeVCuTt/LwnGA4+c
 hnLMSupeB2K8Py9TWoOqZqZGI4lQN4Kkg4b8UXvtrHU/E5bl+lqeQKJxy3himtpW
 PHZ73xRjEzbmSQulC9FFryg4TmnxQ/M73aVIUXEohEkYcEHQxxZyJniM87lY3gHl
 2RssHn2tM8GiosRmDKlpdMPjF99YLO5usuH0cf0rfEZ5H7Du2ugVVtKrkQD6kiwY
 h1nCrujbCEw7tOCfwuvmuw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Sep 2025 19:08:49 +0900
Subject: [PATCH v2 08/15] cmd646: Do not delete the subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-use-v2-8-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
References: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It is no longer necessary.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/ide/cmd646.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 2a59516a9ddb..ea4d501c5e40 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -302,17 +302,6 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void pci_cmd646_ide_exitfn(PCIDevice *dev)
-{
-    PCIIDEState *d = PCI_IDE(dev);
-    unsigned i;
-
-    for (i = 0; i < 2; ++i) {
-        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io);
-        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_ioport);
-    }
-}
-
 static const Property cmd646_ide_properties[] = {
     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
 };
@@ -325,7 +314,6 @@ static void cmd646_ide_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, cmd646_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_cmd646_ide_realize;
-    k->exit = pci_cmd646_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_CMD;
     k->device_id = PCI_DEVICE_ID_CMD_646;
     k->revision = 0x07;

-- 
2.51.0


