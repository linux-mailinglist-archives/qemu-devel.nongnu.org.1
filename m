Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9072117A
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 20:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5VeL-0007WB-JR; Sat, 03 Jun 2023 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1q5VeI-0007Vs-7v
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 14:06:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1q5VeF-0004Ww-Ue
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 14:06:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-652699e72f7so1545794b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685815602; x=1688407602;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sp080UyrPKM1A4XMcuyiAa/k6JYL/y5piFsx2keodpw=;
 b=UWtEB1bSavbyQJhcTXPQHLEBuQOKDCVv0KFJF2vi113bHirWKzxzS6Ku1dBsqyQLCG
 hTp2Wpewdqwr9+WpRp1ultyP+bjKCnltF3BG3JSbqe4Lzg+OSsGrkZIGWS9p7XzI8fHK
 uPj2DIzBDqhnHGBRKhMWYbBkvR/Zxhh1SbM1aN4KagQb0uUEU/eU1HDO/+g5Iv12l9D1
 eayxyyEHAjUK7C21CBQUowrg22SCrMUuyNy8VfAGLv2BigeqRjswyo2MX1eSjv7Uyass
 ygFd5yoh/7Jww24drbRSilAu8P8L8chN3x3GX2r+octAjMwu9+tLBDzB3xw3HtjPpL3c
 u5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685815602; x=1688407602;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sp080UyrPKM1A4XMcuyiAa/k6JYL/y5piFsx2keodpw=;
 b=Gy1BA4AldMR7SUJvxZY51WhzWGXvRajIalPbDFRgRZ35uwUggpAUMU48RY9qOGMdz/
 OhxYSSHKZp2WSBIKzSH62J6SHa9UANDc5Id0p7XHc9bVvB8dlNduIC7A7+Oh3DhZJDar
 lZQ6d3Q2lCFtFVoFECFVOMQf1S3YiY6lDXH9U33FQFYnMsgbkgOwibHv16ok/8KlYsGw
 3TSd/n6vUnvzyE7wXB49XFISg5K58qPoppADW9MuAT992BmSkaB5WrpN7fZnSeWjER7C
 YCNpx5sxBa8RHmQx7dgkdN2Q7acBsklefvcev72/17hIMI0Z9PpUmd8OL4islnsCkKJY
 YC2Q==
X-Gm-Message-State: AC+VfDzbr05x5JYbyzqlsVaKRPBqVJBRquHTmXFlc8Yy5tOBLGiEPJaY
 NDO9+jqXN5NxeyIPtg9j1e6x05CaxIY=
X-Google-Smtp-Source: ACHHUZ7xKiBm6XJeJ31suRqyM3K1UoRFkwMEMuv3+NciglvDemPhzEDd7MG03it4l6DpxY7em3wRSA==
X-Received: by 2002:a05:6a20:3c90:b0:10c:7a20:6dd6 with SMTP id
 b16-20020a056a203c9000b0010c7a206dd6mr959305pzj.42.1685815602261; 
 Sat, 03 Jun 2023 11:06:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 u11-20020aa7848b000000b0063f2e729127sm2773768pfn.144.2023.06.03.11.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 11:06:41 -0700 (PDT)
Message-ID: <4377a8d5-54d1-e0b3-e87a-0c04ec3b1360@roeck-us.net>
Date: Sat, 3 Jun 2023 11:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230502121459.2422303-1-peter.maydell@linaro.org>
 <20230502121459.2422303-32-peter.maydell@linaro.org>
 <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
 <a77c864f-f571-b0a8-3c7f-dadbbf8c8185@tls.msk.ru>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PULL 31/35] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
In-Reply-To: <a77c864f-f571-b0a8-3c7f-dadbbf8c8185@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.095,
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

On 6/3/23 10:46, Michael Tokarev wrote:
> 03.06.2023 18:03, Guenter Roeck wrote:
>> Hi,
>>
>> On Tue, May 02, 2023 at 01:14:55PM +0100, Peter Maydell wrote:
>>> The Allwinner PIC model uses set_bit() and clear_bit() to update the
>>> values in its irq_pending[] array when an interrupt arrives.  However
>>> it is using these functions wrongly: they work on an array of type
>>> 'long', and it is passing an array of type 'uint32_t'.  Because the
>>> code manually figures out the right array element, this works on
>>> little-endian hosts and on 32-bit big-endian hosts, where bits 0..31
>>> in a 'long' are in the same place as they are in a 'uint32_t'.
>>> However it breaks on 64-bit big-endian hosts.
>>>
>>> Remove the use of set_bit() and clear_bit() in favour of using
>>> deposit32() on the array element.  This fixes a bug where on
>>> big-endian 64-bit hosts the guest kernel would hang early on in
>>> bootup.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-id: 20230424152833.1334136-1-peter.maydell@linaro.org
>>
>> In v8.0.2, the cubieboard emulation running Linux crashes during reboot
>> with a hung task error. Tested with mainline Linux (v6.4-rc4-78-g929ed21dfdb6)
>> and with v5.15.114. Host is AMD Ryzen 5900X.
>>
>> Requesting system reboot
>> [   61.927460] INFO: task kworker/0:1:13 blocked for more than 30 seconds.
>> [   61.927896]       Not tainted 5.15.115-rc2-00038-g31e35d9f1b8d #1
>> [   61.928144] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [   61.928419] task:kworker/0:1     state:D stack:    0 pid:   13 ppid:     2 flags:0x00000000
>> [   61.928972] Workqueue: events_freezable mmc_rescan
>> [   61.929739] [<c13734f0>] (__schedule) from [<c1373c98>] (schedule+0x80/0x15c)
>> [   61.930041] [<c1373c98>] (schedule) from [<c137ad64>] (schedule_timeout+0xd4/0x12c)
>> [   61.930270] [<c137ad64>] (schedule_timeout) from [<c137477c>] (do_wait_for_common+0xa0/0x154)
>> [   61.930523] [<c137477c>] (do_wait_for_common) from [<c1374870>] (wait_for_completion+0x40/0x4c)
>> [   61.930764] [<c1374870>] (wait_for_completion) from [<c1044cd0>] (mmc_wait_for_req_done+0x6c/0x90)
>> [   61.931012] [<c1044cd0>] (mmc_wait_for_req_done) from [<c1044e34>] (mmc_wait_for_cmd+0x70/0xa8)
>> [   61.931252] [<c1044e34>] (mmc_wait_for_cmd) from [<c10512a0>] (sdio_reset+0x58/0x124)
>> [   61.931478] [<c10512a0>] (sdio_reset) from [<c1046328>] (mmc_rescan+0x294/0x30c)
>> [   61.931692] [<c1046328>] (mmc_rescan) from [<c036be10>] (process_one_work+0x28c/0x720)
>> [   61.931924] [<c036be10>] (process_one_work) from [<c036c308>] (worker_thread+0x64/0x53c)
>> [   61.932153] [<c036c308>] (worker_thread) from [<c03753e0>] (kthread+0x15c/0x180)
>> [   61.932365] [<c03753e0>] (kthread) from [<c030015c>] (ret_from_fork+0x14/0x38)
>> [   61.932628] Exception stack(0xc31ddfb0 to 0xc31ddff8)
>>
>> This was not seen with v8.0.0. Bisect points to this patch. Reverting it
>> fixes the problem.
> 
> Does this happen on master too, or just on stable-8.0 ?
> 

It does. Tested with v8.0.0-1542-g848a6caa88.

Here is my command line in case you want to give it a try:

qemu-system-arm -M cubieboard -kernel arch/arm/boot/zImage -no-reboot \
     -initrd rootfs-armv5.cpio -m 512 \
     --append "panic=-1 rdinit=/sbin/init earlycon=uart8250,mmio32,0x1c28000,115200n8 console=ttyS0" \
     -dtb arch/arm/boot/dts/sun4i-a10-cubieboard.dtb -nographic \
     -monitor null -serial stdio

initrd is https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv5.cpio.gz

This is with multi_v7_defconfig with some debug options added. If necessary
I'll be happy to provide the exact configuration.

Guenter


