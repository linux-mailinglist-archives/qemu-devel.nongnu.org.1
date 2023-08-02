Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C2976D2E6
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRE6s-0001Yf-5F; Wed, 02 Aug 2023 11:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRE6r-0001YB-0A
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRE6m-0008Lu-Ht
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690991387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAaKEDfj6I7MNOVuna1+RU7smspcCrY0chIOO16jt9Y=;
 b=bWjykeOsd4jDJEbsxX3u4zGA6JOj/IGNewRfv0dX8Q3+TQAw5OtZZG2+FNWJaDT7zyIFoc
 6lHmi9IzsmcDyTZgXktiUMqS7s1IkIQXw2U3nZa6QN3pdlCLd8njiGZ4+cRRZ/QIw11Yrh
 TfeF//GB35f0zy8azLiBF3V/VJSrrJk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-KpPgAVuVPrSwAkPiuNDUTA-1; Wed, 02 Aug 2023 11:49:46 -0400
X-MC-Unique: KpPgAVuVPrSwAkPiuNDUTA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-56c7adba6afso8706234eaf.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690991385; x=1691596185;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UAaKEDfj6I7MNOVuna1+RU7smspcCrY0chIOO16jt9Y=;
 b=B0jIUROM/zq5joOXSK9skH5Kz1IYpHsBGWU72+BSpOY1tB6CokmXEWfHkSKAuLfKdu
 v9EQVN2ZlK3tOifx1tIr0VB4jd9DvVCSMXGyzsLJvsAIa74CcUG5DUYY6KDhQXcavMy0
 0WRK1AaBjek22tPDR3pfuYmmM6AcxWXNfNG75zWPw6o74XuTLNr9/xWtnSRLi479NyKp
 8NZG0AtdwvGjk54Zs2H8qq7zMhGxoGqARJielLMLBif2ZnHBea7NwSOfJIdiBqearc8x
 JUqYxgEYWlynHlqH9D+ttTmzBFY6I9tVNnIxnKKLjzQm2bYubAStPRz2Xkd6VAAjRR40
 j61g==
X-Gm-Message-State: ABy/qLYqDAceiZaO1xAKQhDBfUDm8insZ54+m2lJ8X3mTm09xKHZ+dyd
 XEE6OpSZosco9J0ICtt53e8fFWZ5s2Tl5wu3gfK0kQ3QOfkh/SSkkLysIgut/tyXzAspRp0PT1a
 8cce7UxFzQyWrfPA=
X-Received: by 2002:a05:6358:9925:b0:12b:df63:9d64 with SMTP id
 w37-20020a056358992500b0012bdf639d64mr6295140rwa.19.1690991385408; 
 Wed, 02 Aug 2023 08:49:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5wZBpN/N6f7hHq7WP1sfowh+OCJ5PKOkQoxoXHntc3pSJtfOCN70rLBP0ohDdSkU9Z91bfg==
X-Received: by 2002:a05:6358:9925:b0:12b:df63:9d64 with SMTP id
 w37-20020a056358992500b0012bdf639d64mr6295120rwa.19.1690991385114; 
 Wed, 02 Aug 2023 08:49:45 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-230.web.vodafone.de.
 [109.43.178.230]) by smtp.gmail.com with ESMTPSA id
 c17-20020a0cf2d1000000b0062ffbf23c22sm5568690qvm.131.2023.08.02.08.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 08:49:44 -0700 (PDT)
Message-ID: <52b5237e-b302-ecde-2373-f833034e4132@redhat.com>
Date: Wed, 2 Aug 2023 17:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/8] gitlab: always use updated msys installer
In-Reply-To: <20230801130403.164060-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/08/2023 15.03, Daniel P. Berrangé wrote:
> We current reference an msys installer binary from mid-2022, which means
> after installation, it immediately has to re-download a bunch of newer
> content. This wastes precious CI time.
> 
> The msys project publishes an installer binary with a fixed URL that
> always references the latest content. We cache the downloads in gitlab
> though and so once downloaded we would never re-fetch the installer
> leading back to the same problem.
> 
> To deal with this we also fetch the pgp signature for the installer
> on every run, and compare that to the previously cached signature. If
> the signature changes, we re-download the full installer.
> 
> This ensures we always have the latest installer for msys, while also
> maximising use of the gitlab cache.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 831b080d12..0bc04ad068 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -23,10 +23,34 @@
>     - If ( !(Test-Path -Path msys64\var\cache ) ) {
>         mkdir msys64\var\cache
>       }
> -  - If ( !(Test-Path -Path msys64\var\cache\msys2.exe ) ) {
> +  - Invoke-WebRequest
> +    "https://repo.msys2.org/distrib/msys2-x86_64-latest.sfx.exe.sig"
> +    -outfile "msys2.exe.sig"
> +  - if ( Test-Path -Path msys64\var\cache\msys2.exe.sig ) {
> +      Write-Output "Cached installer sig" ;
> +      if ( ((Get-FileHash msys2.exe.sig).Hash -ne (Get-FileHash msys64\var\cache\msys2.exe.sig).Hash) ) {
> +        Write-Output "Mis-matched installer sig, new installer download required" ;
> +        Remove-Item -Path msys64\var\cache\msys2.exe.sig ;
> +        if ( Test-Path -Path msys64\var\cache\msys2.exe ) {
> +          Remove-Item -Path msys64\var\cache\msys2.exe
> +        }
> +      } else {
> +        Write-Output "Matched installer sig, cached installer still valid"
> +      }
> +    } else {
> +      Write-Output "No cached installer sig, new installer download required" ;
> +      if ( Test-Path -Path msys64\var\cache\msys2.exe ) {
> +        Remove-Item -Path msys64\var\cache\msys2.exe
> +      }
> +    }
> +  - if ( !(Test-Path -Path msys64\var\cache\msys2.exe ) ) {
> +      Write-Output "Fetching latest installer" ;
>         Invoke-WebRequest
> -      "https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-base-x86_64-20220603.sfx.exe"
> -      -outfile "msys64\var\cache\msys2.exe"
> +      "https://repo.msys2.org/distrib/msys2-x86_64-latest.sfx.exe"
> +      -outfile "msys64\var\cache\msys2.exe" ;
> +      Copy-Item -Path msys2.exe.sig -Destination msys64\var\cache\msys2.exe.sig
> +    } else {
> +      Write-Output "Using cached installer"
>       }
>     - Write-Output "Invoking msys2.exe installer at $(Get-Date -Format u)"
>     - msys64\var\cache\msys2.exe -y

Reviewed-by: Thomas Huth <thuth@redhat.com>

... I think the original idea was to use a "tagged" version to avoid that we 
have some kind of "rolling release" here, but since the latest content is 
fetched anyway during the following update, that idea was likely not working 
as expected...


