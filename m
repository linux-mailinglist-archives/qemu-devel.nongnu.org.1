Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 390817B2E8D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9ED-0005nt-7h; Fri, 29 Sep 2023 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Dj-0005I0-M2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9DU-0005iA-IQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=062lQOPC+PhYZGAGOhww6XlMuZlq/6DlQrwBd4uWz6k=;
 b=NyftmxXBmNuQ7i2gK1B//6L66IRGpzZyuKRX+PGQ4FufQJTXcvmuz8n0AhICYj0+OlRDFo
 cq4+cPyNSRc6kKu5tR0MUssKan5IUgIIyVzySXPh8iw79Vn8YkGyUvldAgMIITrhQ73RkD
 fjIQhTGwP56hB0jYluBVWmt1Q664TP0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-wcuXOiItNNaNFhPIxA3NDg-1; Fri, 29 Sep 2023 04:51:17 -0400
X-MC-Unique: wcuXOiItNNaNFhPIxA3NDg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-530f2ccceeeso10954867a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977476; x=1696582276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=062lQOPC+PhYZGAGOhww6XlMuZlq/6DlQrwBd4uWz6k=;
 b=O5hYp1EsbMBnOCfeyhSUunIOFiKvO5+y8ybkWRlJGqtKnAR+ft7fRzvzlhzGUUH/17
 /L8YycllhfLjIs0uiCrXULLLGmF1QCVcNAh8n6ZKYVJyCBW7pNwknAE6r27Pc+rNfhvt
 G94MuHufBuqCSp7629nzqTFxG3Wr9nvjPWFt/wnYhcC4NidX+GpDiSpz4UKjmEJayrXe
 qE8Xo92dwuRGeH6zeovgue3LjqzBUVM3DjudRptMeSfHXIi3jNOubUMzI32HzgEvaaaZ
 jfnxF1OtzfVjLfgQAV73aHv4d1OWsZd1YgWaHD9uUa37aiuS05eCFRex/35Kco66amba
 91mg==
X-Gm-Message-State: AOJu0Yw4m1wY9apl7XNMZIRYb0wqzoWawqr7syFMzZcrWYHx5dfup8Iy
 w6Glc57W15Q8SNCXSu2PvEhocfco01ZKlHJUhgGRyS9AuY24qQ+3Nk6PkUdbEUyp03SI6ziPzBY
 Qv4CpapqaIjmfKJE/ox17jgPYc3DuGxf88vLX44uCwRYzBx4DVgSGPGgbo7QZfox3+ZU368JP2j
 U=
X-Received: by 2002:a05:6402:3458:b0:532:e6c8:128d with SMTP id
 l24-20020a056402345800b00532e6c8128dmr3746297edc.24.1695977476313; 
 Fri, 29 Sep 2023 01:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMK/rmwUYHGT8Hu+EoTBDBnH2MQ4IMtTpn+15zHijg2jX0tPkqUI7PE+OWiHfAMSVds7BOaw==
X-Received: by 2002:a05:6402:3458:b0:532:e6c8:128d with SMTP id
 l24-20020a056402345800b00532e6c8128dmr3746284edc.24.1695977476001; 
 Fri, 29 Sep 2023 01:51:16 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 v10-20020aa7dbca000000b005330b2d1904sm10711131edt.71.2023.09.29.01.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 01/14] ui/vnc: Require audiodev= to enable audio
Date: Fri, 29 Sep 2023 10:50:54 +0200
Message-ID: <20230929085112.983957-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If there is no audiodev do not send the audio ack in response to
VNC_ENCODING_AUDIO, so that clients aren't told audio exists, and
immediately drop the client if they try to send any audio control messages
when audio is not advertised.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst       |  8 +++-----
 docs/about/removed-features.rst |  6 ++++++
 ui/vnc.c                        | 11 ++++++++++-
 ui/vnc.h                        |  2 ++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8f3fef97bd4..c07bf58dde1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -45,13 +45,11 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help`` option can be used to convert
 the current values of the environment variables to ``-audiodev`` options.
 
-Creating sound card devices and vnc without ``audiodev=`` property (since 4.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Creating sound card devices without ``audiodev=`` property (since 4.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 When not using the deprecated legacy audio config, each sound card
-should specify an ``audiodev=`` property.  Additionally, when using
-vnc, you should specify an ``audiodev=`` property if you plan to
-transmit audio through the VNC protocol.
+should specify an ``audiodev=`` property.
 
 Short-form boolean options (since 6.0)
 ''''''''''''''''''''''''''''''''''''''
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 97ec47f1d25..276060b320c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -436,6 +436,12 @@ the process listing. This was replaced by the new ``password-secret``
 option which lets the password be securely provided on the command
 line using a ``secret`` object instance.
 
+Creating vnc without ``audiodev=`` property (removed in 8.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+When using vnc, you should specify an ``audiodev=`` property if
+you plan to transmit audio through the VNC protocol.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/ui/vnc.c b/ui/vnc.c
index c302bb07a5b..acb56461b2d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2195,7 +2195,10 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             send_ext_key_event_ack(vs);
             break;
         case VNC_ENCODING_AUDIO:
-            send_ext_audio_ack(vs);
+            if (vs->vd->audio_state) {
+                vs->features |= VNC_FEATURE_AUDIO_MASK;
+                send_ext_audio_ack(vs);
+            }
             break;
         case VNC_ENCODING_WMVi:
             vs->features |= VNC_FEATURE_WMVI_MASK;
@@ -2502,6 +2505,12 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                           read_u32(data, 4), read_u32(data, 8));
             break;
         case VNC_MSG_CLIENT_QEMU_AUDIO:
+            if (!vnc_has_feature(vs, VNC_FEATURE_AUDIO)) {
+                error_report("Audio message %d with audio disabled", read_u8(data, 2));
+                vnc_client_error(vs);
+                break;
+            }
+
             if (len == 2)
                 return 4;
 
diff --git a/ui/vnc.h b/ui/vnc.h
index 757fa83044e..96d19dce199 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -464,6 +464,7 @@ enum VncFeatures {
     VNC_FEATURE_LED_STATE,
     VNC_FEATURE_XVP,
     VNC_FEATURE_CLIPBOARD_EXT,
+    VNC_FEATURE_AUDIO,
 };
 
 #define VNC_FEATURE_RESIZE_MASK              (1 << VNC_FEATURE_RESIZE)
@@ -481,6 +482,7 @@ enum VncFeatures {
 #define VNC_FEATURE_LED_STATE_MASK           (1 << VNC_FEATURE_LED_STATE)
 #define VNC_FEATURE_XVP_MASK                 (1 << VNC_FEATURE_XVP)
 #define VNC_FEATURE_CLIPBOARD_EXT_MASK       (1 <<  VNC_FEATURE_CLIPBOARD_EXT)
+#define VNC_FEATURE_AUDIO_MASK               (1 <<  VNC_FEATURE_AUDIO)
 
 
 /* Client -> Server message IDs */
-- 
2.41.0


