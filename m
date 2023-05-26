Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27C7712116
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Rxv-0005mC-Km; Fri, 26 May 2023 03:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2Rxu-0005m2-1I
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2Rxs-0004pO-IL
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685086459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hrgQ5ANOuXI6um3JGobCmuVd0rBAyg2QIrhVf3/OPE=;
 b=cNmMp5mxll2/nzpuWIUkNQzErVL3XdXpsrWwM7h6+jyD+4MK1C0e1ojICJiKBLybDILVeg
 0spqMxgPZOshmUddG5E1e55i69Gfe4Nuro70pKqeBHcLBB8cV4Jy+lHVSBibCmMeem38SD
 yfhrXS6pgzaoYEt31hDwjZmdW7PETmU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-nNe5_-CzPzqbh-pXVBI9Zw-1; Fri, 26 May 2023 03:34:17 -0400
X-MC-Unique: nNe5_-CzPzqbh-pXVBI9Zw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30a938fcfb5so254128f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685086456; x=1687678456;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hrgQ5ANOuXI6um3JGobCmuVd0rBAyg2QIrhVf3/OPE=;
 b=auS3HxpfZg4rakrJXvjHvI9AmRSK6nyKA1qchDKm/y1XVOAp2ANeeW+dnhtfHyxxOz
 oax0klXTS/wzYICnQOjiyyKY063UQV1Aw+ZLvwRatueAWlS+WHosaz85PGySyxDyx0L/
 s1/+Pj/rrVAnVBh0CvoRdq94LZTjPCO00hRbTMRPGNiDBM/Ed0VFQtzdaW8ilXavmjoG
 i0ltbZjf38bb5F9I4MYm1XGxb+GSkAFIxvGf8ZR/H3MxC87H5sNiJrXSTAY3W+M5/0ez
 2xe/tDrSSNqh4f3eksNJCPCFTg4QYJ2hh1UX1hIebZJ5JwMiru0jT+IP0K02xTuMAsES
 HG8Q==
X-Gm-Message-State: AC+VfDyMfalcSJfB7ExosJ+WeVp2V0FDj6eVSiMNjCrR+Wc0HeAaeNrU
 +2CU26mzn8/bbrX9iynNC6J7DO20oHenlIrqFzLCiV3nxE6k0q2X0qRHayqwL/7AgBGdZ8kqkJH
 6rZ0kcKxjh/aiiTgd0xxk7Wo=
X-Received: by 2002:a05:6000:11:b0:306:2d45:a8e0 with SMTP id
 h17-20020a056000001100b003062d45a8e0mr551191wrx.15.1685086456716; 
 Fri, 26 May 2023 00:34:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4f4hRVOJXVnFWyU/Hzav5l3gxCEF5VbMAeviJ+/fvyaQQlvixPVwlkTsfU3+/DguliGQSO+A==
X-Received: by 2002:a05:6000:11:b0:306:2d45:a8e0 with SMTP id
 h17-20020a056000001100b003062d45a8e0mr551181wrx.15.1685086456456; 
 Fri, 26 May 2023 00:34:16 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 x4-20020a05600c21c400b003f0aefcc457sm7970077wmj.45.2023.05.26.00.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 00:34:15 -0700 (PDT)
Message-ID: <8d0dfbed-91e7-ea7d-afe9-cc170de5ad79@redhat.com>
Date: Fri, 26 May 2023 09:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH qemu 1/1] [meson.build] Add conditional dependency for
 libkeyutils
Content-Language: en-US
To: ~_6d6178667269747a <maxfritz@me.com>, qemu-devel@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <168471463402.18155.3575359027429939965-1@git.sr.ht>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
 zhenwei pi <pizhenwei@bytedance.com>, antischmock@googlemail.com
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <168471463402.18155.3575359027429939965-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


  Hi!

On 22/05/2023 02.12, ~_6d6178667269747a wrote:

There is something weird with your setup (sender name is "~_6d6178667269747a" ?)

> From: Max Fritz <antischmock@googlemail.com>
> 
> This modification enables better control over the inclusion of libkeyutils
> based on the configuration, enhancing the flexibility of the build system.
> 
> Signed-off-by: Max Fritz <antischmock@googlemail.com>
> ---
>   meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d..206d4033bf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1764,8 +1764,11 @@ if gnutls.found()
>     tasn1 = dependency('libtasn1',
>                        method: 'pkg-config')
>   endif
> -keyutils = dependency('libkeyutils', required: false,
> -                      method: 'pkg-config')
> +keyutils = not_found
> +if get_option('keyring').enabled()
> +  keyutils = dependency('libkeyutils', required: false,
> +                        method: 'pkg-config', kwargs: static_kwargs)
> +endif
>   
>   has_gettid = cc.has_function('gettid')

Please put the maintainer for the crypto/ folder for this into copy (done now).

  Thomas



