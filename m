Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E2B76BCC7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuMf-0006OR-4o; Tue, 01 Aug 2023 14:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuMP-0006It-Bp
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuMN-0004rV-N7
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690915483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwyIshTTu7fbc7pQgv8XqQ0FdMjqxpoYtdBJ8S6BlXY=;
 b=RaJaKcVxYDjb+6XeBSJrjWa1mpqOedbsJt8xMmt3jUpp/+Y4D3IG16N48hy79FKQzwRAm3
 9g98e/v8b7q8Xn6rKmqfccOwBq1gQgXDf5Wr6B0c8oFx3gooSDn+g6Qqw/u6iW1jIAy4NK
 dt+dTPJ1YvZEQfxL1/epNekEYRXafCM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-Z2VuYHujP9KZBObE-SE52g-1; Tue, 01 Aug 2023 14:44:41 -0400
X-MC-Unique: Z2VuYHujP9KZBObE-SE52g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-403ad49c647so61315771cf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915481; x=1691520281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwyIshTTu7fbc7pQgv8XqQ0FdMjqxpoYtdBJ8S6BlXY=;
 b=O5rLNP8F29MQoyDhamhJ/+D3D+wcAjPYuDtNjwXjg0p/77C5XQ7dZ3d2WmfwlRRRtF
 doKt8IECtm6ZCZ4g/iktxHDXh12hPpHvJWy0vxVkF/KfCuwULGcDUuSKTWOdYReZKl5b
 fdZtDyUp/OFDsfzjGVkWlRUkcvXg52INBBwo1Us/gP2e45OWItOY1+1ZOGLeoJ3M+xFM
 I8ity8N8+HOiMsGjHnUSyMfNhVzVetmicBwnvAM2ZiHM0tvyWBWryQt4qFr8mGFB+MKg
 l8FTFnTnS/BCsFSSDmuJ6NQDFOjtkc/08JVXmood+LiYELaqOfTF7svl4RJ7gSB4J0Fz
 ZReQ==
X-Gm-Message-State: ABy/qLYKa6NeWfjtqvsIn4ylX7Jv7tEGIXFHWqWUj4bZ7vNsKRpHMUIH
 2ZpyY/8rLRjPa8N6jZEAEXQTc9EiXP73uAA+Y39xbvQerk1ZgCCM2JAmQxArWRPQcMRHaOMY379
 hzdbn5eBgmYviNSc=
X-Received: by 2002:a05:622a:11cd:b0:40f:c547:c6a1 with SMTP id
 n13-20020a05622a11cd00b0040fc547c6a1mr6104086qtk.5.1690915481008; 
 Tue, 01 Aug 2023 11:44:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGeiQjZOnYxqoa6NKxFIZHtbn1F1tuRFZl49iGD8h5+XtObhCwc53FkbKzowO87pom79FDXSA==
X-Received: by 2002:a05:622a:11cd:b0:40f:c547:c6a1 with SMTP id
 n13-20020a05622a11cd00b0040fc547c6a1mr6104075qtk.5.1690915480790; 
 Tue, 01 Aug 2023 11:44:40 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 r2-20020ac83b42000000b00403c1a19a2bsm4658589qtf.92.2023.08.01.11.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:44:40 -0700 (PDT)
Message-ID: <4ac62a63-1873-6c04-7f46-32c479b5ea6a@redhat.com>
Date: Tue, 1 Aug 2023 20:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 8/8] gitlab: disable FF_SCRIPT_SECTIONS on msys jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-9-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-9-berrange@redhat.com>
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
> The FF_SCRIPT_SECTIONS=1 variable should ordinarily cause output from
> each line of the job script to be presented in a collapsible section
> with execution time listed.
> 
> While it works on Linux shared runners, when used with Windows runners
> with PowerShell, this option does not create any sections, and actually
> causes echo'ing of commands to be disabled, making it even worse to
> debug the jobs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 552e3b751d..cd7622a761 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -12,6 +12,10 @@
>     needs: []
>     stage: build
>     timeout: 80m
> +  variables:
> +    # This feature doesn't (currently) work with PowerShell, it stops
> +    # the echo'ing of commands being run and doesn't show any timing
> +    FF_SCRIPT_SECTIONS: 0
>     artifacts:
>       name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>       expire_in: 7 days

Acked-by: Thomas Huth <thuth@redhat.com>


