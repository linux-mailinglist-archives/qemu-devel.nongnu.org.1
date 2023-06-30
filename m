Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE32743F25
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFGJA-00043m-64; Fri, 30 Jun 2023 11:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qFGJ8-00043Q-BB
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qFGJ5-0000E8-TP
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688139911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hE//u7A5yTkhCbpXZYsRhr0RRa5AIJ95hGupDzOsuH8=;
 b=IjUhwQaj6OLHy9IZvyC2uzMa2fC47qrzJt2K3CBlcrJ+PPRmYjbMFVgNtcg0R8vLJ3wnGm
 TWKLJl3o9PDWmFmZ0qYs5WyMRwKuxrYkppeQPHoZxFXB1qaMATSbsZFNFtuVFBpiHMttLp
 R0FUDp2Lh92gUgSKTHGaMX0cQ0F4A34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503--uPcyA2QPCm4JaTWMutP4w-1; Fri, 30 Jun 2023 11:45:09 -0400
X-MC-Unique: -uPcyA2QPCm4JaTWMutP4w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fb40d90456so9291885e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 08:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688139908; x=1690731908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hE//u7A5yTkhCbpXZYsRhr0RRa5AIJ95hGupDzOsuH8=;
 b=fK9xc/nLzxae6BvGP6LjYqTpqq0Zk/5lA9Nxrw2WIcZLrlGT/LtZiAuwBJ3pjE1eoL
 7vrOES8K/DeMQmcNY8b2Qh/yrmsWDbfS8PfGf/Bx+igyBhSWvt6SFuxeU1xCKuJDlwJE
 2k4dRihXou47uIwa+5gY8knUt6Cdh9U/9az1tQsUG8LPp+RSnU3bsqquZB0gj+UsICjZ
 8HLT+20PwBI82UJmEqeW3bxZ/hTO96Za/6iVXYSplq+xSSBLnNwTD/LxxKj7hRNgEFn1
 BjIwBX4Him1TEmx9tlmXcAaCjpNW7/NcjzjH6bNvVgDd3AIaakVYH2aUHFFf/k/sP78d
 NxTg==
X-Gm-Message-State: AC+VfDz3KNwwvtUxDhVOF1fnnTFzrtRZ4B9mmqrtpGy9taTpwPbnAZkz
 0j2oddtQnIAM6X47Sm/aWbI4hjHb18g6iuLQEG+26hzL3uj2GLyT1CBrewhmS0FkRKZbEY1DQFO
 D2yrzF06D9gU57oI=
X-Received: by 2002:a05:600c:2312:b0:3f9:fd12:a8b0 with SMTP id
 18-20020a05600c231200b003f9fd12a8b0mr2746827wmo.20.1688139908471; 
 Fri, 30 Jun 2023 08:45:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45ZId8nNWDS4U0W/VVox57ob2e9YySnMRGudn9AvjMYvZKNpBIHW9NOyfbkoHFnmmOfCMnJg==
X-Received: by 2002:a05:600c:2312:b0:3f9:fd12:a8b0 with SMTP id
 18-20020a05600c231200b003f9fd12a8b0mr2746812wmo.20.1688139908072; 
 Fri, 30 Jun 2023 08:45:08 -0700 (PDT)
Received: from [192.168.8.100] (tmo-065-218.customers.d1-online.com.
 [80.187.65.218]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d5951000000b00313f61889ecsm12501786wri.66.2023.06.30.08.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 08:45:07 -0700 (PDT)
Message-ID: <091ce590-1499-1aea-9cfa-67e4035615b4@redhat.com>
Date: Fri, 30 Jun 2023 17:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 18/42] tests: avocado: boot_linux_console: Add test case
 for bpim2u
Content-Language: en-US
To: qianfan <qianfanguijin@163.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-19-peter.maydell@linaro.org>
 <280c57d2-9648-36ea-74e9-6ffc7f3b4388@redhat.com>
 <b954eaad-508c-2341-eaeb-8ec4111de664@163.com>
 <4f749512-a395-40e4-c20e-ed4928c2cb87@redhat.com>
 <f7d5a8eb-cd7f-e0f5-91cc-4b3840b5de2c@163.com>
 <be0b195b-101b-692c-672c-f16e41522853@redhat.com>
 <77ef230f-b896-9f18-e7b1-d9821a664e0a@163.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <77ef230f-b896-9f18-e7b1-d9821a664e0a@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/06/2023 11.04, qianfan wrote:
> 
> 
> 在 2023/6/30 16:53, Thomas Huth 写道:
>> On 30/06/2023 10.45, qianfan wrote:
>>>
>>>
>>> 在 2023/6/30 15:27, Thomas Huth 写道:
>>>> On 30/06/2023 08.15, qianfan wrote:
>>>>>
>>>>>
>>>>> 在 2023/6/29 19:35, Thomas Huth 写道:
>>>>>> On 06/06/2023 11.47, Peter Maydell wrote:
>>>>>>> From: qianfan Zhao <qianfanguijin@163.com>
>>>>>>>
>>>>>>> Add test case for booting from initrd and sd card.
...
>>>>>>
>>>>>> FYI, the test_arm_bpim2u_gmac test just failed during one of my CI runs:
>>>>>>
>>>>>> https://gitlab.com/thuth/qemu/-/jobs/4565108610#L300
...
>>>> Oh, that's ugly, I think the problem is likely that the numbering
>>>> of device names that are directly in /dev/ is never guaranteed by
>>>> the Linux kernel.
>>>>
>>>> Could you please try whether this work more reliably for you
>>>> instead:
>>>>
>>>> diff a/tests/avocado/boot_linux_console.py 
>>>> b/tests/avocado/boot_linux_console.py
>>>> --- a/tests/avocado/boot_linux_console.py
>>>> +++ b/tests/avocado/boot_linux_console.py
>>>> @@ -869,7 +869,7 @@ def test_arm_bpim2u_gmac(self):
>>>>          self.vm.set_console()
>>>>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>>>>                                 'console=ttyS0,115200 '
>>>> -                               'root=/dev/mmcblk0 rootwait rw '
>>>> +                               'root=b300 rootwait rw '
>>>>                                 'panic=-1 noreboot')
>>>>          self.vm.add_args('-kernel', kernel_path,
>>>>                           '-dtb', dtb_path,
>>>>
>>>> ?
>>> Yes, this patch is useful.
>>>
>>> The rootfs can mount successful even if the mmc block enumed as mmcblk1, 
>>> next is the
>>> kernel logs:
>>>
>>> mmc1: new high speed SD card at address 4567
>>> mmcblk1: mmc1:4567 QEMU! 64.0 MiB
>>> EXT4-fs (mmcblk1): mounting ext2 file system using the ext4 subsystem
>>> EXT4-fs (mmcblk1): mounted filesystem without journal. Opts: (null)
>>> VFS: Mounted root (ext2 filesystem) on device 179:0.
>>
>> Great!
>>
>>> But the test scripts still fail due to it always waiting mmc0blk:
>>>
>>>      exec_command_and_wait_for_pattern(self, 'cat /proc/partitions', 
>>> 'mmcblk0')
>>
>> Ok, so the "0" likely got to be dropped here?
>>
>>> Could you please explain where is the "b300" come from?
>>
>> I ran the kernel once without the "root=/dev/mmcblk0 rootwait"
>> part in its command line. Then it prints out something like this:
>>
>>  VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>>  Please append a correct "root=" boot option; here are the available 
>> partitions:
>>  0100            4096 ram0
>>  (driver?)
>>  0101            4096 ram1
>>  (driver?)
>>  0102            4096 ram2
>>  (driver?)
>>  0103            4096 ram3
>>  (driver?)
>>  b300           65536 mmcblk0
>>  driver: mmcblk
>>  Kernel panic - not syncing: VFS: Unable to mount root fs on 
>> unknown-block(0,0)
>>
>> Seems like the "b300" is stable here, no matter whether
>> its mmcblk0 or mmcblk1.
> This way is really hack.

Ack, it's not really nice - but it's still better than a flaky, unreliable 
test, isn't it?

I'll send it as a proper patch for discussion.

> And who case this issue, linux kernel or qemu? I 
> can't make sure.

It's likely the Linux kernel - I think the numbering of entries in /dev/ is 
not guaranteed.

  Thomas



