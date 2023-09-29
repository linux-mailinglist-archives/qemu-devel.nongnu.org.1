Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A790C7B2E77
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9ET-0006fx-Ep; Fri, 29 Sep 2023 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EQ-0006at-Vx
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9E3-0005oO-HJ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6lElwUIbLdoz65hukixK+VcaOx6Q0d9fx35MRKLQtU=;
 b=CWS5aqcN1antLRMHVPB1c6GaaUj4AJE+UXUizW9p6IHuEYgX4TZN1kLrxkCy3bJkPnpKpk
 7iiRqgljN386gjI3uIS7zDgxb76HB2UXIszRys4rX8cTcR4hN94pB5cRknPZ0XigO2vGjh
 VFhpSs6u2ZdgAF4ed9hx3dTbry+zgJQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wFi-eXwuPoGLR46VFY_GPw-1; Fri, 29 Sep 2023 04:51:44 -0400
X-MC-Unique: wFi-eXwuPoGLR46VFY_GPw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-531373ea109so11304412a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977502; x=1696582302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6lElwUIbLdoz65hukixK+VcaOx6Q0d9fx35MRKLQtU=;
 b=v+Lhyc9I6qIaMgP3NBfhYkpmeDArSGvROo7mmUTwCm1iCSrs/mXJK385j6nlAtbzp1
 gCUCnhBJU+UZoVv9roZHpSmFid+ofeYdNYtuR8Khxab6dL6igHe7bVl+43OhP04XE6ND
 AAYJdFxG9lcSO+GAUslK/4XL4mstQ+lW9i2FgQi7I0iEGWnX8axBqLvfOUMGF2/Bw0bo
 vYU7ZafibDHbdi/xi3ZzKNXdLKr8MN1UIcDVMpYZkmL09tDcGWqlwtTshRNKybivQ/hc
 9bGbNs6DU6CkgFT0oT/0+Y4vtDPxcWG4Jn/gh02zWfDgHpiz3Sp5J33Xthl25unqKgNj
 3/pQ==
X-Gm-Message-State: AOJu0Yy4Ov/DalZRPULoqo+zkydAa7I9dpJJZ6z8izaPq8nRfUA3wtlU
 IU35x1Z7+JzLBZmkrXDKnvFUeaL9AqDy9lKklZvBPlzXEJMhz+ehX80dKaGJdyhqQ9a+D3RU8pD
 1wpOr17zwo9sxUOsDR6lKEYq3ARijfEAfInCXgqSZtRldCRSSRO3v3lgEc5PPaLK81OvlbnOiQe
 c=
X-Received: by 2002:a05:6402:3454:b0:536:2b33:83ed with SMTP id
 l20-20020a056402345400b005362b3383edmr3622328edc.24.1695977502696; 
 Fri, 29 Sep 2023 01:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAq+gZD2rWb+vGdqUjdiuOFd8NtFse+GDOv/rFHo2rojP9c7ctUXk27tT1jMlm0AKcnLcLnw==
X-Received: by 2002:a05:6402:3454:b0:536:2b33:83ed with SMTP id
 l20-20020a056402345400b005362b3383edmr3622315edc.24.1695977502462; 
 Fri, 29 Sep 2023 01:51:42 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 j5-20020aa7c405000000b00537708be5c6sm542827edq.73.2023.09.29.01.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 13/14] audio: forbid default audiodev backend with
 -nodefaults
Date: Fri, 29 Sep 2023 10:51:06 +0200
Message-ID: <20230929085112.983957-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
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
index f0788345bf8..7cfcbfb6ef1 100644
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


