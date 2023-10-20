Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CEB7D0B20
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlUk-0003pR-3t; Fri, 20 Oct 2023 05:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlUM-0003Mp-N3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlUF-0005EZ-0x
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NEEz0of07fn4zb+l+XaUCsh2X5on0kwK2ZjeKgP2a8=;
 b=flZbPVG5KP2HL5ows2M8qrBwE0/R2JkwkOQHJnh9Bb6I3A9XBuvzmJnJEUVV+nk+p4D0b2
 qlE4NitQ/kkxrNiBNQcRT6gK6FLyONo5k/fE6ywL2zKft8koho6P47sbDaOUF1SwDmK1e4
 LckBuSREObYBaQGNi2VFO0n2ntKUWhA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-MRsTpopGNtSdsTwOrbaIUw-1; Fri, 20 Oct 2023 05:08:00 -0400
X-MC-Unique: MRsTpopGNtSdsTwOrbaIUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E29C2810D60;
 Fri, 20 Oct 2023 09:07:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C5372166B26;
 Fri, 20 Oct 2023 09:07:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 04/13] migration: Use vmstate_register_any() for ipmi-bt*
Date: Fri, 20 Oct 2023 11:07:22 +0200
Message-ID: <20231020090731.28701-5-quintela@redhat.com>
In-Reply-To: <20231020090731.28701-1-quintela@redhat.com>
References: <20231020090731.28701-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Otherwise device-introspection-test fails.

$ ./tests/qtest/device-introspect-test
...
Broken pipe
../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted (core dumped)

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 2 +-
 hw/ipmi/ipmi_bmc_sim.c    | 2 +-
 hw/ipmi/isa_ipmi_bt.c     | 2 +-
 hw/ipmi/isa_ipmi_kcs.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index e232d35ba2..324a2c8835 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -504,7 +504,7 @@ static void ipmi_bmc_extern_init(Object *obj)
     IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
 
     ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
-    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
+    vmstate_register_any(NULL, &vmstate_ipmi_bmc_extern, ibe);
 }
 
 static void ipmi_bmc_extern_finalize(Object *obj)
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 905e091094..404db5d5bc 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
 
     ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
 
-    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
+    vmstate_register_any(NULL, &vmstate_ipmi_sim, ibs);
 }
 
 static Property ipmi_sim_properties[] = {
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a83e7243d6..afb76b548a 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -125,7 +125,7 @@ static void isa_ipmi_bt_init(Object *obj)
 
     ipmi_bmc_find_and_link(obj, (Object **) &iib->bt.bmc);
 
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, iib);
+    vmstate_register_any(NULL, &vmstate_ISAIPMIBTDevice, iib);
 }
 
 static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index b2ed70b9da..5ab63b2fcf 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -132,7 +132,7 @@ static void isa_ipmi_kcs_init(Object *obj)
      * IPMI device, so receive it, but transmit a different
      * version.
      */
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
+    vmstate_register_any(NULL, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
 static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
-- 
2.41.0


