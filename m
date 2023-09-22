Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85A7AAE85
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:45:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjciq-00020L-P0; Fri, 22 Sep 2023 05:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcil-0001zg-Tu
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcii-000656-Pe
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCxmX/sA/KVkmCXBwpEBmXlLd6ry3Z+OC3PJAGREtq0=;
 b=g+LNxsF8Z4Pw1I5n8w2pKwHIsJ5CCaoXiJVeBm8Wh9sbU1L+cUPnrIpS7Qx2t4GSVL5XP3
 XJsCZNId0bjoIGe5IdrTRuuYxT/Mvyi/InYsseQogKDmM9enooyV0Nj0AbVrYSO7CqjA+k
 BqTeLhpI6M3J5PKsyw3OqvNlnq77fUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-yAV8Dk1VPxG5n_D8p6HGaQ-1; Fri, 22 Sep 2023 05:45:05 -0400
X-MC-Unique: yAV8Dk1VPxG5n_D8p6HGaQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32153a4533eso1281827f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375904; x=1695980704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCxmX/sA/KVkmCXBwpEBmXlLd6ry3Z+OC3PJAGREtq0=;
 b=cAgNywWDPuljHtJ4+AMvBFlnZKS/ODe8nWiNHpa2l58iURU4VcRDeHbLUACqB/UuFv
 Qi2M93j7Rj3TWM3yEqYWKT7MYNEZL3HgfjmkYIJw2/a+LLBqQ4RjPqbRaJOQ2XnzTI5b
 bJgOegoOQAEw9Kefd7W4uGwtJagJc+K65W8iuRAYsrbjqQ62SAd37e5rJqGefJqRdXf5
 z9wnzoaiJN/Q0kqK+gxeD3sEC+YSISdQpQtoyNDcyenRD3clDa0z6wBgIIRr8W1hYIxR
 T52S7oPqmHGToy8E6L7d+Y84L+mX/RFESIU5+2OxYOUgko83+oLLfgrR2aX85d/JDjrj
 h97Q==
X-Gm-Message-State: AOJu0YwzAdS7hiEpvg6rywprZcQkicS97zAALsULfyxTHm1zAktvlWhQ
 qk4x63AWsJ1FES4DnhtOoE9T/Exfy7eBmrDHqlo7SpCOazuIFP4TAJGBaPL3pzwYZCFLyNaPF8n
 OisUtJ9dlFRzPO1QtMQEqDvkwAym/zTrYZy85BLhMDqdP/4S0Be8uni1QzrdNOR1/rxDjsMm1Qk
 A=
X-Received: by 2002:a5d:4f84:0:b0:321:5b64:f744 with SMTP id
 d4-20020a5d4f84000000b003215b64f744mr6805790wru.20.1695375903747; 
 Fri, 22 Sep 2023 02:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAQAN/DwS1LkOYGvQ/BPhGRL0ROjVspExMz6lZUMb3dHS36qsP5fXn8FQXYCUkailhA3J/Qg==
X-Received: by 2002:a5d:4f84:0:b0:321:5b64:f744 with SMTP id
 d4-20020a5d4f84000000b003215b64f744mr6805771wru.20.1695375903349; 
 Fri, 22 Sep 2023 02:45:03 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a5d68c2000000b0031431fb40fasm4004176wrw.89.2023.09.22.02.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 1/9] audio: Add easy dummy audio initialiser
Date: Fri, 22 Sep 2023 11:44:51 +0200
Message-ID: <20230922094459.265509-2-pbonzini@redhat.com>
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

In case of sound devices which are created by default (some of them even with
-nodefaults) it would not be nice to users if qemu required explicit:

  -audiodev driver=none,id=audio0 -machine audiodev=audio0

when they just want to run a VM and not care about any audio output.  Instead
this little helper makes it easy to create a dummy audiodev (driver=none) in
case there is no audiodev specified for the machine.  To make sure users
are not surprised by no sound output a helping message is also printed out.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 34 ++++++++++++++++++++++++++++++++++
 audio/audio.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index d72e7db7fb9..8c74bc6b88c 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -41,6 +41,7 @@
 #include "sysemu/runstate.h"
 #include "ui/qemu-spice.h"
 #include "trace.h"
+#include "hw/boards.h"
 
 #define AUDIO_CAP "audio"
 #include "audio_int.h"
@@ -2174,6 +2175,39 @@ bool audio_init_audiodevs(void)
     return true;
 }
 
+static void audio_init_dummy(const char *id)
+{
+    Audiodev *dev = g_new0(Audiodev, 1);
+    AudiodevListEntry *e = g_new0(AudiodevListEntry, 1);
+
+    dev->driver = AUDIODEV_DRIVER_NONE;
+    dev->id = g_strdup(id);
+
+    audio_validate_opts(dev, &error_abort);
+    audio_init(dev, NULL);
+
+    e->dev = dev;
+    QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
+}
+
+const char *audio_maybe_init_dummy(const char *default_id)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (ms->default_audiodev) {
+        return ms->default_audiodev;
+    }
+
+    dolog("warning: No audiodev specified for implicit machine devices, "
+          "no audio output will be available for these. "
+          "For setting a backend audiodev for such devices try using "
+          "the audiodev machine option.\n");
+
+    audio_init_dummy(default_id);
+
+    return default_id;
+}
+
 audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
 {
     return (audsettings) {
diff --git a/audio/audio.h b/audio/audio.h
index a276ec13eba..81d39526625 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -176,6 +176,8 @@ void audio_help(void);
 AudioState *audio_state_by_name(const char *name);
 const char *audio_get_id(QEMUSoundCard *card);
 
+const char *audio_maybe_init_dummy(const char *default_id);
+
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
 
-- 
2.41.0


