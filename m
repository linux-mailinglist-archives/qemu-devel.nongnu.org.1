Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A79573C4B6
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 01:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCpxD-00078k-Hx; Fri, 23 Jun 2023 19:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCpxA-00077t-Jd
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 19:12:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCpx4-0004qf-7g
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 19:12:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so113776166b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687561944; x=1690153944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/tp78wR5cCQo1o4v79lcAWZh4iL1FRFJA1Am+4OQnw=;
 b=igv69yN0YiEHUGOBlN8Kk0okmXZetn2vMNh95qk0FcnhAiRK5wPG17Nbuxb0sU1l5V
 H8TGo4LNe/VM3QTaw9v71QjJk6VoMDtHwwTR2YEzVwzHdqGEBGxzi0OkZi61TUTnocLF
 mXOrpPgqvaJeN7gG3utM80BocuOdmoRUK3IHtv5tM2Q26rtrfCfHE0SUYsEuq6ouZSYj
 uCM11WCD+tNVDwbg/xJFS/whGFDxoQzQpNYaAa59vCh6700uIT5hO/BhjAxSAkzdzwwh
 4/Uhta0xYxA3uEi8c+hltoJMxBgYwBJjwyQogCPTp5c5pZSR4h5rVfsvCWD+97wN2IiO
 It1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687561944; x=1690153944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S/tp78wR5cCQo1o4v79lcAWZh4iL1FRFJA1Am+4OQnw=;
 b=P+weekf1ZfybupnDU2svCGdYFiT6G4f5h248VzKEwgv9D1/YKbbMaV+dGPuevESkJg
 OYDhnOjOJe4BZIqjr+ntyzLmfi/hhb8IbTmTCQFW8VwraUYV93BnvzdhcBNi8+2V9zR0
 Wzu+UiL4Z4Y2fsZnV6J3TGa4sdylDZ2G67FkTp3qQzloXVnj6YIapnBH7Oi+vH7KcKiu
 vbet5OSqkuwxTG/qnbkvsVeEQHMQt7pxlUXLAAROQ/4qhW0jU2TnOGHWRqa+N/UW6rYx
 HuaK4maqsPT7bv/RJcorKJtCu15rUW1Tf37Pt5iIztf10WILnJ8sBfnlJ0yc/6rSuxSq
 8izg==
X-Gm-Message-State: AC+VfDwx2VPLWYsacAS/Z+efYliRc0WhrC3iBFU26h1MUPkz9nCL36Ct
 fy0OwYHGkbW7CQIam96Jv0WrIv5V41a6aGee8Br6MQ==
X-Google-Smtp-Source: ACHHUZ5/Y6IcOiGaxMhwfWT4vJ9fzCf/EuxAuUYWkg8XcZr4aEvnZw3WFyvxkoogdGuaa5DlegvBIQ==
X-Received: by 2002:a17:906:7945:b0:982:781e:ba13 with SMTP id
 l5-20020a170906794500b00982781eba13mr22290424ejo.39.1687561944477; 
 Fri, 23 Jun 2023 16:12:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 qo5-20020a170907212500b00988c93c85a5sm169114ejb.183.2023.06.23.16.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 16:12:23 -0700 (PDT)
Message-ID: <94bbfa23-836c-5e8c-db3b-2b040f3326a6@linaro.org>
Date: Sat, 24 Jun 2023 01:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH-for-8.1] accel: Remove HAX accelerator
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, libvir-list@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230623230837.4194-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230623230837.4194-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 24/6/23 01:08, Philippe Mathieu-Daudé wrote:
> HAX is deprecated since commits 73741fda6c ("MAINTAINERS: Abort
> HAXM maintenance") and 90c167a1da ("docs/about/deprecated: Mark
> HAXM in QEMU as deprecated"), released in v8.0.0.
> 
> Per the QEMU deprecation policy, we shouldn't remove it before
> QEMU release v8.2.0. However per the latest HAXM release (v7.8),
> the latest QEMU supported is v7.2:
> 
>    Note: Up to this release, HAXM supports QEMU from 2.9.0 to 7.2.0.
> 
> (https://github.com/intel/haxm/releases/tag/v7.8.0)
> 
> The next commit (https://github.com/intel/haxm/commit/da1b8ec072)
> added:
> 
>    HAXM v7.8.0 is our last release and we will not accept
>    pull requests or respond to issues after this.
> 
> As of commit b455ce4c2f, it became very hard to build and test
> HAXM. Its previous maintainers made it clear they won't help.
> It doesn't seem to be a very good use of QEMU maintainers to
> spend their time in a dead project. Save our time by removing
> this orphan zombie code before the QEMU v8.2 release.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 5b258b446b..cc8a1e38a9 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -659,15 +659,18 @@ Use ``Icelake-Server`` instead.
>   System accelerators
>   -------------------
>   
> -Userspace local APIC with KVM (x86, removed 8.0)
> +Userspace local APIC with KVM (x86, removed in 8.0)
>   ''''''''''''''''''''''''''''''''''''''''''''''''

Oops I didn't mean to commit this line. The doc won't build with padding.

>   ``-M kernel-irqchip=off`` cannot be used on KVM if the CPU model includes
>   a local APIC.  The ``split`` setting is supported, as is using ``-M
>   kernel-irqchip=off`` when the CPU does not have a local APIC.


