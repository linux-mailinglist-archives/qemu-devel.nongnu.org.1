Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A999A7C493D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 07:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqRsa-0004wQ-Th; Wed, 11 Oct 2023 01:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqRsY-0004vP-Gz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:35:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqRsW-0002J3-GG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:35:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so63230605e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697002526; x=1697607326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TKT28EE/VrCRj5sSmto3UmM99h5KvFjUmC1S+xVBJOU=;
 b=le7po+a2B2tEVJcdcpdok7rv9Hkpojpf6CJRKaykyGZmvs/It1r9v0jhvnnJk5qzPy
 Icn2r5vbzZBmuqVfpVuIn1qRbr9a7sDI+VKv1Xf1IhOq5KOOyQj742mo0E7GSzx3QM/2
 Ou8+/EWZvna0uJrsP6bGnxHxFAcvpLzF/rz3Vik+bpUUx4GepZj8VBwhQSDLkR18MoUs
 SumLSEKKcKlcaepExb+1Z8tmxP/V+DTF1hcN2qmPRWKVBQySqAryMr3xxN7vCpTe3/Du
 7/bKnmAxV5wTWMIaDa6MTpz6atok1urHgL6FT3O/hzmR7H/8z/LYsNhIFK2fIxqOBxiR
 YQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697002526; x=1697607326;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TKT28EE/VrCRj5sSmto3UmM99h5KvFjUmC1S+xVBJOU=;
 b=SD5yXnsy8qT1/NUzkCG1Xv4odmGuXmMonYBnvpwT5nn3led3of3edMJgN6MnS7jR6U
 6cpSXYHM/Zpq45fyebu7i8D9UiuNFAlSc0dhtLyoamoFqqxhPVg7gR6V17Awtltt/R41
 Dlebd9746jOUlQXj+zh17K/xKZ3fJufCizu9bSr6U7sUF5jLudm+PPUjr2WQhBrgfoIL
 E7ldfogZzy+m2We+dHXyfuPro8E2f6ry+HM3lVEtU7k5b6PPj3oLPk4Gt5ARVgK3ibe+
 j1koIvBWqPAkipcmDfiwLcPIen2uZCyopAwDjEwqOySO+W1rP5vEQ1/q0Ok9WgovSeSK
 0s1A==
X-Gm-Message-State: AOJu0YyhV29T3Egi4h6q9jjpCElP5p2Rog/CWob21MN40/bjhalTMXv4
 ScbSUQUta8ts71/kbovQUHcmTw==
X-Google-Smtp-Source: AGHT+IHKiZM9UsugsKReL+D2lD5Vv9a+Q5nFpivel0IHVd5mdYITOA0Ni2bGEPJ85YquGu5xmDEnZA==
X-Received: by 2002:a7b:c45a:0:b0:403:e21:1355 with SMTP id
 l26-20020a7bc45a000000b004030e211355mr16706389wmi.36.1697002526420; 
 Tue, 10 Oct 2023 22:35:26 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d6345000000b0032326908972sm14200156wrw.17.2023.10.10.22.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 22:35:25 -0700 (PDT)
Message-ID: <14ff27a8-284b-66f8-097a-5d49c94dcff8@linaro.org>
Date: Wed, 11 Oct 2023 07:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL 50/51] subprojects: add wrap file for libblkio
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-51-pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Tyler Fanelli <tfanelli@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907130004.500601-51-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Paolo,

On 7/9/23 14:59, Paolo Bonzini wrote:
> This allows building libblkio at the same time as QEMU, if QEMU is
> configured with --enable-blkio --enable-download.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   subprojects/libblkio.wrap | 6 ++++++
>   1 file changed, 6 insertions(+)
>   create mode 100644 subprojects/libblkio.wrap
> 
> diff --git a/subprojects/libblkio.wrap b/subprojects/libblkio.wrap
> new file mode 100644
> index 00000000000..f77af72210c
> --- /dev/null
> +++ b/subprojects/libblkio.wrap
> @@ -0,0 +1,6 @@
> +[wrap-git]
> +url = https://gitlab.com/libblkio/libblkio

Tyler noticed this project isn't mirrored on QEMU gitlab namespace.

> +revision = f84cc963a444e4cb34813b2dcfc5bf8526947dc0
> +
> +[provide]
> +blkio = libblkio_dep


