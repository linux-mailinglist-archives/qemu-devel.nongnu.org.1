Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753E7E7163
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:27:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19kA-0002Y6-Um; Thu, 09 Nov 2023 13:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r19jx-0002UA-IR
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r19jv-0006ym-SF
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699554411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKcxe+mJ71dBtyD0j527RCnjrr5Mm2SMBIz1P2uCRp0=;
 b=Q0nwrjISpHbJs5hb2mCWXkz6JHzqgqZ2smIS3sI4wt1RQKe7jOm4Sw3AyLj5ngpmQ5QpH6
 vtwXQTY1gbZIOtiU2AvGBi5mKyzPdb991feMZFTIcgvGM6euJHjwZtTIi/2im9Q1l1Q3Xr
 WiFXPqcZtV0fzOkM32fivJGq1I2tl8Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-geBWzTSsPN-Tp1bAWhYhKA-1; Thu, 09 Nov 2023 13:26:49 -0500
X-MC-Unique: geBWzTSsPN-Tp1bAWhYhKA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so98308366b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699554408; x=1700159208;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKcxe+mJ71dBtyD0j527RCnjrr5Mm2SMBIz1P2uCRp0=;
 b=agBxthAQ3VT/l02ll5mgf4H8s8C/gvIR8OpTMdu8szfl3i67zFcYdlBZHA9Iq+QH7R
 newPdrLnQ1vkg5B8NtOIEf5Uczm+NolXB27l/g6YJ9Pr1peA+mZJW7L445d6Ze2v69mc
 dmctIYnnqfxrYHr12IbqWMfaKdc8h3YfmB9SkVvampc1Z2W07eSTUvMaEx5EeQCarcME
 dfekHIEl+rniT3sgfIEbZEWM3XN9/BQWKrX0C3zAmsY1MNJ+9FSDfted8fFQhF0+K9ef
 MHpj3zYGWA0vWuEZl9Gybq4LbsIv7gsvWg58F6kZVoUulPYoKyxPuDBzy26md0Fmkwr1
 mWiw==
X-Gm-Message-State: AOJu0YxNdhw0mK/Q9yKQZ+7D3PB1psE1DdAF0hiuCGvkeFIVyoRug66A
 8W8uVVafvP1Fr2tkv4XFkeI6gTUgHoO+cPiVCEUMF/qMN+2AIzEFw+rmgCVEnwtwaWf745DEhIc
 Da6I6ot6Jl8nUHd8=
X-Received: by 2002:a17:906:794a:b0:9c3:b609:7211 with SMTP id
 l10-20020a170906794a00b009c3b6097211mr5188007ejo.1.1699554408470; 
 Thu, 09 Nov 2023 10:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHMkTitnoMfywALCoS0hfqpjx97MIWa/1EPaJDUmq++UTVH/HSt3SFJNf6xdr4VXVWLwdLiQ==
X-Received: by 2002:a17:906:794a:b0:9c3:b609:7211 with SMTP id
 l10-20020a170906794a00b009c3b6097211mr5187998ejo.1.1699554408175; 
 Thu, 09 Nov 2023 10:26:48 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 u20-20020a1709060b1400b009cb2fd85371sm2866614ejg.8.2023.11.09.10.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 10:26:47 -0800 (PST)
Message-ID: <6214d5aa-1895-485b-9e41-061f4067e5fb@redhat.com>
Date: Thu, 9 Nov 2023 19:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotests/149: Use more inclusive language in
 this test
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20231109180910.376632-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231109180910.376632-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/9/23 19:09, Thomas Huth wrote:
> Let's use 'allowlist' and 'ignorelist' here instead of
> problematic words.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/149     | 14 +++++++-------
>   tests/qemu-iotests/149.out |  8 ++++----
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 2ae318f16f..42f627688a 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -518,7 +518,7 @@ configs = [
>   
>   ]
>   
> -blacklist = [
> +ignorelist = [

unsupported_configs

>       # We don't have a cast-6 cipher impl for QEMU yet
>       "cast6-256-xts-plain64-sha1",
>       "cast6-128-xts-plain64-sha1",
> @@ -528,17 +528,17 @@ blacklist = [
>       "twofish-192-xts-plain64-sha1",
>   ]
>   
> -whitelist = []
> +allowlist = []
>   if "LUKS_CONFIG" in os.environ:
> -    whitelist = os.environ["LUKS_CONFIG"].split(",")
> +    allowlist = os.environ["LUKS_CONFIG"].split(",")

tested_configs

While at it:

-whitelist = []
+# Optionally test only the configurations in the LUKS_CONFIG
+# environment variable
+tested_configs = None

and below

-if len(whitelist) > 0 and config.name not in whitelist:
+if tested_configs is not None and config.name not in test_configs:

>   
>   for config in configs:
> -    if config.name in blacklist:
> -        iotests.log("Skipping %s in blacklist" % config.name)
> +    if config.name in ignorelist:
> +        iotests.log("Skipping %s in ignorelist" % config.name)

Skipping %s (cipher not supported)

Even better would be to change blacklist to a regular expression and 
make it just [ "^cast6-.*", "^twofish-.*" ], but I am not going to 
require that. :)

>           continue
>   
> -    if len(whitelist) > 0 and config.name not in whitelist:
> -        iotests.log("Skipping %s not in whitelist" % config.name)
> +    if len(allowlist) > 0 and config.name not in allowlist:
> +        iotests.log("Skipping %s not in allowlist" % config.name)

Skipping %s (not in LUKS_CONFIG)

Paolo


