Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CA7ABF02
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQ5-0002lv-U3; Sat, 23 Sep 2023 04:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ4-0002lk-2p
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ2-0000Vv-Ml
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Y5mGHdIaoekDM3qGFpM3ZTJnw3h0Dxzfcg+kd3Bk5A=;
 b=EeHFAtSyf0dOlYam3om+HbFTnzHRg8a7E6ADBcRD5VQIA70X93zVboYTnBARcXBhn6szuw
 C3WuM6kff6XwjreiU7lzvM3in3l5dveHSqR4yUhMstTr7a++1yrtOKJ8EN80vJaMOeTOBJ
 ntWzq54bJ0i83aW2QuY/nGm4mnCy0dM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-tzfSQnI9N52sy61YYkXIYQ-1; Sat, 23 Sep 2023 04:55:15 -0400
X-MC-Unique: tzfSQnI9N52sy61YYkXIYQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso2347118f8f.0
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459313; x=1696064113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y5mGHdIaoekDM3qGFpM3ZTJnw3h0Dxzfcg+kd3Bk5A=;
 b=kygJQsdIPQDcmxAvrjrB19Hymer9q0tlsstWNiLk8tawuL0m8hfqgT1xRl0uOtR06V
 ENii9viG7RnGCXHbsCwGqSnhBJWMSEqH3OfDStkQYOvauSvuYeFCNT4Icf6v8R9yQ8Xq
 3RY4JT50IOqPL4MzHzl25gvRc4h9NaMI8/dqUQxE3nDN/546KsgTenfF5v6Z5Lb+4Q9K
 DMssQ8INT28Wsqk6jaBxMq68qwK5MCBF4T38GQkf4XiHg9wt3MHNdjH6R4QW04nH1wzm
 8vegc3m0M1H8YtXOn3+IqxRYn++mlMD4JzUUTouoR02HYNO3wDbdfVgyGY2lXzmz/s5r
 kcQQ==
X-Gm-Message-State: AOJu0YyxcB1bOwskWio3zjZURBe5k9Xwet4dVTJz1h9TN/A0DOsh0FSI
 Z2fG2orK7KzamBAacjxJovpc/2ljlgMS1CqB4vPD4YEWDtxvQE7TEcINDoQHczGD7keFMYAw6MT
 lrqy+ZR3pLvEBJvo+fl1QzWVMzrBbemrzrNAX6UXCu17iZtuvh/JWxn0qS7Q9jBcx6ImqLWT7vl
 g=
X-Received: by 2002:adf:e4ce:0:b0:321:6414:5869 with SMTP id
 v14-20020adfe4ce000000b0032164145869mr1789121wrm.58.1695459313269; 
 Sat, 23 Sep 2023 01:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2o/qnoAC5EOjNETw0YhDPOd9BIMm6givj3Xq4V2lOXDeGWxXCmCSvuhsWuPA8WWLJf3cpdw==
X-Received: by 2002:adf:e4ce:0:b0:321:6414:5869 with SMTP id
 v14-20020adfe4ce000000b0032164145869mr1789108wrm.58.1695459313007; 
 Sat, 23 Sep 2023 01:55:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a5d66d1000000b0031759e6b43fsm6405634wrw.39.2023.09.23.01.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 02/13] audio: Require AudioState in AUD_add_capture
Date: Sat, 23 Sep 2023 10:54:55 +0200
Message-ID: <20230923085507.399260-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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
index 90c7c49d116..42bfa330146 100644
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


