Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89D709E2E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03wr-0007oX-FA; Fri, 19 May 2023 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q03wp-0007o3-IB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q03wn-00020r-Vd
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684517480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKSuEyJ0VRWZT/lZ93O7WkEtQ6h4HcAoDvPFosuXNTg=;
 b=MlvMLy5pKgcu5pmUpRvEdcfLlvJH0X8GkyhbAP0bPev4ZcaSsxTZzORCIvB0zD2tLuj34y
 zXf0M80CnB95tUhS/sYdiD3sGUUji0kMW9LoIuGb14Ukxgr1jjQ6b1Z+znTh/oJ/p5xAON
 y5pwTp0KTacB/PgMTVVxK4dGnxjX85k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-g54nNyo2PDGnz2qBsbwzgw-1; Fri, 19 May 2023 13:31:19 -0400
X-MC-Unique: g54nNyo2PDGnz2qBsbwzgw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-965cd056598so475336966b.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684517477; x=1687109477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YKSuEyJ0VRWZT/lZ93O7WkEtQ6h4HcAoDvPFosuXNTg=;
 b=k11S/qPvg4Qni/ake7d6h25IN3DWJg/PiU7zByTowi7j4mthkYrvmH27B5FGBXFcCI
 FwdzB0k8FW9+WxtY4EPUr0KrVlkgJK7KtfhogOlfjdlfw7/ih+19Ugri6BT9rWLJGeOi
 bfGa+fMtWQEgGNGcI2ExFCF/VPJvAKJUbDvHPP/Adjf9goI+Y7RmgKe8KYoJ6llgrZ3Y
 Z5sxCDv8Rj/wf8zyq84Ez/B8gQX8tgp26EF8vzAIQ8Rc2q7Uudenk+dZJ1onggGqQ4ez
 FD+M727wyN6v2Oeuv/bK4r1zWp2UNXRzvkfnPv4CpvemYJ08w1IA8e/l55RxDriS5vHN
 P99g==
X-Gm-Message-State: AC+VfDzw/V0nHEPdpoO7Gm3myFMyAgCudBeQhu7JyX84vFgiFXfrJadH
 sfafB7Q4A/83qrSF+ZpaCUZvCTrUmHDW45Y6Fk+BObzHqMTx+oxDQjojPS0832Fu5T7JM/auUlp
 eu65yErZsaxgc4oIxai4O7sw=
X-Received: by 2002:a17:906:c359:b0:96a:f688:db80 with SMTP id
 ci25-20020a170906c35900b0096af688db80mr2219759ejb.67.1684517477695; 
 Fri, 19 May 2023 10:31:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fUH2Ty6EYxX4Km/78sMEh0IV33I8rVfAtE7rlkTuSUbfieI+3e+ga36xMZYCPLKckLQlKfg==
X-Received: by 2002:a17:906:c359:b0:96a:f688:db80 with SMTP id
 ci25-20020a170906c35900b0096af688db80mr2219743ejb.67.1684517477339; 
 Fri, 19 May 2023 10:31:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 e14-20020a056402148e00b0050bc7c882bfsm1846673edv.65.2023.05.19.10.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 10:31:16 -0700 (PDT)
Message-ID: <379845d1-7a4e-a0eb-345c-451b17e77638@redhat.com>
Date: Fri, 19 May 2023 19:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230518114025.1006732-1-pbonzini@redhat.com>
 <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
 <CABgObfbk=8Uq3gN1dThxq3jJOAEk_cGu0Y4bvRtvdR9xZ2xtxw@mail.gmail.com>
 <CAFEAcA_4_JD46CxkT2dcXSLHKNsa7kKYPYJkqEzZERDTK_wx-A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA_4_JD46CxkT2dcXSLHKNsa7kKYPYJkqEzZERDTK_wx-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/19/23 19:01, Peter Maydell wrote:
>> Can you send your config-host.mak after a failed rebuild? I think
>> what's happening is that the path to meson has changed but Makefile
>> still tries the old one (which could be the system meson in
>> /usr/bin).
> 
> Attached; it has 
> MESON=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson
>
>  That meson says: $
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson --version> 
> 1.1.0 is neither the system meson (which is 0.61.2) nor the version
> the build system wants (0.63.0) nor the version that it complains
> that it's found (0.61.5), so I'm not sure what's going on there...

1.1.0 must be something you have cached somewhere, but 0.61.5 comes from
the old submodule.  You should be able to find it with

grep -wA2 'rule REGENERATE_BUILD' ../build.ninja

You should be able to unhose the directory with

pyvenv/bin/meson setup --reconfigure ../..

(where ../.. should be the path to the sources) or even with the patch:

diff --git a/Makefile b/Makefile
index 3c7d67142f13..08fb6a3b058a 100644
--- a/Makefile
+++ b/Makefile
@@ -115,15 +115,15 @@ Makefile.ninja: build.ninja
  	  $(NINJA) -t query build.ninja | sed -n '1,/^  input:/d; /^  outputs:/q; s/$$/ \\/p'; \
  	} > $@.tmp && mv $@.tmp $@
  -include Makefile.ninja
+endif
  
+ifneq ($(MESON),)
  # A separate rule is needed for Makefile dependencies to avoid -n
  build.ninja: build.ninja.stamp
  $(build-files):
  build.ninja.stamp: meson.stamp $(build-files)
-	$(NINJA) $(if $V,-v,) build.ninja && touch $@
-endif
+	$(MESON) setup --reconfigure $(SRC_PATH) && touch $@
  
-ifneq ($(MESON),)
  Makefile.mtest: build.ninja scripts/mtest2make.py
  	$(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
  -include Makefile.mtest

Paolo


