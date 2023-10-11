Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E577C5E24
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfcq-0008WL-DJ; Wed, 11 Oct 2023 16:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qqfcn-0008W0-Ui
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:16:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qqfcO-0007De-CZ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:16:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32615eaa312so216250f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1697055342; x=1697660142; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cW2iLJJrsUsD80CiFP4WOikPznomVj3lGYcCHAn3vTs=;
 b=GEiDeDdeQkxhgfiq+s08HD+urYFhhKuBw9pmI4hMQLh8HOSzC73tCC8K74vy6LrP3/
 7SgZGJlvpE0J6qdpT/RdvKum0R9s5pHCcNniOUaMrlrvFlOuQqPke+WbOLdu/xY9Ga/t
 mQpvkR9zbeVi9QeVkmT+dGeRVxKYpRQWzkt2Y8M/7y5lbs4yevQfe1/UfVXrKmuFx8PR
 uAP397xemk6wHbxQ/V2K9OhbfdwuEQ+mHgznOH/8z8Yd5hzsA+NskIuNCbi7LwBPCkrD
 eB4oaAe0xkcL1iMnhHnskuJU7dKljnGns4gIJAfH+0YbO8Nto1d9swRN2Ul7i98GL/BZ
 d16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697055342; x=1697660142;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cW2iLJJrsUsD80CiFP4WOikPznomVj3lGYcCHAn3vTs=;
 b=sUU+jZ0uXXocnI4S6iII3TsCRy0VLlBa7Sir1uT9baSadWxERFAD8qdm9Ek6GM9dbJ
 O7Bf8Kx+HEWYBDRB3Z4p4LF4F3cMJWG5UL94Oc1RAunI6sReu5J3lv6gUfpNtN4tQubX
 cjZL9UX34YOqkRmz0GbPPaGCi0UN6F58jdr1rHyQmWsnfW2Z8Yc7McsYNtmpVLU3hVdI
 TgyzXxr9furibtIKk9kDDtWwQjyglMgPSLWzurbz/LVK4YxS02LHuGIh74Qazng24uOs
 88qfTGizV75T/JD2fckwBocqvo6yzGgbuqF/k84BvtWhlDjdN0WOOrDBg1w97x1eJpdI
 wxAw==
X-Gm-Message-State: AOJu0YwVl1rsRzf6Tm/VK489xSvw6uQXL8JcAt2hy+hgkkHaQ93Lk+3y
 uyDQMZDdBg003IGGBDc8K+KuPw==
X-Google-Smtp-Source: AGHT+IEvgl9CiBFJpoKMOTVvPFZqC6tKbEoy0eevPrhGoRNQ61gsQGKH+qVNe8LVTTMJVKenWx/9zQ==
X-Received: by 2002:a5d:6909:0:b0:317:e542:80a8 with SMTP id
 t9-20020a5d6909000000b00317e54280a8mr21034113wru.15.1697055342292; 
 Wed, 11 Oct 2023 13:15:42 -0700 (PDT)
Received: from [10.8.0.16] ([185.223.232.243])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adff243000000b0031431fb40fasm16363365wrp.89.2023.10.11.13.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 13:15:41 -0700 (PDT)
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <cfcca2d3-212e-2a90-1acc-1d23105c3804@amperemail.onmicrosoft.com>
 <c6eb2290323644e89c40c834bb934f62@huawei.com>
 <721d05b7-ee2b-999c-da72-d369483cfbb2@amperemail.onmicrosoft.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Message-ID: <22929591-ebea-9a6b-914f-9f21d43931df@opnsrc.net>
Date: Wed, 11 Oct 2023 21:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <721d05b7-ee2b-999c-da72-d369483cfbb2@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Vishnu

On 11/10/2023 12:08, Vishnu Pajjuri wrote:
> Hi Salil,
> 
> On 11-10-2023 16:02, Salil Mehta wrote:

[...]

>>> From: Vishnu Pajjuri<vishnu@amperemail.onmicrosoft.com>
>>> Sent: Wednesday, October 11, 2023 11:23 AM
>>> To: Salil Mehta<salil.mehta@huawei.com>;qemu-devel@nongnu.org; qemu-
>>> arm@nongnu.org
>>> Cc:maz@kernel.org;jean-philippe@linaro.org; Jonathan Cameron
>>> <jonathan.cameron@huawei.com>;lpieralisi@kernel.org;
>>> peter.maydell@linaro.org;richard.henderson@linaro.org;
>>> imammedo@redhat.com;andrew.jones@linux.dev;david@redhat.com;
>>> philmd@linaro.org;eric.auger@redhat.com;will@kernel.org;ardb@kernel.org;
>>> oliver.upton@linux.dev;pbonzini@redhat.com;mst@redhat.com;
>>> gshan@redhat.com;rafael@kernel.org;borntraeger@linux.ibm.com;
>>> alex.bennee@linaro.org;linux@armlinux.org.uk;
>>> darren@os.amperecomputing.com;ilkka@os.amperecomputing.com;
>>> vishnu@os.amperecomputing.com;karl.heubaum@oracle.com;
>>> miguel.luis@oracle.com;salil.mehta@opnsrc.net; zhukeqian
>>> <zhukeqian1@huawei.com>; wangxiongfeng (C)<wangxiongfeng2@huawei.com>;
>>> wangyanan (Y)<wangyanan55@huawei.com>;jiakernel2@gmail.com;
>>> maobibo@loongson.cn;lixianglai@loongson.cn
>>> Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
>>>
>>> Hi Salil,
>>>
>>> On 26-09-2023 15:33, Salil Mehta wrote:
>>>> [ *REPEAT: Sent patches got held at internal server yesterday* ]
>>>>
>>>> PROLOGUE
>>>> ========

[...]

>>> Tested on Ampere's platform for vCPU hotplug/unplug with reboot,
>>> suspend/resume and save/restore.
>>> Also tested for vCPU hotplug/unplug along with VM live migration.
>>>
>>> Please feel free to add,
>>> Tested-by: Vishnu Pajjuri<vishnu@os.amperecomputing.com>
>> Many thanks for this.
>>
>> As you are aware, we have now split above patch-set into:
>>
>> 1. Architecture agnostic patch-set (being reviewed below)
>>     https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/#t
>> 2. ARM specific patch-set (Would soon be following as RFC V3)
>>
>>
>> If possible, can I request you to sanity test the Architecture
>> agnostic patch-set as well for regression and provide the
>> Tested-by Tag for this patch-set as well?
> 
> Sure, I'll do.


Thanks. I have added your tag in the architecture agnostic patch-set

https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@huawei.com/ 



>> This is to ensure these changes if accepted do not break any
>> existing features.
>>
>>
>> Many thanks again for your past efforts all these times!
> It was great working experience with you.
> And my pleasure to contribute to new feature like vCPU hotplug on ARM64 
> platform.


You are welcome.


Cheers
Salil





