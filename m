Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2A70C0F8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q16Sh-0003qQ-28; Mon, 22 May 2023 10:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q16Sc-0003qB-94; Mon, 22 May 2023 10:24:31 -0400
Received: from smtp80.cstnet.cn ([159.226.251.80] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q16SZ-0003TV-FL; Mon, 22 May 2023 10:24:30 -0400
Received: from [192.168.0.120] (unknown [61.165.33.195])
 by APP-01 (Coremail) with SMTP id qwCowACnrpoPe2tk7FZ1Aw--.18817S2;
 Mon, 22 May 2023 22:24:16 +0800 (CST)
Message-ID: <427643e4-7115-675b-c8ed-deb683611d79@iscas.ac.cn>
Date: Mon, 22 May 2023 22:24:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: liweiwei@iscas.ac.cn, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Subject: Re: [PATCH 3/7] disas/riscv.c: Support disas for Zcm* extensions
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20230519021926.15362-1-liweiwei@iscas.ac.cn>
 <20230519021926.15362-4-liweiwei@iscas.ac.cn>
 <ed91c669-a2b1-116a-669e-78f469f7c9fc@ventanamicro.com>
From: Weiwei Li <liweiwei@iscas.ac.cn>
In-Reply-To: <ed91c669-a2b1-116a-669e-78f469f7c9fc@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnrpoPe2tk7FZ1Aw--.18817S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1UArW5tr1rAw4xJFyxZrb_yoWruFWUpr
 18Jr1UJryUJr18Jr1UJr1UJryUJr1UJw1UJr1UJF1UJr1UJr1jqr1UXr1jgr1UJr48Jr1U
 Jr1UJr1UZr1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
 c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
 x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
 0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXiSdUUUUU=
X-Originating-IP: [61.165.33.195]
X-CM-SenderInfo: 5olzvxxzhlqxpvfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.80; envelope-from=liweiwei@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 2023/5/22 21:00, Daniel Henrique Barboza wrote:
>
>
> On 5/18/23 23:19, Weiwei Li wrote:
>> Support disas for Zcmt* instructions only when related extensions
>> are supported.
>>
>> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
>> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
>> ---
>>   disas/riscv.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/disas/riscv.c b/disas/riscv.c
>> index 729ab684da..9e01810eef 100644
>> --- a/disas/riscv.c
>> +++ b/disas/riscv.c
>> @@ -2501,7 +2501,7 @@ static void decode_inst_opcode(rv_decode *dec, 
>> rv_isa isa)
>>                   op = rv_op_c_sqsp;
>>               } else {
>>                   op = rv_op_c_fsdsp;
>> -                if (((inst >> 12) & 0b01)) {
>> +                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
>>                       switch ((inst >> 8) & 0b01111) {
>>                       case 8:
>>                           if (((inst >> 4) & 0b01111) >= 4) {
>> @@ -2527,16 +2527,20 @@ static void decode_inst_opcode(rv_decode 
>> *dec, rv_isa isa)
>>                   } else {
>>                       switch ((inst >> 10) & 0b011) {
>>                       case 0:
>> -                        if (((inst >> 2) & 0xFF) >= 32) {
>> -                            op = rv_op_cm_jalt;
>> -                        } else {
>> -                            op = rv_op_cm_jt;
>> +                        if (dec->cfg->ext_zcmt) {
>> +                            if (((inst >> 2) & 0xFF) >= 32) {
>> +                                op = rv_op_cm_jalt;
>> +                            } else {
>> +                                op = rv_op_cm_jt;
>> +                            }
>
> In this code, since you're not doing anything if dec->cfg->ext_zcmt is 
> not set,
> you could also break earlier and avoid changing the other lines:
>
>
>>                       case 0:
>> +                     if (!dec->cfg->ext_zcmt) {
>> +                         break;
>> +                     }
>>                       if (((inst >> 2) & 0xFF) >= 32) {
>>                           op = rv_op_cm_jalt;
>>                       } else {
>>                           op = rv_op_cm_jt;
>>                       }
>>                       break;
>
OK. It's acceptable to me. I'll update this in next version.

Regards,

Weiwei Li

> >                           }
>>                           break;
>>                       case 3:
>> -                        switch ((inst >> 5) & 0b011) {
>> -                        case 1: op = rv_op_cm_mvsa01; break;
>> -                        case 3: op = rv_op_cm_mva01s; break;
>> +                        if (dec->cfg->ext_zcmp) {
>> +                            switch ((inst >> 5) & 0b011) {
>> +                            case 1: op = rv_op_cm_mvsa01; break;
>> +                            case 3: op = rv_op_cm_mva01s; break;
>> +                            }
>
>
> Same thing here.
>
>
> These are minor stylistic comments.
>
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
>>                           }
>>                           break;
>>                       }


