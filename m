Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A0F7983A5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 09:57:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWMl-00055L-EM; Fri, 08 Sep 2023 03:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeWMg-0004wy-C3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeWMe-0007Mv-AI
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694159835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=85kh3TLzxvqW9aCAsaWAj32WwGP0cmTpAx49VzXkwGs=;
 b=h8GWMMCUAaarnK7Avu/is3+19ZO/dSw6fk7ld+DnvAlnPv7D3oIioRZ5RNqfRHXimXRIZp
 HmsNCsO1VkznFf8bkFPMTYdYwaaH6Q4wRAnWeD4d5JB5+I/TMcsVMwjqyastKWqgiA6Fs7
 wU1ga0bDB9D9tKoc8hPLkXNkuBEZwcQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Qdje2VS0Po-1xJ3iMAGaDg-1; Fri, 08 Sep 2023 03:57:13 -0400
X-MC-Unique: Qdje2VS0Po-1xJ3iMAGaDg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so14430885e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 00:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694159832; x=1694764632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=85kh3TLzxvqW9aCAsaWAj32WwGP0cmTpAx49VzXkwGs=;
 b=OOCmcU3IhuQnYDnhUNUJ/WjqtNHRSksBHorxg+fIsw9xTFbzvjrS2PNffoISU5H4ci
 Uv+Swbs2rQ1Fo6wGTksx8P9YW5mPEe0zRgO1rVbi8nzyLu+VJH6ALWb/Bwcu72Tisn3p
 dezjtQCnlni0koh+7N62xtL7rqjg56Ar98sj+EuhVtmYKf862vGp6MEouIWpAzpLfhPJ
 unA0ErufUhaZYcD/KsIJfURcTQfnvBt2aGkv5R8qKOthBSMf9Ebjr6JP9R1/xc0aMkv8
 zOGgJ6FF5kRu+/fs+quSD09sq0mOld/liXNm969BsDx00cd0vh8eOBWbgIkvBviQ6YIS
 3rYQ==
X-Gm-Message-State: AOJu0YyQkL6lZWUMl7uZaY0gxC52dUdLo2R9AfST31ahEKoSNl+khoyb
 xP/rAT6WyDjfWSmRJaXcfYKlvegfMBMOFn0mOn9S47c2s2FsDiq7a4BEoOfunaq3aKWiIUMl5An
 yy8tu4nh/KVjR1wWJfrfCIGTsfuwE8G2/erbLnyVViU1hoSW32t6/ARib/NiiuRHDB1fsOQI5sH
 g=
X-Received: by 2002:a1c:f70b:0:b0:3fd:3006:410b with SMTP id
 v11-20020a1cf70b000000b003fd3006410bmr1522845wmh.34.1694159832397; 
 Fri, 08 Sep 2023 00:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bFDhyAcM/TpRX+nloRXki9u7ZRoGvlb2nayQtWsenrZqHA9/TumLkp/pgEY2PEQ/j3b2pQ==
X-Received: by 2002:a1c:f70b:0:b0:3fd:3006:410b with SMTP id
 v11-20020a1cf70b000000b003fd3006410bmr1522824wmh.34.1694159831825; 
 Fri, 08 Sep 2023 00:57:11 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.171.164])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003fe539b83f2sm4481946wmb.42.2023.09.08.00.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 00:57:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH] block: mark aio_poll as non-coroutine
Date: Fri,  8 Sep 2023 09:54:58 +0200
Message-ID: <20230908075458.527013-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

It is forbidden to block on the event loop during a coroutine, as that
can cause deadlocks due to recursive locking.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 32042e8905a..f1d0a37d68f 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -468,7 +468,7 @@ void aio_dispatch(AioContext *ctx);
  * or more AIO events have completed, to ensure something has moved
  * before returning.
  */
-bool aio_poll(AioContext *ctx, bool blocking);
+bool no_coroutine_fn aio_poll(AioContext *ctx, bool blocking);
 
 /* Register a file descriptor and associated callbacks.  Behaves very similarly
  * to qemu_set_fd_handler.  Unlike qemu_set_fd_handler, these callbacks will
-- 
2.41.0


