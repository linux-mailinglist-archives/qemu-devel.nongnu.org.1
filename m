Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B47B1512
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllae-0004o7-Pb; Thu, 28 Sep 2023 03:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllac-0004ng-G1
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaZ-00069w-W0
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRcCfHHfRJZEoliXZknMt/jPGA2DXK7pmSmEe/5VPDM=;
 b=FJ5vqT3efgnBjXfXwq+81ap41Lpfm0YmF+MfyXfYyE3xShcLJ9FQGXtXHAfCZJrMCMw3gM
 1oewInfqqYuPIxIrCXWZdhrTGwYk9+KLdbB9XaI3jvDBmHsRUYulm/k7wt/ftrgKPcXtRJ
 O6JtxEBs7fhg7cAsWp8C4LyMDePjmAM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-eoVtasxJMLSlKwEj0L5uMA-1; Thu, 28 Sep 2023 03:37:34 -0400
X-MC-Unique: eoVtasxJMLSlKwEj0L5uMA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso1106722766b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886653; x=1696491453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRcCfHHfRJZEoliXZknMt/jPGA2DXK7pmSmEe/5VPDM=;
 b=MOWsGP2AXNhI0wIyi6amN475aIB8/d6BzzY3hhHD5Jr5jgI/PZCq7pr/qwp9cMFPMq
 JmZG+Nh7YUy5E8TEexFJfWKp9pFEi7l1yj0qy0N743xrugccMK+owNozHOGmCDlFjkcE
 yettrG6zTM5CVzO/crqKC5XPhdphmDx/mHXR6nl8PZUTowYc7VZc725yHFkTG/F4H9xy
 iJ5Dce/VvrRk82+kwgX/FGgDQFnITmn418cfrEw+M+nEHOkTEevXfPfIDzOiLz2RJcp8
 D8HYwWw6F2BAk1M7S5Wn1eqv8qzrJNu0uUuPQhVkw8k//LbFHUqEzmTqdIOgojtFdifH
 2HgA==
X-Gm-Message-State: AOJu0YxvxgBrORXhhC6/oNHjNF2vqPPuK+7CIRZgUeC8IEZqN/3UeZ9r
 B1UtoA5+eFZ6cR5cNs9S7suaHi0asd6voP4Fvp+nkurO99oOuRbvtnfQDGPFkSG4Sj5/SoDtz4n
 08iyowf08CqX4sqymvRy/udPRBCyR2AIgV8GOjrNPilN3IsAegET9RUses6nxU2dHQrtPeiE7Z8
 I=
X-Received: by 2002:a17:906:68c9:b0:99c:75f7:19c1 with SMTP id
 y9-20020a17090668c900b0099c75f719c1mr449940ejr.39.1695886652807; 
 Thu, 28 Sep 2023 00:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ZqtyyBCXpND/uF5eND/8DLDwjnobZY8RqAAhYi5qYUVKm/dxiWohYodb7i4GvUlTdLgD9Q==
X-Received: by 2002:a17:906:68c9:b0:99c:75f7:19c1 with SMTP id
 y9-20020a17090668c900b0099c75f719c1mr449929ejr.39.1695886652575; 
 Thu, 28 Sep 2023 00:37:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 mh2-20020a170906eb8200b0099cc3c7ace2sm10541733ejb.140.2023.09.28.00.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH 13/13] audio: forbid default audiodev backend with -nodefaults
Date: Thu, 28 Sep 2023 09:36:57 +0200
Message-ID: <20230928073705.871327-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928073705.871327-1-pbonzini@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
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

Now that all callers support setting an audiodev, forbid using the default
audiodev if -nodefaults is provided on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index bc837cb2ff2..868164373e1 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1806,10 +1806,12 @@ static AudioState *audio_init(Audiodev *dev)
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
-        if (!QSIMPLEQ_EMPTY(&audiodevs)) {
+        if (!QSIMPLEQ_EMPTY(&audiodevs) || !defaults_enabled()) {
             error_setg(errp, "No audiodev specified for %s", name);
-            error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?",
-                              QSIMPLEQ_FIRST(&audiodevs)->dev->id);
+            if (!QSIMPLEQ_EMPTY(&audiodevs)) {
+                error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?",
+                                  QSIMPLEQ_FIRST(&audiodevs)->dev->id);
+            }
             return false;
         }
 
-- 
2.41.0


