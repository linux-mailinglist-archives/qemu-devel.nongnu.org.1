Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B67AF175
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQJ-0003MB-2A; Tue, 26 Sep 2023 13:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPd-000273-Hg
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPa-0006hX-G0
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXh2gOGuGydxlcHn0MJWkG6oNwaWADlluHpoQ0K5Bu4=;
 b=UNpn1GjPdCVRBGppAhm1d2SbOQ523PF56+6uumE3jkTzOgt5Y/dLkNTJ3Aa2Go3Icc3Vqw
 4LQkn0txo7qUBVHQBGVe4J9yFnAFZ8GKZHVmFrfzViUmUMRrLsjtzwWnCryRQT9+J9F3Ge
 ypDL3jsk7kS6bX07p3qyiESuAvb+GHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-aSewzDKhOcCCWtLhNC-m8g-1; Tue, 26 Sep 2023 12:59:48 -0400
X-MC-Unique: aSewzDKhOcCCWtLhNC-m8g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso78911825e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747586; x=1696352386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXh2gOGuGydxlcHn0MJWkG6oNwaWADlluHpoQ0K5Bu4=;
 b=RDNIdCGV4IToLRHCmwThq5LlqqlOg5ZU/zDGdxezrNWENU0Z6pXN1ZluZeN6thqKLP
 XPDMT39g95MRvviWKuSoK23duFGacotafs5SORA9eKZLw5TtbWx5XOASwTIcvqC9AbRt
 r7iz6tH0qKmBSp/GlrZVk8ABZuKmOkoE1KnoMin7HSkzTG2ndUx2hoTU5w2hWu01CS+d
 OhuYsvq0C81E2TzrDd6y45QCuvj2PUi5OOGyPkBQraixaiedJRu87qmJGkfA6zy/yq3F
 vpgxH0Nbqk+GmXygRVRauAM/PHlZNXWacj2nmqooLzo/lUJMA/wAyT3oD3WJvR6n9ygz
 gPRA==
X-Gm-Message-State: AOJu0Ywz3w6IiH1i1Tqz/Qajf46sngPu4Tryp0Kics5cH/o4POeXkMfb
 tCh0+NeJbCJsQyH3YdJ88mBUX8jMG8OnijPB7Z6Ra+/0uXM5d1DMswar0wli3hvChrTiutS/9ul
 M63FcUfn+F3MDQ9M9yaeuXx4PYaGRFk4vj0z42za2cY9BQvsykwc5qdxnKTwV60lMMOYeEmUDle
 4=
X-Received: by 2002:a1c:7904:0:b0:402:d72:bee5 with SMTP id
 l4-20020a1c7904000000b004020d72bee5mr8827661wme.21.1695747586660; 
 Tue, 26 Sep 2023 09:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOCQmmkmKDfn4FeiOoR7KwXeZWiSBt5eYHtWWrOIVMQuCKZ972y6mTAXOQ/yHsbqdETH2xog==
X-Received: by 2002:a1c:7904:0:b0:402:d72:bee5 with SMTP id
 l4-20020a1c7904000000b004020d72bee5mr8827646wme.21.1695747586277; 
 Tue, 26 Sep 2023 09:59:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a05600c54c700b003fc16ee2864sm14015558wmb.48.2023.09.26.09.59.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] target/i386/svm_helper: eliminate duplicate local
 variable
Date: Tue, 26 Sep 2023 18:59:12 +0200
Message-ID: <20230926165915.738719-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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

This shadows an outer "cs" variable that is initialized to the
same expression.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/svm_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 2d27731b608..32ff0dbb13c 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -387,8 +387,6 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     env->hflags2 |= HF2_GIF_MASK;
 
     if (ctl_has_irq(env)) {
-        CPUState *cs = env_cpu(env);
-
         cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
     }
 
-- 
2.41.0


