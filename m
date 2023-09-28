Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A24597B151A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaU-0004m0-EY; Thu, 28 Sep 2023 03:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaS-0004lV-AX
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaQ-00067q-Q9
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nIZHyME/6b7rtTxYhSqm/zP9fkqfmWO/kM/7NiEJSg=;
 b=McgjkQmCcxnh5OY3GWhS4LzS3BEEhymF6xxtJegVKvd7DRLfnDt+ZV5rivO9Q1uaxwmEsv
 1Wtkci/ufxoiEVRwO24VUnS+a/1XNOheyj6tlBoOAMdyWQaIJ5HdiY/WHq8+VxL3fxb7xP
 Vf0pC729CxLttKd00LSuY6XqG6Ck0Kc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-G4M3wpR1N2C-M91bheI66w-1; Thu, 28 Sep 2023 03:37:24 -0400
X-MC-Unique: G4M3wpR1N2C-M91bheI66w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b2c1159b0aso41123866b.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886643; x=1696491443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nIZHyME/6b7rtTxYhSqm/zP9fkqfmWO/kM/7NiEJSg=;
 b=n1u2QIXxP5otIVC3wAq+uNQha9Kg89R7nxmKE8HSF6j7YAppzghoIfFrI3Jl5io4Vq
 omhR1Y/JCv2RqaSRoGRntsq+acji65SWrjN3hWeuVL7gqey9l7zFE4IgB3fwP+hNL0tm
 7UscTWtlJWwyVq2VQJK5JsKSNXIKMvGkmbjde/8Y5LUKbEWEN4jWz/gFIX8KIvz2E5oA
 w7A55H5RcAanf3amv3v7gBYU4cxmCsMKnm/VO97h/tsKxG4nPAv4phIk7U1mt/ziwkFa
 opS5KIKps+8C/JVULJjBt0ypaWBieElAhpdmxaP+h2WjMkkrrgyjmCj4NAf6ls7TUmkl
 aUrQ==
X-Gm-Message-State: AOJu0YySNLiYPeIEp2LaDYILkyDomsm7jkn21eTpkNXqsRyRVIGR3pqY
 +NMIvWElB+cLs4OUI/qMAHdnT4e2UJuj2TgbH5ji0mIgTehKCsQEwKMp4GTBbr0zeVyuHvd0e+w
 GO3u1bgOy2RPvOT3xA5zFuZ/v8ciFOUPlirAEtQBVxhaC03hT35C6sMDBIY1aMSqmXT3zpsnAk/
 I=
X-Received: by 2002:a17:907:2711:b0:9b2:6b4f:d5ab with SMTP id
 w17-20020a170907271100b009b26b4fd5abmr483653ejk.29.1695886643146; 
 Thu, 28 Sep 2023 00:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY6A17qkyCNObr6QsV9dpa4mW8BQetYaBbCJLM36ppt49RhQJAjnWUCajJKTMB41eQVfwH+w==
X-Received: by 2002:a17:907:2711:b0:9b2:6b4f:d5ab with SMTP id
 w17-20020a170907271100b009b26b4fd5abmr483633ejk.29.1695886642744; 
 Thu, 28 Sep 2023 00:37:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 tk9-20020a170907c28900b009b2b47cd757sm1899337ejc.9.2023.09.28.00.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, balaton@eik.bme.hu,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 08/13] Introduce machine property "audiodev"
Date: Thu, 28 Sep 2023 09:36:52 +0200
Message-ID: <20230928073705.871327-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928073705.871327-1-pbonzini@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
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
index cb38b8cf4cb..6aa49c8d4f1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
+#include "audio/audio.h"
 
 GlobalProperty hw_compat_8_1[] = {};
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
@@ -686,6 +687,26 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
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
@@ -931,6 +952,17 @@ out_free:
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
@@ -1136,6 +1168,7 @@ static void machine_finalize(Object *obj)
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


