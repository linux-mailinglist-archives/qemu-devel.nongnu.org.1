Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D07BD492
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkw5-0005b7-HJ; Mon, 09 Oct 2023 03:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpkw3-0005ad-CA
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpkw1-0007mM-Lp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696837452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qd+nGieuTTmF5lmD6sldutAp20u8I2pBoODFswtZSx0=;
 b=PukFpgIVsH1uMvsrEflTPaqKYg6+K40EfqOn7BzQtrasrODjzRu2F8Kucb+b58XnNXMCFw
 m6Hh7xCy+itmkY5606W+RMkqJXmJ8iNaLhWzYjoRp8EPoEGprNvINgsIulEzDoKv+E9+pi
 k96jsKPOOPRiow6nlj7Lzkj6dX1GQMI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-VxdRzs89O_CFT8zBrrl3xQ-1; Mon, 09 Oct 2023 03:44:11 -0400
X-MC-Unique: VxdRzs89O_CFT8zBrrl3xQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41b19dc9ee4so11422401cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696837451; x=1697442251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qd+nGieuTTmF5lmD6sldutAp20u8I2pBoODFswtZSx0=;
 b=qfJt6Eib/Ozi2upBvUfoJmuZJAzlZafmzrbF30+WWKhLo1k95xeu1kIFIoOOduWxKK
 5YuOaRAIfXXyyKIEu483zx7p6LtFLcy0DzGDZPlUSHUkZDN2RnEvcH7isZ25XUb3VGIO
 RPIz34AH3WcjHdXr2es70KiURy8Sqo13HGnfjxqiLKd7vwvtYE7mgyQSPJjZFt1FXV/8
 MHUC+Kg4402YMcWEQV/QLncj2LslzsBjoe4XRFZvXfKL2D2egeNAL1pD12f1Ux3sPmgS
 nWnxzhauikGZo93e4Fq+OguJVw4CDv46p8/1jofwonZ1w6fJYK93m3IGAwQvCOPENegY
 uTZg==
X-Gm-Message-State: AOJu0Yw0ihEcEq8JnssQA5USdKHoST8JY/iEpeHEObqH+m4X01WyoEKr
 6zLQnS2vtPQ0oZDxzENcPsII2nREbom8kcFzze4UXh+zrRxfRMFo/uuk/3SAiBf+egdw+WWLw0D
 9/tx0AM4nDLkryoU=
X-Received: by 2002:a05:622a:1787:b0:410:9626:f0bf with SMTP id
 s7-20020a05622a178700b004109626f0bfmr16185670qtk.13.1696837451039; 
 Mon, 09 Oct 2023 00:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHrU+HMuRzqYJChh1ceuO25FvOX74+nUAcm6JXqZG8bDkVctKMjewSHpplm63BJSZS9gQBfw==
X-Received: by 2002:a05:622a:1787:b0:410:9626:f0bf with SMTP id
 s7-20020a05622a178700b004109626f0bfmr16185660qtk.13.1696837450693; 
 Mon, 09 Oct 2023 00:44:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 l25-20020ac84cd9000000b004181c32dcc3sm3491272qtv.16.2023.10.09.00.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 00:44:10 -0700 (PDT)
Message-ID: <c28a1d44-8e7e-a351-8efa-28566e9fc306@redhat.com>
Date: Mon, 9 Oct 2023 09:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] meson: mitigate against use of uninitialize stack for
 exploits
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231005173812.966264-1-berrange@redhat.com>
 <20231005173812.966264-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231005173812.966264-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 05/10/2023 19.38, Daniel P. Berrangé wrote:
> When variables are used without being initialized, there is potential
> to take advantage of data that was pre-existing on the stack from an
> earlier call, to drive an exploit.
> 
> It is good practice to always initialize variables, and the compiler
> can warn about flaws when -Wuninitialized is present. This warning,
> however, is by no means foolproof with its output varying depending
> on compiler version and which optimizations are enabled.
> 
> The -ftrivial-auto-var-init option can be used to tell the compiler
> to always initialize all variables. This increases the security and
> predictability of the program, closing off certain attack vectors,
> reducing the risk of unsafe memory disclosure.
> 
> While the option takes several possible values, using 'zero' is
> considered to be the  option that is likely to lead to semantically
> correct or safe behaviour[1]. eg sizes/indexes are not likely to
> lead to out-of-bounds accesses when initialized to zero. Pointers
> are less likely to point something useful if initialized to zero.
> 
> Even with -ftrivial-auto-var-init=zero set, GCC will still issue
> warnings with -Wuninitialized if it discovers a problem, so we are
> not loosing diagnostics for developers, just hardening runtime
> behaviour and making QEMU behave more predictably in case of hitting
> bad codepaths.
> 
> [1] https://lists.llvm.org/pipermail/cfe-dev/2020-April/065221.html
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 2003ca1ba4..19faea8d30 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -442,6 +442,11 @@ hardening_flags = [
>       # upon its return. This makes it harder to assemble
>       # ROP gadgets into something usable
>       '-fzero-call-used-regs=used-gpr',
> +
> +    # Initialize all stack variables to zero. This makes
> +    # it harder to take advantage of uninitialized stack
> +    # data to drive exploits
> +    '-ftrivial-var-auto-init=zero',
>   ]

I was a little bit torn about using =zero when I first read your patch, but 
after looking at [1], I tend now also tend to agree that =zero is likely the 
best choice. So from my side:

Reviewed-by: Thomas Huth <thuth@redhat.com>


