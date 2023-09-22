Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0FC7AAE9D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcis-00020i-25; Fri, 22 Sep 2023 05:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcip-000202-Vt
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcil-00065s-F7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItSI1WPmKkkEOk3tbrM3yYg3Xv+avjA6O69RCRPouRs=;
 b=DJblDA0btqFvUy1p6Ib8Co/yekvE8uZwEmV7MM0BfcKKGfm+OvWGSACLFhxHasf1UYXGVu
 RkLLAitWgp1+J9bzrVWQqXuFyjRQHbyfMXm2HRnuXl1RFyS7Gyjbdgz7H0EBkzehSSwC9o
 lDc8xn7kd99urE9t9nwzZW16MFNh2nc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-5D5tBuh2PjWDs8k1esuqrQ-1; Fri, 22 Sep 2023 05:45:09 -0400
X-MC-Unique: 5D5tBuh2PjWDs8k1esuqrQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40526a782f7so15022015e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375907; x=1695980707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItSI1WPmKkkEOk3tbrM3yYg3Xv+avjA6O69RCRPouRs=;
 b=YKn783W9ChR2woUBzBXV3qqRX+9apf3GVTcroHcWE/qIbu0oeR8pJ1oVdFGM8jkzVg
 MGpTZJoxHRJNq5wm86NxrFhqUmyk/e52Q5ONlHI0+wgNwXUDixoBhPQhgbNXGiT95W4Q
 tOOZwrdZcukP+azvBDKm+IR6HnYeuj/LxcFVmVOt9ukrS55dtZAye/J2Y8niJ9NKn7oN
 X6Hdo+hHl6vEXp7csj+JJO8M+b3kEzezqbFuH+xh6cmTrz6cG6Mb6zEMtKVzmNpafkhy
 lh9+FJAkqffvkM3s4xNc9l0bq5W78VZ1mODW7sHk9gv8mU0pLEVvvzsL+hH78ZYAiLX/
 4aCw==
X-Gm-Message-State: AOJu0YyAgQPg09AHC1zUyR5fUALCk+/pM3qPZNmb45tn8Ht+bhpXoWiV
 wcW92XD9a5OtgZ/citLKPJhGbS+c7SpR/eChszcj/JhxTTNxLXrhlXTT3BMvaxH32i2MeJD4uAM
 rvFMkrpxytfw3WtEpxjlKZJwCncakxz9T5Bg2d6sImtCEMoVMdoNwkDdvTqQL4AbfnGKw8rDI/5
 M=
X-Received: by 2002:a05:600c:4c14:b0:405:3cb7:b4ea with SMTP id
 d20-20020a05600c4c1400b004053cb7b4eamr1588263wmp.37.1695375907505; 
 Fri, 22 Sep 2023 02:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESExvccsAWVFpXum6EL8Oo4d3mDKTjZv4g8wmIVYUS/dnT/8mPEeWJLVB2tO87xY47rDvFpw==
X-Received: by 2002:a05:600c:4c14:b0:405:3cb7:b4ea with SMTP id
 d20-20020a05600c4c1400b004053cb7b4eamr1588248wmp.37.1695375907129; 
 Fri, 22 Sep 2023 02:45:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a05600c479300b00405391f485fsm2867742wmo.41.2023.09.22.02.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 3/9] vl: support -audio BACKEND without model
Date: Fri, 22 Sep 2023 11:44:53 +0200
Message-ID: <20230922094459.265509-4-pbonzini@redhat.com>
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

For machines with an embedded audio device, "-audio BACKEND" will
set the audiodev property of the machine itself.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5a1413da2aa..70c9eb34dcf 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2933,11 +2933,12 @@ void qemu_init(int argc, char **argv)
                 if (!qdict_haskey(dict, "id")) {
                     qdict_put_str(dict, "id", "audiodev0");
                 }
-                if (!qdict_haskey(dict, "model")) {
-                    error_setg(&error_fatal, "Parameter 'model' is missing");
+                if (qdict_haskey(dict, "model")) {
+                    model = g_strdup(qdict_get_str(dict, "model"));
+                    qdict_del(dict, "model");
+                } else {
+                    model = g_strdup("default");
                 }
-                model = g_strdup(qdict_get_str(dict, "model"));
-                qdict_del(dict, "model");
                 if (is_help_option(model)) {
                     show_valid_soundhw();
                     exit(0);
@@ -2947,7 +2948,11 @@ void qemu_init(int argc, char **argv)
                 visit_type_Audiodev(v, NULL, &dev, &error_fatal);
                 visit_free(v);
                 audio_define(dev);
-                select_soundhw(model, dev->id);
+                if (g_str_equal(model, "default")) {
+                    qdict_put_str(machine_opts_dict, "audiodev", dev->id);
+                } else {
+                    select_soundhw(model, dev->id);
+                }
                 g_free(model);
                 break;
             }
-- 
2.41.0


