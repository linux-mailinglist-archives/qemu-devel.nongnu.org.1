Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9D7AE2B6
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 02:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkvTW-0007Nh-No; Mon, 25 Sep 2023 19:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qkvTU-0007NN-Jy
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 19:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qkvTR-0007FI-O8
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 19:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695686325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOvcIRFv6hFezh56Gs1I2EKTDQgBQaStMW0xU95/6XA=;
 b=XCs9E5MhP2gh5EW5Z7++qrxHoSTH/SrMGjWlLeE/hhtEv6EHDuI5xdroZiVIc5Q2xRLkjF
 9Uw8svl695MdfBP2IOcdA7Iftf7QEd7PL6k5I6psj4aLRpro8UlfaJcbRwhAAlKt2qwW72
 TGHSEfxKimK4gbkDi5Mc8RJKCF3GY2Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Ue9SJM2UMjWCvOiwYHDvQg-1; Mon, 25 Sep 2023 19:58:43 -0400
X-MC-Unique: Ue9SJM2UMjWCvOiwYHDvQg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1c625a7c507so24588035ad.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 16:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695686322; x=1696291122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fOvcIRFv6hFezh56Gs1I2EKTDQgBQaStMW0xU95/6XA=;
 b=vQaAKcYTssQqQtoFFlBU7j4V/PJviJn0O8VjpiHfc6UkY6vp4S5X/stHy1gjOgrvXg
 Yr04fUYo7V5BYXyW75CSExAPmf4GCF/3Ckk338eeSu/fNqDaWGToe/Ktpw4/GLUG4RrW
 M62lGMYg/LBpQZl+3vs+qmPSk636/Oec//1nsgH7nFpdwOUMTNOBHVKgpG4xTQv/cis4
 BklSH+ulHBK0vcQgCIMJZNwrW5znc0NRNWH4cH+TcfCrqQTouLYKQMjZJbZw7Ml36qFB
 VbOoRmcUQJkQis3RNFw6aMFFSMlivqUY5gkwRT+jEFATxBeIcSnWSmQFWnPXR92Y607F
 eLnQ==
X-Gm-Message-State: AOJu0YyYx5Xp3Yg3H87WHzfbdnnHSDM+zk6v9Z/tfxdP6nO+eTA/AA/k
 8SByGUpFJzISKEwG4Xdkvo8ZnDIX0Q3mFsetTQtgQhIaX/5iEiGHr87Skngc6E5O7PT4lTVuev6
 fDMFlS8yzqu1LWQI=
X-Received: by 2002:a17:903:41c3:b0:1c0:c86a:5425 with SMTP id
 u3-20020a17090341c300b001c0c86a5425mr7632915ple.19.1695686322307; 
 Mon, 25 Sep 2023 16:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTOYZ4R8No70XtAVs3R00YEGkHpRqbaNRklPCoAch4PxCX7mjvGj+SfQWnwy/RbBuIayxhlw==
X-Received: by 2002:a17:903:41c3:b0:1c0:c86a:5425 with SMTP id
 u3-20020a17090341c300b001c0c86a5425mr7632881ple.19.1695686321995; 
 Mon, 25 Sep 2023 16:58:41 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a170902b28500b001c62b9a51a4sm561612plr.239.2023.09.25.16.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 16:58:40 -0700 (PDT)
Message-ID: <15913a45-35ef-29eb-00b4-db64cc80509c@redhat.com>
Date: Tue, 26 Sep 2023 09:58:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, Russell King <linux@armlinux.org.uk>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "maz@kernel.org"
 <maz@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lorenzo.pieralisi@linaro.com" <lorenzo.pieralisi@linaro.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "justin.he@arm.com"
 <justin.he@arm.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20230925194333.18244-1-salil.mehta@huawei.com>
 <1ba2e69bf0a94c1498ab5863b365559b@huawei.com>
 <ZRHpyxCe8ybsxKck@shell.armlinux.org.uk>
 <a4f5b9370c2c45c7a09fe55f4a7b1a62@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <a4f5b9370c2c45c7a09fe55f4a7b1a62@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 9/26/23 06:21, Salil Mehta wrote:
>> From: Russell King <linux@armlinux.org.uk>
>> Sent: Monday, September 25, 2023 9:13 PM
>> To: Salil Mehta <salil.mehta@huawei.com>
>> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org;
>> james.morse@arm.com; jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; lorenzo.pieralisi@linaro.com;
>> lpieralisi@kernel.org; peter.maydell@linaro.org;
>> richard.henderson@linaro.org; imammedo@redhat.com; andrew.jones@linux.dev;
>> david@redhat.com; philmd@linaro.org; eric.auger@redhat.com;
>> will@kernel.org; catalin.marinas@arm.com; ardb@kernel.org;
>> justin.he@arm.com; oliver.upton@linux.dev; pbonzini@redhat.com;
>> mst@redhat.com; gshan@redhat.com; rafael@kernel.org;
>> borntraeger@linux.ibm.com; alex.bennee@linaro.org;
>> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
>> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
>> miguel.luis@oracle.com; sudeep.holla@arm.com; salil.mehta@opnsrc.net;
>> zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
>> <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
>> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
>> Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8
>> Arch
>>
>> On Mon, Sep 25, 2023 at 08:03:56PM +0000, Salil Mehta wrote:
>>> Looks like some problem with Huawei's mail server server. No patches
>>> except the cover letter are reaching the qemu-devel mailing-list.
>>
>> I haven't seen any of the actual patches - just the cover letters.
>> Was that intentional?
> 
> No. all the patches are either getting held either by the server or
> Some other problem. This has happened for both the instances of the
> patch-set I had pushed to the mailing list within 2 hours.
> 
> I am not sure how to sort it out without the help of IT. China is
> asleep now.
> 
> Any suggestions welcome to debug this. Or Should I wait till tomorrow?
> 

Thanks for your efforts to continue working on the feature. Hope the mail
server issue can be fixed early so that patches can be posted. I don't
see the attached patches either. However, the code is available for early
access in your private repository, as clarified in the cover letter :)

   https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Thanks,
Gavin


