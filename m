Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5217AAE24
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVy-0004n7-8J; Fri, 22 Sep 2023 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVr-0004lq-Ue
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVp-0003OP-Rq
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ar0m0LYk0/QKhifyFZnoChpcwJhKJrH0sWIs/crkluE=;
 b=eykTbD5tqla0SVga2wtyjLpGPd6fhd3YMhryzjwyITVQuDnFQ7oKHKYXT9zNXELxbK6IPz
 N7AcsE+xHWn6m8zADD+/A0CwZCsCVgItQeuvVjcfUZ8X4upMBx4ereHsMifhxoLJtxPlGL
 KPixXPLWxLfETpOrARDp0ZcJcZnL2eU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-oDDbCxEyOPaCNaiGirX8tg-1; Fri, 22 Sep 2023 05:31:48 -0400
X-MC-Unique: oDDbCxEyOPaCNaiGirX8tg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so13969455e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375106; x=1695979906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar0m0LYk0/QKhifyFZnoChpcwJhKJrH0sWIs/crkluE=;
 b=gpneGQs3wUdkAjmnTNKTVKaxraSbDXvzZYLyYrSctDI8pNIgda1/Qrcftm5lz33c6A
 LvVZO4JK7AwXIUV7q5s4LSD+CoIuu20nEq5nKYS8zOPS8KRj52XgKvcLajFDs5EsuhnX
 CXWV4LRx2XxkPG4326RPnDV3gREuIKbfQVvordbK9BnIqC+neXDFfbKLlsFLE+pqcPId
 xTAz0nxy2w2QUARm1/IP9EU9YQZHq8Z5tVm5xn02mQmB1YNlmkWLbg0zDEZ8rtODoGb1
 O1e0Q0rKRgsY4PwHQb7SYxjLV2qXsuN2uyaW+mNtWstX91sdi4HkLPqyWe2OdiOPk/6C
 4whg==
X-Gm-Message-State: AOJu0Yy5awM292kaHH1zQnJmlpwQUpC9YqYJcSZXNiUZORi4eZPvFgIb
 W675GCoabIAOarrKLNAvlP41kQRKfRX6uWVZArGzllkmWJ8K3lR/VPPRRICEQgB0SdueJBSSqXs
 Fnc5pVLneklf9FimHUa8hXubRo9yvACFPUMwRRwOihhtEewex0ZLialTggXhQs0IUVvEsAM51hP
 0=
X-Received: by 2002:a05:6000:224:b0:322:da1f:60d9 with SMTP id
 l4-20020a056000022400b00322da1f60d9mr1693332wrz.47.1695375106276; 
 Fri, 22 Sep 2023 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd8osFA3j/Z8aGy1b6/HOQ/j7iFYl3opu8OAEcF4n3rzi6JrQ+tlJGZwc8yOOf0WzJEBScGg==
X-Received: by 2002:a05:6000:224:b0:322:da1f:60d9 with SMTP id
 l4-20020a056000022400b00322da1f60d9mr1693318wrz.47.1695375105953; 
 Fri, 22 Sep 2023 02:31:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a5d68c2000000b0031431fb40fasm3976378wrw.89.2023.09.22.02.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 10/12] audio/spiceaudio: Fail initialisation when not using
 spice
Date: Fri, 22 Sep 2023 11:31:23 +0200
Message-ID: <20230922093126.264016-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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

The caller would already fail, but this way the message can better
express the reason for the failure.

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2043498

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <5db1fdef0330f20ed6ae306b5a71dad1b5e9b44c.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/spiceaudio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index d17ef1a25ef..af9bd7d54c9 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -74,8 +74,9 @@ static const SpiceRecordInterface record_sif = {
 static void *spice_audio_init(Audiodev *dev)
 {
     if (!using_spice) {
-        return NULL;
+        error_setg(&error_fatal, "Cannot use spice audio without -spice");
     }
+
     return &spice_audio_init;
 }
 
-- 
2.41.0


