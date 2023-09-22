Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA07AAE9C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjciv-00022C-Mr; Fri, 22 Sep 2023 05:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcit-00021V-LI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcis-00067k-5W
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJdEfzhhhMMfOiEf/g3p1aD8w9vzoQMGskLuj8de+qg=;
 b=CkfLo/dnEcgOK8pL3PId2hZuekliiNWkJLRRx9ZOyN9xEWngNZT+FkWMSAezZQ124zJMrV
 dgqmvBBD3i9tNSeVobzMbuubHkoykS6vH0bM2s33TQV7d2U/qN99tkbJdHUkVHPz3QQZpF
 BZFHWSWFab3qkDXaafUnyG2FGVIXTxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Ca9eaSKoM6GVlB_3T7Ms8A-1; Fri, 22 Sep 2023 05:45:16 -0400
X-MC-Unique: Ca9eaSKoM6GVlB_3T7Ms8A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31fe49c6bb1so1200673f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375914; x=1695980714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJdEfzhhhMMfOiEf/g3p1aD8w9vzoQMGskLuj8de+qg=;
 b=Cj0FqhVz/WKIDyZ0OieU4Uj0Cy0ZLw/jWMkATUgB/GAmnlU6HLOKDE2xtSZMm3p4Nc
 McnRDOzAlwEPV13Z1yYkTih1HDxo+ITrXDvCCWSzxGnvM1F8z6FbQpN7fdFzZbdwKN2C
 PBwNwnMh0hV13sgZmXHEEBTVuIE6U7DbzNBbJwJFXnqhy99PfX5MNn3FunEXPaVEftDq
 ea5pb05uNfPoYq8HF3NHznVcy5qYY28WSmLJ6lQncKsGxw60uLDfugzlY1ZfFwEG7jQp
 XMPd38RhOrhZnkn63DKbXI0+MR2soveKgC6Ddc8F1yXUSp2Oyeilj5+8EkvbGXuY8UuA
 9+vg==
X-Gm-Message-State: AOJu0YxHXzHEamYJxrGGuJx11uzrJVFvL65C6JzZMG/DkaPhysCOUynM
 MFUWxiff5C3Vk0eR6ClPAUGtg5sNZaZYRj+nHKK+V0I8m9cEkVtKDyHtk/s7OYc95J4E+P6YnrF
 fg2V2YRl0kwgaADpGFRUf/ozeVv9sqbpIas2vzYCOYOtrfTssdnQy0Uu7jxseCBcFs3b+CaH38H
 I=
X-Received: by 2002:a5d:6282:0:b0:321:4ca9:ee86 with SMTP id
 k2-20020a5d6282000000b003214ca9ee86mr8061536wru.53.1695375914693; 
 Fri, 22 Sep 2023 02:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW2F1M/z+Q9LaLE/vWhoLky2ZAoVASgH66r7h8G7zTx5PoSpqeIzvzmaDTbHHv91SwimLcoQ==
X-Received: by 2002:a5d:6282:0:b0:321:4ca9:ee86 with SMTP id
 k2-20020a5d6282000000b003214ca9ee86mr8061520wru.53.1695375914319; 
 Fri, 22 Sep 2023 02:45:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a5d654c000000b00317f29ad113sm3993038wrv.32.2023.09.22.02.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 7/9] vl: recognize audiodev groups in configuration files
Date: Fri, 22 Sep 2023 11:44:57 +0200
Message-ID: <20230922094459.265509-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922094459.265509-1-pbonzini@redhat.com>
References: <20230922094459.265509-1-pbonzini@redhat.com>
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

This is necessary for the q35 configuration tests to pass,
once audiodev becomes mandatory.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/config/q35-emulated.cfg         |  4 ++++
 docs/config/q35-virtio-graphical.cfg |  4 ++++
 softmmu/vl.c                         | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/docs/config/q35-emulated.cfg b/docs/config/q35-emulated.cfg
index c8806e6d362..b4bd7e858a9 100644
--- a/docs/config/q35-emulated.cfg
+++ b/docs/config/q35-emulated.cfg
@@ -288,3 +288,7 @@
   driver = "hda-duplex"
   bus = "ich9-hda-audio.0"
   cad = "0"
+  audiodev = "audiodev0"
+
+[audiodev "audiodev0"]
+  driver = "none"                      # CHANGE ME
diff --git a/docs/config/q35-virtio-graphical.cfg b/docs/config/q35-virtio-graphical.cfg
index 148b5d2c5e4..820860aefe0 100644
--- a/docs/config/q35-virtio-graphical.cfg
+++ b/docs/config/q35-virtio-graphical.cfg
@@ -248,3 +248,7 @@
   driver = "hda-duplex"
   bus = "sound.0"
   cad = "0"
+  audiodev = "audiodev0"
+
+[audiodev "audiodev0"]
+  driver = "none"                      # CHANGE ME
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 70c9eb34dcf..f74fc3d3e40 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2125,6 +2125,7 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
 static bool is_qemuopts_group(const char *group)
 {
     if (g_str_equal(group, "object") ||
+        g_str_equal(group, "audiodev") ||
         g_str_equal(group, "machine") ||
         g_str_equal(group, "smp-opts") ||
         g_str_equal(group, "boot-opts")) {
@@ -2140,6 +2141,15 @@ static void qemu_record_config_group(const char *group, QDict *dict,
         Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(dict));
         object_option_add_visitor(v);
         visit_free(v);
+
+    } else if (g_str_equal(group, "audiodev")) {
+        Audiodev *dev = NULL;
+        Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(dict));
+        if (visit_type_Audiodev(v, NULL, &dev, errp)) {
+            audio_define(dev);
+        }
+        visit_free(v);
+
     } else if (g_str_equal(group, "machine")) {
         /*
          * Cannot merge string-valued and type-safe dictionaries, so JSON
-- 
2.41.0


