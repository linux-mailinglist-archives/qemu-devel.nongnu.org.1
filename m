Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2F72558A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nWk-0005Jt-DI; Wed, 07 Jun 2023 03:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6nWi-0005JO-3F
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6nWc-0007AU-IM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686122649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcgjJVsyGlNrjst9h+5Fzb1rLEr8bjfmPrEYNiDCbDo=;
 b=EoOobI6xkQjKNfmy/lWdefB9wCUHFHMe+VNZMfowhXCXVcgGuvdP5c7HFtSCtLOeT27ltm
 ktmgPjU7yUNJGJtHklQsTS6XX5yvClkZOg/XMfvcpcnUTF+xogyge1/8Y196N/wGAhUkk3
 07fF5+7rCvckNETj7+aInV+tfCZ88Zc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-mq9LcRe7PTCsKg3pFyWbJQ-1; Wed, 07 Jun 2023 03:24:07 -0400
X-MC-Unique: mq9LcRe7PTCsKg3pFyWbJQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f7ecfccf2eso4454095e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686122646; x=1688714646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vcgjJVsyGlNrjst9h+5Fzb1rLEr8bjfmPrEYNiDCbDo=;
 b=k/EA8vWjdEvIgcxJQo1GYKlQTjgzX/SuiNdXPSKZ+mKgnBH7jT3q/Nr4bd+i3R3I3q
 bVuYmFeYK4xgrXXoJRWc1N/0NAErTQyrBScfZYPSpjsbKCP8aHL2eSNF+WDDrctoPKwb
 8kFxdPb6DxYnQ+47hNSav4xGRFTlZpCnFtHm36nZ+KC8wz/823ovEPwZXL/AZU3J46Wn
 IkGEUhVojVL+oz6fMIBv03AIzIQBiBtvGE/U7llm9bPgo1z0ogWJJBTlY6eKhxmpKB48
 CIAKuBmND7dfA/fjJEKTDs3LUZYstQvgkmuCoBmxNiDDa7m/BlZ7NbVX1AJfi8iakwfa
 l4Cw==
X-Gm-Message-State: AC+VfDwazR+NIOj98pr4eC0Ttcm6DrgyBpCCU2gwNRX4BJVN4OgPdv3j
 dh1M+wFI7P2fjpG6UZaG4bp+nYqkfaDpIK/0aSDwSU71DYVF/czZlpCakVA/tQ3DrL7rR3y3g8g
 vDcgnj1OAA+BAuLw=
X-Received: by 2002:a05:600c:2947:b0:3f7:371a:ec8d with SMTP id
 n7-20020a05600c294700b003f7371aec8dmr3697634wmd.26.1686122646087; 
 Wed, 07 Jun 2023 00:24:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GD/7kOV6FPM0APsjhnR1949tOsm/bg7LsALqY2v3SpiQYE9q2UfwoQR6493DWB3l12T7UAQ==
X-Received: by 2002:a05:600c:2947:b0:3f7:371a:ec8d with SMTP id
 n7-20020a05600c294700b003f7371aec8dmr3697621wmd.26.1686122645777; 
 Wed, 07 Jun 2023 00:24:05 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003f7e62d38d4sm1113146wmc.25.2023.06.07.00.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:24:05 -0700 (PDT)
Message-ID: <9d2bb62f-d7c4-b3b7-7c12-f572467c7911@redhat.com>
Date: Wed, 7 Jun 2023 09:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] gitlab: Add cross-arm64-kvm-only
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20230606224609.208550-1-richard.henderson@linaro.org>
 <20230606224609.208550-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230606224609.208550-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 07/06/2023 00.46, Richard Henderson wrote:
> We are not currently running a --disable-tcg test for arm64,
> like we are for mips, ppc and s390x.  We have a job for the
> native aarch64 runner, but it is not run by default and it
> is not helpful for normal developer testing without access
> to qemu's private runner.
> 
> Use --without-default-features to eliminate most tests.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 61b8ac86ee..1e0e6c7f2c 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -29,6 +29,14 @@ cross-arm64-user:
>     variables:
>       IMAGE: debian-arm64-cross
>   
> +cross-arm64-kvm-only:
> +  extends: .cross_accel_build_job
> +  needs:
> +    job: arm64-debian-cross-container
> +  variables:
> +    IMAGE: debian-arm64-cross
> +    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
> +
>   cross-i386-user:
>     extends:
>       - .cross_user_build_job

Reviewed-by: Thomas Huth <thuth@redhat.com>


