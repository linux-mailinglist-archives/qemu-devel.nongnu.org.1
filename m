Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC457907FE
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQE8-0000vR-C9; Sat, 02 Sep 2023 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE6-0000tp-8J
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE3-0001fg-LB
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjIkCF5qgOZQn7olwlUoun7cKywGIXhs+Hi0nn+kw18=;
 b=Y0x5YzgiXGPESld+eFhRyPeo1GSMET9+WxWqNFm8i04+12SRZY9Loge6/hTiSR+FWy6QTG
 FoTAQfOURwNzL2CCK4YjxxLoai5zW4SBqmnvRbWMOkgyKUwBlyvfJ75XcdVHmOm3kEWFvP
 K9SEkWFzbABpRpPWCaLImsd0n7crGkU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-IXQ61ynjMqCPKMhuFITvhQ-1; Sat, 02 Sep 2023 08:59:40 -0400
X-MC-Unique: IXQ61ynjMqCPKMhuFITvhQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c7b8d0f0aso1658075f8f.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659578; x=1694264378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjIkCF5qgOZQn7olwlUoun7cKywGIXhs+Hi0nn+kw18=;
 b=UKSQERkYct6jwGV8MBcR/EEedh7pFdyTP3drrIERehUlA4HC0QKUHLqIU9EdSVMZRW
 Bws0yP/1jVmJaX6cAu0EoQSrjBKxS4ejYxbV9ru9fMjoGyOjQ4Z/0a5V+ZpOFTv4LGvw
 cJfdsSPvBTmTbekUrWnSBQA3hAr9qEE9VDb0JkIi5wX1MGMwhAsAd/Q1zjJgKMBgVEuK
 9HfwwXlzjDT/3yXF9uw58Q3LMG080PWAgO3H3iC1ImwVFE7S27Z2jnOaDhrtOO55okwW
 yHg2HfcAbx93TcNDARYxYL/DuUGawWhTPD+K2zlKcvmMxTVESBOHzPcpo1/i8dYVQnSh
 qFkQ==
X-Gm-Message-State: AOJu0YwFPHauWFWS12kaEvX+2F54+EVvh0x3X283Awt9BD73sB2b1UX5
 OevHnMafPqttWV7YqNlmHvCKz6t6luQpFdsC5+6Sr4jO66Jp2DkN8BtjUz8mdlQtInUeZ1d5TZB
 YBZtJjsbbvQ0xGstQGnPZfDK+5vN+8mmFNd2aZlHiPpktyvKvgiUA9uR4jTA9MhVoqzIuufbXjQ
 c=
X-Received: by 2002:a5d:4006:0:b0:319:8ce0:4e52 with SMTP id
 n6-20020a5d4006000000b003198ce04e52mr3492471wrp.67.1693659578330; 
 Sat, 02 Sep 2023 05:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDIev9tUbck2JA/7llBa0UwGsJRlWHlbKIN7tD+Q59Iq8oILMvhcca0aOsGTDR55ZLpue+hg==
X-Received: by 2002:a5d:4006:0:b0:319:8ce0:4e52 with SMTP id
 n6-20020a5d4006000000b003198ce04e52mr3492462wrp.67.1693659577920; 
 Sat, 02 Sep 2023 05:59:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a5d4804000000b0031c56218984sm8397074wrq.104.2023.09.02.05.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/15] meson: do not unnecessarily use cmake for dependencies
Date: Sat,  2 Sep 2023 14:59:20 +0200
Message-ID: <20230902125934.113017-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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

Both gvnc and sysprof-capture come with pkg-config files, so specify
the method to find them.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration/meson.build | 2 +-
 tests/qtest/meson.build     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index ac71f132901..a91aa61c659 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -1,4 +1,4 @@
-sysprof = dependency('sysprof-capture-4', required: false)
+sysprof = dependency('sysprof-capture-4', method: 'pkg-config', required: false)
 glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
                          method: 'pkg-config', static: true)
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b071d400b37..df63909ee51 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -321,7 +321,7 @@ qtests = {
 }
 
 if vnc.found()
-  gvnc = dependency('gvnc-1.0', required: false)
+  gvnc = dependency('gvnc-1.0', method: 'pkg-config', required: false)
   if gvnc.found()
     qtests += {'vnc-display-test': [gvnc]}
     qtests_generic += [ 'vnc-display-test' ]
-- 
2.41.0


