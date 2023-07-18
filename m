Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8A757548
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 09:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLf5V-0000rw-JC; Tue, 18 Jul 2023 03:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qLf5S-0000ra-Vg
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 03:25:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qLf5P-0002FY-Mu
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 03:25:34 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8DxxPBgPrZkH4gGAA--.17386S3;
 Tue, 18 Jul 2023 15:25:20 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvM5fPrZkJ9kyAA--.9522S3; 
 Tue, 18 Jul 2023 15:25:20 +0800 (CST)
Subject: Re: [PATCH 0/6] linux-user: brk() syscall fixes and armhf static
 binary fix
To: Helge Deller <deller@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230717213545.142598-1-deller@gmx.de>
 <703ab494-1778-c50a-d46f-988fab846da3@loongson.cn>
 <bde51a26-4572-67bd-d9e0-58826db9d5fb@gmx.de>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <610c77cf-33f4-41d9-7fa1-fe8b9c091912@loongson.cn>
Date: Tue, 18 Jul 2023 15:25:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bde51a26-4572-67bd-d9e0-58826db9d5fb@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxvM5fPrZkJ9kyAA--.9522S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4xGr48ZFyUKw1kGr1xZwc_yoW8tFW3pr
 93JFZxAr18Jrs3G3ySq3WkA3WFqF18Jw45Gr1fX340vFZavr15uw4UGw15GF9xJr40kF1j
 qFW5t3srGr98Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.097,
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



在 2023/7/18 下午1:42, Helge Deller 写道:
> On 7/18/23 05:03, Song Gao wrote:
>> Hi,  Helge
>>
>> Could you see the following bugs:
>> https://gitlab.com/qemu-project/qemu/-/issues/1707
>>
>> This issue is also caused by  the commit  86f04735ac.
>
> I don't have access to such a box (and on an arm64 debian porterbox
> I get unmet build dependencies, e.g. for gcc-powerpc64-linux-gnu).
>
> If you can provide me with access to a machine I can test,
> otherwise you may simply check out:
>   git pull https://github.com/hdeller/qemu-hppa.git linux-user-brk-fixes
> and test yourself.
>
Thank you.
I update code to the lastet,   it's no problem.

Thanks.
Song Gao
> Helge
>>
>> Thanks.
>> Song Gao
>>
>>
>> 在 2023/7/18 上午5:35, Helge Deller 写道:
>>> Commit 86f04735ac ("linux-user: Fix brk() to release pages") 
>>> introduced the
>>> possibility for userspace applications to reduce memory footprint by 
>>> calling
>>> brk() with a lower address and free up memory.
>>> This change introduced some failures for applications with errors like
>>> - accesing bytes above the brk heap address on the same page,
>>> - freeing memory below the initial brk address,
>>> and introduced a behaviour which isn't done by the kernel (e.g. zeroing
>>> memory above brk).
>>>
>>> This patch set fixes those issues and have been tested with existing
>>> programs (e.g. upx).
>>>
>>> Additionally it includes one patch to allow running static armhf 
>>> executables
>>> (e.g. fstype) which was broken since qemu-8.0.
>>>
>>> Helge
>>>
>>> Helge Deller (6):
>>>    Revert "linux-user: Make sure initial brk(0) is page-aligned"
>>>    linux-user: Fix qemu brk() to not zero bytes on current page
>>>    linux-user: Prohibit brk() to to shrink below initial heap address
>>>    linux-user: Fix signed math overflow in brk() syscall
>>>    linux-user: Fix strace output for old_mmap
>>>    linux-user: Fix qemu-arm to run static armhf binaries
>>>
>>>   linux-user/elfload.c |  7 +++++++
>>>   linux-user/strace.c  | 49 
>>> ++++++++++++++++++++++++++++++++++++++++----
>>>   linux-user/syscall.c | 25 +++++++++++++---------
>>>   3 files changed, 67 insertions(+), 14 deletions(-)
>>>
>>> -- 
>>> 2.41.0
>>>
>>


