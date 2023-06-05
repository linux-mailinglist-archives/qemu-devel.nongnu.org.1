Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF7722798
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6AMv-0001JJ-7N; Mon, 05 Jun 2023 09:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1q6AMs-0001JA-Qb
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:35:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1q6AMq-0007iT-Gi
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:35:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-256d1b5f7c0so3556508a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972126; x=1688564126;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDyT3HEoIS5RmHuNt7thsvI1nlwjDuPlVXhZ+cXZM/0=;
 b=VkYsbkZfaEWFbVH4aInCeS4dvjCoiuh+ZFl+CQqWRNW4VgZE89u9LRqmeaOHHSd0yU
 5DENqIOwKHisX2Jfa62/h+If7XYQzrkNMi9oUz233IwVW9sk6FojVtQoBKbyTlMfL3SF
 U8UJ4EzJhlFtEEAGh2uBoU10oFe5D+BP84HWkPLnXUXNmtXvVS24I/MDzpojtJEVC6rS
 VEoJyLsTN+1ySrusWSU9gD42Rp8BMzRU+WHFnAzgYy4XVMnZEmvqUDoT4XNCR9t3/0mP
 8D2/Fxe4v/xI95OErgIusRRm9kxgzuEFUlQSK7B08OdksecXS8UjVJA9ONVOBFiA/Eja
 7oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972126; x=1688564126;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDyT3HEoIS5RmHuNt7thsvI1nlwjDuPlVXhZ+cXZM/0=;
 b=DO2P8FoRlyPSjtPlqMyFDIPHdWG5fCvSHJdHS787JcshEs2dSj2dAR70hO2vCYNsyh
 U7k7V33uZu/JlT94MuVOIP08+RShLvr5UBJuzcnbayQsR+YpHfrSp7GBhi7ZqExlnwBb
 sd7AoZwbzhIJg8ywputt/nHDbpCFqH1caR6ftrk6oSmXwNXWqUyce6w3CN01sCA9YVeu
 9RF15BAdC8621UXZiNeqvTQHcFwJA1Bk2aCSVDxqyNFk6PHQwt1X9Xhu8VQ8ZcPyCuCc
 DlAgtVLnznjGUts+BerQMwxja01n7EM6xMJ+fUhCE0UCEWYO+WnYDb/2COvV7vPRmK2O
 iLMg==
X-Gm-Message-State: AC+VfDyMc7LomypAcoHGtudFv+4Va/A4ujCuaFO59J7Sgc39edmemRFl
 p+023w2OxR3kgP7jU/lrdjI=
X-Google-Smtp-Source: ACHHUZ46GgsBFfioGrBKa2PUngAfyIX2mRI9W32V31FerP+hXxIicXY0r55vMvtdnoMXT15n0AOOHQ==
X-Received: by 2002:a17:90a:6b4e:b0:244:d441:8f68 with SMTP id
 x14-20020a17090a6b4e00b00244d4418f68mr8904970pjl.16.1685972125739; 
 Mon, 05 Jun 2023 06:35:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a17090a448900b0023a9564763bsm7669374pjg.29.2023.06.05.06.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:35:25 -0700 (PDT)
Message-ID: <0196226c-39a9-8bab-1543-34d5412f926e@roeck-us.net>
Date: Mon, 5 Jun 2023 06:35:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230502121459.2422303-1-peter.maydell@linaro.org>
 <20230502121459.2422303-32-peter.maydell@linaro.org>
 <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
 <a77c864f-f571-b0a8-3c7f-dadbbf8c8185@tls.msk.ru>
 <4377a8d5-54d1-e0b3-e87a-0c04ec3b1360@roeck-us.net>
 <CAFEAcA_L8XCdRLGU_xeMC3JGzK_4h0LDWXz0VFLMgdkWigc1VQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PULL 31/35] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
In-Reply-To: <CAFEAcA_L8XCdRLGU_xeMC3JGzK_4h0LDWXz0VFLMgdkWigc1VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/5/23 02:40, Peter Maydell wrote:
> On Sat, 3 Jun 2023 at 19:06, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/3/23 10:46, Michael Tokarev wrote:
>>> 03.06.2023 18:03, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Tue, May 02, 2023 at 01:14:55PM +0100, Peter Maydell wrote:
>>>>> The Allwinner PIC model uses set_bit() and clear_bit() to update the
>>>>> values in its irq_pending[] array when an interrupt arrives.  However
>>>>> it is using these functions wrongly: they work on an array of type
>>>>> 'long', and it is passing an array of type 'uint32_t'.  Because the
>>>>> code manually figures out the right array element, this works on
>>>>> little-endian hosts and on 32-bit big-endian hosts, where bits 0..31
>>>>> in a 'long' are in the same place as they are in a 'uint32_t'.
>>>>> However it breaks on 64-bit big-endian hosts.
>>>>>
>>>>> Remove the use of set_bit() and clear_bit() in favour of using
>>>>> deposit32() on the array element.  This fixes a bug where on
>>>>> big-endian 64-bit hosts the guest kernel would hang early on in
>>>>> bootup.
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Message-id: 20230424152833.1334136-1-peter.maydell@linaro.org
>>>>
>>>> In v8.0.2, the cubieboard emulation running Linux crashes during reboot
>>>> with a hung task error. Tested with mainline Linux (v6.4-rc4-78-g929ed21dfdb6)
>>>> and with v5.15.114. Host is AMD Ryzen 5900X.
>>>>
>>>> Requesting system reboot
>>>> [   61.927460] INFO: task kworker/0:1:13 blocked for more than 30 seconds.
>>>> [   61.927896]       Not tainted 5.15.115-rc2-00038-g31e35d9f1b8d #1
>>>> [   61.928144] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> [   61.928419] task:kworker/0:1     state:D stack:    0 pid:   13 ppid:     2 flags:0x00000000
>>>> [   61.928972] Workqueue: events_freezable mmc_rescan
>>>> [   61.929739] [<c13734f0>] (__schedule) from [<c1373c98>] (schedule+0x80/0x15c)
>>>> [   61.930041] [<c1373c98>] (schedule) from [<c137ad64>] (schedule_timeout+0xd4/0x12c)
>>>> [   61.930270] [<c137ad64>] (schedule_timeout) from [<c137477c>] (do_wait_for_common+0xa0/0x154)
>>>> [   61.930523] [<c137477c>] (do_wait_for_common) from [<c1374870>] (wait_for_completion+0x40/0x4c)
>>>> [   61.930764] [<c1374870>] (wait_for_completion) from [<c1044cd0>] (mmc_wait_for_req_done+0x6c/0x90)
>>>> [   61.931012] [<c1044cd0>] (mmc_wait_for_req_done) from [<c1044e34>] (mmc_wait_for_cmd+0x70/0xa8)
>>>> [   61.931252] [<c1044e34>] (mmc_wait_for_cmd) from [<c10512a0>] (sdio_reset+0x58/0x124)
>>>> [   61.931478] [<c10512a0>] (sdio_reset) from [<c1046328>] (mmc_rescan+0x294/0x30c)
>>>> [   61.931692] [<c1046328>] (mmc_rescan) from [<c036be10>] (process_one_work+0x28c/0x720)
>>>> [   61.931924] [<c036be10>] (process_one_work) from [<c036c308>] (worker_thread+0x64/0x53c)
>>>> [   61.932153] [<c036c308>] (worker_thread) from [<c03753e0>] (kthread+0x15c/0x180)
>>>> [   61.932365] [<c03753e0>] (kthread) from [<c030015c>] (ret_from_fork+0x14/0x38)
>>>> [   61.932628] Exception stack(0xc31ddfb0 to 0xc31ddff8)
>>>>
>>>> This was not seen with v8.0.0. Bisect points to this patch. Reverting it
>>>> fixes the problem.
>>>
>>> Does this happen on master too, or just on stable-8.0 ?
>>>
>>
>> It does. Tested with v8.0.0-1542-g848a6caa88.
>>
>> Here is my command line in case you want to give it a try:
>>
>> qemu-system-arm -M cubieboard -kernel arch/arm/boot/zImage -no-reboot \
>>       -initrd rootfs-armv5.cpio -m 512 \
>>       --append "panic=-1 rdinit=/sbin/init earlycon=uart8250,mmio32,0x1c28000,115200n8 console=ttyS0" \
>>       -dtb arch/arm/boot/dts/sun4i-a10-cubieboard.dtb -nographic \
>>       -monitor null -serial stdio
>>
>> initrd is https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv5.cpio.gz
>>
>> This is with multi_v7_defconfig with some debug options added. If necessary
>> I'll be happy to provide the exact configuration.
> 
> If you can provide a link to the zImage and the dtb to reproduce
> as well, that would be helpful.
> 

Please see http://server.roeck-us.net/qemu/arm-v7/.

There are also compiled versions of qemu v8.0.0 and v8.0.2 as well as scripts
to run the test. Note that the initrd will auto-reboot. The cubieboard emulation
does not support board reset, so the test will normally end with

Requesting system reboot
[   22.020700] reboot: Restarting system

In the failure case, the second line is not seen, and there will be a hung task
crash about 30 seconds after the reboot request.

Requesting system reboot
[   61.960821] INFO: task kworker/0:2:67 blocked for more than 30 seconds.
[   61.961406]       Tainted: G                 N 6.4.0-rc5 #1

Hope this helps,
Guenter


