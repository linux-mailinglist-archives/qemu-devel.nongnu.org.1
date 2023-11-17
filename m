Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A87EEC47
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 07:37:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3sSA-0003ft-NV; Fri, 17 Nov 2023 01:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3sS7-0003Le-SO
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 01:35:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3sS1-00069j-Pv
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 01:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700202931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jve6GBEePRNw9o5Z1vLuNkaSWGWmbH6W8QMg8fcwrg0=;
 b=CDh/Tyic0Wos5k0HvHNz2aS9zALxHayBHq0+oENFcDPOhdYR+CPQFtYmsQGl7U6sEpoXo1
 q5kZHLDqB/HRTVcMPSmhIwihEgDkcO7YywNxNbeSt04q52k6MNJpnB8tQoPqgxU3L2MVE9
 qh+1LgfPsYcRZcziobel+a2Lcf5GfKA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-rJtdMZIZMOiybH7s71zoIQ-1; Fri, 17 Nov 2023 01:35:29 -0500
X-MC-Unique: rJtdMZIZMOiybH7s71zoIQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66fa17e145aso20974016d6.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 22:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700202929; x=1700807729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jve6GBEePRNw9o5Z1vLuNkaSWGWmbH6W8QMg8fcwrg0=;
 b=PWcavQHtbJzbjL5m70THMZU7g8y41EX+uQDh7SH3DzOI/PiLGCO7pB6F0nx0Kxojfj
 vSLbVDc6mtK0MY+5j157iuGF5MjQpO8SzJUECxOHqC69ag459Bh3yJXGt5JKA04/E8LX
 MV0hGAw6nlYEKxXIsymHWuO6a1JLTJZGdk98EmzyXrE4nA25qLFlytFo371tobGf8Q16
 3UTC8FbZKvw3ntTPr8X3WiyOJ8kT6NQg+9G9WXVulZJUB07iKmbdsbb78UAYkAZrpjau
 425iSJ5i7W2TEXJmBNH7O6f/fix3amRUr2zN+slklWUh8X8aNBGMQfNxv+cBO0eFIm5L
 c7EA==
X-Gm-Message-State: AOJu0YyvZz9a0kV9WSU0GRhF55T2HyXn9F4iFVRfY0tSY5n9lgZeZE6K
 OjfLWI6XbNwXoX8IAiCRBYn0K/5v9qYk1CAqKvSuZboq8ydLtbFgIdn9WbRuJZXjCyDyutvZfyI
 34QHwYRcE9m9c6vY=
X-Received: by 2002:ad4:5812:0:b0:66d:1b4c:e867 with SMTP id
 dd18-20020ad45812000000b0066d1b4ce867mr10717218qvb.45.1700202929072; 
 Thu, 16 Nov 2023 22:35:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyEMWGJktt45PXYn+3NSmtKScVMnTXQyqrp4eKgox5pDH7pBl82toUt3zoOGn5zao9P+j1pQ==
X-Received: by 2002:ad4:5812:0:b0:66d:1b4c:e867 with SMTP id
 dd18-20020ad45812000000b0066d1b4ce867mr10717213qvb.45.1700202928908; 
 Thu, 16 Nov 2023 22:35:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a0cee68000000b0065afbb39b2dsm401264qvs.47.2023.11.16.22.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 22:35:28 -0800 (PST)
Message-ID: <800a75b9-8c0c-459b-8cad-ab36e9a08d69@redhat.com>
Date: Fri, 17 Nov 2023 07:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-headers: Synchronize linux headers from linux
 v6.7.0-rc1
To: maobibo <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 gaosong <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 qemu-devel@nongnu.org, mst@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 lixianglai@loongson.cn
References: <20231114015412.53135-1-zhaotianrui@loongson.cn>
 <be0da6a9-6f1e-11d9-f088-328ea33aee36@loongson.cn>
 <771dd5ff-45d0-40bd-87dd-40f666d3355d@redhat.com>
 <257d6562-51fb-867a-e65c-13418c6ce888@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <257d6562-51fb-867a-e65c-13418c6ce888@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

On 11/17/23 02:14, maobibo wrote:
> Thomas,
> 
> Linux 6.7-rc1 has already released, LoongArch KVM is supported in this version. LoongArch qemu KVM function depends on linux-headers and I do not know whether LoongArch qemu KVM can be merged in 8.2 cycle.

It's too late for 8.2. See https://wiki.qemu.org/Planning/8.2.

Thanks,

C.



> Regards
> Bibo Mao
> 
> 
> On 2023/11/16 下午9:19, Thomas Huth wrote:
>> On 15/11/2023 11.07, gaosong wrote:
>>> Hi,
>>>
>>> Can this patch be merged in during the 8.2 cycle?
>>
>>   Hi!
>>
>> We normally do linux-headers updates along with the patches that need the new definitions ... so is there an urgent reason to push this stand-alone
>> patch into 8.2 without any patches that require these new definitions?
>>
>>   Thomas
> 
> 


