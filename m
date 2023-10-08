Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B67BCBF3
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 05:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpKw8-0001md-2J; Sat, 07 Oct 2023 23:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qpKw5-0001mF-41
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 23:58:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qpKw1-0003FU-QY
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 23:58:32 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxtPDYKCJlw_MvAA--.27369S3;
 Sun, 08 Oct 2023 11:58:16 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axm+TVKCJlWpcaAA--.58310S3; 
 Sun, 08 Oct 2023 11:58:15 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: fix ASXE flag conflict
To: Richard Henderson <richard.henderson@linaro.org>, Jiajie Chen <c@jia.je>, 
 qemu-devel@nongnu.org
Cc: git@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230930112837.1871691-1-c@jia.je>
 <8c7e0e7f-9196-cc91-be1e-ce0b02fb4db9@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e55469ee-6879-ee4b-b7aa-095372cf7f75@loongson.cn>
Date: Sun, 8 Oct 2023 11:58:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8c7e0e7f-9196-cc91-be1e-ce0b02fb4db9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axm+TVKCJlWpcaAA--.58310S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw15Jr15trWfuw1kuFWrtFc_yoW8GrW3pa
 yxCFy5tFW0grZ7K397W3Z5WFn5Wr4fGw47Xw1fWFWvkFZ8JrnYqa40q390gF4Duay8ZryU
 ZF15Gw1rZF4DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.644,
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

在 2023/9/30 下午11:46, Richard Henderson 写道:
> On 9/30/23 04:28, Jiajie Chen wrote:
>> HW_FLAGS_EUEN_ASXE acccidentally conflicts with HW_FLAGS_CRMD_PG,
>> enabling LASX instructions even when CSR_EUEN.ASXE=0.
>>
>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1907 >> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   target/loongarch/cpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index f125a8e49b..79ad79a289 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -462,7 +462,7 @@ static inline void set_pc(CPULoongArchState *env, 
>> uint64_t value)
>>   #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
>>   #define HW_FLAGS_EUEN_FPE   0x04
>>   #define HW_FLAGS_EUEN_SXE   0x08
>> -#define HW_FLAGS_EUEN_ASXE  0x10
>> +#define HW_FLAGS_EUEN_ASXE  0x40
>>   #define HW_FLAGS_VA32       0x20
>>   static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, 
>> vaddr *pc,
> 
> Better to put all defines in bit order, otherwise it will be easy to 
> make the same mistake again.
>  > With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


