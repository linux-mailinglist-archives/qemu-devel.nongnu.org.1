Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84B478AC86
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZep-0003S9-1M; Mon, 28 Aug 2023 06:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeb-0003Oe-2h
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeW-00058F-GL
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5USIrKsbqWrZWZgvE37P1mUv31f09yyWxouUnu06xw=;
 b=Sgiif38jF5JJ1LiyP95q1jJ91Kk47L6ZT4hcXMPxJvHV1Bb1gw3FPRnJlkllhWcakyG1qS
 I2GluHaOeVeD0pejXnhT9/yKKU18nk7Ee3LpA1SmS1ZnjwkgHv19HY35wj9E5mDNZSAdDm
 dk+08uK3KsapAtNSSEkdPIKD1D25bdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-lALRXNazOJaWAbgG_ZBX3w-1; Mon, 28 Aug 2023 06:39:21 -0400
X-MC-Unique: lALRXNazOJaWAbgG_ZBX3w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe5b94bd62so22593675e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219160; x=1693823960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5USIrKsbqWrZWZgvE37P1mUv31f09yyWxouUnu06xw=;
 b=fxX1pob8giLgZwrAEjmzG9K5tJdUZ1MiT2j28oqOHsQSyqBI8bPfnn+bNc8qOkyKjb
 wf4gPB74jvQacbhW4EzdR3Tz9ehRbg6GWojPDxEQ6lU9vT+yi8SJLZrCBQHFUpZ1NHG5
 D3ibA/MzXeyPwAnpmmWViPft8aggcPEQ4yE5AL+JcVHK4qLxpLX3hzcWnHgNhl47P5ej
 36YRNf6IzGGzPAdt3Y8O2FyJU4Iz7ay483DNwqNc7Kt2JvzC0N/eEGUlfnY5+cstc2Zd
 pL/Am+pVMVTjpSAzhBAScOvblyFivu1yHhWhHLgx9Ye2f3ve3OWG4MzTaSsddau3F8Ml
 EOBA==
X-Gm-Message-State: AOJu0Yx+E5p8bw3FBP79E9sPbQMEZiH9jOpD3w5KajV7sCr2EUJABrMf
 b3MFXF6iINOR37HVN4oot8OmqEt1YH8XTANUBPqmpPiHG+uru5zSIkEQcbu3hzuSKj2zKKZtgSj
 avYmiP9nlLtAHp6IqscBwCti+AHQXpCe9zpg8Jydx1AVHc9YKxUoG4nNeW516PfbB7YA8JmbpXb
 w=
X-Received: by 2002:a05:600c:2211:b0:401:b705:ebea with SMTP id
 z17-20020a05600c221100b00401b705ebeamr6535883wml.12.1693219159851; 
 Mon, 28 Aug 2023 03:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl/LDALZHRXnkCgwp4N5VZPIxcEzOahhSgo7UJ4emb9fT+Ai5pXl8tQ5srAzH1hfLh9LKjfg==
X-Received: by 2002:a05:600c:2211:b0:401:b705:ebea with SMTP id
 z17-20020a05600c221100b00401b705ebeamr6535871wml.12.1693219159550; 
 Mon, 28 Aug 2023 03:39:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c028c00b003feef5b0bb7sm10366490wmk.40.2023.08.28.03.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/14] configure: fix container_hosts misspellings and
 duplications
Date: Mon, 28 Aug 2023 12:38:52 +0200
Message-ID: <20230828103856.46031-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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

container_hosts is matched against $cpu, so it must contain QEMU
canonical architecture names, not Debian architecture names.
Also do not set $container_hosts inside the loop, since it is
already set before.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index e4d42d640e4..08bf24b689c 100755
--- a/configure
+++ b/configure
@@ -1352,7 +1352,7 @@ probe_target_compiler() {
     sh4) container_hosts=x86_64 ;;
     sparc64) container_hosts=x86_64 ;;
     tricore) container_hosts=x86_64 ;;
-    x86_64) container_hosts="aarch64 ppc64el x86_64" ;;
+    x86_64) container_hosts="aarch64 ppc64le x86_64" ;;
     xtensa*) container_hosts=x86_64 ;;
   esac
 
@@ -1459,7 +1459,6 @@ probe_target_compiler() {
         container_cross_prefix=x86_64-linux-gnu-
         ;;
       xtensa*)
-        container_hosts=x86_64
         container_image=debian-xtensa-cross
 
         # default to the dc232b cpu
-- 
2.41.0


