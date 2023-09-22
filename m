Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3947AAE29
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVx-0004mx-Ol; Fri, 22 Sep 2023 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVn-0004jW-GE
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVk-0003NZ-F2
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqGt2fPfgTyHEp6DMIYvMCh4gKwvp12ld6099wBQ+mY=;
 b=bl9Hg6q0tIcSZYaGIS0mEJwyOAbgWSkk2CRViPP9GGwPwdW+TAJJLi55NFfpLoxKVDoCuI
 2IQWR3SFegqh+PqqIrjKZ4wy0F2RNw3zr1XQbtZqiUqAjOwbZ/jmRz2KSC1Ox+MNKkcTv0
 mGs+WR6Qs0RfwX6M9Nuk+JeJBd/93JY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-1bb12S-INJCXMb8wv-agUA-1; Fri, 22 Sep 2023 05:31:42 -0400
X-MC-Unique: 1bb12S-INJCXMb8wv-agUA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so15137625e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375100; x=1695979900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqGt2fPfgTyHEp6DMIYvMCh4gKwvp12ld6099wBQ+mY=;
 b=ImaAA7QaeSCtWRjnTmX1Cu16EoiHYBM8tdtednr8Ei32FmEZGU1+Vp7NWJ4oFUhvqF
 xcK8r50OaKFqKaDYHN+8IRMOIFmaFY/hgLtfho9OLUi3qvL3NZxfHxuuQtfvNk7jg29N
 HuN+6MzSeq9YiV4qNHFpSeLp8VtZUKxApT2bn2jJCK67HJlIQFkIBrEDqvzsWc3BITI+
 bCHaOdSMQVAafy75C9xUz9a2RLOGF+EajQnPHZwpSxepUU7WRzxDHVwh4bJegSTVzk/q
 guUyYf8X6w6nBaPvTsatWeg/+w+j4xdRgyWQQFXr3Aw8Xyd4BTVGiW1we6SXivyJf1b5
 RGsA==
X-Gm-Message-State: AOJu0YziZbOYd//MBo8WMEz3ILkh0SQuz24ceVJdHWqcu2VbqGJ+1HBQ
 OZFOYke0k2+9qzNZ4Qz9YZUYlpS8fS3d2TlEbNiWfkdgCbXHwRcIXXXcc7s0ASxNG2rw0I0IY7T
 EWyJSxPhkKVpwcKRnCYnPIZ76uEQLJIfLJ05HxuEPEq2T87aTTzGfCAEo3LaFwAN8l3dzt3RO75
 s=
X-Received: by 2002:a05:600c:b46:b0:3fe:dcd0:2e32 with SMTP id
 k6-20020a05600c0b4600b003fedcd02e32mr8377991wmr.19.1695375100344; 
 Fri, 22 Sep 2023 02:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIVAi7tQwrTEgWXUrHuDYRrTBkQ7r11xeQPtIL95FGD0ojNhmsoed0AB0hSgpg6a9CTjRGgQ==
X-Received: by 2002:a05:600c:b46:b0:3fe:dcd0:2e32 with SMTP id
 k6-20020a05600c0b4600b003fedcd02e32mr8377980wmr.19.1695375100085; 
 Fri, 22 Sep 2023 02:31:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f15-20020adff98f000000b0031ae8d86af4sm3935079wrr.103.2023.09.22.02.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/12] hw/audio/lm4549: Add errp error reporting to init
 function
Date: Fri, 22 Sep 2023 11:31:20 +0200
Message-ID: <20230922093126.264016-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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

From: Martin Kletzander <mkletzan@redhat.com>

This will be used in future commit.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <be1bf295b3c6a3dee272b4b4e8115e37c2a772b5.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/lm4549.c | 3 ++-
 hw/audio/lm4549.h | 3 ++-
 hw/audio/pl041.c  | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index 32b1481b561..418041bc9c6 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -276,7 +276,8 @@ static int lm4549_post_load(void *opaque, int version_id)
     return 0;
 }
 
-void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque)
+void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
+                 Error **errp)
 {
     struct audsettings as;
 
diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index aba9bb5b077..61c3ab12dd3 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -36,7 +36,8 @@ typedef struct {
 extern const VMStateDescription vmstate_lm4549_state;
 
 
-void lm4549_init(lm4549_state *s, lm4549_callback data_req, void *opaque);
+void lm4549_init(lm4549_state *s, lm4549_callback data_req, void *opaque,
+                 Error **errp);
 uint32_t lm4549_read(lm4549_state *s, hwaddr offset);
 void lm4549_write(lm4549_state *s, hwaddr offset, uint32_t value);
 uint32_t lm4549_write_samples(lm4549_state *s, uint32_t left, uint32_t right);
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 03acd4fe344..868dffbfd32 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -564,7 +564,7 @@ static void pl041_realize(DeviceState *dev, Error **errp)
     }
 
     /* Init the codec */
-    lm4549_init(&s->codec, &pl041_request_data, (void *)s);
+    lm4549_init(&s->codec, &pl041_request_data, (void *)s, errp);
 }
 
 static const VMStateDescription vmstate_pl041_regfile = {
-- 
2.41.0


