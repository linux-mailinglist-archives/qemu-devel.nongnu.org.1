Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A860707DE1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzai9-0007Cf-1J; Thu, 18 May 2023 06:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai6-0007CO-MR
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai5-0004la-A8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YW2RiDVuo8s3fHdACuQ7sebR9x64p06vs4OxuqmRjaY=;
 b=f8aJ/s21PiifWRRXMuOxRfsG7fAG6i3wGrUgQRhtMfBZfOu5+H1KE5JHWklPLtn9vrtBnu
 YdueSauKcmTJt6qB4anuVi0lO3GuFr+Ka7EEZ/tDx5XkvZgF+vVcV0WbYpRRLTVqRvqhwR
 yzvGNVvHvtMUhqOwY4N0XjV1noS6gRQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-NVvBqoMNNLuGFqKZOFSFrQ-1; Thu, 18 May 2023 06:18:11 -0400
X-MC-Unique: NVvBqoMNNLuGFqKZOFSFrQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-966329c872bso247420966b.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405089; x=1686997089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YW2RiDVuo8s3fHdACuQ7sebR9x64p06vs4OxuqmRjaY=;
 b=B5Fz48NSBa2gll4LEYFVNLRUojDNdiJObcqU3hE2QOVnpoj3X01awmPuDSmVJbUBLP
 qIloMh4LP4yNJyCMUIpJV1ZcN0+9COJJiZ6T6ol6m3oHtO+glZSsIesQrH7V61pSosop
 zFOzulZ6WQPdOG96jW3+NNEZsyDohQ6k1i9AIOnt6w4YnK8NoyziTztRbh9g2sUvw6Xy
 scN0CrMzrbugtzCithFjpSwzHMflNUyu+zv8wbUWDutUUk4warrfKsXxKZCTi62uRCSv
 RVF+e7/Irqfwlbe/pVuAqpT9YfMqlQfX0KMXkU7TTfg6uTGKOJ0ykvFs9WFjMnBreppT
 xFNA==
X-Gm-Message-State: AC+VfDyeCEfaK2rLc4YRo+6bHFutByiThu+dIV0HNpe9Xk8r1ZA2Tmhk
 kwrkxMBLwwtkbDowGAIYXBvUDzv7GFk6c47xhZSOzW8uCBE/JbK19aZaStIIt6J0JnWvcKySyT/
 EQ7QIgmLu0pE+r1Acz+SOItfYMQ/EksC6/U17Vx+vAT1bjS7OreIgAnRqM2QseBTKAnj592vVxD
 8=
X-Received: by 2002:a17:907:318b:b0:957:17c5:8705 with SMTP id
 xe11-20020a170907318b00b0095717c58705mr37373711ejb.51.1684405089737; 
 Thu, 18 May 2023 03:18:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78/r05KgtbdH43ioHuiG/XQmekZjMBr2M9RWnNOXQj7dkYo1MEypzCps0tD+xqrL2iIkRvNA==
X-Received: by 2002:a17:907:318b:b0:957:17c5:8705 with SMTP id
 xe11-20020a170907318b00b0095717c58705mr37373697ejb.51.1684405089337; 
 Thu, 18 May 2023 03:18:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a1709060a5700b00966447c76f3sm779511ejf.39.2023.05.18.03.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 2/4] monitor: allow calling monitor_resume under mon_lock
Date: Thu, 18 May 2023 12:18:02 +0200
Message-Id: <20230518101804.992085-3-pbonzini@redhat.com>
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

Move monitor_resume()'s call to readline_show_prompt() outside the
potentially locked section.  Reuse the existing monitor_accept_input()
bottom half for this purpose.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 4b11bca2a21d..7080d2da8ec6 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -567,6 +567,12 @@ static void monitor_accept_input(void *opaque)
 {
     Monitor *mon = opaque;
 
+    if (!monitor_is_qmp(mon)) {
+        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+        assert(hmp_mon->rs);
+        readline_show_prompt(hmp_mon->rs);
+    }
+
     qemu_chr_fe_accept_input(&mon->chr);
 }
 
@@ -585,12 +591,6 @@ void monitor_resume(Monitor *mon)
             ctx = qemu_get_aio_context();
         }
 
-        if (!monitor_is_qmp(mon)) {
-            MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
-            assert(hmp_mon->rs);
-            readline_show_prompt(hmp_mon->rs);
-        }
-
         aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
     }
 
-- 
2.40.1


