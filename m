Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488F7A0C20
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqcD-0003MR-3Y; Thu, 14 Sep 2023 13:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcA-0003Lp-RD
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc9-0002HG-CD
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fc30G/UJj9VkKOdSEvlN0aV0jjSWQajqBHdMdcHorNc=;
 b=dXdJ9ZfT4Na/BfAiCv2xbMThHbh2wk4AhjZ9Q4IzwFfT7j0xVyQF3k+tmEIbwK/goiEI4E
 ulOTTdRU2zZRnSGrGIPDV0i+xqGvCFXieXERWuH7XnWyeaLbwnKPFJMRA0IKw08L4Rhgop
 LG1pgZ2QkXcHi6jFUflo5FL7AcR4zG8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-cgpwFhLEMRikvSle-ZUSUw-1; Thu, 14 Sep 2023 13:58:51 -0400
X-MC-Unique: cgpwFhLEMRikvSle-ZUSUw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6495ac57250so13168196d6.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714328; x=1695319128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fc30G/UJj9VkKOdSEvlN0aV0jjSWQajqBHdMdcHorNc=;
 b=cFfHJzW/WtUEZVL6HiiDKbJXSgKkey+ae1wwSO9FHtOziLbzPK1KwK7LpLmgw1yXft
 h40vfZ20egg87LsMU+OehCAizwO87VIGUjTe9FZz1ncbylALImGoXgZWbGS7mCmClu/y
 HUfoNpgxcqWGmaXsWG1/g1DF4WIEbFQeUxpyRUxM0fKshL0xYHT2G/g4gPaYroaSc6Jo
 RVpgbX/h2itQLAwTe/ED9MOz5Tzyf7rk3EkBGs+FIe5aji0ZP2GVltBwx4T9WqLEvxLX
 B50D5xbxDAxgxAKUSn1iTwGSkFrUyerX8CYnsI/asfXsgFybYiWImGzD5cP/Oi21avCk
 ogFQ==
X-Gm-Message-State: AOJu0YwhfnH62fgXinmbR0/l/sfDUWycdOZfcUz/z1ulK47Z9++KQrW2
 njkyjOnf1b6aOOp0//Q5K4l8q+/AxeepXotaBflhH488+KWx8mRDkZgyJRmgXU3RAWS5vygn8PQ
 YBPVF/E9RccHZUySGNouFMdUr5Y3QSvFYsWlsplFZjLD2WIo/02DcOjnWrXeTmGD3AafLWOhhiW
 ptsg==
X-Received: by 2002:a05:6214:8ce:b0:64f:518d:ac91 with SMTP id
 da14-20020a05621408ce00b0064f518dac91mr6242805qvb.8.1694714328601; 
 Thu, 14 Sep 2023 10:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCyTtH29ryVrkL0tTOhFmHY4U4QnhAjF2aQCL5Zssvhw+C560iHL24WbqaFZDWWXU5xuRBuA==
X-Received: by 2002:a05:6214:8ce:b0:64f:518d:ac91 with SMTP id
 da14-20020a05621408ce00b0064f518dac91mr6242790qvb.8.1694714328341; 
 Thu, 14 Sep 2023 10:58:48 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:46 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 4/8] i386/sev: Replace UPDATE_DATA ioctl with sev library
 equivalent
Date: Thu, 14 Sep 2023 13:58:31 -0400
Message-Id: <20230914175835.382972-5-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
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


