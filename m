Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57C7A5B79
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVO4-0007Pn-QN; Tue, 19 Sep 2023 03:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiVNz-0007Pd-5E
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiVNx-00080q-BH
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695109379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gM5/Qc7CxsI53awUftZkILmn79dOgqUk+dmgyCSnU0s=;
 b=OtxXwOxvv5ihi8azi3hSGqr4r2CY7hBwt9o3lyuhhRpRPYaFK4F3M+XpYjrxsn0/Bh/LDP
 feM5TLZiS7K/ZMobuHrH3nwPzl1PwsARg7zpbGuSxn/JU1gUFERNajIUZ4LCP2x4aKw2Jl
 +FpkPfhSQZOkhBxr6lc58u5oxPS+vGA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-eWj8Nw0oOuawBHwHmRxQAA-1; Tue, 19 Sep 2023 03:42:57 -0400
X-MC-Unique: eWj8Nw0oOuawBHwHmRxQAA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401d8873904so42761285e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 00:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695109376; x=1695714176;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM5/Qc7CxsI53awUftZkILmn79dOgqUk+dmgyCSnU0s=;
 b=cZnpoRZ4GFZDTscBe/hFspjWufDB6GYTDQ2k3Dto9KF+8Uwj6bRuuDW0TJ0fM7E4TI
 G9rXTznkzIpBOiXKxNT783xekrgP1nojtWzRL3X12KuMkeWiDOrheXUe/JMM+qEHaU/k
 jhtVXSuwJSDQHfNc99skxjE2RtuiaQSFJmLv8m3ERvR6dNiCBjN9kKSiSZm9O5MYwmry
 yxDdNFTi81qqJQqLEDkGdTpQryq5z8zEsRRKrobJKhZ9W7KtRGS9xUfnNf05WoOT5shX
 UYRMRthtSGWDeZXvoBa6GrmF1fDv51wBPG5zDebnic9blMunFgCWHa/rjOYdLfvJV48Y
 GDtw==
X-Gm-Message-State: AOJu0Ywkrnbs7odGivI9AE1PiVe+MB1v1s07fUhUW9e437J6L3RLUJk3
 QFp6hn0+s6k0RuvIRgmPPwLn8qANoXl0QF/mi3g1roEcKXbxGBwr3TEu5WtVKFIXj6cRvsURaXQ
 QtaQjna23dFLQ+58=
X-Received: by 2002:a05:600c:3647:b0:401:cc0f:f866 with SMTP id
 y7-20020a05600c364700b00401cc0ff866mr9539513wmq.12.1695109376186; 
 Tue, 19 Sep 2023 00:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmeI4zPDHiOaPTPP/9qxhkxecqFwcxWs0Mk0g3iQ3fCAo3vu9xRhbiOECRo60LjjIHbANwdQ==
X-Received: by 2002:a05:600c:3647:b0:401:cc0f:f866 with SMTP id
 y7-20020a05600c364700b00401cc0ff866mr9539497wmq.12.1695109375783; 
 Tue, 19 Sep 2023 00:42:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1300:c409:8b33:c793:108e?
 (p200300cbc7021300c4098b33c793108e.dip0.t-ipconnect.de.
 [2003:cb:c702:1300:c409:8b33:c793:108e])
 by smtp.gmail.com with ESMTPSA id
 26-20020a05600c231a00b003fe1a96845bsm17373271wmo.2.2023.09.19.00.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 00:42:55 -0700 (PDT)
Message-ID: <7eab0019-f4e7-f3a1-f9a6-46acc4b3d2d1@redhat.com>
Date: Tue, 19 Sep 2023 09:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org,
 qemu-devel@nongnu.org
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
 <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
 <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
 <CAK3XEhP5dyn5bORreJSt7U_QANh2oWG2Tn9UKttbAxEKTSmEfg@mail.gmail.com>
 <CAK3XEhN-x3NdPBknpM=7ORMOdKMzRX6dMn=dY5x=ajf9+tZkSg@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhN-x3NdPBknpM=7ORMOdKMzRX6dMn=dY5x=ajf9+tZkSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 19.09.23 08:18, Ani Sinha wrote:
> On Tue, Sep 19, 2023 at 9:53 AM Ani Sinha <anisinha@redhat.com> wrote:
>>
>> On Tue, Sep 19, 2023 at 9:20 AM Ani Sinha <anisinha@redhat.com> wrote:
>>>
>>> On Mon, Sep 18, 2023 at 9:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 18.09.23 17:56, Ani Sinha wrote:
>>>>> On Mon, Sep 18, 2023 at 8:59 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 18.09.23 17:22, Ani Sinha wrote:
>>>>>>> On Mon, Sep 18, 2023 at 7:25 PM Ani Sinha <anisinha@redhat.com> wrote:
>>>>>>>>
>>>>>>>> 32-bit systems do not have a reserved memory for hole64 but they may have a
>>>>>>>> reserved memory space for memory hotplug. Since, hole64 starts after the
>>>>>>>> reserved hotplug memory, the unaligned hole64 start address gives us the
>>>>>>>> end address for this memory hotplug region that the processor may use.
>>>>>>>> Fix this. This ensures that the physical address space bound checking works
>>>>>>>> correctly for 32-bit systems as well.
>>>>>>>
>>>>>>> This patch breaks some unit tests. I am not sure why it did not catch
>>>>>>> it when I tested it before sending.
>>>>>>> Will have to resend after fixing the tests.
>>>>>>
>>>>>> Probably because they supply more memory than the system can actually
>>>>>> handle? (e.g., -m 4g on 32bit)?
>>>>>
>>>>> cxl tests are failing for example.
>>>>>
>>>>> $ ./qemu-system-i386 -display none -machine q35,cxl=on
>>>>> qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
>>>>> phys-bits too low (32)
>>>
>>> also another thing is:
>>>
>>> ./qemu-system-i386 -machine pc -m 128
>>> works but ...
>>>
>>> $ ./qemu-system-i386 -machine pc -m 128,slots=3,maxmem=1G
>>> qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
>>> phys-bits too low (32)
>>>
>>> or
>>>
>>> $ ./qemu-system-i386 -machine pc-i440fx-8.2 -accel kvm -m 128,slots=3,maxmem=1G
>>> qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
>>> phys-bits too low (32)
>>>
>>> but of course after the compat knob older pc machines work fine using
>>> the old logic :
>>>
>>> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -accel kvm -m 128,slots=3,maxmem=1G
>>> VNC server running on ::1:5900
>>> ^Cqemu-system-i386: terminating on signal 2
>>
>> I dpn't know if we always need to do this but this code adds 1 GiB per
>> slot for device memory :
>>
>>      if (pcmc->enforce_aligned_dimm) {
>>           /* size device region assuming 1G page max alignment per slot */
>>           size += (1 * GiB) * machine->ram_slots;
>>       }
>>
>> For a 32-bit machine that is a lot of memory consumed in just alignment.
> 
> Let's look at an example when we get rid of all alignment stuff.
> 
> $ ./qemu-system-i386 -machine pc-i440fx-8.2 -m 512M,slots=1,maxmem=1G
> above 4G start: 0x100000000,above 4G size: 0x0
> qemu-system-i386: Address space limit 0xffffffff < 0x11ffffffe
> phys-bits too low (32)
> 
> So basically, above_4g_start = 4GiB. size = 0.
> Then it is adding the device memory which is 1GiB - 0.5 GiB = 0.5 GiB.
> So the  0x11ffffffe is exactly 4.5 GiB.
> 
> Anything above 4 GiB is beyond 32 bits.
> 

It's not worth worrying about memory devices for 32bit at all. For 
example Linux doesn't support memory hotplug on any 32bit system (not 
even with PAE and friends).

-- 
Cheers,

David / dhildenb


