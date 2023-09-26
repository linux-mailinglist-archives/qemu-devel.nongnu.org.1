Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 566827AF174
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQO-0003a5-VG; Tue, 26 Sep 2023 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPj-0002Bp-Ts
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPi-0006kS-F3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUYC7R0Bsr1lN0lN2GWwwp+UkZzf/EPefO8IwL5rt1A=;
 b=WF2cw+CXaXmTty2YNAwU/E92oYu1SscWpn1ovb/MT/GZwpTtmDETNmL3t0ohAN4yJWbknr
 Qg2exFA15wZEQbPXgfCl6N8oy+cNaLAtL03DI6OgXzicOERTQwXEysNI5ntpTmoXsYby9h
 VF8UUVoucrqNgYTHpWoFwzzsg57Z+g4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-BtD_320IP-2_EQDTHv_fcg-1; Tue, 26 Sep 2023 12:59:53 -0400
X-MC-Unique: BtD_320IP-2_EQDTHv_fcg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405334b0873so76150025e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747591; x=1696352391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUYC7R0Bsr1lN0lN2GWwwp+UkZzf/EPefO8IwL5rt1A=;
 b=apCOXYPIrt0A1fJYnhwVpsmVpFBfvlEjovVoK1QUesHrH+uDJF0jQWEj7jvLq0QoXc
 5dJDKvRYBtkhA/49ogex4pT1oHGs7GRgPMB8b8fruSF++qYeNgJSPSmFPwzOIxsiEfiU
 rvr6uhDs+E9QHrfbjXwwroyZKUuMvAiHv6XTnFqxGfQAcWsYqf3dseTqZmJYY5k/78F/
 +56JdqTJ/91vlM/B1GDgxoOS9Lllfed33lkDoAOmjEUt884FNh9C6KO/hELxWUk9NnuW
 QJCAKiY1cjkSOS9hAjP3eOUPsmuX1nnZ0nxRH1+p4/J9pTNunLiXh16Tuixmq/LuJkSa
 wdYg==
X-Gm-Message-State: AOJu0YxF5bA79gyG3QFY+pcXnQZM21iVuwyWIw/+fbaSlc1UQZXvW8Zr
 C51FizIZAQuL0EWHcB/SKHPM9UftAqPtnVhTGnu1DkF1oPDbIKHSHImw/ehfJLuQtBD5ELtu9EF
 cTD+BFYjM9+ls4HIIVfffO5G7jdcBAb/d3Cu+5vcWwVHaoyMqgMBBbF16aCr1Ry7XH5PyiW9pfl
 o=
X-Received: by 2002:a1c:7417:0:b0:3fe:d630:f568 with SMTP id
 p23-20020a1c7417000000b003fed630f568mr8686817wmc.39.1695747591635; 
 Tue, 26 Sep 2023 09:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBS/EDURKnmgJOouU8beiQlVhfnThhy6j1EQfK7AfGAgzZtrnQZ2LkSvGuB6ctDCfMXvGKuQ==
X-Received: by 2002:a1c:7417:0:b0:3fe:d630:f568 with SMTP id
 p23-20020a1c7417000000b003fed630f568mr8686802wmc.39.1695747591275; 
 Tue, 26 Sep 2023 09:59:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b003232380ffd5sm7075870wrb.106.2023.09.26.09.59.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] audio: remove shadowed locals
Date: Tue, 26 Sep 2023 18:59:15 +0200
Message-ID: <20230926165915.738719-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 90c7c49d116..2f479657117 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1706,7 +1706,7 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
     size_t i;
     int done = 0;
     const char *drvname = NULL;
-    VMChangeStateEntry *e;
+    VMChangeStateEntry *vmse;
     AudioState *s;
     struct audio_driver *driver;
     /* silence gcc warning about uninitialized variable */
@@ -1824,8 +1824,8 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
         s->period_ticks = dev->timer_period * (int64_t)SCALE_US;
     }
 
-    e = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
-    if (!e) {
+    vmse = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
+    if (!vmse) {
         dolog ("warning: Could not register change state handler\n"
                "(Audio can continue looping even after stopping the VM)\n");
     }
@@ -1900,10 +1900,8 @@ CaptureVoiceOut *AUD_add_capture(
     cap = audio_pcm_capture_find_specific(s, as);
     if (cap) {
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
-        return cap;
     } else {
         HWVoiceOut *hw;
-        CaptureVoiceOut *cap;
 
         cap = g_malloc0(sizeof(*cap));
 
@@ -1937,8 +1935,9 @@ CaptureVoiceOut *AUD_add_capture(
         QLIST_FOREACH(hw, &s->hw_head_out, entries) {
             audio_attach_capture (hw);
         }
-        return cap;
     }
+
+    return cap;
 }
 
 void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
-- 
2.41.0


