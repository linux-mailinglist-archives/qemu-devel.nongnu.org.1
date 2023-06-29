Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340827422C9
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnTO-0006pt-Mk; Thu, 29 Jun 2023 04:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEnTM-0006pG-SM
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:57:52 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEnTL-0005sT-2h
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:57:52 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso672356e87.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688029068; x=1690621068;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vGhjFIbNKxtdmynk5VW8vTayQ4UmVUrGHRgsNWOYbZI=;
 b=wGfe0UH92t0nQbENzl8bjzQBLlx+gC6bpVFvh8QPKyqgl/ujnDiGtDdB+lFgqZVqvX
 IkO/lLNYhqykyE8OkN+W+eE35PV0BRp2VujgvRK9MOapSnS01vdi0/FitTYxCRw7kGeS
 8dzRrlWOHpD76u3qajgDKkbCj97SeGUeaV3qjCxVCFf2K7GbuVHJze2Wuo2FRV+pGkGn
 bUH/BznxL6lBQ94FfzjVI3Iev4jCkl3M6z3o2GHOR3sgvwkzOwPCGKVcgcJxowg+itlM
 8cZQXxZv8iqGcWDBRRHD9/FALY/HtnTHFcrRzlaa/nJRBYAf2LOArtdU2fmx8oYdGUfP
 7pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029068; x=1690621068;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGhjFIbNKxtdmynk5VW8vTayQ4UmVUrGHRgsNWOYbZI=;
 b=OH0rtwIjuw+2l7ZSQongRByPqWM1flMvkRO3efUO2UMiLSt5cUGcmhjQuA4i1r5tHU
 5g7DW+P45CmugbdLlumGPu0f7xqkQcDzPAyM+Xwu0lUdgK5OTR8mDkvDeBLpgCNzzufI
 ZDfzjb5S6ut78nwhs9IHmcJ0fzPTo96oByxlIMD9JNs4S0pXh3LcvHiogD0kukSJpP/9
 VeFZNLARMgLu3OIrMOR74XXAVnFR68ccdQRk9VFsVUIecS4QCEF+sea4sQRfmk2fv104
 yQPQzo4ZiO0YMUy4AF4pr9SsPh+kQryXdRfVPQMvR3xoNlIFEnHwJw3o6fme+Xp9ggct
 w6pg==
X-Gm-Message-State: AC+VfDzYdsCzXBTocll66XrbfhRapNPZFoIHhGVCzSW2IeZy+WONXfC6
 QZLhiRLc0bl63rIGNXRu/WPR1g==
X-Google-Smtp-Source: ACHHUZ6xlk1ETc0XSndZ789A6lV4/4vg7db+CZ1QGPugg0e1QpFcyB70Ne+yTtghtHw2RsjixD0gMA==
X-Received: by 2002:a05:6512:2315:b0:4f9:6a74:d149 with SMTP id
 o21-20020a056512231500b004f96a74d149mr14434520lfu.15.1688029067952; 
 Thu, 29 Jun 2023 01:57:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 u18-20020adfeb52000000b003113943bb66sm15310497wrn.110.2023.06.29.01.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 01:57:47 -0700 (PDT)
Message-ID: <891eb829-9ba6-bcde-9617-6bad23c8ac8b@linaro.org>
Date: Thu, 29 Jun 2023 10:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [qemu-web PATCH] Fix installation instructions for Debian/Ubuntu
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230629080234.179687-1-thuth@redhat.com>
 <305b3e1f-aa55-8efe-8394-7c1b90ffe3f3@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <305b3e1f-aa55-8efe-8394-7c1b90ffe3f3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/6/23 10:12, Michael Tokarev wrote:
> 29.06.2023 11:02, Thomas Huth wrote:
>> There is no package called "qemu" here - thus use the two meta-packages
>> "qemu-system" and "qemu-user" instead.
> 
> There are 2 questions here.
> 
> 1. Do we really want to suggest users to install the whole thing?
> qemu-user and qemu-system are two entirely different beasts, used
> for entirely different purposes.  This is exactly the reason why
> I dropped `qemu' package from debian/ubuntu, - because effectively
> there are two independent, entirely different packages.
> 
> Also 1.a, - again, whole qemu-system usually isn't needed. There are
> another 2 big different classes here, - native thing (probably with
> kvm), and foreign thing.
> 
>> Resolves: https://gitlab.com/qemu-project/qemu-web/-/issues/8
> ..> -* <strong>Debian/Ubuntu:</strong> `apt-get install qemu`
>> +* <strong>Debian/Ubuntu:</strong> `apt-get install qemu-system 
>> qemu-user`
> 
> 2.  There are 2 qemu-user packages on debian/ubuntu: it is qemu-user
> and qemu-user-static. My guess is that most users actually need the latter,
> at least this one lets to run foreign chroots without copying anything from
> host system to a chroot.  In rare cases when one wants to install and run
> foreign binaries directly into the host system, qemu-user is okay. But it
> is a really rare case, and usually combined with running foreign chroots
> anyway.
> 
> So I'd say this whole thing needs a bit more explanation, like,
> 
>   when you want to run qemu-system emulation, install qemu-system 
> (meta)package.
>   when you want user-mode emulation, install qemu-user-static package.
> 
> Or something like this.

Or link to the Debian wiki where the qemu packages are explained :)

> This is actually a question to QEMU upstream, - I think the same reasoning
> applies there as well.
> 
> Thanks,
> 
> /mjt
> 
> 


