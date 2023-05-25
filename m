Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443B710E40
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlL-0004lX-0P; Thu, 25 May 2023 10:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl7-0004fS-Sx
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl5-0007ev-N6
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+X2yMp/rrkiuznHlbFPis928m34/lXQlFacSTwXix4=;
 b=g5bH0wYETyZng397sE3iWLsgxFBDF/KobJYLQqdPYt6Xqzc5fssGOVjJyOaJPt2lZf17OJ
 LP0eDj9X+0kxyyl8k2fwjVgY2Eyo0SbsuFRVoXP/k+h3BY9/j3mCUJlNupwLJIO5RPjPAw
 bF+GJANez6yVNsCHdWyOOR6Az+DGMCM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Zq7ZJ6o3Myuvlec304ng2g-1; Thu, 25 May 2023 10:15:56 -0400
X-MC-Unique: Zq7ZJ6o3Myuvlec304ng2g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bcd245040so2776595a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024152; x=1687616152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+X2yMp/rrkiuznHlbFPis928m34/lXQlFacSTwXix4=;
 b=hfINVD5cBe5sEWe/e6niFTSERyk44lm8H4bv3s+Yoc8CtY6zi4mFNXfj0tKsJmWT0K
 SA7ZCZ1G1VKlJrdTV1xVTSdNtlOUGtZZDF6JepQj2W9U6hHKYdVsWGMxXOH4SDz8ITSq
 zD8kdavj6tiaL6XbWO35jdeuVvRtRnPo7mfoyfd3Ll1m6M7Xz3EriHaIbf0sHUaWSeda
 XgePf2cOFd0UMamtkaWc9pH6b/xoe+tdGXkz+qFu2l32acM6WOE98OgwjpS2NUmvKbTk
 bcxASVYT6PI1DoVMOIWU1BMfB88ZhPX80XHzgiSxtEsb56sA2d/tNWx2k7tR0WOOkoMg
 tzLg==
X-Gm-Message-State: AC+VfDxMrexTui7VfaTQEP6NoXZ+e5fVuwTuc4Xr4vdjqy0aU9JEhp6n
 jBW4S/yrMrk4uOtVuUVsH9Ib/bt8ZCWOvrQy5GC8VPG8j8EkgLrNf8RjcVXpzYdFKaBU+60+I2K
 5qvoqB482rBhRLrl4CXa1J0I0kV6MQ6acHhMi+VbLclAYNNxAYK8uG3cYkZ3J37Q8D/EnTlBgog
 E=
X-Received: by 2002:aa7:c252:0:b0:510:6217:9994 with SMTP id
 y18-20020aa7c252000000b0051062179994mr4539759edo.39.1685024152264; 
 Thu, 25 May 2023 07:15:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ugXZPk/qPYvhrAavxM+9kBbQa4CD4aNjYwcdrk9wIJbVJ/FYXAYT4NtU5GUAGJsURB7mPYA==
X-Received: by 2002:aa7:c252:0:b0:510:6217:9994 with SMTP id
 y18-20020aa7c252000000b0051062179994mr4539750edo.39.1685024152008; 
 Thu, 25 May 2023 07:15:52 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 y26-20020aa7c25a000000b0051421010690sm610052edo.21.2023.05.25.07.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/20] monitor: use QEMU_LOCK_GUARD a bit more
Date: Thu, 25 May 2023 16:15:24 +0200
Message-Id: <20230525141532.295817-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 602535696c59..4b11bca2a21d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -161,10 +161,9 @@ static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
 {
     Monitor *mon = opaque;
 
-    qemu_mutex_lock(&mon->mon_lock);
+    QEMU_LOCK_GUARD(&mon->mon_lock);
     mon->out_watch = 0;
     monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->mon_lock);
     return FALSE;
 }
 
@@ -203,9 +202,8 @@ static void monitor_flush_locked(Monitor *mon)
 
 void monitor_flush(Monitor *mon)
 {
-    qemu_mutex_lock(&mon->mon_lock);
+    QEMU_LOCK_GUARD(&mon->mon_lock);
     monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->mon_lock);
 }
 
 /* flush at every end of line */
-- 
2.40.1


