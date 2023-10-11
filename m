Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39647C5968
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcHq-0004ZN-8F; Wed, 11 Oct 2023 12:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqcHn-0004ZC-CG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 12:42:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqcHi-0006ug-JU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 12:42:12 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-694ed847889so5470590b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697042529; x=1697647329;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bhuqxDEwUsp5mmSE06AZ0dD5Fg0syCRz4XehtAIKMg=;
 b=F9xeRDtqflSVgyw0fh8R2vC7wZrvYnORZDRw68VfyeZXTNNC2+k32pzPx/8M1b8xk2
 394fPY0IiOFPyyNvQN7C8IfC0ev/3PrHuwvCJlEXb+5KGdSvxwc5jtWUZkEh8jq1Tl0I
 dyd8MNXTpouCHDve+hzm1xaziqqyCreCPpzu8eVkdeNvIoJAwTnefbqZZMm9trCwM+s+
 BKQ9fakfNmPrHtAkpRDlBkh5mHatD+9d3uECgPWMC2+UdPikZBtr0VQzbxFDGl0H+SvG
 DHFpf9xXeG9ECL5U1ozuCRJjdDmw6aoFrTb1zbmXMm7t8nel7VN982Dr/0fGyx27i5pe
 Fg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697042529; x=1697647329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bhuqxDEwUsp5mmSE06AZ0dD5Fg0syCRz4XehtAIKMg=;
 b=Ov9n1zk0imkvpYpPc+edpXeNkwZ1RUlCX1SMxPAJmfE03qHrFf7Qdy5sB1nx8z8hsL
 7SUXkMLOjtbVJ+SLLBv2l7Xv68Iu5k5H4aLyDxsRleyMYjzVnzeVwXwRoRXpWjtuBWI7
 CyRCZOiiWAZ/F44bdkr444Jn+Zkj7N/jrPHb6h1dpbFGUPDUdakVsRcUPPcuMHdUmgvD
 2h3WEpvnx6tXZ4ztQ1flo7vIOQ59qrZoaVI0BOoRAOJYF3x7F36mIgqHNBHqt4/j2uqK
 Z8YgYqL6jXTadjlgMeueG7arUDJrQ21DwOyFE0kXb9ptGe75ncdCIR9ctSFAONdqggdZ
 UMQg==
X-Gm-Message-State: AOJu0YzmRHO0fQ9QkbylFZ1Lgt4ZG99O0IWzgZlWSdkvpSRW138/4RTH
 BeWrk7uw0oO1qhQ5PSPhA8qf0g==
X-Google-Smtp-Source: AGHT+IE0Zq4dnlsbbBbgIyhoU5EMQz7jmC0Sf73ItU8EKmIN+MLCvfvwyqC+qmeCJnSipqf1clE/CQ==
X-Received: by 2002:a05:6a20:1e57:b0:15c:e0bf:40ec with SMTP id
 cy23-20020a056a201e5700b0015ce0bf40ecmr15798417pzb.17.1697042528917; 
 Wed, 11 Oct 2023 09:42:08 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a63b213000000b0059c3ba41db7sm87844pge.30.2023.10.11.09.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 09:42:08 -0700 (PDT)
Message-ID: <69ba49f0-843f-4a74-ad00-5ce1138ee074@daynix.com>
Date: Thu, 12 Oct 2023 01:42:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/23] plugins: Support C++
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-24-akihiko.odaki@daynix.com>
 <ZSZiAHtXGOZnZNas@redhat.com>
 <2c970c00-519c-4175-b0ca-9081c4aa0daf@daynix.com>
 <ffdd55c2-4ae9-4b1f-ac12-a9ad714c3f26@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ffdd55c2-4ae9-4b1f-ac12-a9ad714c3f26@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/12 1:21, Thomas Huth wrote:
> On 11/10/2023 17.48, Akihiko Odaki wrote:
>> On 2023/10/11 17:51, Daniel P. Berrangé wrote:
>>> On Wed, Oct 11, 2023 at 04:03:09PM +0900, Akihiko Odaki wrote:
>>>> Make qemu-plugin.h consumable for C++ platform.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>   docs/devel/tcg-plugins.rst |  4 ++++
>>>>   meson.build                |  2 +-
>>>>   include/qemu/qemu-plugin.h |  4 ++++
>>>>   tests/plugin/cc.cc         | 16 ++++++++++++++++
>>>>   tests/plugin/meson.build   |  5 +++++
>>>>   tests/tcg/Makefile.target  |  3 +--
>>>>   6 files changed, 31 insertions(+), 3 deletions(-)
>>>>   create mode 100644 tests/plugin/cc.cc
>>>>
>>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>>>> index c9f8b27590..984d8012e9 100644
>>>> --- a/docs/devel/tcg-plugins.rst
>>>> +++ b/docs/devel/tcg-plugins.rst
>>>> @@ -283,6 +283,10 @@ run::
>>>>     160          1      0
>>>>     135          1      0
>>>> +- contrib/plugins/cc.cc
>>>> +
>>>> +A pure test plugin to ensure that the plugin API is compatible with 
>>>> C++.
>>>> +
>>>
>>> IMHO we don't need to be adding a test just to prove the
>>> existance of the G_BEGIN_DECLS/G_END_DECLS macros in the
>>> plugin header.
>>
>> Strictly speaking, if you include this header file from C++, the code 
>> will be interpreted as C++ instead of C but with C linkage. That 
>> worries me that the header file may get something not allowed in C++ 
>> in the future.
> 
> I think it should be enough if you add the G_BEGIN_DECLS/G_END_DECLS 
> macros here. QEMU is a C project, and it was quite difficult to get rid 
> of the C++ code again, so please don't soften the check in meson.build 
> and don't introduce new .cc files.
> If you have some code somewhere that uses C++ for plugins, I think it 
> would be better to add a regression test there instead.

It doesn't sound right to test the upstream header file in a downstream 
project. It will take time until the fix becomes readily usable for the 
downstream even if the downstream finds a bug.

What about adding a check for CONFIG_PLUGIN before enabling C++? This 
will ensure nobody dares introducing C++ code again for code else plugins.

