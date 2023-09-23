Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA67ABF01
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQH-0002ti-Bb; Sat, 23 Sep 2023 04:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQE-0002rM-G6
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQC-0000Xe-U1
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJXL0n4vVrzyREDY6NDWU/4wIUS60qglXl50wt0Aabs=;
 b=HuNNUJzOVQxo3JdsH+6SCWzquWknj6cxxAAmTrWIhACR5Wcui3L+WoSUht9QdXH0RBFsEb
 sE56O6744RCOIisZFd8VlXot6ad2xr1UNRkpa9wfeLXUVpGq8ojCeChOfRUeMFutyGv/pu
 y/auhTu6so4pVmzw2czFuC6zk1l6Gvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-JgDOJVD0OmayE7oq_qqvnA-1; Sat, 23 Sep 2023 04:55:26 -0400
X-MC-Unique: JgDOJVD0OmayE7oq_qqvnA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so28160925e9.3
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459324; x=1696064124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJXL0n4vVrzyREDY6NDWU/4wIUS60qglXl50wt0Aabs=;
 b=vMMnAHXKlnt0pilF4cvzLqEI3NOGFHbQZzRFB1+4AVWocDihSphTfQZMM2JVecb8oX
 AGl47gnRPkY3vSYifueLDTnAtE2wIQCQw0pWhM0h6qwcn2zxUPxLmpS2DYB6h5ZmaVtS
 0GlMECUsakgoRM+WUj88HJCOGIK4bqnaHlF99Mhm+xq0QlqsyJsT7/gYpMLQ7FDyLPtC
 Xup1NiF5KUj+nkaHAFFFLmWtDws71cIvibWG+yRerbnCYxklxxFegK4TziYwNHrlPh7T
 twjyQwuuq/LP4t547lQ8w6n+aSdWAmX43hGRaZzJuwnyYB2pMh0sXRlDGSqZ0ZTY35Xc
 trBw==
X-Gm-Message-State: AOJu0YwV+cUiXmENKw/qzpmFAI8TL3J7/47NTZ/DVLhGpQ2vzNeD/TH5
 MC1LKMid03KLt2QZdIREg7p7eKtuDKGcb/tw2EwWAZJO72LG0Om1ar8QqqBxhVzs+shvvT5oWZI
 PQ76AVIjteUmchA/QWuCiZX9+xI0yXSaKeyyzx5FtCnpPKLeC1MV3jABzeQNwMTskInr4sb9IK3
 Q=
X-Received: by 2002:a7b:c417:0:b0:405:3455:567e with SMTP id
 k23-20020a7bc417000000b004053455567emr1405065wmi.5.1695459324331; 
 Sat, 23 Sep 2023 01:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC7bLr0ZOF/5mHA5tMheTwbSiJ0UlFskVoxytGKMjDkgMq9+236osJ+oLK27bRT61DMmi72w==
X-Received: by 2002:a7b:c417:0:b0:405:3455:567e with SMTP id
 k23-20020a7bc417000000b004053455567emr1405050wmi.5.1695459323995; 
 Sat, 23 Sep 2023 01:55:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b004051b994014sm9492312wmj.19.2023.09.23.01.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 08/13] Introduce machine property "audiodev"
Date: Sat, 23 Sep 2023 10:55:01 +0200
Message-ID: <20230923085507.399260-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

Many machine types have default audio devices with no way to set the underlying
audiodev.  Instead of adding an option for each and every one of them, this new
property can be used as a default during machine initialisation when creating
such devices.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
[Make the property optional, instead of including it in all machines. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 33 +++++++++++++++++++++++++++++++++
 include/hw/boards.h |  7 +++++++
 2 files changed, 40 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf4e14..6291c0dccaa 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
+#include "audio/audio.h"
 
 GlobalProperty hw_compat_8_1[] = {};
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
@@ -682,6 +683,26 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
     return allowed;
 }
 
+static char *machine_get_audiodev(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->audiodev);
+}
+
+static void machine_set_audiodev(Object *obj, const char *value,
+                                 Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    if (!audio_state_by_name(value, errp)) {
+        return;
+    }
+
+    g_free(ms->audiodev);
+    ms->audiodev = g_strdup(value);
+}
+
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 {
     int i;
@@ -927,6 +948,17 @@ out_free:
     qapi_free_BootConfiguration(config);
 }
 
+void machine_add_audiodev_property(MachineClass *mc)
+{
+    ObjectClass *oc = OBJECT_CLASS(mc);
+
+    object_class_property_add_str(oc, "audiodev",
+                                  machine_get_audiodev,
+                                  machine_set_audiodev);
+    object_class_property_set_description(oc, "audiodev",
+                                          "Audiodev to use for default machine devices");
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1132,6 +1164,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
+    g_free(ms->audiodev);
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6c67af196a3..b5153f5f85b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -24,6 +24,7 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 
 extern MachineState *current_machine;
 
+void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
 bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
@@ -358,6 +359,12 @@ struct MachineState {
     MemoryRegion *ram;
     DeviceMemoryState *device_memory;
 
+    /*
+     * Included in MachineState for simplicity, but not supported
+     * unless machine_add_audiodev_property is called.
+     */
+    char *audiodev;
+
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
     uint64_t   ram_slots;
-- 
2.41.0


