Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D597BB639
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinO-0008NV-8Z; Fri, 06 Oct 2023 07:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0008Fd-IO
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin5-0000Jv-RR
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Luqbg0iv9QomaP+bzgEzMOtbMBnMckqWwEvz6p/CP1I=;
 b=PJAgPUUym1Npc5uxESfcG/cAqvQit8TGcU1vFfLfT4/MeNtAdQnA/ju99THFbFuccyMOqG
 6YcKdyhiCJXa5N82vhEplY9qFb/vqS1lKTSIlwhRZENsDE5GJE48KVOS32nwFbwo2kVpaZ
 doBdybrQYR8mE+z6R8F0LrjOze5j0ws=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-u4IS52XhNbyBKvpAH8Gnrg-1; Fri, 06 Oct 2023 07:14:26 -0400
X-MC-Unique: u4IS52XhNbyBKvpAH8Gnrg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so1722151a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590865; x=1697195665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Luqbg0iv9QomaP+bzgEzMOtbMBnMckqWwEvz6p/CP1I=;
 b=ZjfZhDcPF2dbDlOOxMOJ7mQ/AsKSneN8YMNzC8fc/O6UamhLvkziqrS3QfdT+neTqS
 Vqh4vL7VveweqPErZyeO0hyHXtPhyjBY47qmc2BWIU2CeFCQXS38lBeEQGFD204EV0qU
 D+kRnkuVAk7oMufzXdDVa0V5BvqGOIqCWx/rIseNN5DC7/737lbCZ9qG7evU0zEMkHGZ
 IDjrsGbr9PxRx2JP0PS/w+tHxRHpjLLSX74NAqnqnA1Mgv1PNjHRxmXnXcAeAFrjCCoD
 2yKXpSHe5TnjWD2dZqWcFsbfZBwNaIlEUec7Xfh91u3k+MmO/JxloW8Ky8HvMopA7BK6
 JarQ==
X-Gm-Message-State: AOJu0YwcKlc7R3gn5jZEKv7+nNYXayzfNPe6WyFQ1cig+vH7vZvc+F8c
 q+avc69OW+yom8EZ2TuA5f4mf3yHx9iyPkN3RiZt0hGHde93NCOjqMwnTJ4TAK34tVcDxmRvEeZ
 IWgMStyZNaCcaYSOGmgofPt/z09LrEmBxtapvUSQsSB5l0VjAscEooSB0Q8MIuY3mG7JRdN4VkW
 w=
X-Received: by 2002:a17:906:3156:b0:9b2:b71f:83be with SMTP id
 e22-20020a170906315600b009b2b71f83bemr6795490eje.1.1696590864900; 
 Fri, 06 Oct 2023 04:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENoIDExoCWsLsDfPO+yb7q21Hl2/Eum692Y+6IGh+11tg+qpxwOdsZVN6GFqRLpZky63Z0IQ==
X-Received: by 2002:a17:906:3156:b0:9b2:b71f:83be with SMTP id
 e22-20020a170906315600b009b2b71f83bemr6795477eje.1.1696590864542; 
 Fri, 06 Oct 2023 04:14:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 op26-20020a170906bcfa00b009b65a834dd6sm2681300ejb.215.2023.10.06.04.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/26] travis-ci: Correct invalid mentions of 'softmmu' by
 'system'
Date: Fri,  6 Oct 2023 13:13:52 +0200
Message-ID: <20231006111412.13130-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-3-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b958eca5de1..76859d48da5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -34,7 +34,7 @@ env:
     - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_BUILD_CMD=""
     - TEST_CMD="make check V=1"
-    # This is broadly a list of "mainline" softmmu targets which have support across the major distros
+    # This is broadly a list of "mainline" system targets which have support across the major distros
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
@@ -197,7 +197,7 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
-    - name: "[s390x] GCC (other-softmmu)"
+    - name: "[s390x] GCC (other-system)"
       arch: s390x
       dist: focal
       addons:
-- 
2.41.0


