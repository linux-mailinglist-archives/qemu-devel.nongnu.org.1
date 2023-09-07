Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB07B797284
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:03:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdG-0002tP-11; Thu, 07 Sep 2023 09:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcp-0002mA-9m
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcb-00079e-4m
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apj0wqzDG1HTN7fF4efJ4aV5GoQliv8/RoC2dU7fXXI=;
 b=A1dmLpnb6O8+1n3xcQLxLe838pF+h6g8zu/5QY8ZEfu+DnO7uvNM3yGWT/fQ/F2wj2YwO6
 p0STjanHj6Lj6P0DMbQtBUZnzrcBsLZ085k3rQJYsmZi1H81FVmjigF+PvS6+z+fWMJCdG
 Wrc1tRmb7sVMiXjnnVjeQUaVH7p0Hqc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-pNio4c1VPPWu2kAHRChmjw-1; Thu, 07 Sep 2023 09:00:27 -0400
X-MC-Unique: pNio4c1VPPWu2kAHRChmjw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f3233861aso639845f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091623; x=1694696423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apj0wqzDG1HTN7fF4efJ4aV5GoQliv8/RoC2dU7fXXI=;
 b=Bgt2zoDztHEYZhVb1ThFfD/5ViNsrsexZxv8lMcSFgQf4d6+Zyu/fkMgGfcnprG2Ky
 D8SMYbQppyY3b4g0kRQAV5mcwtnd75E+7lkuIjbCGDYFe3qFUOJ+IxUkqZruY/bgBPkP
 LGb8vIBTEmChtjEs07Hyih6tnbHUNM8rYU/kvYxHcvB8b59TPme8mWSCWEvXeeYoTsoY
 1BFxiA58yS6MqTKuHgm6lHe/xDRr39Rz9YbxJCVOxS2hVvcZZptZfhxaptJ460jzn4Xc
 FdblOslOgNsP87bNKds9xf9e4nuNIUhLreeU/CES0q11yYS5XV6Q3krrc0RL5enfrcan
 IOsg==
X-Gm-Message-State: AOJu0YxVYIKerwkAvHKyyyY2ruazXl3ozDwEAcgwTIuVVKjjjUAvJjH6
 u0D22J4OAOeQMC0YMsfqPdA6Aji1H387rY6S+2YXY1GzrwYj6v0fQGDig//gWbOBzzuqVH86Dsb
 ACPssC7KFqG6//mHJKqXq8BeXChZOeNGjD97WAEO6UnB0BowqvelYdLmHd4z4rc9UYArPZJed3w
 Y=
X-Received: by 2002:a05:6000:901:b0:317:67bf:3376 with SMTP id
 cw1-20020a056000090100b0031767bf3376mr4901169wrb.57.1694091623584; 
 Thu, 07 Sep 2023 06:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsb3vkCbR5ju2oPyvM0m3aM74jGqGiBL0Yl9WyfZsawGMVIPWy+fDbibu03Jzmli/yWJ4KNg==
X-Received: by 2002:a05:6000:901:b0:317:67bf:3376 with SMTP id
 cw1-20020a056000090100b0031767bf3376mr4901147wrb.57.1694091623281; 
 Thu, 07 Sep 2023 06:00:23 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adffccc000000b003143c9beeaesm23194222wrs.44.2023.09.07.06.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/51] os-posix.c: create and export os_set_runas()
Date: Thu,  7 Sep 2023 14:59:16 +0200
Message-ID: <20230907130004.500601-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230901101302.3618955-3-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/os-posix.h |  1 +
 os-posix.c                | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 65b9c94e919..d32630f9e76 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -50,6 +50,7 @@ void os_setup_signal_handling(void);
 int os_set_daemonize(bool d);
 bool is_daemonized(void);
 void os_daemonize(void);
+bool os_set_runas(const char *optarg);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/os-posix.c b/os-posix.c
index cfcb96533c1..f0ee5c8b002 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -102,8 +102,14 @@ void os_set_proc_name(const char *s)
 #endif
 }
 
-
-static bool os_parse_runas_uid_gid(const char *optarg)
+/*
+ * Prepare to change user ID. optarg can be one of 3 forms:
+ *   - a username, in which case user ID will be changed to its uid,
+ *     with primary and supplementary groups set up too;
+ *   - a numeric uid, in which case only the uid will be set;
+ *   - a pair of numeric uid:gid.
+ */
+bool os_set_runas(const char *optarg)
 {
     unsigned long lv;
     const char *ep;
@@ -111,6 +117,13 @@ static bool os_parse_runas_uid_gid(const char *optarg)
     gid_t got_gid;
     int rc;
 
+    user_pwd = getpwnam(optarg);
+    if (user_pwd) {
+        user_uid = -1;
+        user_gid = -1;
+        return true;
+    }
+
     rc = qemu_strtoul(optarg, &ep, 0, &lv);
     got_uid = lv; /* overflow here is ID in C99 */
     if (rc || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
@@ -137,11 +150,7 @@ int os_parse_cmd_args(int index, const char *optarg)
 {
     switch (index) {
     case QEMU_OPTION_runas:
-        user_pwd = getpwnam(optarg);
-        if (user_pwd) {
-            user_uid = -1;
-            user_gid = -1;
-        } else if (!os_parse_runas_uid_gid(optarg)) {
+        if (!os_set_runas(optarg)) {
             error_report("User \"%s\" doesn't exist"
                          " (and is not <uid>:<gid>)",
                          optarg);
-- 
2.41.0


