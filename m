Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E9707DEC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiA-0007DE-S2; Thu, 18 May 2023 06:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai8-0007Ch-KB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai7-0004lx-3u
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8Klag7Ne4wY7gy2Rwf1dxdEH04Qv4qwDtxZI5ZuCHQ=;
 b=C45Yaper20G8oDR2gwin6VgMdB7PV6QciMupgNFs2G2wXsO9qKo5yaDoxuanS3JZK1dMdk
 92Cd3IWvyf3kFvmL78KPipcgdN9aMGM3FStEjiu7tT54CqBQU71VEOELQ7lOOcq7hWMoFt
 jek4CaguYg8cPmGkGOdqQ4nhqeymVDs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-R_G32j-KNLupTVj7oFh1ng-1; Thu, 18 May 2023 06:18:13 -0400
X-MC-Unique: R_G32j-KNLupTVj7oFh1ng-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-506b21104faso371202a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405091; x=1686997091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8Klag7Ne4wY7gy2Rwf1dxdEH04Qv4qwDtxZI5ZuCHQ=;
 b=c/1c2ptCDS0odUfmPLKufAL2k4GmQUmarqWad8UzyJMSz9UTPJ9ABJULt9/qtjBKgj
 9BP968TtRuIP7PAilVBJKw5lFV8F2lg9kVh4enpiKe/fOp66srQumt75LKomupK9ADfc
 TbHNUGx3pfgc2tf8v0+sOXfAhMoPGN+JMmzs40TMx3dsnnShnayYuITy8mA0DpSBoc4C
 zarorzf1urNRSbRKiXK5bDMseRLw5Q32xH7WG/0lhXvUKxBJQEzgkU7SlzV4tUO3fJ/x
 Vt3TcUlNesyC41cY7tCqRtxqjka73yrEvoR9IpguxH+Sle4PdHT1MBLoarhrrzfcbEIy
 1q9A==
X-Gm-Message-State: AC+VfDxHsJBvj1ftkJGK5woeRY7oJzmEJCxXTxnEx1Fn/5OEBmYitTXe
 1M9ff9cNSG+Oa+VfMeo5ZWRZIkxSu8/hFd1mpWBRTxkqtfAQgDoXVg0ftPzlze1bgo90s70Ruby
 kJN3zhSF0+9+SO8XOcJ4OtoTuHrh//DbpgpnLXpfybq7Qbnj0IgdSFYqb1nnMnWWGR/m+N2iUvC
 M=
X-Received: by 2002:a05:6402:150e:b0:509:c669:1e93 with SMTP id
 f14-20020a056402150e00b00509c6691e93mr3983577edw.23.1684405091594; 
 Thu, 18 May 2023 03:18:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kQ8apKngUw4pzN2XQw0sm9SLGuyurtQCXuU7RoWtYasWikK7JQ3PO7rPDEm4wcZ9mO/5SHQ==
X-Received: by 2002:a05:6402:150e:b0:509:c669:1e93 with SMTP id
 f14-20020a056402150e00b00509c6691e93mr3983569edw.23.1684405091164; 
 Thu, 18 May 2023 03:18:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 b19-20020aa7d493000000b0050dab547fc6sm393771edr.74.2023.05.18.03.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 3/4] monitor: add more *_locked() functions
Date: Thu, 18 May 2023 12:18:03 +0200
Message-Id: <20230518101804.992085-4-pbonzini@redhat.com>
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

Allow flushing and printing to the monitor while mon->mon_lock is
held.  This will help cleaning up the locking of mon->mux_out and
mon->suspend_cnt.

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


