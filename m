Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F0D7B1556
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllm3-0006b5-Hu; Thu, 28 Sep 2023 03:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllm1-0006aj-Qy
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllm0-0000Xq-89
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695887363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q/xuei5jXb7txjEpdo7OMsmCakhB3VToReXgRWSlDfU=;
 b=Xfm2+SFP0KR84fK9AR1wh5oIR6EwaGB/VdXQ194WdRPtDuNVDsoJtUKxB6S/wMmH9KzNeI
 orA2F7QBshMcfP7w8xghdQMtPPKL/sPrcUTB58C4AZtvLZ/O63YNXikbxkRW/OnuCCRGY9
 V6zYHT0pwbNlNPT/Xp6TRr6+ftw5dU0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-kYdm-mcQPqOTxQFFmj6RNQ-1; Thu, 28 Sep 2023 03:49:21 -0400
X-MC-Unique: kYdm-mcQPqOTxQFFmj6RNQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae12311183so1087451066b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695887360; x=1696492160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/xuei5jXb7txjEpdo7OMsmCakhB3VToReXgRWSlDfU=;
 b=C35IOyLRVdByUQ0w0hc2ZObfiXIyq7EdHBIGS9G6+9cHyGegOWn0FfoVpo5iw1A4Lg
 yZNOEGy0leSOwVnp4AFP8yMYFZDf3XWfk2aJdaRMM19x7kCwB1Uyb42w6vW6HNF2EDXb
 0fYp2sRSluyvXgYmj3Lg/bcF0qBzMOx3MW9B7RkR2SP/Avf1RnaDNEXmEijD9niiO9iK
 VvUAyZeCgnyqpcd76WFqPVbP9raAHS44i7i+QTggB7DAKJcDliqcyPK8XDI1XKqAS9ez
 jhzf1UAft23EIxGyKOe/3s8kcfyAIOWUg8aoOWud7kjLZZXL2zHfhurGWv5W/CpwqlCb
 2UuA==
X-Gm-Message-State: AOJu0Ywy+diHB+vl+8WQ/ZaMj/jAJS9+CGIgZh5EXSpKTDS3uLmt5n4W
 5Wu6ZiAY8i83NNgcxyJYmase9EdXnzcsLImm4VD2GS46BGCnRVnIu/1IHXLGyu/ig8W25+XusQz
 8wV3J/rWQr5O4xql0/x5MlmU2sY7HYeqT2gN0x/+LpilBbq8ud2M3BUdI/KRM9F2Sc6TQ23hqni
 Q=
X-Received: by 2002:a17:906:9c9:b0:9ae:50e3:7e40 with SMTP id
 r9-20020a17090609c900b009ae50e37e40mr512368eje.52.1695887360273; 
 Thu, 28 Sep 2023 00:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbwLJpPIhXXePqhouIwdBGYzEofxcGnwnUzVyY7lckeusXKnO/TnZTdobBf/6GsYiKh4aZgA==
X-Received: by 2002:a17:906:9c9:b0:9ae:50e3:7e40 with SMTP id
 r9-20020a17090609c900b009ae50e37e40mr512348eje.52.1695887359776; 
 Thu, 28 Sep 2023 00:49:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 eg42-20020a05640228aa00b00533dad8a9c5sm6163799edb.38.2023.09.28.00.49.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:49:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] crypto: only include tls-cipher-suites in emulators
Date: Thu, 28 Sep 2023 09:49:18 +0200
Message-ID: <20230928074918.874468-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

tls-cipher-suites is an object that is used to inject TLS configuration
into the guest (via fw_cfg).  It is never used for host-side TLS
operation, and therefore it need not be available in the tools.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 crypto/meson.build   | 3 ++-
 hw/nvram/meson.build | 6 +-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/crypto/meson.build b/crypto/meson.build
index 9ac1a898027..c46f9c22a7f 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -46,7 +46,8 @@ endif
 if have_afalg
   crypto_ss.add(if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
 endif
-crypto_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
+
+system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
 
 util_ss.add(files(
   'aes.c',
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 988dff6f8e5..75e415b1a01 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -1,8 +1,4 @@
-if have_system or have_tools
-  # QOM interfaces must be available anytime QOM is used.
-  qom_ss.add(files('fw_cfg-interface.c'))
-endif
-
+system_ss.add(files('fw_cfg-interface.c'))
 system_ss.add(files('fw_cfg.c'))
 system_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
 system_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
-- 
2.41.0


