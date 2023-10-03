Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A237B6452
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnap8-0003xW-N6; Tue, 03 Oct 2023 04:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaor-0003lO-Lk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaop-0000Qo-G1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUsBw7Kt7G+GqYe51WoV2cEtrfFekkw/Aub/QiRVm0s=;
 b=FbHnJ9H21vqjoleq/3z3FaUv6mPIjzdL+IM6epM9X0eGb1e7uW0RoKDaTiA5sEuwGGA0p1
 3hot951H0BxGvxV185H8QB8mWnqoSEaGs8h+ZP+N3dY7niHyIbLWrMJnPncYX1f7C/QUap
 9Pd3WaYMdFjsxNvSgJPal5p4WRI1g4E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-vRaCZVsfOH2kwQvhIe_Lug-1; Tue, 03 Oct 2023 04:31:34 -0400
X-MC-Unique: vRaCZVsfOH2kwQvhIe_Lug-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9aa20a75780so51867166b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321892; x=1696926692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUsBw7Kt7G+GqYe51WoV2cEtrfFekkw/Aub/QiRVm0s=;
 b=lg7JXmIAvDpyYEirCZENIJjFZJjdVJNehSqKvK7NrymDkZyPDPT6k+t6Ydl2fn2fgL
 1ae73bpBHqwbxe3H3zMWX4uKV06+yETDeVLfSq4yKIezH6yCRBRsoPfXSXQVoFDvVlXk
 000vg4oziSem9UJGkWzW4MXbjaEldxWLnHSCxpx7nnvkcs+YwIWH2HT+zVrbdcITUIPr
 Jt4bbfrVWK8931z4WS4WVZPqgRkU/ndseCOv2UjPbo3mBrFkZP3OcbuAe8N50ASEr025
 wbNZzHBqzKnsaWNy2XSvp71d114B8H9FFBgjkm7AKiX8XfHRQgem/9TzmMPfFeh8FtO9
 ljFw==
X-Gm-Message-State: AOJu0Yx5Ab52EhOCYERiiJeQTK33d8EQdWQsbIDK1iXvX1knIQwCGcRS
 rFR0JH595rGaPEEOAP5Vy01K/z3gtz83G9klKLdFZFuCcTANR2ka941l0o6vOVgVJyKr0FWTOLK
 bxLkNY5aLjek4hcADvT0OfOSQEm5VCRhIKfQB6h2Qh11/wnTPAYtKhqZplthKk99i+r5bbAozcY
 w=
X-Received: by 2002:a17:906:53ca:b0:9b2:8df4:f2cd with SMTP id
 p10-20020a17090653ca00b009b28df4f2cdmr13563578ejo.18.1696321892687; 
 Tue, 03 Oct 2023 01:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE5jtuibSwzADlm6WMDS0l2IshzEWRllefinMbGTkmaE7Ye/owA2izqeeV61Vqpco545AfMQ==
X-Received: by 2002:a17:906:53ca:b0:9b2:8df4:f2cd with SMTP id
 p10-20020a17090653ca00b009b28df4f2cdmr13563567ejo.18.1696321892417; 
 Tue, 03 Oct 2023 01:31:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a170906065200b0099bca8b9a31sm654596ejb.100.2023.10.03.01.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] audio: forbid default audiodev backend with -nodefaults
Date: Tue,  3 Oct 2023 10:30:41 +0200
Message-ID: <20231003083042.110065-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.145.221.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that all callers support setting an audiodev, forbid using the default
audiodev if -nodefaults is provided on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index 4289b7bf028..730bf2498dc 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1692,6 +1692,10 @@ static void audio_create_default_audiodevs(void)
 {
     const char *drvname = getenv("QEMU_AUDIO_DRV");
 
+    if (!defaults_enabled()) {
+        return;
+    }
+
     /* QEMU_AUDIO_DRV=none is used by libqtest.  */
     if (drvname && !g_str_equal(drvname, "none")) {
         error_report("Please use -audiodev instead of QEMU_AUDIO_*");
@@ -1808,6 +1812,14 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
         if (!QTAILQ_EMPTY(&audio_states)) {
+            /*
+             * FIXME: once it is possible to create an arbitrary
+             * default device via -audio DRIVER,OPT=VALUE (no "model"),
+             * replace this special case with the default AudioState*,
+             * storing it in a separate global.  For now, keep the
+             * warning to encourage moving off magic use of the first
+             * -audiodev.
+             */
             if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
                 dolog("Device %s: audiodev default parameter is deprecated, please "
                       "specify audiodev=%s\n", name,
@@ -1820,6 +1832,10 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
             }
             card->state = audio_init(NULL, errp);
             if (!card->state) {
+                if (!QSIMPLEQ_EMPTY(&audiodevs)) {
+                    error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?",
+                                      QSIMPLEQ_FIRST(&audiodevs)->dev->id);
+                }
                 return false;
             }
         }
-- 
2.41.0


