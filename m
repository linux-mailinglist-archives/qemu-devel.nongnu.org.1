Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7BA84AC32
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 03:30:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBD4-0008N7-Cl; Mon, 05 Feb 2024 21:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rXBD1-0008MJ-Pg; Mon, 05 Feb 2024 21:29:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1rXBCz-0003Vf-5S; Mon, 05 Feb 2024 21:29:15 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxbOlzmcFlfxILAA--.20913S3;
 Tue, 06 Feb 2024 10:29:07 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXs1xmcFlK6EwAA--.48618S3; 
 Tue, 06 Feb 2024 10:29:07 +0800 (CST)
Subject: Re: [PATCH] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205021318.3759925-1-maobibo@loongson.cn>
 <678324f1-2b8d-45a1-aea8-03c187f069d1@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <e0052a77-d6b1-fee9-a179-d7074132304f@loongson.cn>
Date: Tue, 6 Feb 2024 10:29:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <678324f1-2b8d-45a1-aea8-03c187f069d1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXs1xmcFlK6EwAA--.48618S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry8Cw48Jw17Xr48AF18Zwc_yoW8GF1rpr
 1kA3409ay8Gr1rJr1xGwn8WFyUAr4DJa4kCF18ZF18JFZ8GryjgrW0qr1jgw1kJFWfXF1U
 Zw1ktF1fu3W2qrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.543,
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

Hi Philippe,

On 2024/2/5 下午8:58, Philippe Mathieu-Daudé wrote:
> Hi Bibo,
> 
> On 5/2/24 03:13, Bibo Mao wrote:
>> The cdrom test skips to execute on LoongArch system with command
>> "make check", this patch enables cdrom test for LoongArch virt
>> machine platform.
>>
>> With this patch, cdrom test passes to run on LoongArch virt
>> machine type.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tests/qtest/cdrom-test.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>> index 0945383789..c8b97d8d9a 100644
>> --- a/tests/qtest/cdrom-test.c
>> +++ b/tests/qtest/cdrom-test.c
>> @@ -271,6 +271,9 @@ int main(int argc, char **argv)
>>               const char *virtmachine[] = { "virt", NULL };
>>               add_cdrom_param_tests(virtmachine);
>>           }
>> +    } else if (g_str_equal(arch, "loongarch64")) {
>> +        const char *virtmachine[] = { "virt", NULL };
>> +        add_cdrom_param_tests(virtmachine);
> 
> What is the default device used, virtio-blk-pci?
> 
yes, it is. For virt machine type, the default type for block device is
virtio interface, and it is defined at function loongarch_class_init().
    mc->block_default_type = IF_VIRTIO

Regards
Bibo Mao


