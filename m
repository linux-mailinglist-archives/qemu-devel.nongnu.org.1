Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0515721168
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 19:48:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5VKh-0003Ac-TW; Sat, 03 Jun 2023 13:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q5VKd-0003AR-Qd
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 13:46:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q5VKb-0007mz-L4
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 13:46:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC05AA7E3;
 Sat,  3 Jun 2023 20:46:06 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 65896937A;
 Sat,  3 Jun 2023 20:46:05 +0300 (MSK)
Message-ID: <a77c864f-f571-b0a8-3c7f-dadbbf8c8185@tls.msk.ru>
Date: Sat, 3 Jun 2023 20:46:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 31/35] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230502121459.2422303-1-peter.maydell@linaro.org>
 <20230502121459.2422303-32-peter.maydell@linaro.org>
 <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

03.06.2023 18:03, Guenter Roeck wrote:
> Hi,
> 
> On Tue, May 02, 2023 at 01:14:55PM +0100, Peter Maydell wrote:
>> The Allwinner PIC model uses set_bit() and clear_bit() to update the
>> values in its irq_pending[] array when an interrupt arrives.  However
>> it is using these functions wrongly: they work on an array of type
>> 'long', and it is passing an array of type 'uint32_t'.  Because the
>> code manually figures out the right array element, this works on
>> little-endian hosts and on 32-bit big-endian hosts, where bits 0..31
>> in a 'long' are in the same place as they are in a 'uint32_t'.
>> However it breaks on 64-bit big-endian hosts.
>>
>> Remove the use of set_bit() and clear_bit() in favour of using
>> deposit32() on the array element.  This fixes a bug where on
>> big-endian 64-bit hosts the guest kernel would hang early on in
>> bootup.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-id: 20230424152833.1334136-1-peter.maydell@linaro.org
> 
> In v8.0.2, the cubieboard emulation running Linux crashes during reboot
> with a hung task error. Tested with mainline Linux (v6.4-rc4-78-g929ed21dfdb6)
> and with v5.15.114. Host is AMD Ryzen 5900X.
> 
> Requesting system reboot
> [   61.927460] INFO: task kworker/0:1:13 blocked for more than 30 seconds.
> [   61.927896]       Not tainted 5.15.115-rc2-00038-g31e35d9f1b8d #1
> [   61.928144] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   61.928419] task:kworker/0:1     state:D stack:    0 pid:   13 ppid:     2 flags:0x00000000
> [   61.928972] Workqueue: events_freezable mmc_rescan
> [   61.929739] [<c13734f0>] (__schedule) from [<c1373c98>] (schedule+0x80/0x15c)
> [   61.930041] [<c1373c98>] (schedule) from [<c137ad64>] (schedule_timeout+0xd4/0x12c)
> [   61.930270] [<c137ad64>] (schedule_timeout) from [<c137477c>] (do_wait_for_common+0xa0/0x154)
> [   61.930523] [<c137477c>] (do_wait_for_common) from [<c1374870>] (wait_for_completion+0x40/0x4c)
> [   61.930764] [<c1374870>] (wait_for_completion) from [<c1044cd0>] (mmc_wait_for_req_done+0x6c/0x90)
> [   61.931012] [<c1044cd0>] (mmc_wait_for_req_done) from [<c1044e34>] (mmc_wait_for_cmd+0x70/0xa8)
> [   61.931252] [<c1044e34>] (mmc_wait_for_cmd) from [<c10512a0>] (sdio_reset+0x58/0x124)
> [   61.931478] [<c10512a0>] (sdio_reset) from [<c1046328>] (mmc_rescan+0x294/0x30c)
> [   61.931692] [<c1046328>] (mmc_rescan) from [<c036be10>] (process_one_work+0x28c/0x720)
> [   61.931924] [<c036be10>] (process_one_work) from [<c036c308>] (worker_thread+0x64/0x53c)
> [   61.932153] [<c036c308>] (worker_thread) from [<c03753e0>] (kthread+0x15c/0x180)
> [   61.932365] [<c03753e0>] (kthread) from [<c030015c>] (ret_from_fork+0x14/0x38)
> [   61.932628] Exception stack(0xc31ddfb0 to 0xc31ddff8)
> 
> This was not seen with v8.0.0. Bisect points to this patch. Reverting it
> fixes the problem.

Does this happen on master too, or just on stable-8.0 ?

Thanks,

/mjt

