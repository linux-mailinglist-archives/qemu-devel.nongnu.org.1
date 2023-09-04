Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7100791320
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4kJ-0005C8-9Z; Mon, 04 Sep 2023 04:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qd4k7-0005BZ-LS
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qd4k5-0008Kq-GZ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693815328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J54+QFr1irPJAAZ45z8udiHD24zPOAIHQ/qc0WcCq2g=;
 b=iP6TOrcxnnia9dS5/9HZ/VMz/ma9jDiO1Z/9Vikdq/Pj9/LqBsXCEJPK20CBse0k+QiDjF
 +v5/bPtewv92o2PgHxvxRo45Z3Rus8Fug26QD+s2f9MLy/gnh1SPn4qL0LqKwX0bkc5dnk
 bUyjVT9tUbOPJZnULdt1fd6Q6g2pmPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-raJxMITZOayUqKdxGUBKNw-1; Mon, 04 Sep 2023 04:15:27 -0400
X-MC-Unique: raJxMITZOayUqKdxGUBKNw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401b8089339so7078855e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815326; x=1694420126;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J54+QFr1irPJAAZ45z8udiHD24zPOAIHQ/qc0WcCq2g=;
 b=lJW3WZSLZ4sel30p0t/pUaNa4D0+2LY2Uh7UAJVKJwwb6Ex7LNx9cY1XViq2S+wqO2
 WeVeSMOxlUyLi3gxZZX6sAyVgYufSjx6+vpZ8p+YWz29PMzIfqRRkzAfr2jTlDdgKIoW
 Z0twJSxZtSYD6JbaD3K4VIQLVX9DKgq3dcVpjw9sSN2vYtub00fes0f1Kb+bd0VbKm/O
 Cv0TblduZ1WzySkU6JMcGvKOse8fCv8CoWAOsDjVoekAot4EX8njh4/7gH/fvFZ/8/Yn
 4xuI4lIQ+fcT71vWiuBF/jZETfN3OU5ptBc64zClGk4U+BPwSqe8+Z7V3ikrhYlywJEv
 F92g==
X-Gm-Message-State: AOJu0Yx8F8LA1AtKJS/KSkN3PqIPqoEfdAaFy9V06YmhMYpf3AMzeJQ4
 +9631GXzU5rYHB3G0b6yrQCvOL0tf6RsDDl+RGR5CxsdjJAJXjpTRO+k75raN8GM0njePtvufZa
 y3GwzZCX9Hrp7iK4=
X-Received: by 2002:adf:ef49:0:b0:317:70da:abdd with SMTP id
 c9-20020adfef49000000b0031770daabddmr7692548wrp.59.1693815326078; 
 Mon, 04 Sep 2023 01:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfcaq/37TIIltJ449lzYsSuzXLhJxhiEbcQBhbC1Yd9r6tmQzsKh+AzNt4EPXCsQVweNjowQ==
X-Received: by 2002:adf:ef49:0:b0:317:70da:abdd with SMTP id
 c9-20020adfef49000000b0031770daabddmr7692535wrp.59.1693815325765; 
 Mon, 04 Sep 2023 01:15:25 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a5d5146000000b00317f3fd21b7sm13671936wrt.80.2023.09.04.01.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:15:25 -0700 (PDT)
Message-ID: <14a94f46-1f15-1480-c0dc-613a21004186@redhat.com>
Date: Mon, 4 Sep 2023 10:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 06/15] configure: remove boolean variables for targets
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230902125934.113017-1-pbonzini@redhat.com>
 <20230902125934.113017-7-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230902125934.113017-7-pbonzini@redhat.com>
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
> Just use $targetos always.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 55 +++++++++++++------------------------------------------
>   1 file changed, 13 insertions(+), 42 deletions(-)
...
> @@ -1718,7 +1687,7 @@ echo all: >> $config_host_mak
>   if test "$debug_tcg" = "yes" ; then
>     echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
>   fi
> -if test "$mingw32" = "yes" ; then
> +if test "$targetos" = "windows"; then
>     echo "CONFIG_WIN32=y" >> $config_host_mak
>     echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
>     echo "QEMU_GA_DISTRO=${QEMU_GA_DISTRO-Linux}" >> $config_host_mak
> @@ -1727,24 +1696,26 @@ else
>     echo "CONFIG_POSIX=y" >> $config_host_mak
>   fi
>   
> -if test "$linux" = "yes" ; then
> +if test "$targetos" = "linux" ; then
>     echo "CONFIG_LINUX=y" >> $config_host_mak
>   fi
>   
> -if test "$darwin" = "yes" ; then
> +if test "$targetos" = "darwin" ; then
>     echo "CONFIG_DARWIN=y" >> $config_host_mak
>   fi
>   
> -if test "$solaris" = "yes" ; then
> +if test "$targetos" = "sunos" ; then
>     echo "CONFIG_SOLARIS=y" >> $config_host_mak
>   fi
>   echo "SRC_PATH=$source_path" >> $config_host_mak
>   echo "TARGET_DIRS=$target_list" >> $config_host_mak
>   
>   # XXX: suppress that
> -if [ "$bsd" = "yes" ] ; then
> -  echo "CONFIG_BSD=y" >> $config_host_mak
> -fi
> +case $targetos in
> +  gnu/kfreebsd | freebsd | dragonfly | netbsd | openbsd | darwin)
> +    echo "CONFIG_BSD=y" >> $config_host_mak
> +    ;;
> +esac

It might look nicer to put the linux and solaris parts from above as 
separate entries in the new case-esac statement.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


