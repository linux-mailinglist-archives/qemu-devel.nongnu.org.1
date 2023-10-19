Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC07CEE6D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 05:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtJhK-00050c-S3; Wed, 18 Oct 2023 23:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qtJhB-00050P-Nv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:27:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qtJh8-0003p0-L6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:27:37 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxueoZojBlvhMzAA--.23486S3;
 Thu, 19 Oct 2023 11:27:22 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxiuQXojBlWToqAA--.25300S3; 
 Thu, 19 Oct 2023 11:27:21 +0800 (CST)
Subject: Re: [PATCH v1 2/3] target/loongarch: Allow user enable/disable
 LSX/LASX features
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 armbru@redhat.com, maobibo@loongson.cn
References: <20231018085908.3327130-1-gaosong@loongson.cn>
 <20231018085908.3327130-3-gaosong@loongson.cn>
 <88eb5431-9183-4619-8049-2910544f6b68@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <012c5dbb-a70f-f46a-4ab5-8284e2a7fc50@loongson.cn>
Date: Thu, 19 Oct 2023 11:27:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <88eb5431-9183-4619-8049-2910544f6b68@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxiuQXojBlWToqAA--.25300S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1xKF4UXrWDZr4xZF4xAFc_yoW8Xw48p3
 4rGrZakFyqgrn5K3WkAw18Gw1IvF4fJ3ZFyw1ruay8Ca15u342gr1v9F1vga4Uuwn7uw1Y
 qF1DJ343Zr1UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
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

在 2023/10/19 上午7:47, Richard Henderson 写道:
> On 10/18/23 01:59, Song Gao wrote:
>> Some users may not need LSX/LASX, this patch allows the user
>> enable/disable LSX/LASX features.
>>
>>   e.g
>>   '-cpu max,lsx=on,lasx=on'   (default);
>>   '-cpu max,lsx=on,lasx=off'  (enabled LSX);
>>   '-cpu max,lsx=off,lasx=on'  (error, need lsx=on);
>>   '-cpu max,lsx=off'          (disable LSX and LASX).
>
> ...
>
>> +    /* CPU has LSX */
>> +    bool has_lsx;
>> +    /* CPU has  LASX */
>> +    bool has_lasx;
>
> Why do you need these variables?
>
> I suspect that you've copied them from one of the more complex Arm 
> cases where we need to resolve multiple properties simultaneously 
> during realize.
>
> You'll get identical behaviour in your current code if you drop these 
> and rely only on the CPUCFG2 bits.
>
> If you wanted to do something more complex, you could use OnOffAuto, 
> so that you can detect conflicting settings (such as #3 above), but 
> not generate an error for
>
>   -cpu foo,lasx=on
>
Got it, thanks for you suggestion.
> where 'foo' is some cpu model which does *no* default lsx=on.  You 
> would see that has_lsx==AUTO && has_lasx==ON and then set lsx=ON.
>
Some cpu model not support lasx or lsx feature,  we should't allow user 
set lsx=on or lasx=on.

I think we need env->features. set the feature when the cpu model 
support this feature.
If the cpu model support the feature,  we allow user set CPUCFG to 
enable/disable this feature.

Do you have more suggestion?

Thanks.
Song Gao


