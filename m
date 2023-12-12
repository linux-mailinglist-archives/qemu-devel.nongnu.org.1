Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 751E480E8FE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:23:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzuI-0006aH-Sx; Tue, 12 Dec 2023 05:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rCzuE-0006Zd-To
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rCzuD-0007qN-Ch
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702376544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kEST+MKo6CibOU3iHFI9ZD1Wnt97ACG36waRHtm6p8=;
 b=eMq095ktEvNHVNd9Eq4vU6jCdIdt4ukuYJy2Pq9b9dfO29Kvuh5/IIq6+XfsOlBQ2mFtd9
 Czm6mTssZlRH5gOGAQoQaoylDsvZ8IsDZNKRlLmgE8S7mFMc3zbN4l9xfsLylPKByxNG6h
 T6myn4Euy0FfUr4uGwuR7s2eC+mxuSg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-mzm3VUJcOgyhxrPCDM3lmA-1; Tue, 12 Dec 2023 05:22:22 -0500
X-MC-Unique: mzm3VUJcOgyhxrPCDM3lmA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33608afb161so3749522f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702376540; x=1702981340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kEST+MKo6CibOU3iHFI9ZD1Wnt97ACG36waRHtm6p8=;
 b=fIscesBiVgdXybPYvfHRWyzDYMY0sXwut8BVpNcARldHbr6l78FfOIPTL8KOU0MJXU
 fP1tjNdB7TngXaMFsmQKkpYOz5QlJijt2GCdkaANDyc7y+ldHGq9+4tt9G+yFMjWlB52
 NdMUZW1YkoIjt/FN9stksfPtUSbISw6g75K5Ek41CvfxKh7IUVzgyUGtMT44q/Rroetp
 su14pBFWOQIqF7Zmo+SjtQ7F8GtYiYX9XzpxePIsyHvIcHWhwlxWHeI+gPQBbrorFBIs
 kLUglttPszNIfSMdRZ9M5SNIcBG1XxmcL+sSM+QgugMoE57MMA2+t5Vy4FzbpCoQcmYL
 L5Fg==
X-Gm-Message-State: AOJu0Yx/WGv/uOPxiVKYW3z4gLmYKNyzhcSphDnaiIj7srsmhmNK4foT
 isklR9NpnIW5ITY+IKO6UX2UWl/8NfO1tfO61i8MNKNVIsPwMJ0wF14xZrvlKECQ95/ImOOPp3F
 ql2KYX++VIgFLx4GUZuws3BVuqI7D4qbgcDoI2ZbJGTykCv3lZH7nyWZj2b/1E1cfPA2BxXJ4BM
 k=
X-Received: by 2002:a05:6000:147:b0:333:3c21:822d with SMTP id
 r7-20020a056000014700b003333c21822dmr3656646wrx.1.1702376540769; 
 Tue, 12 Dec 2023 02:22:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyQ64+BktazHW7LP9E+eXgq2YlVWocmAr0EA6zksGgvrZk50asFLZfDkGteDk0yr9KgkLo8g==
X-Received: by 2002:a05:6000:147:b0:333:3c21:822d with SMTP id
 r7-20020a056000014700b003333c21822dmr3656637wrx.1.1702376540487; 
 Tue, 12 Dec 2023 02:22:20 -0800 (PST)
Received: from [10.201.49.8] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4cc1000000b0033350f5f94dsm10439027wrt.101.2023.12.12.02.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 02:22:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/2] xen: fix condition for skipping virtio-mmio defines
Date: Tue, 12 Dec 2023 11:22:14 +0100
Message-ID: <20231212102214.243921-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212102214.243921-1-pbonzini@redhat.com>
References: <20231212102214.243921-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GUEST_VIRTIO_MMIO_* was added in Xen 4.17, so only define them
for CONFIG_XEN_CTRL_INTERFACE_VERSIONs up to 4.16.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/xen/xen_native.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 6f09c48823b..1a5ad693a4d 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
 }
 #endif
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41700
 #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
 #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
 #define GUEST_VIRTIO_MMIO_SPI_FIRST   33
-- 
2.43.0


