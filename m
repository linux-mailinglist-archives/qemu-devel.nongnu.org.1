Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C17B558C
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKMg-00083x-WE; Mon, 02 Oct 2023 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMf-000830-4T
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMd-0003eb-JD
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zaDS58SaB+9o6+flazBQrj9kRQw5pA/KRCUziy84sQ=;
 b=Z3zisqYM8eApoWuD/cMweqdtpTA35G65xq7HNTUXi91L4MI7sKMtUEDbMkChqWV8JtN45Y
 Xnc0T/otrw81+wo/YFtSD3DMZH1XfEo9Tgsltdj8Z/vrDRtnAvnYhX8BZsw5QXMzeSajhP
 /Y++qp7F8cUyjYyQv05JYC+enDS4S1U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296--TFaS8RlPXuzU1P7GyOjLQ-1; Mon, 02 Oct 2023 10:57:37 -0400
X-MC-Unique: -TFaS8RlPXuzU1P7GyOjLQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5349289a704so5645242a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258654; x=1696863454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zaDS58SaB+9o6+flazBQrj9kRQw5pA/KRCUziy84sQ=;
 b=eAT8VqluNslOz+y5r1a9obRgKdkpcTWolCH67R2kPtjAsjjpK36gvReuxmYyhoue7F
 1nClEq6IpWfBBkKyAmGJt6IsmseS7U1LMndL5nscGBYZYWgupKFxBGUPPFN+ZCsLhtCp
 IEer5IrhqOVmp5lHwNdeTIhJcjfIyXk+nN7kSPECX3MXAI8M8NPzNOPL1Po+iJx1/9xn
 XqTZDPYOu+/QToem/ZAURwi9D/kYAtWsZDxwh46oy/uQsFwCbhh+cI0H1ODNDTSNikOg
 GorhA/7fVSemg1ZAIV5MzAu3emzEhe0fej/GOEbNXo1rkaJz6CI1MybcHprh/jNSig0f
 w5aw==
X-Gm-Message-State: AOJu0Yy3W+WqKehYLwcAvtZmvCUNEIOvqPSF76dr1UF73PgeM85KMp3D
 NLmcjnuPJdS6dWlb4i+9tjb7Q6Q0JqocCJI3LMPKLo3lwvCjRHhhR8anB6QLhfgS9Q4k4SmsXfu
 T0HblVR7wQA09gU+EwkYn+5PuhzL7ioVKQlhj1bsPMhU49tcOhFLb10QLf1f/IjY5UowMe4m3Wn
 A=
X-Received: by 2002:aa7:c7c3:0:b0:530:52a0:8b1a with SMTP id
 o3-20020aa7c7c3000000b0053052a08b1amr9435112eds.25.1696258654667; 
 Mon, 02 Oct 2023 07:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfE0WwWkHBXgj0Fyriq9MBTxWrgQD598QKXsABPms1dxHIFBL9KRC9xEy/VXs1QAeaPmwXsQ==
X-Received: by 2002:aa7:c7c3:0:b0:530:52a0:8b1a with SMTP id
 o3-20020aa7c7c3000000b0053052a08b1amr9435100eds.25.1696258654289; 
 Mon, 02 Oct 2023 07:57:34 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 cw27-20020a056402229b00b0052ffc2e82f1sm8536362edb.4.2023.10.02.07.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 02/13] audio: Require AudioState in AUD_add_capture
Date: Mon,  2 Oct 2023 16:57:16 +0200
Message-ID: <20231002145728.87958-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
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
 audio/audio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 2f479657117..d4387cb3e21 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1876,10 +1876,8 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        if (!legacy_config) {
-            dolog("Capturing without setting an audiodev is deprecated\n");
-        }
-        s = audio_init(NULL, NULL);
+        error_report("Capturing without setting an audiodev is not supported");
+        abort();
     }
 
     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
-- 
2.41.0


