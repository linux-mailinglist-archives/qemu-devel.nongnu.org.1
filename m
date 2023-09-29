Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A19127B2E74
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:53:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EG-0006B1-HA; Fri, 29 Sep 2023 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9E8-0005fQ-Au
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9DW-0005ij-35
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMRKISlM1zzvlrL63i/7up7pyLzmuYdCsyEbrLNbyC0=;
 b=BS/irB5aC+XBAyND/vUY4eyEfJAOOA94XstzWx6xxUXonhu/w1hhFt+R+zIIt1B1D4VAv2
 sGUwtNNMUQF7luTrz/rO9Y02fGM5Vus3AAk+A1+szrmdxy1NzxvjQOSzCStEQDYRiTW/IF
 95EiD4KonrjaosfdOTBwcGYSD3d9iKs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-Arhb1a48Pai6zh1peuKSlg-1; Fri, 29 Sep 2023 04:51:19 -0400
X-MC-Unique: Arhb1a48Pai6zh1peuKSlg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-533f8bc82a8so8501362a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977478; x=1696582278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMRKISlM1zzvlrL63i/7up7pyLzmuYdCsyEbrLNbyC0=;
 b=pNWv8sRqVRhNSPlIWBwkYKtlfMygBa9skUx2yyMFcbrYV1tuH6tPZtu66wnGsAcu8k
 8Xt2TiSmiubL2b9FMoHzFgCw8P2peeDmvCixiH5PA2h37TywAEplj9rOOBNoVT6tuPz9
 jg2da4T6aW1mplYt57f+36VXmPAlcyT1wk92OFAfOAZf16uYZpIKZ77gCEr6a6v26SHJ
 8p43C31x3oIcsTAHWhybtyMvraEtC1fdZSCaxBjpYlpmbHsFh5NNyjY6RXTg4L1+Oae1
 M6IDWve2zHYaoRH30UNNwuSWr/Px9hWnNehFu6DuOhTvQlPso1FyCCZ/S3CRiVW5nTgD
 lP+w==
X-Gm-Message-State: AOJu0YwD4OwH//UFX9F0AXox8ymMY1Lpi1gj54q6XmNUlhn1+8VVGdrf
 0qk8I+EZSw+4aV/rrJiRALkzNDr7xRq8iYZ5+V7TEFbY9Zza5KSQvOBGc35+SIQ+bVEtc2TziS6
 mC5ZP1cv3CZKym5k260YVlKr+YmiBVsde0haTEWK8aHcDJZqsv4OwFLbp+MIaIsv1nF9vzhHmuq
 U=
X-Received: by 2002:aa7:d5c4:0:b0:533:4f9b:67c8 with SMTP id
 d4-20020aa7d5c4000000b005334f9b67c8mr3189069eds.16.1695977478280; 
 Fri, 29 Sep 2023 01:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmDoR0yppC90CNYD/bdVfPaQdb9Xt9TRlOOYNwRwR5py+ythrsj6JHbknGxJIEs5x6ZABvLw==
X-Received: by 2002:aa7:d5c4:0:b0:533:4f9b:67c8 with SMTP id
 d4-20020aa7d5c4000000b005334f9b67c8mr3189060eds.16.1695977478043; 
 Fri, 29 Sep 2023 01:51:18 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 cy23-20020a0564021c9700b005362c9905b2sm1893055edb.35.2023.09.29.01.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, balaton@eik.bme.hu,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH v3 02/14] audio: Require AudioState in AUD_add_capture
Date: Fri, 29 Sep 2023 10:50:55 +0200
Message-ID: <20230929085112.983957-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
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

Since all callers require a valid audiodev this function can now safely
abort in case of missing AudioState.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 2f479657117..4332c4c6ce8 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1876,10 +1876,9 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        if (!legacy_config) {
-            dolog("Capturing without setting an audiodev is deprecated\n");
-        }
-        s = audio_init(NULL, NULL);
+        error_setg(&error_abort,
+                   "Capturing without setting an audiodev is not supported");
+        abort();
     }
 
     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
-- 
2.41.0


