Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A376BCBB
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:44:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuM0-0005qy-N5; Tue, 01 Aug 2023 14:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuLp-0005qd-TR
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuLo-0002cU-DF
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690915447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOdneJmHsULUmspTynIx+7hxRtFTH2Gw6lxoheyzru0=;
 b=cIf7ygHIR210wvNn6lIe3Q/kcanOGr1ECJrjGDaDhwGKzB+/dOHYYrhQmoHqQvYnvsaf4E
 5yteYsjsbwkd6vxb7l3Vg7cU4+MBfwVcJJug3DyJedYHmTq8D0aAFiyYAseATJVkzo6vDR
 G3+My1WrOgE1dCxFKosBSFidlQLyEdA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-UR0EfpgSPmaV9eTrJihWYQ-1; Tue, 01 Aug 2023 14:44:06 -0400
X-MC-Unique: UR0EfpgSPmaV9eTrJihWYQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7683cdabcb7so702978485a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915446; x=1691520246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOdneJmHsULUmspTynIx+7hxRtFTH2Gw6lxoheyzru0=;
 b=Z6mWyEmo8VmsSe5X4W5kGYk7H6AIsflvCDXdw6dSyhyE4UKcqJseTlaIC6HSVC2chp
 DfbTr80nPGo7DCFqRCkkDXdDqKyYk14gZzNydi1vPsCYU3HxRR7IGJO1Ym01xVncUh0g
 KAn+GMG8qPHlt+uw0qYCl5DmzdZrOqDLlDS2TEKgPw+/xT2t4aDVcMa87qJnFKge4A9O
 ANwWwbOPoFQ5PHEgWOuE8m/Ao9qgdoQUWPQka7nUK5xZv2qkXlEUBlCeDEf7XexukYl2
 Mi+JvXnrN05UzgFJu1UPNfXOqUW/u4cUTR5bTTee9EgPIU77z4fBIvj3bhCcRT1G25fR
 77TQ==
X-Gm-Message-State: ABy/qLbujOJ41yw10dssc9zgSQX4gqzqQ2wa9plWEisemAC3tmljfZq4
 qGnrT3i3HczYuYsGnYkze+OhKH5INrJW0siNplz96Lt7JR1sZHH8rX6JQsacQyDK6c0YRaLNIBq
 791vLelS9HNanqA4=
X-Received: by 2002:a05:620a:94d:b0:76c:9ada:5b0d with SMTP id
 w13-20020a05620a094d00b0076c9ada5b0dmr9804918qkw.72.1690915445947; 
 Tue, 01 Aug 2023 11:44:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXk+W5Z1UzasxZkn3Ln+6kVjvYtsiOeACkaUbZ95xdDjIPkXpTuJuiwN1UsYAVOPYYk0ZH1w==
X-Received: by 2002:a05:620a:94d:b0:76c:9ada:5b0d with SMTP id
 w13-20020a05620a094d00b0076c9ada5b0dmr9804909qkw.72.1690915445647; 
 Tue, 01 Aug 2023 11:44:05 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 k8-20020a05620a142800b0076c97ae43b9sm3034572qkj.66.2023.08.01.11.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:44:05 -0700 (PDT)
Message-ID: <952019de-c467-e924-5660-eb4b75847a06@redhat.com>
Date: Tue, 1 Aug 2023 20:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/8] gitlab: disable optimization and debug symbols in
 msys build
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-8-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01/08/2023 15.04, Daniel P. Berrangé wrote:
> Building at -O2, adds 33% to the build time, over -O2. IOW a build that
> takes 45 minutes at -O0, takes 60 minutes at -O2. Turning off debug
> symbols drops it further, down to 38 minutes.
> 
> IOW, a "-O2 -g" build is 58% slower than a "-O0" build on msys in the
> gitlab CI windows shared runners.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 34109a80f2..552e3b751d 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -113,7 +113,7 @@ msys2-64bit:
>       # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
>       # changed to compile QEMU with the --without-default-devices switch
>       # for the msys2 64-bit job, due to the build could not complete within
> -    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices
> +    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
>       # qTests don't run successfully with "--without-default-devices",
>       # so let's exclude the qtests from CI for now.
>       TEST_ARGS: --no-suite qtest
> @@ -123,5 +123,5 @@ msys2-32bit:
>     variables:
>       MINGW_TARGET: mingw-w64-i686
>       MSYSTEM: MINGW32
> -    CONFIGURE_ARGS:  --target-list=ppc64-softmmu
> +    CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
>       TEST_ARGS: --no-suite qtest

This is IMHO a very good idea! But I think for now it's enough if you only 
change the 64-bit, isn't it?

  Thomas


