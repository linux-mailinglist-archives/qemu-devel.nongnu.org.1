Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4C7DDABF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 02:50:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy0MP-0005yN-8Z; Tue, 31 Oct 2023 21:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qy0MM-0005y6-KP
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 21:49:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qy0MJ-0000ih-RF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 21:49:30 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxXeudrkFlDB02AA--.35462S3;
 Wed, 01 Nov 2023 09:49:18 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx7y+arkFl3L43AA--.54451S3; 
 Wed, 01 Nov 2023 09:49:16 +0800 (CST)
Subject: Re: [PATCH v1 2/6] target/loongarch: Add set_vec_extctx to set
 LSX/LASX instructions extctx_flags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-3-gaosong@loongson.cn>
 <1c4c0856-337e-4c5e-b2af-6caf35060b0a@linaro.org>
 <24981f5e-3397-427e-a552-635887d581cd@loongson.cn>
 <c43b9404-fd99-4f8a-9e35-62f5a4e50b5b@linaro.org>
 <4f952bcc-61c9-b3b6-d858-00c64167c292@loongson.cn>
 <0d60c6d4-a785-4abd-a16a-279b50abf09d@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <19276c86-edbf-44a2-acfa-6bcbceb96edf@loongson.cn>
Date: Wed, 1 Nov 2023 09:49:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0d60c6d4-a785-4abd-a16a-279b50abf09d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx7y+arkFl3L43AA--.54451S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
 BjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
 xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
 j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
 AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
 67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
 ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
 87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
 AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.053,
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

在 2023/10/31 下午10:50, Richard Henderson 写道:
> On 10/30/23 23:16, gaosong wrote:
>>> Anyway, I think my previous suggestion is better:
>>>
>> Oh,  Could you  show more details?  I think I didn't get you point.
>>
>>>>> If you want to track what the program is using, you should do it 
>>>>> exactly like the real kernel: disable the execution unit, have the 
>>>>> program trap, and the enable the execution unit when the trap 
>>>>> occurs. At this point, CSR_EUEN enable bits contain 
>
> Untested, but something like this.
>
>
Got it .   Thank you very much.

Thanks.
Song Gao
> r~
>


