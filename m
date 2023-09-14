Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2397A04C5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglyL-0007sp-CK; Thu, 14 Sep 2023 09:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qglxf-0007fi-FY
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:01:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qglxc-0005Hp-3P
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:00:47 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dxg_DxAwNlOHInAA--.11205S3;
 Thu, 14 Sep 2023 21:00:33 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx+y7wAwNlSAAFAA--.191S2; 
 Thu, 14 Sep 2023 21:00:33 +0800 (CST)
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
Date: Thu, 14 Sep 2023 21:00:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx+y7wAwNlSAAFAA--.191S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWxtr43WFy8ZrWrAr1rKrX_yoW8CFWDpa
 s5Zr13Kr48Jr1xGw4UJan8Jr1UKr48A3W5Jr1xAr1jkr1Uuw1rZF1UuryDt3Z8Jr4rtr47
 Ar1DXr4jyr1DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi David:

> On 12.09.23 04:11, xianglai li wrote:
>> Introduce new function to destroy CPU address space resources
>> for cpu hot-(un)plug.
>>
> How do other archs handle that? Or how are they able to get away 
> without destroying?
>
They do not remove the cpu address space, taking the X86 architecture as 
an example:

1.Start the x86 VM:

./qemu-system-x86_64 \
-machine q35  \
-cpu Broadwell-IBRS \
-smp 1,maxcpus=100,sockets=100,cores=1,threads=1 \
-m 4G \
-drive file=~/anolis-8.8.qcow2  \
-serial stdio   \
-monitor telnet:localhost:4498,server,nowait   \
-nographic

2.Connect the qemu monitor

telnet 127.0.0.1 4498

info mtree

address-space: cpu-memory-0
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g 
@pc.ram 0000000000000000-000000007fffffff
     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
       00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem

3.Perform cpu hot swap int qemu monitor

device_add 
Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1
device_del cpu1

info mtree

address-space: cpu-memory-0
address-space: cpu-memory-1
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g 
@pc.ram 0000000000000000-000000007fffffff
     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
       00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem


 From the above test, you can see whether the address space of cpu1 is 
residual after a cpu hot swap, and whether it is reasonable?

The address space destruction function of the CPU can be used to delete 
the residual address space of the CPU1.

Thanks,

xianglai.





