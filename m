Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD887793EFC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtb9-00038P-Qa; Wed, 06 Sep 2023 10:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtb6-000386-Gq
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:33:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtb4-0005Ml-8D
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:33:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401d24f1f27so36094815e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694010812; x=1694615612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=51xO//K+ASA5oXknpG86fGOhSmVBfG4239E1iNml3nM=;
 b=C1bR0dUK/Z42W789RT/MbFKD0qR3e9hIUk4AVRcQlaVKxQavXyNNh53nRHW8myVrjk
 Yvxj8t4Cex/jNejsOzFvvyv9QMp4E+CE0eeVdkzexK/eqNjV+RffU9wKfa+ZMIIL2xzT
 UvO1iTZZV0JJFOIlfKG3TzGYr2W4DybEG4iYToJ91YUk9HgbYJHcys8jeMXpRz6N9eXl
 z4XOYiqx6xseDQmkTShw9BTnQyYfFsfmD6j5xfEMjAe39v2ih/bsHTsev6GBOLsjjfGe
 LvytWe+GynT0EF6DkgJVSyXx/XayJXmjR2yRt9tJYR/M5IEVYXWmFMtOe+TYgTmQKUL6
 ngcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010812; x=1694615612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=51xO//K+ASA5oXknpG86fGOhSmVBfG4239E1iNml3nM=;
 b=GgwMLPBqsTKuuEsdMeQL7/+Ya+J9FzYpcGwxt5utbX3H9tJw6rsak0sNSAVwNG5fSn
 PKhiFeM0hTMbS6hI8NfH4SQlE5XEsemkRdVlN+/hHoEsJzFoUdZEpgHYx7inIjybJ9Rt
 JtO8HlIasvusZ5qBys+0IGV/yGiu+u81BWwX3Dlel14avv/Z3lsE97h+1s9YB76yi7K7
 PmxogXsd4VkmNtMAfzFht+mZLjHuV075DaRE0uyoEtjKJ5CtBeGEM2HYZf2XAtKvZJbX
 UgkiHA+vgbMK44UxI4cVufD2T6B6YZyGC6jLTM6KzTkTw+Tch3NjdF+tw2AAIJgOQgux
 H7oQ==
X-Gm-Message-State: AOJu0Yz1bOSH/8UquxiXbi8UZlbIne63t4lZXoN+qmWf689CC65fDzxp
 YJKFpnAbsP5KvxcbqRApn9hBsUYAZ67ytU9QM3s=
X-Google-Smtp-Source: AGHT+IFUArq0tbjlr+gTDJwZ8z3+ospBc/u03ZvSgHAHFz7t3Rs43ZeyLuNtd1NC7AkNVbY3f5at/Q==
X-Received: by 2002:a05:6000:108a:b0:317:6c19:6445 with SMTP id
 y10-20020a056000108a00b003176c196445mr2622427wrw.39.1694010811920; 
 Wed, 06 Sep 2023 07:33:31 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 u6-20020a5d5146000000b00317f3fd21b7sm20480650wrt.80.2023.09.06.07.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:33:31 -0700 (PDT)
Message-ID: <fb2ee793-9b1b-93b9-5228-6c205be1b374@linaro.org>
Date: Wed, 6 Sep 2023 16:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] target/i386: Translate feature_word_info to xml
Content-Language: en-US
To: Tim Wiederhake <twiederh@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230811135011.23343-1-twiederh@redhat.com>
 <20230811135011.23343-3-twiederh@redhat.com> <ZN3/fUEyC7sSqWy7@redhat.com>
 <37b9e75a96188b6e2693ae6b2128e7a31b76bb82.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <37b9e75a96188b6e2693ae6b2128e7a31b76bb82.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 21/8/23 11:54, Tim Wiederhake wrote:
> On Thu, 2023-08-17 at 12:07 +0100, Daniel P. Berrangé wrote:
>> On Fri, Aug 11, 2023 at 03:50:09PM +0200, Tim Wiederhake wrote:
>>> This is the data file that will be used to generate the C code.
>>> All information, including the comments, is preserved.
>>>
>>> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
>>> ---
>>>   target/i386/feature_word_info.xml | 1607
>>> +++++++++++++++++++++++++++++
>>>   1 file changed, 1607 insertions(+)
>>>   create mode 100644 target/i386/feature_word_info.xml
>>>
>>> diff --git a/target/i386/feature_word_info.xml
>>> b/target/i386/feature_word_info.xml
>>> new file mode 100644
>>> index 0000000000..ff741b9f5a
>>> --- /dev/null
>>> +++ b/target/i386/feature_word_info.xml
>>> @@ -0,0 +1,1607 @@
>>> +<feature_words>
>>
>> I think adding data formats based on XML is pretty undesirable
>> for QEMU. AFAIK, the only place we've used XML is where we
>> needed to have interoperability with an external tool.
>>
>> Can we not just do this using JSON instead, which would avoid
>> the need to write python parsing code as we can directly load
>> it into a python object.
>>
>> With regards,
>> Daniel
> 
> I thought of json as well, but that has some drawbacks over xml here:
> 
> Integer values, e.g. "eax=0x80000008", would need to be stored in
> either decimal form or as a string. Both solutions are not desirable in
> my opinion.
> 
> Additionally, preserving the comments is not as straight forward.
> Comments in json are a non-standard extension and not understood by all
> parsers, e.g. python's json module. This would require some regex-
> preprocessing that comes with its own problems.

Would YAML work?


