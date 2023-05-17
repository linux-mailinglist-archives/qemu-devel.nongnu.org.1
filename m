Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3370700D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:54:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDx-0007K9-4S; Wed, 17 May 2023 13:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDp-0007I4-Vf
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDm-00046x-Kv
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18IKHxyOv9PYot11dos7srKdbqWwToWb1XTwOxkQT8g=;
 b=SyCGU3HvD8gutuR2crbTifM8yAVbpcnR3YmUcpgzuUzMTafr5mw+E20EGCDloAgj0q3G8c
 grdTCc2X90RhIRh6C1X78aFZMIN8st5YzgRGrSo6nQUZvqms7TcMB2Nh/h/wdYfKXTppiM
 wO5UhK0zGU5CG3XeDMoqbMY25qhU8ic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-rUTxLOMSPfqNEiOXfzub9g-1; Wed, 17 May 2023 13:45:51 -0400
X-MC-Unique: rUTxLOMSPfqNEiOXfzub9g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-306281812d6so467173f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345550; x=1686937550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18IKHxyOv9PYot11dos7srKdbqWwToWb1XTwOxkQT8g=;
 b=NbEkEMltL0CAET0RkgIC+Hy5li1QHEZBIvtbYjAeOB/vB9kxNVYvlDjm70IvQS//Mj
 NbUmryxpZNzDECf1IsiSAcen1VXXXGN+QEVQ3wsO0SSrgjFYqcUGEP7a4QMrTvJhpx8+
 XV9B+hafwCMPwhb8Gdyc+UYIWSy+yINjLvX6IIwTAIDqKTmlJwZemfyAybfjqH7baYrH
 qFOU2z3Iryb8P+P8zmywBt4vxahPthFjXzm5AnDD5WDyEnHqdbaDFFIE4BsfBX8GFh/f
 bFoOdNIXR7xbn/xg5/E2GrMpR0bI2SBHBlF51Sel5MlEmqUxWk650mUJj8mX+fosZcW0
 +I1g==
X-Gm-Message-State: AC+VfDzYkNt34R1Na5H49aUZopfWIa4ONGkaOy5hkbr+SQnfZDiczJK6
 +N+JgjF/DKBQBHpXYgF0o+sGJ8jaU1a13Iv4J9qzbLdnB8rOPf90wG0tEzVQyJjxZdO2ZpH+C28
 xI0boVUf3JEfshfpccXRJrJ9CFelhNHDTtWQJZPo0xn7jrmOyIaNKjJtWVUyNAFmP9Qi/3Yj7eV
 I=
X-Received: by 2002:adf:f950:0:b0:309:22ba:dcdc with SMTP id
 q16-20020adff950000000b0030922badcdcmr1479072wrr.42.1684345549915; 
 Wed, 17 May 2023 10:45:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ykN0hIn3upuUN45IinZOwFfVmOnKKEoNY8qS6xSDtEPZWezBKJ/T1/MRu9Mn3zOoppg1+xw==
X-Received: by 2002:adf:f950:0:b0:309:22ba:dcdc with SMTP id
 q16-20020adff950000000b0030922badcdcmr1479057wrr.42.1684345549647; 
 Wed, 17 May 2023 10:45:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c358400b003f1738d0d13sm3961048wmq.1.2023.05.17.10.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Th=C3=A9o=20Maillart?= <tmaillart@freebox.fr>,
 qemu-stable@nongnu.org
Subject: [PULL 16/68] scsi-generic: fix buffer overflow on block limits inquiry
Date: Wed, 17 May 2023 19:44:28 +0200
Message-Id: <20230517174520.887405-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Using linux 6.x guest, at boot time, an inquiry on a scsi-generic
device makes qemu crash.  This is caused by a buffer overflow when
scsi-generic patches the block limits VPD page.

Do the operations on a temporary on-stack buffer that is guaranteed
to be large enough.

Reported-by: Théo Maillart <tmaillart@freebox.fr>
Analyzed-by: Théo Maillart <tmaillart@freebox.fr>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index ac9fa662b4e3..2417f0ad8479 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -191,12 +191,16 @@ static int scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s, int len)
     if ((s->type == TYPE_DISK || s->type == TYPE_ZBC) &&
         (r->req.cmd.buf[1] & 0x01)) {
         page = r->req.cmd.buf[2];
-        if (page == 0xb0) {
+        if (page == 0xb0 && r->buflen >= 8) {
+            uint8_t buf[16] = {};
+            uint8_t buf_used = MIN(r->buflen, 16);
             uint64_t max_transfer = calculate_max_transfer(s);
-            stl_be_p(&r->buf[8], max_transfer);
-            /* Also take care of the opt xfer len. */
-            stl_be_p(&r->buf[12],
-                    MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+
+            memcpy(buf, r->buf, buf_used);
+            stl_be_p(&buf[8], max_transfer);
+            stl_be_p(&buf[12], MIN_NON_ZERO(max_transfer, ldl_be_p(&buf[12])));
+            memcpy(r->buf + 8, buf + 8, buf_used - 8);
+
         } else if (s->needs_vpd_bl_emulation && page == 0x00 && r->buflen >= 4) {
             /*
              * Now we're capable of supplying the VPD Block Limits
-- 
2.40.1


