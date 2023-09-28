Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667247B1518
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaN-0004eK-Hw; Thu, 28 Sep 2023 03:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaI-0004Zl-CH
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaG-00064s-4p
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMRKISlM1zzvlrL63i/7up7pyLzmuYdCsyEbrLNbyC0=;
 b=dpFBZR6dJ0V4AiUfQgaQRDmtH0OMGu6MVUbvM4FWcHiwjV4vu3Hq2HrzEeE0MAvhqwHnBB
 uGJMTVZLXdX0sz9AjCFVB+bM5oYM0lEP1bISy6VhaAi1Po8lnRhXKHgJrV9hw78gHlH855
 B1xjie7jQmOzfYg+6JFLDHOK3i330k0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-uNH-8KLUPjKCFMiyxW__wA-1; Thu, 28 Sep 2023 03:37:12 -0400
X-MC-Unique: uNH-8KLUPjKCFMiyxW__wA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5362b33e8ffso221418a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886631; x=1696491431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMRKISlM1zzvlrL63i/7up7pyLzmuYdCsyEbrLNbyC0=;
 b=L3itafzbV2SBBYxM6zcwtiDgCBKtH/Jw0irJR7NTRbFKYt+YV0DLSWPeFsJ5Em6ANf
 yV6zzvmE0GSxNH2ekgAqCVu/zGTkWc1gXCo2OwI0+KZQ+vPivgYzNlRta/ZfeBrJpRqK
 euloNH1EOzRFjSTgq95AtEO3CrIow89ZHJciRbD/kLIjxjqs9d+clJNuq+iEVdqc55z2
 cCT+VdUKq9n3Uo86/1u/lpGd/jwpPmuD8rPhVfWMiGb3lNA+VtIlRb9WpOkYCsHw1ZZ3
 +6Jyu6DFESbYWA9pxYVwl0ZGUmBdxtdWYwmIVIgQk2f7Yhn5J9SLM0LyxjGB8DFpN5Fr
 73mw==
X-Gm-Message-State: AOJu0YwqFqLh1d5+AqsKdWyhOAWNkA445YfjxRQXvGZu9FXLdUlBFydr
 q889Bh+VwYS8sf1A06QuaXN8VCaa/lBnlKNouwYyO/pLDinpe0K27jMOwt4B8Tmch4ncrStN7+x
 yCbLL0rlBecB00yQDhijz12NzOitgHh5Yy20ZTbz1Qo3FROBuIq15iZIGxqs16gFTl2zkkkffWd
 g=
X-Received: by 2002:a05:6402:b15:b0:51b:d567:cfed with SMTP id
 bm21-20020a0564020b1500b0051bd567cfedmr367458edb.5.1695886631404; 
 Thu, 28 Sep 2023 00:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCxHjehWEuLhiPYDRVI18gkKgF0Wfx4nj/RbjfIs0N8TW7OBZewQP6mJ2NR6iSAhuXmU6sog==
X-Received: by 2002:a05:6402:b15:b0:51b:d567:cfed with SMTP id
 bm21-20020a0564020b1500b0051bd567cfedmr367449edb.5.1695886631147; 
 Thu, 28 Sep 2023 00:37:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a056402278a00b0053447d022f9sm3864211ede.18.2023.09.28.00.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, balaton@eik.bme.hu,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 02/13] audio: Require AudioState in AUD_add_capture
Date: Thu, 28 Sep 2023 09:36:46 +0200
Message-ID: <20230928073705.871327-3-pbonzini@redhat.com>
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


