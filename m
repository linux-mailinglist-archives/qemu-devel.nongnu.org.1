Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA2791305
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4f5-0001Rk-Uh; Mon, 04 Sep 2023 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qd4er-0001MT-FH
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qd4eo-0007Ab-TZ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693815000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNnPlncpKGwJgeNakHqloc9t9GUhSe4DGXH0m6agJa0=;
 b=LOuIfkY+ZXErgC6FA9OCSFgFNAE8B7UoMq6BjCsaAkKVz8IMDK5QMrMlHIamu184KzEdsG
 7kQhWZODx8uwFLGPjpo0HbCE90vHEza3hRL2/vDNIf9uXewKQAfHah0MZDThXvqdQCNX2Y
 FQztlVxx99KBMVOMfuE3lqRG4/q7cNg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2aOrrau_Ph-bgUWwAuH8Ag-1; Mon, 04 Sep 2023 04:09:57 -0400
X-MC-Unique: 2aOrrau_Ph-bgUWwAuH8Ag-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-402493650c6so7755685e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693814996; x=1694419796;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNnPlncpKGwJgeNakHqloc9t9GUhSe4DGXH0m6agJa0=;
 b=byUlP/pZHHEima6BN8GMBFzua/Io3jhoGt8P1yhgEt2CJp/AURhwgkxLIgcVsoSV6d
 cIrwJCKwQM0kNNBM0nBtX5aNZ15zdXqVUPd929KBcZq7cQMuGJx5Ybr4pjJSLkRPPIqc
 wsm49W7IZh9wqIl1wd3ybg00/tJmGSTk4Jq1x4jdF0m0WgkWujmdy/m8xbyGoKkFmoAP
 1hJ6X5cFp+NPPHxcV8tZu/75hcc26JLg9v4ocokdDnNCjmomA/YIEIUHRaFPj4lQzpBn
 9GFBW4VH4yJKAjSQrJV4m3+FTmE5/cClYvIrZkExVqdngjctw3tgnMgS3FEEhtLkpZy6
 +qwQ==
X-Gm-Message-State: AOJu0YxM8wb0vs3Fc5YUNtlVCJhQ7WrJsQg9snDqqIwbMcjFnho2rFsc
 7V2SBU0BYKDlE7nuRyAZ6es/AsV3gpar70vs3kAoO3pAsrgDPMh0rHoMoeCMiyIkYthSSmx01vK
 1cyljtUnoRw7I2nk=
X-Received: by 2002:a7b:ce0a:0:b0:401:b53e:6c55 with SMTP id
 m10-20020a7bce0a000000b00401b53e6c55mr7035948wmc.0.1693814996146; 
 Mon, 04 Sep 2023 01:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIvhoPypzIooYj9NEv6tEeTZ3WSae3j62VarO9BQ2fYYQ4WV6w62uK3jt8vBaSIP7Kk2X4KQ==
X-Received: by 2002:a7b:ce0a:0:b0:401:b53e:6c55 with SMTP id
 m10-20020a7bce0a000000b00401b53e6c55mr7035931wmc.0.1693814995801; 
 Mon, 04 Sep 2023 01:09:55 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a7bc447000000b003fe1fe56202sm13238247wmi.33.2023.09.04.01.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:09:55 -0700 (PDT)
Message-ID: <19b6e079-7d72-b9f4-2cac-2af39eb625a0@redhat.com>
Date: Mon, 4 Sep 2023 10:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 02/15] meson: update unsupported host/CPU messages
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230902125934.113017-1-pbonzini@redhat.com>
 <20230902125934.113017-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230902125934.113017-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/09/2023 14.59, Paolo Bonzini wrote:
> Unsupported CPU and OSes are not really going away, but the
> project simply does not guarantee that they work.  Rephrase
> the messages accordingly.  While at it, move the warning for
> TCI performance at the end where it is more visible.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 45 ++++++++++++++++++++++++++-------------------
>   1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1e..9bcf117f8a4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -678,9 +678,7 @@ endif
>   tcg_arch = host_arch
>   if get_option('tcg').allowed()
>     if host_arch == 'unknown'
> -    if get_option('tcg_interpreter')
> -      warning('Unsupported CPU @0@, will use TCG with TCI (slow)'.format(cpu))
> -    else
> +    if not get_option('tcg_interpreter')
>         error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
>       endif
>     elif get_option('tcg_interpreter')
> @@ -4317,28 +4315,37 @@ summary_info += {'selinux':           selinux}
>   summary_info += {'libdw':             libdw}
>   summary(summary_info, bool_yn: true, section: 'Dependencies')
>   
> -if not supported_cpus.contains(cpu)
> +if host_arch == 'unknown'
>     message()
> -  warning('SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!')
> +  warning('UNSUPPORTED HOST CPU')
>     message()
> -  message('CPU host architecture ' + cpu + ' support is not currently maintained.')
> -  message('The QEMU project intends to remove support for this host CPU in')
> -  message('a future release if nobody volunteers to maintain it and to')
> -  message('provide a build host for our continuous integration setup.')
> -  message('configure has succeeded and you can continue to build, but')
> -  message('if you care about QEMU on this platform you should contact')
> -  message('us upstream at qemu-devel@nongnu.org.')
> +  message('Support for CPU host architecture ' + cpu + ' is not currently')
> +  message('maintained. The QEMU project does not guarantee that QEMU will')
> +  message('compile or work on this host CPU. You can help by volunteering')
> +  message('to maintain it and providing a build host for our continuous.')

Please remove the dot after "continuous".

> +  message('integration setup.')
> +  if get_option('tcg').allowed() and target_dirs.length() > 0
> +    message()
> +    message('configure has succeeded and you can continue to build, but')
> +    message('QEMU will use a slow interpreter to emulate the target CPU.')
> +  endif
>   endif
>   
>   if not supported_oses.contains(targetos)
>     message()
> -  warning('WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!')
> +  warning('UNSUPPORTED HOST OS')
>     message()
> -  message('Host OS ' + targetos + 'support is not currently maintained.')
> -  message('The QEMU project intends to remove support for this host OS in')
> -  message('a future release if nobody volunteers to maintain it and to')
> -  message('provide a build host for our continuous integration setup.')
> +  message('Support for host OS ' + targetos + 'is not currently maintained.')
>     message('configure has succeeded and you can continue to build, but')
> -  message('if you care about QEMU on this platform you should contact')
> -  message('us upstream at qemu-devel@nongnu.org.')
> +  message('the QEMU project does not guarantee that QEMU will compile or')

You are starting a new sentence here, so "the" at the beginning should start 
with a capital letter?

> +  message('work on this operating system. You can help by volunteering')
> +  message('to maintain it and providing a build host for our continuous.')

Please remove the dot after "continuous".

> +  message('integration setup. This will ensure that future versions of QEMU')
> +  message('will keep working on ' + targetos + '.')
> +endif
> +
> +if host_arch == 'unknown' or not supported_oses.contains(targetos)
> +  message()
> +  message('If you care about QEMU on this platform, please contact the')
> +  message('developers at qemu-devel@nongnu.org.')

I'd maybe add a "and want to keep it alive" or "and want to keep it up and 
running" after "platform".

>   endif

With the nits fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


