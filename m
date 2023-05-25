Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63024710E3C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlE-0004gO-Bj; Thu, 25 May 2023 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl3-0004e8-Gr
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl1-0007dh-Jb
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJOHud7zDMwnpwt2q0ARIGg4F68erJAtnxVdSgsHo28=;
 b=SDMk3rKuoUoth5MCuH/Pa9DzDYNVfLpNAt9WvxaEKbc48fbwvB/OSvpS8+hhHm6OHxMObC
 QGeDethKfaX32gWbcfrk0WGDaOBLGeFlkI8T0d0WOWj+ut28F4vwrsHoZKW8C8dszj07Kc
 IpyK66+MfIMwvNFnsh1hYR4YNLHBr1M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-BdPsBxVhPHe-uplrbfJpIA-1; Thu, 25 May 2023 10:15:57 -0400
X-MC-Unique: BdPsBxVhPHe-uplrbfJpIA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fffd1ba46so68072166b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024155; x=1687616155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJOHud7zDMwnpwt2q0ARIGg4F68erJAtnxVdSgsHo28=;
 b=ek8sUYRvGebb1avWjaRIikV/Gll1GmJaXfH2CDw+g+NjSKr9kfE0yjyw+odgbjzctf
 jp3RCCDi2b0k0ZHfBpu6i5YFyciM49NxnAxb0Nll9ktFistb5CVOL1i/BKlZRchxxgCv
 NiuAcnIYcX/BIFam6+LiGXE9w5rAxXj+KhPXCMT/v8zedVxNNSthlwiy7qNUWwhlG999
 YMbztUrJXUEI1VtXrj55vO7V29sMhcULjL7VQbFMG8XDH15Vae/9TU+U0gwHpP05zJ3J
 Dkhhmu0V9vT44dQpGFqzZ55O1IGgcHKKCXwiXC/eZGAMs2okL/Vie16SZYgK/lITgpO7
 eM4w==
X-Gm-Message-State: AC+VfDy49nwQ6cJ4x5E7OsymG67L7vAGZObuXcivqhohAn7tX1GK14l3
 6qUHvd/2BqxYHVytCaVs+BQuSeX2HdbPPbxgYiI5l+XPjUh+8iY248ErHQYgrrDrxzAG4ECvYwW
 BJDFGLOVPJBgHlWsH6/NG0+egLLVpfEnHgcANJejLLP5qBM9ZjCmOzbJkGCcGkj/8tmjLoOlLkr
 0=
X-Received: by 2002:a17:906:9744:b0:94e:cf72:8147 with SMTP id
 o4-20020a170906974400b0094ecf728147mr2050625ejy.48.1685024155223; 
 Thu, 25 May 2023 07:15:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hQSI/MUXMAab4jt2UgQJbz4S2KaLFdsSnu0pMNlbeETao4ujeO2lQ2Afcffn4lWlFsoczRA==
X-Received: by 2002:a17:906:9744:b0:94e:cf72:8147 with SMTP id
 o4-20020a170906974400b0094ecf728147mr2050593ejy.48.1685024154909; 
 Thu, 25 May 2023 07:15:54 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 dv22-20020a170906b81600b0096f78953b77sm904183ejb.147.2023.05.25.07.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/20] monitor: add more *_locked() functions
Date: Thu, 25 May 2023 16:15:26 +0200
Message-Id: <20230525141532.295817-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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

Allow flushing and printing to the monitor while mon->mon_lock is
held.  This will help cleaning up the locking of mon->mux_out and
mon->suspend_cnt.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/monitor/monitor.h |  3 +++
 monitor/monitor.c         | 14 ++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 033390f69917..965f5d545003 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -40,6 +40,9 @@ void monitor_flush(Monitor *mon);
 int monitor_set_cpu(Monitor *mon, int cpu_index);
 int monitor_get_cpu_index(Monitor *mon);
 
+int monitor_puts_locked(Monitor *mon, const char *str);
+void monitor_flush_locked(Monitor *mon);
+
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
 
 void monitor_read_command(MonitorHMP *mon, int show_prompt);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 7080d2da8ec6..20e33e28d20d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -154,8 +154,6 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
     return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
 }
 
-static void monitor_flush_locked(Monitor *mon);
-
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
                                   void *opaque)
 {
@@ -168,7 +166,7 @@ static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
 }
 
 /* Caller must hold mon->mon_lock */
-static void monitor_flush_locked(Monitor *mon)
+void monitor_flush_locked(Monitor *mon)
 {
     int rc;
     size_t len;
@@ -207,12 +205,11 @@ void monitor_flush(Monitor *mon)
 }
 
 /* flush at every end of line */
-int monitor_puts(Monitor *mon, const char *str)
+int monitor_puts_locked(Monitor *mon, const char *str)
 {
     int i;
     char c;
 
-    qemu_mutex_lock(&mon->mon_lock);
     for (i = 0; str[i]; i++) {
         c = str[i];
         if (c == '\n') {
@@ -223,11 +220,16 @@ int monitor_puts(Monitor *mon, const char *str)
             monitor_flush_locked(mon);
         }
     }
-    qemu_mutex_unlock(&mon->mon_lock);
 
     return i;
 }
 
+int monitor_puts(Monitor *mon, const char *str)
+{
+    QEMU_LOCK_GUARD(&mon->mon_lock);
+    return monitor_puts_locked(mon, str);
+}
+
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     char *buf;
-- 
2.40.1


