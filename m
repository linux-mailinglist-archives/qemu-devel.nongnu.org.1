Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE4D8BDB0F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 May 2024 08:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Dw9-0002U4-V8; Tue, 07 May 2024 02:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4Dvq-0002QU-0y
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4Dvn-0001ja-Ak
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715061842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8OmJ/ELJ9lWegoGcumLoZ2FlbDoklvWgLkFvaZpqbAE=;
 b=bVjhVDWjUo6z7MU06zBuaZ3S3RT2mjK4tArIqIwSsKZz4Kuetsw6zfzbkAffrJ+ko+rtXv
 +z1Ia1k6KEsZWtrPRTWUY8MEr+OozqUAnY3FJSoAQx/adol0qNmOY7Qt4l2YFW3HR0xDVE
 73h0dRWqQmabJv7LY+uFXpfUIdWpDlo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NPQpHUZHOl6WHmu_mYcoaw-1; Tue, 07 May 2024 02:04:00 -0400
X-MC-Unique: NPQpHUZHOl6WHmu_mYcoaw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572ef242caaso626359a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 23:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715061839; x=1715666639;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OmJ/ELJ9lWegoGcumLoZ2FlbDoklvWgLkFvaZpqbAE=;
 b=FqJtHZDPRMZxQirXMhOcO8puPUK2sdOhTkOI1RgvPqWNJ6CREOSKFQmSnXuHAV3iQ8
 dXYvn1RGS3gn2U96JIHqLbaJ0ss40eKN0+bFy4gbcLP6xaUVmPbe7HCi31ncHH3tmTfd
 1E7E0pYY6TTfGJn+hWnLiZ/lVP7jqNsIEUBuMc8Ed5B6XDxKKvASAYA6HHIDnZWiJgPS
 /Viu3CCU/5nLM52Avf1hL5XwJXaPPdpEFeV+BQb+gJ8mOP+eEinPMd3COMIwU6L/AIce
 o/9NjVSmmf1tvhZfiLbgjuRe8YPGckCdzTT44Es8FTBwbpDrRsztlsNaU9wGGXvh6dLo
 QWsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNksWfwacjD0dSfq3g/+YzCyFrN89ikxkZ3V8RNEVBCyumyii9I7UHoBYApSzOl56FWeICeEKHG6Hli+dEBFopFjH6WMg=
X-Gm-Message-State: AOJu0YzRxp0HXQuP+dJHCkI/IEn9nc6cP6sLPITOT9etyQ/SWpbzjVCj
 nJtJo3ZixZnRuSBeZx4lJ6QvBg9gO7qgVqiUbcJoGWgYFpDpUXrdNojI+oSMt/O0XGw0T+izSh5
 0FmnfsMLWUG4egjXAlUeGaLFKcN1GVTWA4A73cjl4kioQg03HeWbS
X-Received: by 2002:a50:9faa:0:b0:572:326b:c055 with SMTP id
 c39-20020a509faa000000b00572326bc055mr8897354edf.13.1715061839231; 
 Mon, 06 May 2024 23:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAsyYPQoEPcT4+nFYc+kRgld6RFvjZJ8hlkF041D6sGscs+VWkmJzOyR0IfrINO8luVEMb1A==
X-Received: by 2002:a50:9faa:0:b0:572:326b:c055 with SMTP id
 c39-20020a509faa000000b00572326bc055mr8897341edf.13.1715061838883; 
 Mon, 06 May 2024 23:03:58 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 p8-20020aa7c888000000b00572aba0d8a0sm5948718eds.88.2024.05.06.23.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 23:03:58 -0700 (PDT)
Message-ID: <2e99999c-d63d-4f9c-a407-8eee496a9d41@redhat.com>
Date: Tue, 7 May 2024 08:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: Drop --static from s390x linux-user build
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240506202020.422514-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240506202020.422514-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On 06/05/2024 22.20, Richard Henderson wrote:
> The host does not have the correct libraries installed for static pie,
> which causes host/guest address space interference for some tests.
> There's no real gain from linking statically, so drop it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Per my suggestion in
> 
> https://lore.kernel.org/qemu-devel/50c27a9f-fd75-4f8e-9a2d-488d8df4f9b9@linaro.org
> 
> 
> r~
> ---
>   .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
> index 105981879f..3a2b1e1d24 100644
> --- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
> +++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
> @@ -2,7 +2,7 @@
>   # setup by the scripts/ci/setup/build-environment.yml task
>   # "Install basic packages to build QEMU on Ubuntu 22.04"
>   
> -ubuntu-22.04-s390x-all-linux-static:
> +ubuntu-22.04-s390x-all-linux:
>    extends: .custom_runner_template
>    needs: []
>    stage: build
> @@ -15,7 +15,7 @@ ubuntu-22.04-s390x-all-linux-static:
>    script:
>    - mkdir build
>    - cd build
> - - ../configure --enable-debug --static --disable-system
> + - ../configure --enable-debug-tcg --disable-system --disable-tools --disable-docs

Maybe mention the --disable-tools and --disable-docs in the commit message, too?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>



