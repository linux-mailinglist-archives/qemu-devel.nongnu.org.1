Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA67AAE88
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:45:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcis-000213-QP; Fri, 22 Sep 2023 05:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcip-000201-W2
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcik-00065H-Ho
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/uW7JqmfdvTEgpNRrC5GI+FBcbtRDs5b03TvjBCV5Y=;
 b=EfJjg5oB0PjMTIgSM3cljeAfoyWH7Bt+pEPU6rpo29V9qHZZRVLF8GDuEv65XDZ7JWrMcL
 jhXO/eXqoqJ1NhSIWwaNyLODdCbvehHKuXI3795rzFYvNiPorubj4pk+ud796IrGP4/nT4
 CRZg9vqU+WpKotr0JH/E4t4H/3C9Ekc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-E96ArzKYMd--Usu7rfyzug-1; Fri, 22 Sep 2023 05:45:07 -0400
X-MC-Unique: E96ArzKYMd--Usu7rfyzug-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so14852845e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375905; x=1695980705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/uW7JqmfdvTEgpNRrC5GI+FBcbtRDs5b03TvjBCV5Y=;
 b=W1urLm9sqJjfkGqccTqGe9ngfJynN2Y1eTLFXH5yq4XAy6GXWVQaMB8KLgL7KvZ+uF
 GUSZ7mH9bmsVCrMubdZfRtp9wn6MxuX1g9xfaXKZ50g82qthDhQpgIfYQHSHgOW17N+p
 IEsgScuyFQfju5eJ9AWW5sqpDoOOWC5RRIv8p26h+VMEaKHdcDhHsS1wqu8SuPg8wqxu
 xxdSYKLrQayFXqtsSPJYTJbkfrk3nDUFha6UqDN+SPq3iefvA2XvUpui0tQb6xvn1pVH
 hr49cyyCDFIP8PRRDuM2zWBOmtH9zhUlgxoK0GZqgxOizVW70+xUZlDte30EoOguddP3
 RsCQ==
X-Gm-Message-State: AOJu0YwXIKwecERzjI9CREV3R51GGbWNUA4HWR1IA/kLD9/Q8E1IwGme
 YXxzc5MpEzrXjT6iujFadV755sPzdeZ5wHSjfVl7MyYtSuqijRnWC7SnC4dz0Ryt1ooWtthj/Vl
 0vOqFHHziP/K2WuLjit6b7jFn0qWDvlKHyTfi51B40Zng66jO68L8ZJX7jvgABwS2r6/i27KI+U
 0=
X-Received: by 2002:a05:600c:3654:b0:3f5:fff8:d4f3 with SMTP id
 y20-20020a05600c365400b003f5fff8d4f3mr6977134wmq.7.1695375905640; 
 Fri, 22 Sep 2023 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGesIG9fvtIemulmGGJ9VIz71SzOE+mINu6DJt6b/Hat8DYOMTA2X5NHcgPPKupQ4MH11P6zw==
X-Received: by 2002:a05:600c:3654:b0:3f5:fff8:d4f3 with SMTP id
 y20-20020a05600c365400b003f5fff8d4f3mr6977116wmq.7.1695375905254; 
 Fri, 22 Sep 2023 02:45:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a05600c21ce00b003fefcbe7fa8sm4175572wmj.28.2023.09.22.02.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 2/9] Introduce machine property "audiodev"
Date: Fri, 22 Sep 2023 11:44:52 +0200
Message-ID: <20230922094459.265509-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922094459.265509-1-pbonzini@redhat.com>
References: <20230922094459.265509-1-pbonzini@redhat.com>
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
 audio/audio.c       |  4 ++--
 hw/core/machine.c   | 28 ++++++++++++++++++++++++++++
 include/hw/boards.h |  7 +++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 8c74bc6b88c..62047ea3069 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2194,8 +2194,8 @@ const char *audio_maybe_init_dummy(const char *default_id)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
-    if (ms->default_audiodev) {
-        return ms->default_audiodev;
+    if (ms->audiodev) {
+        return ms->audiodev;
     }
 
     dolog("warning: No audiodev specified for implicit machine devices, "
diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf4e14..f677e96a223 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -682,6 +682,22 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
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
+                                         Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->audiodev);
+    ms->audiodev = g_strdup(value);
+}
+
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 {
     int i;
@@ -927,6 +943,17 @@ out_free:
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
@@ -1132,6 +1159,7 @@ static void machine_finalize(Object *obj)
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


