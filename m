Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE887B1517
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaO-0004ft-7G; Thu, 28 Sep 2023 03:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaI-0004Zj-6k
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaF-00064p-CQ
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1brQ0L6jX9JGOmP9MWofOwAVVOt7EQgwkiTZ5/Pclw=;
 b=Ib9nfmS0uaC14I8GtTkh10qHNRVkNrTXUQQmf1/peaKzxeje31CMBDFuUXyzXgtsosfcJ/
 kAxntYSkoO7n66v3WI6bkHeRuA101SSXBjpUN4SucLHnV4VeMk8FEGL7pfGZs7uUKUWryX
 o4sdNnECtYj+Xjx+s4xOnXdRq5+tGpg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-WjPjprHhMWS_QZFqOUfCmg-1; Thu, 28 Sep 2023 03:37:11 -0400
X-MC-Unique: WjPjprHhMWS_QZFqOUfCmg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5334392eb67so24894250a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886629; x=1696491429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1brQ0L6jX9JGOmP9MWofOwAVVOt7EQgwkiTZ5/Pclw=;
 b=c/ffjQiR4UB1L5CqrOVL4QRojayiuClXt07jgsIoB1hvKY6lipzRWq7FR8rGSroijV
 BRdO91gcSVTR3WFGT9hQ4yoQtxAmq8jsgbVgouyqUPxURpYB6+0ZTph/aT141fGzt4f1
 CkJwy+2kBw7tNdxI2/KhNwsmyHGAytc6bo9XX0mWV9SoA8bFJFXcRUZatZ7yrdpX2gOF
 vDxZv01DpW0PSzaU6dVeZO5GjxKY4fIR1gQKopjIqE67Bi97zUqBtuZTqxKbgrDRKVne
 8gzAcIRoIIv6FDlbHbBCFHMey5J7+KfFSE4Ory0XZLTJML/MNJg5NHnZ79hjZ+VANn5B
 hY1A==
X-Gm-Message-State: AOJu0YyvEnJ+8Vq6YjnIF5c2v7WmAUc9oIVQG8l61mbQY8NoWT93Lfkz
 AUq6rUBqVPED4SyFVKDUxERGzX8utEj5sHYw0JBBLF+atX/m9tL4nd1nd49lXT3YCRrM9dH2N7v
 TK4QWgqsy00eAauHiprs8EIzn2SBQ2MKccoD54HCYI5R2F4V4PqRB8LpHtXrvS9yhz2VTVR4/NB
 U=
X-Received: by 2002:a05:6402:5106:b0:533:26cd:37c4 with SMTP id
 m6-20020a056402510600b0053326cd37c4mr517733edd.11.1695886629572; 
 Thu, 28 Sep 2023 00:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOcndHorICbqRyJtuxw4oJ4JfEB+aNAOOLSU+jwQLH18LkKdmrynh0URjMehEBCDli0PpYwA==
X-Received: by 2002:a05:6402:5106:b0:533:26cd:37c4 with SMTP id
 m6-20020a056402510600b0053326cd37c4mr517711edd.11.1695886629265; 
 Thu, 28 Sep 2023 00:37:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a056402121300b0052e9b50dafdsm9169370edw.33.2023.09.28.00.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH 01/13] ui/vnc: Require audiodev= to enable audio
Date: Thu, 28 Sep 2023 09:36:45 +0200
Message-ID: <20230928073705.871327-2-pbonzini@redhat.com>
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

If there is no audiodev do not send the audio ack in response to
VNC_ENCODING_AUDIO, so that clients aren't told audio exists, and
immediately drop the client if they try to send any audio control messages
when audio is not advertised.

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


