Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112157AEFFB
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAJk-0001nP-VB; Tue, 26 Sep 2023 11:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlAJb-0001ln-VB
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlAJZ-0005Ou-F2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695743372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jUYC7R0Bsr1lN0lN2GWwwp+UkZzf/EPefO8IwL5rt1A=;
 b=c+NrSozCJlJjzaOkWHeaVPRPpiHmgUXfnR6XK72CVzl4XtfKqIeVB9TNErn+bABs7Rr3Q0
 0P41wU74csiq4Tfq/ap4UZjvaYoOivfnGp3QRIWn2aCOo+RDoumggXJZFoFUvub0bXfrkX
 m55DPVT/k9tQApBJyiOBsTau5mWNv9s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-ioKgBiWPM9-iPfBbbJ8kBg-1; Tue, 26 Sep 2023 11:49:30 -0400
X-MC-Unique: ioKgBiWPM9-iPfBbbJ8kBg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32001e60fb3so5259402f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743368; x=1696348168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUYC7R0Bsr1lN0lN2GWwwp+UkZzf/EPefO8IwL5rt1A=;
 b=hZh0kqxAc/CmPiWwZg+tM9YqNYZ1qV0ST+1ehqQsmee62PWjYUUaKeSadIVBZBrjci
 z+ST73UydnBt8UhLhUKYgdedqQ0BzNYiLa7L3IfJ2pgJXD+cbrHApI5HXcOrU7sE1zyy
 5IQaY/KYbgp7UNxpwvPhaH2w7Iu1uQaA/oRPlBoREBa1yp9iN9uhX3wb+Vi2L6V63mak
 FvrM0zdhdednERyG4WQ/xzjcU9G7kUbsR3uy2oS1XKPl+dTVvhlYvaLnjrOcCjSDp6FG
 eMg7pmoqn76mSC7ksltTgngPxHMuJT23Jc78Exv98GUpem/wDGa1TKxb4uqSE7UKawvO
 Rpew==
X-Gm-Message-State: AOJu0Yxq3TbBR3LEKrGQ3DVYEHk8GuYvQBHPPreTaCyBWlHsWuSimKBZ
 WZqpJJJ/N5UMuveaSUQWMjd3gv/1WHl9l1Frmarhc5jkHDTlgJ70er5u+KFLxoIGCo6s+tSVuC2
 hKTZlcrrVQY31zjqG0pHirozFbgKmC5Yg9x1thgjL5LMo+PBQ0z/9/Jg3EgWOsyU4jdXneCr/oc
 w=
X-Received: by 2002:adf:f583:0:b0:317:6734:c2ae with SMTP id
 f3-20020adff583000000b003176734c2aemr2461153wro.11.1695743367857; 
 Tue, 26 Sep 2023 08:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1MG0W99W6Y+KUKENXX0ogCXPHXn+ZbwA6QfGMY9FA1kv6uIJhpHjAcMruV8TB6VVelvre5g==
X-Received: by 2002:adf:f583:0:b0:317:6734:c2ae with SMTP id
 f3-20020adff583000000b003176734c2aemr2461132wro.11.1695743367449; 
 Tue, 26 Sep 2023 08:49:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adfe751000000b00317909f9985sm14846848wrn.113.2023.09.26.08.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 08:49:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] audio: remove shadowed locals
Date: Tue, 26 Sep 2023 17:49:26 +0200
Message-ID: <20230926154926.728185-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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


