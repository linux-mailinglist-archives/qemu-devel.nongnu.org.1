Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF9831923
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRx-0003aH-Om; Thu, 18 Jan 2024 07:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRp-0003VF-HI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRn-0006A3-EU
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgR/sVi8gSL0IDF14DxKGC6MRJw27EltXky4KfMrUso=;
 b=iKbHf96apBsT980rEtIdo7oMsnIlUVwMdWXumYZjeQvAlXmg2gJh6CatYLx5EgwsyRNd5C
 9auQRrHI3KCu27mVwsNgZnNrz1bD3fzltHLGVW/ocZaEtKOhP83sgza0h3fvti9F5uj6sf
 JbxNsiURYY/g5JOACw3FyAxxzUTb7jE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-wDTHMuk6MAa-arCcXWgcKg-1; Thu, 18 Jan 2024 07:24:37 -0500
X-MC-Unique: wDTHMuk6MAa-arCcXWgcKg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso460739066b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580675; x=1706185475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgR/sVi8gSL0IDF14DxKGC6MRJw27EltXky4KfMrUso=;
 b=R8/eQgqD6KnTUx4I1JLoWUrQhOs93Yt1pWAayG6HETkkRB6gn1RiFCqPUfTIgdP+tu
 VczQpIBnj5xo9TCoFiqoqmgskNhu8WDxgE++YYzUOx9dTVCOhI4Ywbvlhhv65Q8ZwzIC
 pGhduTzknBfxqEM//WUvzTWMj8D4yYOMnNn4TnOGCYvF0QPGvl8nsEZGOlK+h47F/G+b
 2zv/uMO0h/UfOGCpyTvN6WLcTh4mdoyX+5tfej2Ult8CGj/tbBNj2vD0DXdaDF5FzGjk
 c2eiH+gMPSl4G9fhg1ogX34FZvQ5CQFipzdcmPEOiAJ9LV3Kwg9pKUldLSElRp2Dm0fe
 lGHQ==
X-Gm-Message-State: AOJu0YySmFlivjaesRw3vz/CJlsxmv8et+UE2DM8T9pEI1eZZLu5st+X
 j0i04TIgq3+AZUyFsg/w764743tO2LMmeYulrgXiDnTuxf9rJB+LA5rknQ34PTfYlvV9UnW3XPj
 1kHowMPnzSoRaunjngPPuS6caHB65ergUkejxLXmK68U7N/R2nwbO7yTbYHnfYoS9VdAEzB241o
 0kj5jjCZiBCTCxZ8eFbNwLcVTxqoU0/KP3I+bF
X-Received: by 2002:a17:906:11d4:b0:a2a:23b6:fb2a with SMTP id
 o20-20020a17090611d400b00a2a23b6fb2amr427635eja.106.1705580675736; 
 Thu, 18 Jan 2024 04:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuLKRVjVh0LOnf1GoA6ivykt5ksPS+ad40GYklsdntVv+OjF4HC3q/FR7sOY6yGdwM7kdCUA==
X-Received: by 2002:a17:906:11d4:b0:a2a:23b6:fb2a with SMTP id
 o20-20020a17090611d400b00a2a23b6fb2amr427631eja.106.1705580675446; 
 Thu, 18 Jan 2024 04:24:35 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 ti14-20020a170907c20e00b00a2cea055d92sm7581694ejc.176.2024.01.18.04.24.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] io_uring: move LuringState typedef to block/aio.h
Date: Thu, 18 Jan 2024 13:24:10 +0100
Message-ID: <20240118122416.9209-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The LuringState typedef is defined twice, in include/block/raw-aio.h and
block/io_uring.c.  Move it in include/block/aio.h, which is included
everywhere the typedef is needed, since include/block/aio.h already has
to define the forward reference to the struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio.h     | 8 ++++----
 include/block/raw-aio.h | 1 -
 block/io_uring.c        | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index c802a392e5e..5d0a1149881 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -55,7 +55,7 @@ typedef void IOHandler(void *opaque);
 
 struct ThreadPool;
 struct LinuxAioState;
-struct LuringState;
+typedef struct LuringState LuringState;
 
 /* Is polling disabled? */
 bool aio_poll_disabled(AioContext *ctx);
@@ -212,7 +212,7 @@ struct AioContext {
     struct LinuxAioState *linux_aio;
 #endif
 #ifdef CONFIG_LINUX_IO_URING
-    struct LuringState *linux_io_uring;
+    LuringState *linux_io_uring;
 
     /* State for file descriptor monitoring using Linux io_uring */
     struct io_uring fdmon_io_uring;
@@ -504,10 +504,10 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
 /* Setup the LuringState bound to this AioContext */
-struct LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
+LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
 
 /* Return the LuringState bound to this AioContext */
-struct LuringState *aio_get_linux_io_uring(AioContext *ctx);
+LuringState *aio_get_linux_io_uring(AioContext *ctx);
 /**
  * aio_timer_new_with_attrs:
  * @ctx: the aio context
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 0f63c2800ce..20e000b8ef8 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -65,7 +65,6 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 #endif
 /* io_uring.c - Linux io_uring implementation */
 #ifdef CONFIG_LINUX_IO_URING
-typedef struct LuringState LuringState;
 LuringState *luring_init(Error **errp);
 void luring_cleanup(LuringState *s);
 
diff --git a/block/io_uring.c b/block/io_uring.c
index 7cdd00e9f16..1e5886c30be 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -49,7 +49,7 @@ typedef struct LuringQueue {
     QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
 } LuringQueue;
 
-typedef struct LuringState {
+struct LuringState {
     AioContext *aio_context;
 
     struct io_uring ring;
@@ -58,7 +58,7 @@ typedef struct LuringState {
     LuringQueue io_q;
 
     QEMUBH *completion_bh;
-} LuringState;
+};
 
 /**
  * luring_resubmit:
-- 
2.43.0


