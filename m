Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A777A921B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjECK-00040T-QR; Thu, 21 Sep 2023 03:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEC9-000408-6e
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:33:54 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEC7-0005qS-IM
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:33:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c5dd017b30so76725ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695281630; x=1695886430;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=po8tqcPrY8BsJxbEF/9ZVNAkMiP5QDpgNrVdXFPTpnA=;
 b=AKEoAkaL//TLqx4ZF5Rn4HtvItlBu2pqN4Q5taF2gw8xZH9GMxSAMy/xkxpsC8FtTJ
 L6a/k23uzG69oKVmM80747UbJLAcX9rpsUnnnrst8v3ha/GTu867vxNvkB6Xyl786edI
 jsF+lv6hY6AxGx48T5RRqQKyR5LlzSyfnd32vFlAvV5gZrABwY6AkafKlQM4iBKC1gSe
 jSCNzT1Fh9u30bKehjx8J9zbaAjYbfU6dDPmr3g6V81E5enVWyU2dcYHb4TR2e1PXCt4
 W3vaQbaCVCQ2PJwz3JQOP1MrrC8r0BarmTgTRta+dueJ/afocGbsgd1gdhXNfjPbJ6pB
 CpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695281630; x=1695886430;
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=po8tqcPrY8BsJxbEF/9ZVNAkMiP5QDpgNrVdXFPTpnA=;
 b=tEHOfeix8NG2jtELobngiSNiwRGugffSuF50vjK9wA3obQEpU/IX2PWF1iQD+OfARJ
 Xm8d8vBJUdJ9Od8GNiRFWvpNFAmr12ExzEIcf2xl7XgEtFu/2Zum067JKiyQ4FAv2Lup
 H2j4c5g3p4WIzeNx6FAcP9SohyWobwwq+cAFOhlaYmD31U50JH6zXY7Quiohp3QWnN1D
 EpPavVf1WSIxVydyyKnvSkInzqt0uKbSZriQ8YI0dqPXBsUXhOLUWCPPeO68uf3tcksy
 /6JG3B94G7SCNMdtnZ39IyTCpowuUbdYZimG5xrDOW0XYdyMtWu1Fj6QddAqwaZIA8FS
 iRUQ==
X-Gm-Message-State: AOJu0YzuEE1OZhLaD+ZyjckhP1CZImtewAMMMFaHI1PqEqUxUZ+xboiI
 BchwouM4jmTJpGPwVrfVsfZ0I1hnusTz2vpEkj8=
X-Google-Smtp-Source: AGHT+IG1AXfwKdE6XactmTd9NDzvouy4iPS+wqI/cxonFtgYhQNhRl3KVTg7cHxJ5DJE3D+H9/koZw==
X-Received: by 2002:a17:902:c3d1:b0:1b5:674d:2aa5 with SMTP id
 j17-20020a170902c3d100b001b5674d2aa5mr5474958plj.13.1695281629856; 
 Thu, 21 Sep 2023 00:33:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a17090301cf00b001b9d95945afsm719184plh.155.2023.09.21.00.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:33:49 -0700 (PDT)
Message-ID: <e57c927a-9cab-4cb4-9127-702a74cb8bd9@daynix.com>
Date: Thu, 21 Sep 2023 16:33:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/reset.rst: Correct function names
Content-Language: en-US
Cc: qemu-devel@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20221125140645.56490-1-akihiko.odaki@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20221125140645.56490-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2022/11/25 23:06, Akihiko Odaki wrote:
> resettable_class_set_parent_phases() was mistakenly called
> resettable_class_set_parent_reset_phases() in some places.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   docs/devel/reset.rst | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> index 7cc6a6b314..38ed1790f7 100644
> --- a/docs/devel/reset.rst
> +++ b/docs/devel/reset.rst
> @@ -184,21 +184,20 @@ in reset.
>       {
>           MyDevClass *myclass = MYDEV_CLASS(class);
>           ResettableClass *rc = RESETTABLE_CLASS(class);
> -        resettable_class_set_parent_reset_phases(rc,
> -                                                 mydev_reset_enter,
> -                                                 mydev_reset_hold,
> -                                                 mydev_reset_exit,
> -                                                 &myclass->parent_phases);
> +        resettable_class_set_parent_phases(rc,
> +                                           mydev_reset_enter,
> +                                           mydev_reset_hold,
> +                                           mydev_reset_exit,
> +                                           &myclass->parent_phases);
>       }
>   
>   In the above example, we override all three phases. It is possible to override
>   only some of them by passing NULL instead of a function pointer to
> -``resettable_class_set_parent_reset_phases()``. For example, the following will
> +``resettable_class_set_parent_phases()``. For example, the following will
>   only override the *enter* phase and leave *hold* and *exit* untouched::
>   
> -    resettable_class_set_parent_reset_phases(rc, mydev_reset_enter,
> -                                             NULL, NULL,
> -                                             &myclass->parent_phases);
> +    resettable_class_set_parent_phases(rc, mydev_reset_enter, NULL, NULL,
> +                                       &myclass->parent_phases);
>   
>   This is equivalent to providing a trivial implementation of the hold and exit
>   phases which does nothing but call the parent class's implementation of the

Hi,

This patch seems to have been forgotten. Can anyone pull this?

Regards,
Akihiko Odaki

