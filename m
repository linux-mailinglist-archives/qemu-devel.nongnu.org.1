Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33397AB4FF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiJ1-0001Hf-53; Fri, 22 Sep 2023 11:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIz-0001C8-Im
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIy-0002q4-2j
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMZ+AskVKkkayA7hWqukYo5LCBh6zTOaAKLH+iWgTGE=;
 b=EQg5p31dfaAZ+iJQ0XAh30F5NIs0mEDs3/YhPn6baUEChjwaC6+BM7df6Eq4iRRUuuFhix
 wFr7534kMbBwnBgMflrV9A8HbgJilTG8Uc9pSmgMzEHLsQyaids6NbDgRKmXBPwibws02s
 NTnd9HHSKmXUYiv3VK/p7I0V0gRbqRg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-EhIQt_dKOdO7lQ6VvrBhFw-1; Fri, 22 Sep 2023 11:42:51 -0400
X-MC-Unique: EhIQt_dKOdO7lQ6VvrBhFw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40540179bcdso4655275e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397370; x=1696002170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMZ+AskVKkkayA7hWqukYo5LCBh6zTOaAKLH+iWgTGE=;
 b=CPsD+tMaJqJ4YrqWJ0veQt4DYuMQVN0boyJOHp9LTMDBHzmPbwKJH0ba2Fe/lP+oa7
 65MQWDkaiJmeZDawHMKNv+GFNvdYmXY26lo3BiJ9ySfIFhKJ5mkO4enRzROZArpnuDiv
 HEA5ez48/S57SAi/QEW526LJG2BI7pGu1qzLrZ4bKMEpjagEbrlX1rQ45UvLsl3vSfi9
 ssf7ui3d6iIJ4taVtFkRQ9KBCYCSWC9AAb6cAq9vIrOOQy7+fNMQliiKIOzwcS1HGlbB
 jt3krc8utoNLxELoZCzuoAh7YgXxOVkvbIGmHbPE/ZtoW8PC70nKq2NAEWbRk3aJBnB5
 ifww==
X-Gm-Message-State: AOJu0YystvHtsRO5lfKbpfY56s/A9Oahog2AEwGMDKOdufvX80hZUmYw
 AJOoKXD96s5iM9S0Gac9dd4e1VL4YAiZ/Yp/VaFgawyDsUNL/iH05ghLm9Ih5uMKP6hT8brpYvu
 PgNPdi8faRNoi9cucEcCWWuhKE0mT9mRB3U/QEpbHw09hhlcHTYdycEHryIe2F8HrN/uWPqW70g
 A=
X-Received: by 2002:a5d:4d4c:0:b0:31f:97e2:a924 with SMTP id
 a12-20020a5d4d4c000000b0031f97e2a924mr48367wru.14.1695397369886; 
 Fri, 22 Sep 2023 08:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSX1xydJU9QEVerkJ8R48/IVdwdXsNGgdpis3W6z0iXO6w24s4WhSDqXJQ7XTo63WRMNtAw==
X-Received: by 2002:a5d:4d4c:0:b0:31f:97e2:a924 with SMTP id
 a12-20020a5d4d4c000000b0031f97e2a924mr48352wru.14.1695397369613; 
 Fri, 22 Sep 2023 08:42:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a056000010500b0031ddf6cc89csm4693058wrx.98.2023.09.22.08.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PULL 9/9] vl: recognize audiodev groups in configuration files
Date: Fri, 22 Sep 2023 17:42:28 +0200
Message-ID: <20230922154228.304933-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
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
index 3db4fd26808..db04f98c36f 100644
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


