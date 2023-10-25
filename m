Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1E7D789C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHr-0001Wm-9g; Wed, 25 Oct 2023 19:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHo-0001Vk-Ih
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHn-0004us-3t
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhk3/jPu+ktOTVn2YBI9nIBNFtxvKHkB32N1WAJPDfE=;
 b=CQ5Q06BhhzLpd+cFiqq81tzHtBJ3F1FdkcaY12DP1ku5mhnJdwXm3XDxVZzcpVSlXHoG5R
 eTsIjZXB1o7nY3NlCk+IVY5j7fhdP/annA9hT3rjjaq+I5NhB4n54KG969+HuiAY2uesE/
 P4S/DKZJ95SdbC1iQDztfQm0iiqM0dA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-RSBRYnqkO9iJ6gMCaciCMA-1; Wed, 25 Oct 2023 19:27:36 -0400
X-MC-Unique: RSBRYnqkO9iJ6gMCaciCMA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7740517a478so39678185a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276455; x=1698881255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhk3/jPu+ktOTVn2YBI9nIBNFtxvKHkB32N1WAJPDfE=;
 b=kllIzEgHs8ABZ0tv301qqrcP5/CowHs88MPzRX52tq30CqGYpjL04fM6SfcpRk30mi
 1frIq6pvFRkv/LzNVMSzwDzdwqJIeLalSDNH0hoi9sQzeOoH2ohzKcCtTJf65Xpy/AY6
 n3yJy13BbNVDxgK8f3Hwc5Qse181gTU5XoxAJ7cm5ICFYOX5zy/MB1DoNv444tQVbhMx
 8DXWgTvgRxKRqjKxvtGpaBBr8gH8om+PUY2ebgdUEUsEovmlj7xvdJ5TpezrHBfTTrBS
 L7boPavG5km4CEElE78J73BNkgfYha/YgwhOfKPlPTKE0Af3S1ENxIv5d15KH4P7VZ+C
 nLoQ==
X-Gm-Message-State: AOJu0YyZ9PmwBl7L1t4kyvUHmLA93Fj2fCuqE2pVPa8UDag846akjRJE
 3RNwkNIWmV0SEwIx0792x5uZCBiMjPk9nUmUya2b3Bwl3JHVFdcL9VLs6CzVULVWJLj5nB+KLny
 LWBaD+J5lwErH4xFB+9ogOqVfxHBHcc7MiBkYk9IHInngnc0FXZrG6dDMjbCmZnl7y/SnlI696h
 I=
X-Received: by 2002:a05:620a:c52:b0:778:b0f5:d4ef with SMTP id
 u18-20020a05620a0c5200b00778b0f5d4efmr17039276qki.30.1698276455612; 
 Wed, 25 Oct 2023 16:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT3xxaT1MpIVLRxhsOLNbsK2JX05PcQSrbaf4CPKZJmcQJP4VhZnk48WlhSc0nCnxLFB2VHg==
X-Received: by 2002:a05:620a:c52:b0:778:b0f5:d4ef with SMTP id
 u18-20020a05620a0c5200b00778b0f5d4efmr17039263qki.30.1698276455277; 
 Wed, 25 Oct 2023 16:27:35 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4585808qkh.86.2023.10.25.16.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 08/24] kvm: remove unnecessary stub
Date: Thu, 26 Oct 2023 01:27:01 +0200
Message-ID: <20231025232718.89428-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

This function is only invoked from hw/intc/s390_flic_kvm.c, and therefore
only if CONFIG_KVM is defined.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 51f522e52e8..a323252f8e2 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -92,11 +92,6 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
-int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
-{
-    return -ENOSYS;
-}
-
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-- 
2.41.0


