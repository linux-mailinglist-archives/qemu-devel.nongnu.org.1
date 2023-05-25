Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABA710E3B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:22:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlI-0004iH-TZ; Thu, 25 May 2023 10:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl2-0004e6-Lk
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl0-0007d5-JU
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YW2RiDVuo8s3fHdACuQ7sebR9x64p06vs4OxuqmRjaY=;
 b=EQYI5XfbcA76sCEXrI6wFpA0aerQy8l+0gIpelAyAKhKcqoy86E7wk9Sh18URZsRDOL+v9
 8Hz/KReMN/ZRr4vOr+lA41kgJteA3uIlt0s/mwIATDxu0RW7mq0RvxZUzmCOATrAh0dK2E
 BH75uK+y0jwx4KJmDfj6hjG/HSg+z+Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-D-kYnxvUMEC8VfebLF6txg-1; Thu, 25 May 2023 10:15:55 -0400
X-MC-Unique: D-kYnxvUMEC8VfebLF6txg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-513fd7d56c8so2733912a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024153; x=1687616153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YW2RiDVuo8s3fHdACuQ7sebR9x64p06vs4OxuqmRjaY=;
 b=NEExssU2dJOoirYdNcvCSXkFw95JcGZOj+y91lEj0QsZbGSRj7yQTgOVwaXz/P6Ulm
 R+gEaNHvxAAzm+ET8iCjLTAjXIZL/ZTkMhnRLoI5aPkSAdFCd73nEFEEvLc6lXC59Sms
 rqLM8BDgAn+Ui+q6nd8TYlvVy1hpjj1JITwYCwJdZyNG3xzLiwBJ+GpA7Xlf0e797N8c
 dwps7m1KCX05stmqR3yjurl20MIbSMsM5LmRmTpKv3kgOHASl9R7LesF4I5DWh3ZcX6V
 N1+3apJrU4xJgt7KDBa5dujIF1GY9yCP5TS8dFFTNJrYO06ZBY3LBVYcd1pRZa129jBc
 mFqg==
X-Gm-Message-State: AC+VfDwppoJY3Pvl4WkdTTgCkfCOlCiDjvT4ZaQu8KD4Vvh4VL2AK767
 GT0O20sHq6LTs2e8P8+fQPh/XYwmK9gG0JG2jJvtYa94z9GgCH8+9+0k38qDmEQngnVfEhs339o
 aJY5brwHI6HX+/7srGhEzgvIGdRo05aXNdaWwGR1UbjEAQH9Gz6GB5nKI5TqYD89kEBtiI0eL9f
 M=
X-Received: by 2002:a17:906:fe0e:b0:94a:35d1:59a with SMTP id
 wy14-20020a170906fe0e00b0094a35d1059amr1258193ejb.14.1685024153747; 
 Thu, 25 May 2023 07:15:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7w9orkts2jzUftWHs9Bhwbu9PvWvYAjCSPPsAShwJQW+Vzx32r0F7IZM2HZad34QrMLXUZmA==
X-Received: by 2002:a17:906:fe0e:b0:94a:35d1:59a with SMTP id
 wy14-20020a170906fe0e00b0094a35d1059amr1258176ejb.14.1685024153443; 
 Thu, 25 May 2023 07:15:53 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a1709064d9100b00969f25b96basm887188eju.204.2023.05.25.07.15.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] monitor: allow calling monitor_resume under mon_lock
Date: Thu, 25 May 2023 16:15:25 +0200
Message-Id: <20230525141532.295817-14-pbonzini@redhat.com>
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


