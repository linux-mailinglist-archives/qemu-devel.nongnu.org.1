Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E93725A70
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pUy-0005bZ-4p; Wed, 07 Jun 2023 05:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6pUs-0005b3-9w
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:30:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6pUq-0004ZP-KL
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:30:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30e412a852dso2724632f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686130227; x=1688722227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sZ7ATomxaKT7ojnYfGLauNhw3C+CDtZZlbZpK3h0pEI=;
 b=ozsLT0opp/3OsvhrX6S+Ivydy5TNSqI8cdFHSKuO5GnxrGUVrkzE1yCIxGDnCHBkUO
 U5juWAyQvIWA3Fo2V16DGUFP+Cjhjj6wwr+hplGLD3BMj9djoWXrY40mKACZYb+qS6c1
 HePemT3qUONxdS/dlyZsFYxVbASHb7h3Y9AxPAmqRX1i/sSrRxn3faPKoOGZiVEmVtsH
 TxwCIHB1jFjPJ+TBySshgcbe/D3EGqZpT2MPLvnQ1DO7Xg7/ygifXVTlrmmhdAKI38NR
 peWO8W+diqPqABHBYcRTep0Hjice38Hgi00cl2HnSDPGruS/gVYX1ra5Xr6Jxs1VppRK
 WwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686130227; x=1688722227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZ7ATomxaKT7ojnYfGLauNhw3C+CDtZZlbZpK3h0pEI=;
 b=I0WsTj2Lc5ja4M7d9m9EJucObO+DwACGKwL0Ldcw7W8CxxcE4qI/OJH/ld3gNSytbr
 9mWiOeB88/IECabqk2cTbQT61AJp3UtPJV2DR9DG18g3EK6QX5iBIFwea3jm/NJ1FwsM
 8WvZKf60igZbuSF9OcwADdd91IsQVfFlCd5wrz1dZ8/yrsOwUXVBbkrjT4cJGJtFpasM
 qjn902CpmTUHUyx4yXXYs8NgrDXcL64lJag+UsnGtVRPhUZhb5SW+cI0p+jauV7vJjd3
 hkKWboIy+60PsR8ChGaovbdZjXFjjaa314dxGB0SA2OwIXPsaTNHaO1IjwwOyW0uGWRB
 0Oeg==
X-Gm-Message-State: AC+VfDz2USONzQnKq5oGVopJzRRpV6kNY8rLqkfihAXjdnAIbhsMwvDw
 wIdRXqr8Dr5h6ymgd6ighMwZFQ==
X-Google-Smtp-Source: ACHHUZ4JMngCFM2nRMpvdSGS/qSJBKsVES+rXaJGsRIn7Mnz6XbH3VI6Xx6WmR8UUlYiLn4FYyPzRg==
X-Received: by 2002:a5d:668c:0:b0:30d:5071:b033 with SMTP id
 l12-20020a5d668c000000b0030d5071b033mr3803143wru.31.1686130226936; 
 Wed, 07 Jun 2023 02:30:26 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4585000000b003078354f774sm15116795wrq.36.2023.06.07.02.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 02:30:26 -0700 (PDT)
Message-ID: <769270ee-5850-0fd5-65ea-f7070a7419af@linaro.org>
Date: Wed, 7 Jun 2023 11:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] meson: fix "static build" entry in summary
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20230607090336.59424-1-pbonzini@redhat.com>
 <f1c785b1-beac-55e1-7da9-d9a5f1ab77ff@linaro.org>
 <CABgObfYJA=K0TXZP4tqaHrTG4N+nsFCOJsvLNM3-mXWsVY84cA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYJA=K0TXZP4tqaHrTG4N+nsFCOJsvLNM3-mXWsVY84cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/6/23 11:26, Paolo Bonzini wrote:
> On Wed, Jun 7, 2023 at 11:09 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 7/6/23 11:03, Paolo Bonzini wrote:
>>> Fixes: a0cbd2e8496 ("meson: use prefer_static option", 2023-05-18)
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    meson.build | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 553c8e0b9c5..34d0444ffbb 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -4088,7 +4088,7 @@ summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
>>>    summary_info += {'profiler':          get_option('profiler')}
>>>    summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
>>>    summary_info += {'PIE':               get_option('b_pie')}
>>> -summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
>>> +summary_info += {'static build':      get_optin('prefer_static')}
>>
>> Typo 'get_option'.
> 
> Yeah, sent after testing but before committing the obvious fix. :(

So with  the typo fixed:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

:)

