Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 182747BB2A6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofb2-0003lV-FT; Fri, 06 Oct 2023 03:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofau-0003l4-43
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofar-00071L-M9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696578591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEsJSqn4HI/DGEa8E15sUB8uaMU3fLg021YYdNgr6eI=;
 b=b1vYCAbE5M4dL0c3PuJIQ1x1AuVl7JlB4noKgHpvbfXn4T//nxXDw177eyYP9eF320Ara/
 mkyA59wiAXzTtFcvjK1OrBcD29rWkp0gW8yK5Jh+SxZXvcLQcCpOKTiRVRamEvhSf+dXnE
 CXZIJx5CMcolNhk4fWfbZRHTP90DKp8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-wTg8AADhM7OuruXb-e0A7Q-1; Fri, 06 Oct 2023 03:49:45 -0400
X-MC-Unique: wTg8AADhM7OuruXb-e0A7Q-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-594e1154756so27741987b3.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 00:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696578585; x=1697183385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LEsJSqn4HI/DGEa8E15sUB8uaMU3fLg021YYdNgr6eI=;
 b=sH2LH0KFhTRfZwx6NTyOkt0zqIvEJhbiEZ7jVtH8vkkMl+Ppu8qNI+P8zYOVJYNdCo
 9Ud1B2MQrFWK7uY4bbiX0Ff4esgZWGQn4VMqCHjcVfJISHXeAyhvALs7YKzGfqZzeR7n
 U+3VcsTs9Re1/3X0hmiLtXGPyLZaC5tEct2NKSdN0QotWexfy5Dayt0KkRCel1bQoGyG
 rodS3IzpUl6zdUJOszWHHs/fgukRv/N4c5fYt02uYbTVnk9/NJ4D7ZvMYTA8neJzwjfa
 fZ4Hu4CvUL5AXPfH0i9bn9dFHX3cJRYlyxhv4lWtWMmSYbNXvomS9U9XJMq/hqsHSz36
 rOnQ==
X-Gm-Message-State: AOJu0YxHF94DCyFsVDoTTsvoEFTRWsXwD2+G+utZkCBZCbth3p7eU2G7
 yA9hStb9B3zxmoWxhNBK8kiwOkBuTkvbHZMxIgmp5vAquCxl2HiEsY5VjbS9WtnuIbqHrn9BJEI
 yXdo8+0F7xVRYQxs=
X-Received: by 2002:a0d:c787:0:b0:59f:7fb9:621a with SMTP id
 j129-20020a0dc787000000b0059f7fb9621amr7960597ywd.22.1696578585348; 
 Fri, 06 Oct 2023 00:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERjMRaFv9e8dvwXBttTl3+U8/TESPSbqxD/4+UXxs7+45u0EGMvzJQWkJ7BcOy/NPUp8e+xA==
X-Received: by 2002:a0d:c787:0:b0:59f:7fb9:621a with SMTP id
 j129-20020a0dc787000000b0059f7fb9621amr7960581ywd.22.1696578585022; 
 Fri, 06 Oct 2023 00:49:45 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a0ce544000000b0065b0d9b4ee7sm1177576qvm.20.2023.10.06.00.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 00:49:44 -0700 (PDT)
Message-ID: <86091688-84a1-330c-faf0-2a76d96a536f@redhat.com>
Date: Fri, 6 Oct 2023 09:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/13] misc: Rename 'softmmu' -> 'system'
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20231004090629.37473-1-philmd@linaro.org>
 <ZR1bjpEi5HdFp2xj@redhat.com>
 <85be2979-c0ca-3eb4-dae9-bbabf256c201@redhat.com>
 <00b2ec16-162e-9204-3a04-f45e0edeeb15@suse.de>
 <CABgObfZBTZZvcSPcMSRLWscyEz7B-2h9g28FJx7t7Ggux6E9cA@mail.gmail.com>
 <ZR1uWXEqcyPxsV3g@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZR1uWXEqcyPxsV3g@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 15.53, Daniel P. Berrangé wrote:
> On Wed, Oct 04, 2023 at 03:49:31PM +0200, Paolo Bonzini wrote:
>> On Wed, Oct 4, 2023 at 3:41 PM Claudio Fontana <cfontana@suse.de> wrote:
>>>
>>> On 10/4/23 14:37, Thomas Huth wrote:
>>>> On 04/10/2023 14.33, Daniel P. Berrangé wrote:
>>>>> Am I mis-understanding what you mean by 'finishes' here, as
>>>>> I see many references to softmmu remaining
>>>>> In particular under configs/
>>>>>
>>>>> I was also hoping it meant that we'd be changing configure
>>>>> to allow
>>>>>
>>>>>       configure --target-list=x86_64-system
>>>>>       configure --target-list=x86_64-vm
>>>>>
>>>>> for less typing
>>>>
>>>> Maybe we should also bikeshed about the naming first... "system" is a quite
>>>> overloaded word in this context already, and "vm" sounds rather like
>>>> hardware-accelerated stuff ... what about using something like "sysemu"? Or
>>>> "fullsys" for "full system emulation" (in contrast to "user space"-only
>>>> emulation)?
>>
>> I agree that changing other remnants should be done right
>> after this patch, for example $softmmu in configure. Changing
>> all targets is a very large and very user-visible change, it is
>> required but it should be planned very well.
>>
>> As to the actual target names, I think system is the only
>> consistent choice since we have --enable/--disable-system
>> (as pointed out by Claudio) and qemu-system-*.  sysemu
>> may make a little more sense in the codebase (we have
>> include/sysemu after all), but maybe that ship has sailed
>> since we have many occurrences of "system", for example
>> system_ss and other related sourcesets.
> 
> Yep, I agree with that view now, lets stick with 'system'.

Ok, convinced, seems like 'system' is likely still the best choice.

  Thomas


