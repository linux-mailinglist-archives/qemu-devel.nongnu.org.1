Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 389DD7A0ED2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgL-0002Gr-5b; Thu, 14 Sep 2023 16:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpL4-0005e5-Nj
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpL3-0000lq-6i
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fc30G/UJj9VkKOdSEvlN0aV0jjSWQajqBHdMdcHorNc=;
 b=h6y8akyhbfWPfETGe5yN/SQLAXMF1kjXVnVlpDFcBmugJOsn7iTv4qZkfofFiEuba3hkA7
 2x2PO7/DIFyPmRqh1AD0Xhxqd3ntdSdIs72+t8f4y2mWGh1eEC8TZ6yNVoh3lWITwRQ6Pv
 f/+QztFdpbS8fsAJZe8lqaBUNF3zOaw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-HyZm7vntOnSKU6yXdKppEQ-1; Thu, 14 Sep 2023 12:35:32 -0400
X-MC-Unique: HyZm7vntOnSKU6yXdKppEQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76f31a228beso141867885a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709330; x=1695314130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fc30G/UJj9VkKOdSEvlN0aV0jjSWQajqBHdMdcHorNc=;
 b=kqJQ7e0IRnjTSxscNVhp0dvvhaLAXDJ98BQSfMBAUL+Za6vsAsfMVcVaq+RAN0+OeR
 v8ntVmcIKaRWq8rugwriq1xa6Q8+V0k7m6wCQiMSefW6+Pgs9eE96uhcALqkpV4oEQK7
 v6oygSz/YtEx1HdU8oRwu+F1c0XUXwrZ7kpfn9L5riOlnPooZULf6Isy+NK+7Je9G8y8
 2DkWI2KZaEabWL9f+m0gdcLhll1JewHOUMtudwjKjymeusBpH4IFTXAG0kH4+Cx6ShgZ
 tRAv1Yz3aAJUP/K9n9npcl32pHUaEO31ioB+A5Hz0K3nySgAPrv+G6eGuBc/oQJ7YTAy
 dKtg==
X-Gm-Message-State: AOJu0Yx1Sbj9pYVgndddn4tBaA9pFQ4ZOzW+mLUUdFHXS8boGULzMFl5
 w39ciUdFCmnYzN9OYTQp+/I4BqWenjTTYsHrYUXXF+brB7Si8pthp9s6jiUt4MR9ocEQF6xQKH2
 tttdGQGuRW0z8gJYhw78xA96o4VAxiQlmcjQdWdOg9bSkba3q0z99osY2RjM/9Rkk4TgngFLHYq
 ztYw==
X-Received: by 2002:a05:620a:d82:b0:76f:1eac:e720 with SMTP id
 q2-20020a05620a0d8200b0076f1eace720mr5755592qkl.25.1694709330593; 
 Thu, 14 Sep 2023 09:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+ltOfNya/PA1payaovYuWjA0frKgdkbQiWQpJhGzSrzdN+jA5343N4jMUUeno2SbcvxT80g==
X-Received: by 2002:a05:620a:d82:b0:76f:1eac:e720 with SMTP id
 q2-20020a05620a0d8200b0076f1eace720mr5755575qkl.25.1694709330310; 
 Thu, 14 Sep 2023 09:35:30 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:28 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 4/8] i386/sev: Replace UPDATE_DATA ioctl with sev library
 equivalent
Date: Thu, 14 Sep 2023 12:33:55 -0400
Message-Id: <20230914163358.379957-5-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914163358.379957-1-tfanelli@redhat.com>
References: <20230914163358.379957-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Sep 2023 16:11:08 -0400
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

UPDATE_DATA takes the VM's file descriptor, a guest memory region to
be encrypted, as well as the size of the aforementioned guest memory
region.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 49be072cbc..615021a1a3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -715,29 +715,6 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
-static int
-sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
-{
-    int ret, fw_error;
-    struct kvm_sev_launch_update_data update;
-
-    if (!addr || !len) {
-        return 1;
-    }
-
-    update.uaddr = (__u64)(unsigned long)addr;
-    update.len = len;
-    trace_kvm_sev_launch_update_data(addr, len);
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
-                    &update, &fw_error);
-    if (ret) {
-        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
-    }
-
-    return ret;
-}
-
 static int
 sev_launch_update_vmsa(SevGuestState *sev)
 {
@@ -1009,15 +986,19 @@ out:
 int
 sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
 {
+    KVMState *s = kvm_state;
+    int fw_error;
+
     if (!sev_guest) {
         return 0;
     }
 
     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(sev_guest, SEV_STATE_LAUNCH_UPDATE)) {
-        int ret = sev_launch_update_data(sev_guest, ptr, len);
+        int ret = sev_launch_update_data(s->vmfd, (__u64) ptr, len, &fw_error);
         if (ret < 0) {
-            error_setg(errp, "SEV: Failed to encrypt pflash rom");
+            error_setg(errp, "SEV: Failed to encrypt pflash rom fw_err=%d",
+                       fw_error);
             return ret;
         }
     }
-- 
2.40.1


