Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DFF7BF7C9
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:47:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9KE-0002ZC-NB; Tue, 10 Oct 2023 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9K3-0002XS-Em
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9Jz-0002qZ-Pc
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696931195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo4EO3b24+7/c1hPw2Stl1TkXZNmaThVkGRtUR1z80I=;
 b=GXxsePQQb8/AZAHbbwicVLOiZoAaz0SavmiOafKZUo+LtGv2G2ZT1qsUQoy40XnkQ/nNil
 pUz5F5w6wiZLXVlWoKw2PDbRNakNeJfVgsF5nZPWTPjON9dq3QG5UKfKyBASbCFjCC1TIj
 L0ktGgAJSBaEtBdsS4t5UYhWDwIA73o=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-etza6JyXM6ygEfZipcnspQ-1; Tue, 10 Oct 2023 05:46:28 -0400
X-MC-Unique: etza6JyXM6ygEfZipcnspQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d8b2eec15d3so7305564276.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696931188; x=1697535988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wo4EO3b24+7/c1hPw2Stl1TkXZNmaThVkGRtUR1z80I=;
 b=Z4luAGOkVu5iuv8/b3GqdkqDUQ9tVpxBKhwrX45+ePeH+yrKQH7hVS+/qTHFqveFq3
 z+Qqr7SRRuUxHrpqyE8yy9J1ygvE2P0xRqFds2meVEBFp8vBHlRESElZZo/X4N1tEJIc
 ya6LX2yxqbfMd8PjSFdCE/85y+wScuy91YweASXBdLaaAbnDp7ml6+JubLATYHVHVawt
 vAcK2xbNqQCXJ13NmclcOrBJoIf0GQeHdvmeDbCoOatheIn9/O+pz2Mq0cHNhWMaYnVH
 dgyMmEKo4CSRA3Fmbw6QOKgIKzdwlg0VfS8x8uwJVVPawuPUwS54RKJXSJBvRUKePZp8
 r0gw==
X-Gm-Message-State: AOJu0YyaKm2MkgeCsWyj+rWlGZxyOpoilb7E4K0T3dJIVoItGEg/X/uY
 zyNj9tbl4a1uDOXYcwMw2QMyUlxqTpqoxxIP/ExhwgSuCaG3dswrqPtpGSDKwcinZkdF3wKh2Ms
 cXZoTmwYnxsSr7R4=
X-Received: by 2002:a25:5541:0:b0:d91:12e7:30f1 with SMTP id
 j62-20020a255541000000b00d9112e730f1mr14757801ybb.53.1696931188162; 
 Tue, 10 Oct 2023 02:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/fgYRdkEnh+3npY9ofAXdUp9swJ19bV4gWRXWRYxcmXkF0Hd+ljClFkEWlnyBXWZQmeU/bA==
X-Received: by 2002:a25:5541:0:b0:d91:12e7:30f1 with SMTP id
 j62-20020a255541000000b00d9112e730f1mr14757789ybb.53.1696931187892; 
 Tue, 10 Oct 2023 02:46:27 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 er19-20020a056214191300b0066cf31eef11sm390345qvb.132.2023.10.10.02.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:46:27 -0700 (PDT)
Message-ID: <e108d282-5eec-4430-1a10-8cf3170bb18c@redhat.com>
Date: Tue, 10 Oct 2023 11:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] tests/libqtest: Introduce qtest_get_arch_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231010074952.79165-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/2023 09.49, Philippe Mathieu-Daudé wrote:
> Add a method to return the architecture bits (currently 8/32/64).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.h |  8 ++++++++
>   tests/qtest/libqtest.c | 21 +++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index e53e350e3a..1e1b42241d 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -654,6 +654,14 @@ bool qtest_big_endian(QTestState *s);
>    */
>   const char *qtest_get_arch(void);
>   
> +/**
> + * qtest_get_arch_bits:
> + *
> + * Returns: The architecture bits (a.k.a. word size) for the QEMU executable
> + * under test.
> + */
> +unsigned qtest_get_arch_bits(void);
> +
>   /**
>    * qtest_has_accel:
>    * @accel_name: Accelerator name to check for.
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index b1eba71ffe..a643a6309c 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -925,6 +925,27 @@ const char *qtest_get_arch(void)
>       return end + 1;
>   }
>   
> +unsigned qtest_get_arch_bits(void)
> +{
> +    static const char *const arch64[] = {
> +        "aarch64", "hppa", "x86_64", "loongarch64", "mips64",
> +        "mips64el", "ppc64", "riscv64", "s390x", "sparc64",
> +    };
> +    const char *arch = qtest_get_arch();
> +
> +    if (!strcmp(arch, "avr")) {

Just a matter of taste, but I prefer g_str_equal(), that's easier to read.

> +        return 8;
> +    }
> +
> +    for (unsigned i = 0; i < ARRAY_SIZE(arch64); i++) {
> +        if (!strcmp(arch, arch64[i])) {
> +            return 64;
> +        }
> +    }
> +
> +    return 32;
> +}

Since this function might get called multiple times, would it make sense to 
cache the value? I.e.:

   static const unsigned bits;

   if (!bits) {
       ... do all the magic to find out the right bits ...
   }

   return bits;

?

  Thomas


