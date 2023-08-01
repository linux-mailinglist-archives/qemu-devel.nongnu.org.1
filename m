Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCD76B5DB
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpRE-0002om-PZ; Tue, 01 Aug 2023 09:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpRD-0002oQ-2a
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:29:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpRB-0008Dl-Gf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:29:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe24b794e5so14964075e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690896559; x=1691501359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gEJJS+t/udcB4WuBrSpN8v5yj2PyhkgsrP3cB+CMTnM=;
 b=nOcvbUsnIfS+pxuC6L5HNKWhOCbhqiScyJFVZjwJUuQrp5rThySqeLwHwg9zYRcsVz
 qqUghdm4XDqDNYQl26DcH1Dyf8jM/kDuqNk6bV69/ak7/qtQvvth+eLBejv5iFebmO5l
 m4FfkiNikKtX4ie/I3SeZSx2uK/X8KTPTf7GbsID5VTQFmWmkUJ+hndneIsiUEURT5Tv
 O8I0Xw/xhQTkmMXqLokqv4hm6l26x/mmjaZAdZA07wJUxwGCGKKwZerBW0pd9D+axldr
 VRwbN3CTbVHflrkUs7TdmqF5/io5NlCpKHx9JDhMUS56c4aYBYd1AyCVb2/2OLenXKoO
 vCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690896559; x=1691501359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEJJS+t/udcB4WuBrSpN8v5yj2PyhkgsrP3cB+CMTnM=;
 b=U5h7biHN/PaauujF1bksyf1yXIz27QylcZwtZItav57E8rmSfAEc4k8Dyl1OtyiIFr
 aGeMtCnCPlIoFWAArN+MAwpZ9Mzv3sEEDIxxj0GBtRufhnLRoNJt3RffUAWKHjFL642p
 0jV/JeFjnrkivI1rQcglbEacHu6+oi6nrIZLrV1zuX3oWMunz5vv3AVNY31wDziajhkr
 Q3gX0Yb51yVNjYu04nBOAm5hb9ulibh+CsSx6Ka5/ecQpnwwpmKN1WYXMthm7pPOQwtE
 bszNVTPjw/WE3LkreK+QIqMtuT1Vk2zg6qt+WYb4UL8jBaHJffbf2bhfKrSNAD12GLS6
 RTZA==
X-Gm-Message-State: ABy/qLYdcntUJtgR9RR+HkrZRK6uF1D3bpzPg8AVcy8oS27/8HjfmNwy
 FJVmICXlyl3ELpqW8SKSVWF4Dw==
X-Google-Smtp-Source: APBJJlEPv4G4ZBngEymfJ4wnUD8Pa6pWbTZ+pNFvmK0S8wD07DFm66m8q+iul64zulWrusl/JrthkQ==
X-Received: by 2002:a7b:c458:0:b0:3fa:98c3:7dbd with SMTP id
 l24-20020a7bc458000000b003fa98c37dbdmr2381289wmi.41.1690896559531; 
 Tue, 01 Aug 2023 06:29:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a5d6906000000b0031760af2331sm15983715wru.100.2023.08.01.06.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 06:29:18 -0700 (PDT)
Message-ID: <f2f40d8e-df48-3320-58c9-1bdf9ede7792@linaro.org>
Date: Tue, 1 Aug 2023 15:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <ZMd/pdT5DmPxtjYW@redhat.com>
 <2ff2a91e-6199-045b-c86e-1023e88eb32c@linaro.org>
 <ZMfuhFxIcSZtqCdO@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZMfuhFxIcSZtqCdO@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 31/7/23 19:25, Daniel P. Berrangé wrote:
> On Mon, Jul 31, 2023 at 04:10:36PM +0200, Philippe Mathieu-Daudé wrote:
>> On 31/7/23 11:32, Daniel P. Berrangé wrote:
>>
>>> I was surprised to see that we're not using ccache in gitlab CI. It wouldn't
>>> help the from-clean compile time, but thereafter it ought to help. I'm doing
>>> some tests with that to see the impact.
>>
>> I tried that few years ago and this had very negative impact on custom
>> runners (maybe I wasn't doing it correctly). Hopefully that changed.
> 
> Our runner usage model has changed since then quite alot. What was previously
> mostly on shared runners, is now on Azure private runners. I can imagine it
> will vary tremendously on what you're using as a private runner.
> 
> In the specific case of the windows jobs though, we're using the shared
> runners.
> 
> Either way, if our jobs are all wired up for ccache correctly, it is then
> trivial to selectively turn off usage of ccache by just tweaking a few
> env vars.

IIRC we weren't using runner tag to filter, so jobs expected to run on
shared runner were ending on private runner, and using env vars was not
working. But you are right, the comments I pointed are obsolete, I
clearly haven't followed all CI changes. Thanks for the tips,

Phil.

