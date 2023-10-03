Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47F7B6429
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:31:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoT-0002N6-5Z; Tue, 03 Oct 2023 04:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoE-0002JJ-0W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao9-0000Iy-Ux
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBVBdM+9uj89cR+ThOaqChPLTmRyffYAAxAEvfalfqQ=;
 b=gwpBYqWCRNDkmmq3i5atvzsrRR/v2S2sEe9MjXw+iNHDeGPpqegUF4Td8DqbcWLPdliLjI
 c91bvb0chCBJ72iV5zcfNqH2rtN2uG7eMaRndAramHFKX73am5YV6V9o3WBdFDlmPbiQDo
 LBZ0L2pr+skzV1ujJ5a0F7XVROjXLfI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-emw-HyOhOfe7naZPNLmYRw-1; Tue, 03 Oct 2023 04:31:07 -0400
X-MC-Unique: emw-HyOhOfe7naZPNLmYRw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so51899966b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321866; x=1696926666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBVBdM+9uj89cR+ThOaqChPLTmRyffYAAxAEvfalfqQ=;
 b=VlQvazTnuP4wSNgXTLJy1YVUwD3rFNI2W0QpP1M2YUCQRs2EfTguf343z+SflGiGJz
 y0kgcEALtVk8BdS0odiZF86bzcNRxeSevjhHJYtOdpUfCErV8SX89FeI1teGASTz9lRU
 DD03j6o4lZHB9QNKhxia/hXjWO2GSCw5GDHfZmK2QZE5CTUTA8PP2hSnlXHFj7iFAzi9
 Jtb9tsPFoc7molY7EYt6HS++FFeXWw7wqjYNkVrNC2fz6hUSMq1zLsZTLPpAp4lYO29G
 HgqD28swdKL9Xq2u32Y1c55D8ZsSClORU7PC2Nr4LtGEGDqWL7txuKaEtfOe8rwB9LOc
 Qs9A==
X-Gm-Message-State: AOJu0YzS2yZ4g4s9gNrFtCyRfsNqBsGJZN6gzRswBv4RLo9UA33X4QlJ
 C//PEs2ivLlyIgYoHH6QyryHln6xGpsuia0GrBa5ZWJrvd/0MtR8oso6mpEJjsuGjWxko0dK2rd
 QnPUGlj/NTsVnbs+EvWfZ6d11442m8pbIYpuI2O7mPW19uwxoUXz+Cq8f6Zyj5TSgdlF50aoxWS
 M=
X-Received: by 2002:a17:906:ce:b0:9a4:88af:b7b with SMTP id
 14-20020a17090600ce00b009a488af0b7bmr10559411eji.62.1696321865871; 
 Tue, 03 Oct 2023 01:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzZUo7agvcs+JIhFIFaKCceuPuYpTGy42p/6AjRborbAfNfq5e6bceCqJMCEoob4Aa1pwMRg==
X-Received: by 2002:a17:906:ce:b0:9a4:88af:b7b with SMTP id
 14-20020a17090600ce00b009a488af0b7bmr10559391eji.62.1696321865524; 
 Tue, 03 Oct 2023 01:31:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a1709064e8500b009b29553b648sm640260eju.206.2023.10.03.01.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/24] crypto: only include tls-cipher-suites in emulators
Date: Tue,  3 Oct 2023 10:30:28 +0200
Message-ID: <20231003083042.110065-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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

tls-cipher-suites is an object that is used to inject TLS configuration
into the guest (via fw_cfg).  It is never used for host-side TLS
operation, and therefore it need not be available in the tools.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


