Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E7A790FB2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 03:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcydW-0005J4-Ua; Sun, 03 Sep 2023 21:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qcydU-0005Iv-D7
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 21:44:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qcydQ-0006OP-TY
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 21:44:16 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxRuhdNvVk1bMeAA--.9015S3;
 Mon, 04 Sep 2023 09:43:58 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNdNvVkI8NqAA--.19583S3; 
 Mon, 04 Sep 2023 09:43:57 +0800 (CST)
Subject: Re: [PATCH v3 16/16] tcg/loongarch64: Implement 128-bit load & store
To: qemu-devel@nongnu.org, yijun@loongson.cn
Cc: Jiajie Chen <c@jia.je>, git@xen0n.name,
 Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>
References: <20230902050415.1832700-1-c@jia.je>
 <20230902050415.1832700-17-c@jia.je>
 <fdd190b9-2d56-a888-d6b4-da9534a38339@linaro.org>
 <e6937197-b09f-4222-2a27-abdd2a2ec10d@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <623570ba-ca0b-8d46-a2dc-333e37bbfedd@loongson.cn>
Date: Mon, 4 Sep 2023 09:43:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e6937197-b09f-4222-2a27-abdd2a2ec10d@jia.je>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNdNvVkI8NqAA--.19583S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWUCrWDGFyrZw1UKrW5twc_yoW8Ary7pr
 WkJF4UtF98Jw4vyr1jvF1UJFy0yry5Ja1DXr18XFyUGrn8Jr1Igr48Xrn0gFyUJrWfJryU
 Aw1jqrnxurnxA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
 AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
 6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

Hi, yijun

在 2023/9/3 上午9:10, Jiajie Chen 写道:
> 
> On 2023/9/3 09:06, Richard Henderson wrote:
>> On 9/1/23 22:02, Jiajie Chen wrote:
>>> If LSX is available, use LSX instructions to implement 128-bit load &
>>> store.
>>
>> Is this really guaranteed to be an atomic 128-bit operation?
>>
> 
> Song Gao, please check this.
> 
> 
Could you explain this issue?  Thanks.

>> Or, as for many vector processors, is this really two separate 64-bit 
>> memory operations under the hood?
>>
>>
>>> +static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, 
>>> TCGReg data_hi,
>>> +                                   TCGReg addr_reg, MemOpIdx oi, 
>>> bool is_ld)
>>> +{
>>> +    TCGLabelQemuLdst *ldst;
>>> +    HostAddress h;
>>> +
>>> +    ldst = prepare_host_addr(s, &h, addr_reg, oi, true);
>>> +    if (is_ld) {
>>> +        tcg_out_opc_vldx(s, TCG_VEC_TMP0, h.base, h.index);
>>> +        tcg_out_opc_vpickve2gr_d(s, data_lo, TCG_VEC_TMP0, 0);
>>> +        tcg_out_opc_vpickve2gr_d(s, data_hi, TCG_VEC_TMP0, 1);
>>> +    } else {
>>> +        tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_lo, 0);
>>> +        tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_hi, 1);
>>> +        tcg_out_opc_vstx(s, TCG_VEC_TMP0, h.base, h.index);
>>> +    }
>>
>> You should use h.aa.atom < MO_128 to determine if 128-bit atomicity, 
>> and therefore the vector operation, is required.  I assume the gr<->vr 
>> moves have a cost and two integer operations are preferred when 
>> allowable.
>>
>> Compare the other implementations of this function.
>>
>>
>> r~


