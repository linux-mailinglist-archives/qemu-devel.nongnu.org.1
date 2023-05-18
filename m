Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061EA707DE4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzai7-0007CX-Ex; Thu, 18 May 2023 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai5-0007Bn-43
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai3-0004lK-Nt
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBojB1HHhw9e5Mqc9sqoqRl9uNsGGM3YqDRyz7NIFJw=;
 b=K+YXBWoA8nar+BsKRpdwyrZrAmt6As/dt9bUI4OMA5DvkXyzGOZawpbaRrmLPs7LjdUne1
 zfFczbkqTf+EqtOnIP1VJKMfDcjLGRDuUXEew5QYhIYvRlfHXhRn670ybUqKaig9W9SwCV
 odGH1dY++OExpW3RNALrDHOUVnX05to=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-oF4AHTqNN62mKH4un8UJPw-1; Thu, 18 May 2023 06:18:09 -0400
X-MC-Unique: oF4AHTqNN62mKH4un8UJPw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9662960d1e4so206448466b.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405088; x=1686997088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBojB1HHhw9e5Mqc9sqoqRl9uNsGGM3YqDRyz7NIFJw=;
 b=Pu8pJHLIC4yQrZMZymc4dTWUDdRReC9M7mYNqbnSAhC0HjavObhXzGMbybytc2pho7
 8zQNP+HIBJanHq8WTafAQSKA/as6v/VhJZIU/c5mnJsN4F0Iq9T4RpNPyXAWbr53O23b
 swaJsl31p1t+lFeVjebLmiYD1LLS2OwjeMR9RYmpKdZmTHPeGfd9wipP5J2It89KDT8y
 a9Rq/+YgHTY2zt9D0zH11QNjMlHOQhw8XilZ7qyxaBrl+QOF0vPJYBXYBpHFvpCh16j8
 7CsLKPbkxhNVDbAkPuv9vvJ8evEFgFzozDQ9MPeePPoP2MuXeZUfeMdMXAyNz0jbElxo
 Ya4w==
X-Gm-Message-State: AC+VfDw/CX6Hgq7Om4y5kVVraHGOhAkJ33XSqX5k21s183WOeCnvf2Ch
 gJt+UQgE3lkxU1Jk14muhMELOy6WjZrlXEPXaCG32LKXiobTG5xVcuwUvko3YP8OgEgc1MVXj3R
 AAe530TpVWg1PIsokdA7lDvu5Hrm6OfE7OnV/wkZkrrWjmfWlmmF/ie4rvmPcTJUwG30ERdfrSn
 Q=
X-Received: by 2002:a17:907:a46:b0:94f:2b80:f3b4 with SMTP id
 be6-20020a1709070a4600b0094f2b80f3b4mr36915825ejc.69.1684405088077; 
 Thu, 18 May 2023 03:18:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ544H4ISYWnS5WDZnizp1bVKCxiMEpPhIocYU9tncvGHfsa/6BROTQZcXfywILF+zMZ/v3g0Q==
X-Received: by 2002:a17:907:a46:b0:94f:2b80:f3b4 with SMTP id
 be6-20020a1709070a4600b0094f2b80f3b4mr36915807ejc.69.1684405087741; 
 Thu, 18 May 2023 03:18:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 lt1-20020a170906fa8100b0096efd44dbffsm764745ejb.105.2023.05.18.03.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 1/4] monitor: use QEMU_LOCK_GUARD a bit more
Date: Thu, 18 May 2023 12:18:01 +0200
Message-Id: <20230518101804.992085-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518101804.992085-1-pbonzini@redhat.com>
References: <20230518101804.992085-1-pbonzini@redhat.com>
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


