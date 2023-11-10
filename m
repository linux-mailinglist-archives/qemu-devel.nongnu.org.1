Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7288C7E7C62
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 14:06:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1RBg-0002VC-Kh; Fri, 10 Nov 2023 08:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1RBW-0002Uk-HM
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 08:04:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1RBU-0005qo-P9
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 08:04:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so14846025e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 05:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699621466; x=1700226266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFE6piEAzvntZ78R/2iIWj1xKTM+Tp0jua0lcHR33+k=;
 b=M1wPAYvu3xW6VkFfUw557wDUGhrC0XSKkcmOt/MIS1P5VkhPPw2fiT1ohxr1h+bnea
 ssGogCA4FbfOsmkOsY+E3bk38EnPMWL5i34+9NLGJrc6xwS4BUJABGV2UhC8m8J3I/2W
 FBvVV17JkkoGS4uy4WFoM2FdqWBbCwZWN3YH8kZiQEdsJ+5URX8+qFvorcu/bA4pibd0
 PlQaXpFgISyV8RYSfMoz6MIaZI6NI86POQZnuRoJ+3ry6B9K8jaGMj2gpdLxFYKN6Axg
 JRsF5da9cRftWNC6rB0SgJOLqy1SPWP4f5Ngc6O08q8wPY+WDPpt9SqdBK+f43lxv0BD
 gF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699621466; x=1700226266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kFE6piEAzvntZ78R/2iIWj1xKTM+Tp0jua0lcHR33+k=;
 b=fBFbzI8zevoxN+WBTQpqC/8jHK87chnh7yEI3v6ZQ2fR6KPA6/FzpnjYVFWkuspBO8
 y5jVQOwUWNV0zIMnVniTAOBXgc9CPHn2bvSzYXhjpxL26Dk8yN7CQy4f0bbqdvK1wxY3
 s8ZAnpzBwZZyhuylETTm7yuV6uXPQ5PLyjMNJ3ZMcIBCxruFNcogxo6CQJ3Q7hJejwu/
 j0I4tyKR58EtV3OYH9NmIznbiB33+fS1f8+IRjOBVu+AbDsLj/6/7JN2SP+LFbFURX7R
 wwBi3VAXugFv1FhTM4uMREZbUX0yvE5JqHrj9F7N7/pcHOc6R+gffQ4PtlJhyWsKKnJv
 J6Vg==
X-Gm-Message-State: AOJu0YzwQT9lX5GDnWRI0kgItDJ/9lZEDFbR/nDItTNeKVzEATJ/AWUb
 pjLGbjykZi5pod2p3DqLq7HS2w==
X-Google-Smtp-Source: AGHT+IHofPebdSWZ44qLnBD+H5iGylrqOxmRhac/MTASHzluZ2otjCXFpsmqAcyGOYdSRIcg+EuLiA==
X-Received: by 2002:a05:600c:5102:b0:408:57bb:ef96 with SMTP id
 o2-20020a05600c510200b0040857bbef96mr6616006wms.30.1699621465991; 
 Fri, 10 Nov 2023 05:04:25 -0800 (PST)
Received: from [192.168.69.115] ([176.187.194.109])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a05600c3b0600b004077219aed5sm5201900wms.6.2023.11.10.05.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 05:04:25 -0800 (PST)
Message-ID: <f0a2b52e-9dca-436f-8422-ff0c69e98ffc@linaro.org>
Date: Fri, 10 Nov 2023 14:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org> <ZU4R+08zuo8xvlg8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZU4R+08zuo8xvlg8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/11/23 12:20, Daniel P. Berrangé wrote:
> On Fri, Nov 10, 2023 at 12:44:56PM +0200, Manos Pitsidianakis wrote:
>> On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> This kind of thing is why Coverity's unused-result warning has a
>>> lot of false positives. We shouldn't introduce extra code like
>>> this to work around the fact that the tooling doesn't understand
>>> our error-handling convention (i.e. error_fatal, and the way
>>> that some functions report errors both via the return value and
>>> also via the Error** argument).
>>
>> I respect that :). But I personally believe that clinging to C's
>> inadequacies, instead of preventing bugs statically just because it adds
>> some lines of code, is misguided. Proper code should strive to make bugs
>> impossible in the first place. At least that is my perspective and I would
>> like there to be constructive discussions about different approaches in the
>> mailing list. Perhaps something good might come out of it!
> 
> Your approach to the problem:
> 
>    if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
>      exit(1);

Rather:

        g_assert_not_reached();

>    }
> 
> is adding dead-code because the exit(1) will never be reachable. So while
> it lets you squelch the unused result warning, it is verbose and misleading
> to anyone who sees it.


