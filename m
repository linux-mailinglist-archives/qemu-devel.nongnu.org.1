Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21C7F19B6
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:20:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57uc-00067T-DO; Mon, 20 Nov 2023 12:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r57uY-000673-Co
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:18:14 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r57uW-0004UU-M8
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:18:14 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c8790474d5so25201841fa.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700500690; x=1701105490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4mzgV1CcBRitUgU6dHx+b+8EmPNTTNpL8kICptnc204=;
 b=BDkMH5X5zZkwvzJ7glQHLDyMTbrqfVDJYee+pPcmeDbBtCAd6TWFJhuyWKRyjCbS9Y
 1ZwxPINxd0YIC/WLjDmirCnLXIVquA4mPd56XIbNxjlUpEgrtI2bXtKvsgF+inXsq9Ll
 9rZocpRoCqNtfKbU87dYtwA4YV2la2SG/QSUVR7uXUG8QPAddP9YgPsQrWI5BV8fKRu2
 TEjxCQLqF5a2jlg1QAG8EH4b0c9xbSa3BqWHrbyf1JoV5tb65KKtgM/JJGh7Arvajpr6
 vYL49mjv+69PcH1Tx0UAE0wLCN8cK1DTVC6QmUiokKnSOfqrYIPgYD7edDXa4YfCuwFg
 xJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700500690; x=1701105490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mzgV1CcBRitUgU6dHx+b+8EmPNTTNpL8kICptnc204=;
 b=ZTkgNs/X9DTHlXWmdgz2SVbBmkf3P3wrrBClKINr5cPyH4V8a17Hc1K/96jqyuo3qJ
 cLsWamLMvoedaN2mor0NsCh/vqzxSOEtljMvtEhQN9X4BczI4WoPY535k93DjN/C9bVp
 RdNhifusFlp2rx6bT8Sjmu3ghpdsF7nQhAK6/fCd7/TR0DBMNCLe7xNf8KxtXh1Cz/rx
 MLTPbIYInnNxx2H4MGBXHffygFzu1/GvJ9w27fJQgTdyPxPIWU5IzzNBAzio9yt2YYy8
 pqTRXdV+mDSU998+erNIfX4XQiPWaIcUl7yxJvW6RT0K+ce2vcGSS69mZLUYvPaYDaYR
 EtPw==
X-Gm-Message-State: AOJu0YxvQyecx/2q7hTGUXnRyt5d7Ov1G1CavJ1gLF5B/tkUd75bvx9e
 FmTfB3v2GHArUJoNtVHrIOytv7IsAHRiWetxTFw=
X-Google-Smtp-Source: AGHT+IFQtKdy38U8WOpk1por17u+lJKlX9Qs+wAulMC+wT1h5Ae/6o8obX0uYpQBNATIQHLKTBFuHg==
X-Received: by 2002:ac2:59c9:0:b0:509:4599:12d9 with SMTP id
 x9-20020ac259c9000000b00509459912d9mr6092859lfn.6.1700500690360; 
 Mon, 20 Nov 2023 09:18:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a5d6a05000000b0032d2489a399sm11625326wru.49.2023.11.20.09.18.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 09:18:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] iothread: Remove unused Error** argument in
 aio_context_set_aio_params
Date: Mon, 20 Nov 2023 18:18:06 +0100
Message-ID: <20231120171806.19361-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

aio_context_set_aio_params() doesn't use its undocumented
Error** argument. Remove it to simplify.

Note this removes a use of "unchecked Error**" in
iothread_set_aio_context_params().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/block/aio.h | 3 +--
 iothread.c          | 3 +--
 util/aio-posix.c    | 3 +--
 util/aio-win32.c    | 3 +--
 util/main-loop.c    | 5 +----
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index f08b358077..7c28239d8d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -716,8 +716,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
  * @max_batch: maximum number of requests in a batch, 0 means that the
  *             engine will use its default
  */
-void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch,
-                                Error **errp);
+void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch);
 
 /**
  * aio_context_set_thread_pool_params:
diff --git a/iothread.c b/iothread.c
index b753286414..6c1fc8c856 100644
--- a/iothread.c
+++ b/iothread.c
@@ -170,8 +170,7 @@ static void iothread_set_aio_context_params(EventLoopBase *base, Error **errp)
     }
 
     aio_context_set_aio_params(iothread->ctx,
-                               iothread->parent_obj.aio_max_batch,
-                               errp);
+                               iothread->parent_obj.aio_max_batch);
 
     aio_context_set_thread_pool_params(iothread->ctx, base->thread_pool_min,
                                        base->thread_pool_max, errp);
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 7f2c99729d..266c9dd35f 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -777,8 +777,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
     aio_notify(ctx);
 }
 
-void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch,
-                                Error **errp)
+void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch)
 {
     /*
      * No thread synchronization here, it doesn't matter if an incorrect value
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 948ef47a4d..d144f9391f 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -438,7 +438,6 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
     }
 }
 
-void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch,
-                                Error **errp)
+void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch)
 {
 }
diff --git a/util/main-loop.c b/util/main-loop.c
index 797b640c41..63b4cda84a 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -192,10 +192,7 @@ static void main_loop_update_params(EventLoopBase *base, Error **errp)
         return;
     }
 
-    aio_context_set_aio_params(qemu_aio_context, base->aio_max_batch, errp);
-    if (*errp) {
-        return;
-    }
+    aio_context_set_aio_params(qemu_aio_context, base->aio_max_batch);
 
     aio_context_set_thread_pool_params(qemu_aio_context, base->thread_pool_min,
                                        base->thread_pool_max, errp);
-- 
2.41.0


