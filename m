Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05669715E79
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3y6A-0006J4-I8; Tue, 30 May 2023 08:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3y5p-0006FN-Pe
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3y5n-0003Lb-6A
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685448286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4zJTxm0TV2pVMuYxE16O4qWg8AzZwFAsm9wNW6oHTk=;
 b=Ev6Hq6QczPe/xzaBmcYP/5DdkcuDnONX710ZFB0EjVFwp/QRDnTe4yUG/MiWhPGfcHYQwN
 Valy0CrKSbx14vobC3xgLAj6jEFyK8WrzgILEirOMp3Sp4sXDsdc6pgr6lv2uL02FajbbO
 ymNf3eBBslM/TJYm9KIhz8M32bum/2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MDwlKgsSPRG35uMFgInsnw-1; Tue, 30 May 2023 08:04:44 -0400
X-MC-Unique: MDwlKgsSPRG35uMFgInsnw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f6ffc45209so11488275e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685448283; x=1688040283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X4zJTxm0TV2pVMuYxE16O4qWg8AzZwFAsm9wNW6oHTk=;
 b=ZAKSk0e8P77tftImJuc2dWPMJN1nT0hFFLPnJ6PMxUoDCS0cfarUbOCbKgIvjTJp8v
 NXLYdXb1N66kE3bEUhQLSU/NBKuX59EIl7kZarZS20rB4h/xnYvoeVpxDmKSSb+ftFzn
 nVpJ7lL1MuwD1sIPOildTWtSpRlRf2KSFwTqQJ/a3y6a+EXNUPfRl3FYv6lKyzTOg1GI
 h63Ur26rOxXuotjTraSaL/CS7puQrhKBdWTr5wBPyXZ2qkAyd9psy/Jv985AWmdOXyJV
 VdKVD5zIFl5O4+0a9Eym13yIt9Zmq8qLYc2geSf1DxMvEHk1So1Wkk7WFKHX/n/DH/yt
 FgMA==
X-Gm-Message-State: AC+VfDxu6NVq3nOUL+IOKuuHdLqYDHAVZN/I+4k0vH2ixrg3qWAOr3QR
 +tJyV0GBnOGqmZZNZBqnOEVXuN4ufbUkoAP07JcDvAPs7BR6g9A/c/ReBUy+oJW4eY+FrWZPl0f
 C0brBO1ybEtroMSAHcBMsXNo=
X-Received: by 2002:a1c:7906:0:b0:3f6:1b7:11f0 with SMTP id
 l6-20020a1c7906000000b003f601b711f0mr1800247wme.7.1685448283155; 
 Tue, 30 May 2023 05:04:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+5Uk77DA9v/poLZDZXd/QfgSb5DCV3Lp5mYKAXm2Mh9N285ifNVX/S/9ho7noRe3uxSkhVw==
X-Received: by 2002:a1c:7906:0:b0:3f6:1b7:11f0 with SMTP id
 l6-20020a1c7906000000b003f601b711f0mr1800235wme.7.1685448282904; 
 Tue, 30 May 2023 05:04:42 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-11.web.vodafone.de.
 [109.43.176.11]) by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b003f6038faa19sm20491412wmj.19.2023.05.30.05.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:04:42 -0700 (PDT)
Message-ID: <1981c8e3-9109-7562-0d64-1fa091a28e3c@redhat.com>
Date: Tue, 30 May 2023 14:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] configure: check for SLOF submodule before building
 pc-bios/s390-ccw
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-5-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230527092851.705884-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/05/2023 11.28, Paolo Bonzini wrote:
> SLOF is required for building the s390-ccw firmware on s390x,
> since it is using the libnet code from SLOF for network booting.
> 
> If SLOF is absent and submodules are not updated, pc-bios/s390-ccw
> cannot be built.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1d1b8736c0eb..c92a3b30b9a4 100755
> --- a/configure
> +++ b/configure
> @@ -1662,7 +1662,8 @@ fi
>   
>   # Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
>   # (which is the lowest architecture level that Clang supports)
> -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu; then
> +if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
> +    ( test "$git_submodules_action" != ignore || test -f roms/SLOF/VERSION ); then
>     write_c_skeleton
>     do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
>     has_z900=$?

Not sure if we really need this. Only the networking part of the s390-ccw 
bios cannot be build without SLOF, but the main binary still builds fine 
also without it.

  Thomas


