Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC087971EC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDQc-0004gh-AE; Thu, 07 Sep 2023 07:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeDQa-0004gQ-EO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeDQW-0005LL-KJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694087038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rHUEFvVOdZi9490GXLSM+2LqkVLeeUPl1E5eYiFyEm0=;
 b=YbrGIpaTweHG/qZ5Ms6mH+KIotpWSM4laGJ5arAGhAF9wUcpXZc4PGO07q0GQKaySOJN1O
 +MNDhIDkgBS3WJ9NxLRQ3fa/sfjYTe6wcIwlhBy1n2SU8NZ19an6g9/dTMjL53Sx8Ty5qw
 AgwB6geCjuHLj3GuY3Jw0G80+FyotNw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-TOl2HY1UPZGT8Id7WObIOw-1; Thu, 07 Sep 2023 07:43:57 -0400
X-MC-Unique: TOl2HY1UPZGT8Id7WObIOw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2be35b7b51aso10217971fa.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694087035; x=1694691835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rHUEFvVOdZi9490GXLSM+2LqkVLeeUPl1E5eYiFyEm0=;
 b=PSyTcsOhOa3kba4DK5Bxq9ZwtgJUNy3e9WKvGiVpiAK1tGS54d5MO1UF0XNoRwpFHV
 i0lH8Auvk+D8+Rhs71KFNvHgqUpnZ6FKfPT7RfveIOXEXisGIzbzRsAHcnlD5AxhPWzy
 KsXhtl50WrVI5lGSAwS2nLI5S0JmwRgT24GUaVrUiOiNTwCS9FsMggYx6jRwEKXAFZDC
 uOFd6nbcU+1WxaRSPyGH4SNMMgau4mfjRWCyBoS571a+DNVDRR2tTWS7QLw5LaIh8qrX
 GAnCTDsQrJppWb/obP5zWNp5sykrYm71o8RmGiTf4QmyKHPZpN2jY1fobRvTQs6s3IsD
 UUUQ==
X-Gm-Message-State: AOJu0YyJvyXq4FOtzrhGGX9T4XiQgJOu35EPozrhZpuSPRMcfTJcWXNn
 s5/lgbe4iUaW+NFndKQ+YbhMLZla6LdBNyMzIvr/Z0r22rFOJ2hqCRDShKvOMaQeaZTWZxFp1bl
 jbi2dPxdumvUneOXEdTIlSdxyzLnmRgkqm06v/3lQQdR5hvP7FXH/+WoN23OMVaeSi8WERpkA4z
 c=
X-Received: by 2002:a2e:9dd9:0:b0:2bc:fc2e:766f with SMTP id
 x25-20020a2e9dd9000000b002bcfc2e766fmr4190218ljj.37.1694087035375; 
 Thu, 07 Sep 2023 04:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQqPxIngmuc2L2OmhRzF4XPQoCuHiXk93PrZNWK2rglSXFkpYt/IA2G9e+73PGBkrFqQfKA==
X-Received: by 2002:a2e:9dd9:0:b0:2bc:fc2e:766f with SMTP id
 x25-20020a2e9dd9000000b002bcfc2e766fmr4190207ljj.37.1694087034885; 
 Thu, 07 Sep 2023 04:43:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312::1fc])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfe50e000000b0031c52e81490sm23092652wrm.72.2023.09.07.04.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 04:43:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH] ff
Date: Thu,  7 Sep 2023 13:43:53 +0200
Message-ID: <20230907114353.493323-1-pbonzini@redhat.com>
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

---
 .gitlab-ci.d/cirrus/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index a9444902ec8..8c71c70574a 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -29,7 +29,7 @@ build_task:
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS
       || { cat config.log meson-logs/meson-log.txt; exit 1; }
-    - $MAKE -j$(sysctl -n hw.ncpu)
+    - $MAKE -j$(sysctl -n hw.ncpu) V=1
     - for TARGET in $TEST_TARGETS ;
       do
         $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=1 ;
-- 
2.41.0


