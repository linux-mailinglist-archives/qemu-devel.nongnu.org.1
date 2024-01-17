Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A5830A55
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:04:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8OR-00020x-LN; Wed, 17 Jan 2024 11:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8OO-00020d-Ca
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8OM-00082p-VA
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705507430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YJMe5nZc4JUUVLqbI7t25POAnQxZeSh5bf3Bhp8Ixco=;
 b=bSx9JTYH19HWGSr9HxSgukoU2ZXSMr+6H+woSzOiCy2GuwZ+aDSmEr4QdJFCyQH1wEbaMJ
 zENmn0gc0Ty0IDHecwWqE0VOMKhehxNgc6GtdIKMXIOMEDOTz0QYC4/dFL+fE99M44Q5+0
 EsW3dPcAixkHpS8S7WTGDlW6ohwJg+4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-H4CNLoA8PXaD4K9W6f0nDA-1; Wed, 17 Jan 2024 11:03:48 -0500
X-MC-Unique: H4CNLoA8PXaD4K9W6f0nDA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5596f90d5c8so1231969a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705507426; x=1706112226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YJMe5nZc4JUUVLqbI7t25POAnQxZeSh5bf3Bhp8Ixco=;
 b=Nul1iceAudZ7ugzlxCAUt4006pFW5W5y6NQ2hySRAt/IUbBUf2rWtcZmEcoS7xYIqn
 THO6zimZUlG+K8Mv5U1k95UmLnfNW4kyS949rN1TLRE1jSpXVWbmT6CjFuXXNDHFluaH
 yk/I6QloJNmTten0i8DtafzCTuek7mJ37AMZF5NiXphFq9wuJZdci1pEPsit0enmLC4h
 QNapisSxMMCNWUWYFebGqokcbQOeanDaENZubZEmkwMt18KpfbAQDoN1gTcEA/JjjN+N
 EbdRp07tyvZ7PNbvdL9kiswxugNWpUWcyIJ2iS9SP4vkMOJbMlrQNO6MCBUY5Ca8pEmt
 FpQg==
X-Gm-Message-State: AOJu0YzVGDXxwGUy4iGMPoAlADG0O5L+AGDpzKYfnZL0X+db3PqacqT4
 zcxTzxG9brEHdNNmoofq/fBUfX1yycrt8uuajcKY1vNEiqc2SkwvhMNyUNgUuQOzv44wJHCAEkG
 8ZpXvCRwieh9D1MXZOqt0tD1ene2xzeIzzm2NN4cUxnYT1CYSfSPdXOGkWnBjIdJLBZlx8hFKbT
 /BoBRhVcU=
X-Received: by 2002:aa7:cfce:0:b0:559:d575:87c5 with SMTP id
 r14-20020aa7cfce000000b00559d57587c5mr726101edy.7.1705507426154; 
 Wed, 17 Jan 2024 08:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqbgRD8/YnCDnZATUOdD5LBlHgZkMcSHy7qry5NtTRD828xDw5jSVZPgbKkiXXg7dEnyKhwQ==
X-Received: by 2002:aa7:cfce:0:b0:559:d575:87c5 with SMTP id
 r14-20020aa7cfce000000b00559d57587c5mr726091edy.7.1705507425873; 
 Wed, 17 Jan 2024 08:03:45 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a50ef17000000b0055751515a84sm8272107eds.51.2024.01.17.08.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:03:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [PATCH] vfio: use matching sizeof type
Date: Wed, 17 Jan 2024 17:03:44 +0100
Message-ID: <20240117160344.175872-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Do not use uint64_t for the type of the declaration and __u64 when
computing the number of elements in the array.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3352f2a9d..0da4003ecf5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1118,7 +1118,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
                         sizeof(struct vfio_device_feature_dma_logging_report),
-                        sizeof(__u64))] = {};
+                        sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
     struct vfio_device_feature_dma_logging_report *report =
         (struct vfio_device_feature_dma_logging_report *)feature->data;
-- 
2.43.0


