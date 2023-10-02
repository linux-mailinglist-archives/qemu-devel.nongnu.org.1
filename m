Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21F7B5589
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKMt-0008DH-7t; Mon, 02 Oct 2023 10:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMq-0008Cs-WC
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMp-0003fg-Cx
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGlxuLyun+dUBX7xD0BT13EOzRTwugSo2SXeCOO3kog=;
 b=NsY8rcY2D0SVJH1y/2vArvHXQe8fyydK6xpuN/ipSVNMLkpjuCV06EDd+U/GeYxaX326k8
 ZDHAlAJcBYhJkM5ws4eKM9jTP+pWxomZCPFzvSpkDdOky4HspszVt1PZiPs1KljCAAMxdW
 Ez4mmWOswkcvhpzQ29sHSrAlvFwawh4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-GOucvuG7OgChWPzXeGflLg-1; Mon, 02 Oct 2023 10:57:47 -0400
X-MC-Unique: GOucvuG7OgChWPzXeGflLg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-325a78c806eso2040078f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258666; x=1696863466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGlxuLyun+dUBX7xD0BT13EOzRTwugSo2SXeCOO3kog=;
 b=WTyOkst1Z/WtEtBGK6dG2oZHS/SDmdJrELSAqQBqo/aSDcWLww7rQYfB0/wXtit0Pu
 rJd5i71XMFucPfccRFCu6IJA35QENVdz5pfX9xM0DCaoCANylLnspwugC/FOkjU3P/x3
 kSx2+7nWmpyEOx3V9xgb5ODUfg3JbmHHVvtKtxmgOkFrGKyWK4BXiZximZxL3cPOB+YJ
 LbM0RxwjCgH8cjzTUbh68hjdcEgcKLi86IsWQkfk0dYOyczV+vNYq+0ciJgu9Zu+NXPY
 CufwZ9l9YNrhxwlbiaOrnrxuHYkPp5uPHe98vUsho/kZyWDIrDxlYC6KoTv9G0tff8YF
 ynQw==
X-Gm-Message-State: AOJu0YxXsX9iFGQj9f1PGhP8iPCFgvdZHw94Jx2R80VlqQyhJJgAXmSe
 vgHPp8ShT/lODbOpbqo8gi/C+iJ8X66GGeHZmVSa9IzZmYw20TDVdf6BGWOzuiJfbKdie0yGhuk
 Ry0O/+iSYDn9RNljVuVVy8jIlsXI3VSq4USpJZ1hzxt8cb0tY5gKg9CoNl8zWpGCMGrp29GeVtw
 A=
X-Received: by 2002:adf:e4cb:0:b0:31f:f432:b541 with SMTP id
 v11-20020adfe4cb000000b0031ff432b541mr9725352wrm.69.1696258666234; 
 Mon, 02 Oct 2023 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Ym7gWLlbRUkSBaWUxKKBzRVBLMpVomQC71y98DYTiKTki7bKEoHWudJLRkUvyYZ09J3/xQ==
X-Received: by 2002:adf:e4cb:0:b0:31f:f432:b541 with SMTP id
 v11-20020adfe4cb000000b0031ff432b541mr9725337wrm.69.1696258665835; 
 Mon, 02 Oct 2023 07:57:45 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 fd18-20020a056402389200b005331f6d4a30sm10025959edb.56.2023.10.02.07.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 08/13] Introduce machine property "audiodev"
Date: Mon,  2 Oct 2023 16:57:22 +0200
Message-ID: <20231002145728.87958-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/hw/boards.h |  9 +++++++++
 2 files changed, 42 insertions(+)

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
index 6c67af196a3..55a64a13fdf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -24,6 +24,7 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 
 extern MachineState *current_machine;
 
+void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
 bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
@@ -358,6 +359,14 @@ struct MachineState {
     MemoryRegion *ram;
     DeviceMemoryState *device_memory;
 
+    /*
+     * Included in MachineState for simplicity, but not supported
+     * unless machine_add_audiodev_property is called.  Boards
+     * that have embedded audio devices can call it from the
+     * machine init function and forward the property to the device.
+     */
+    char *audiodev;
+
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
     uint64_t   ram_slots;
-- 
2.41.0


