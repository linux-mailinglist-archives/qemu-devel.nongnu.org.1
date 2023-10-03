Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16607B6439
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoX-0002aU-B2; Tue, 03 Oct 2023 04:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoJ-0002LV-Nh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoD-0000JB-1a
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=062lQOPC+PhYZGAGOhww6XlMuZlq/6DlQrwBd4uWz6k=;
 b=NW8l4ARjGnIOqXHeUb3iMLqoKvdq+eTfnqBr7+LpupuqXCiNtKkQMaVpvznIEVVD4mpdJi
 nr1qORhRieIBzwF2ZB59MCbdvIuDRsEIODsxB8PDXwsXJLzH30ZzOztSyGjMQW77UeFJ0A
 4HnPwgbF+iTPChgVN4X6nb/856g4iuI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-scm5HJHLMAiGmvJOnvCuoA-1; Tue, 03 Oct 2023 04:31:10 -0400
X-MC-Unique: scm5HJHLMAiGmvJOnvCuoA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso49810466b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321868; x=1696926668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=062lQOPC+PhYZGAGOhww6XlMuZlq/6DlQrwBd4uWz6k=;
 b=Ep6n+5114Uj6VXC8GC09hYtjf9vLbBs5aSeIy1TVtF8TdL2wAs8d9hdIvpK+j6+1lG
 y3Ti9CqE//3OLXm7WXZ3pnu4TLxxwbSsj3hnTrLGKWDwjg7QiQPXYkezMI27v7A01NZM
 xSqYdnbbAA8xZiiQTZZxOIELl2TRxVHN/yGi60B5SJ9W3Mq5l5NIBAzhkKiMNTzbB4hu
 BygZ+c0Mb/bTJxWAuyc+O0hSabQ4yr96oO4hmNveJA08yumshTJcZU4FsYK95GFCLt9h
 DJB8oBF9PaiOppfATsOBuWvdSfvrMiPwhgQ+f0wnxAXxbtzCQ9vlWWNkDtNHgTp5NcN0
 AcWw==
X-Gm-Message-State: AOJu0YwSBR8UxpuJi3Bw2h8SYqB9qhlhSmsN2EYPJMY0hGFM4VOwom5i
 6747cCwTz/m/pbUYLm7aG1HxunD5xyxM3Uqc+HwjQPFAOqb2ooPQFtJYWs1BDfHwDfxRhg5ZsHL
 qYC8CyLtg57WT/S3JTCOXEPdn8/77lpcWYtZzQOeFBPKiLT+dIiWMNlmyoNBCV6Y06aC9wTxOrG
 U=
X-Received: by 2002:a17:906:749b:b0:992:c8d7:b66f with SMTP id
 e27-20020a170906749b00b00992c8d7b66fmr11749899ejl.75.1696321868326; 
 Tue, 03 Oct 2023 01:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+03vM2Bn88nAlceA/zx7mvqOsVLZXwBO4PQ8ZpGKTbNzlRiplYww0ShjYW77Z3Pe21ueoJg==
X-Received: by 2002:a17:906:749b:b0:992:c8d7:b66f with SMTP id
 e27-20020a170906749b00b00992c8d7b66fmr11749883ejl.75.1696321867965; 
 Tue, 03 Oct 2023 01:31:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a170906089700b009adc77fe165sm653134eje.118.2023.10.03.01.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/24] ui/vnc: Require audiodev= to enable audio
Date: Tue,  3 Oct 2023 10:30:29 +0200
Message-ID: <20231003083042.110065-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


