Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E62A353F3
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Feb 2025 02:58:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiky5-0001K9-QE; Thu, 13 Feb 2025 20:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tiky3-0001K1-Ii
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:58:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tiky1-0004vP-2f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:58:11 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxaWooo65nP+10AA--.6755S3;
 Fri, 14 Feb 2025 09:58:01 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx_MQlo65nujgRAA--.64019S3;
 Fri, 14 Feb 2025 09:57:59 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add full type support for
 query-cpu-model-expansion
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20250213091626.3650603-1-maobibo@loongson.cn>
 <3a1f0744-4795-8f07-7258-0922745906ac@loongson.cn>
 <20250213175241.03bde8c1@imammedo.users.ipa.redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <347c5a1b-2346-eff0-2c8f-34fdfa8a4886@loongson.cn>
Date: Fri, 14 Feb 2025 09:57:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250213175241.03bde8c1@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MQlo65nujgRAA--.64019S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1UZF1DGryrXFy8CFW7GFX_yoW5Ww1kpr
 WxAF4jya97tF9rAa40y3WYqr1Fvr9rGrW2g3Z0gryUtFnIqF1fAF18ta909F98Z3yxXayY
 qw4Fk343Za17ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.157,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025/2/14 上午12:52, Igor Mammedov wrote:
> On Thu, 13 Feb 2025 17:40:56 +0800
> bibo mao <maobibo@loongson.cn> wrote:
> 
>> please discard this patch :(
>>
>> libvirt uses static type already on LoongArch platform, there is
>> compatibility issue. Static type cannot be removed, although I do
>> not know the difference between static type and full type.
> 
> looking at loongarch-qmp-cmds.c:qmp_query_cpu_model_expansion(),
> you do filter reported features by global cpu_model_advertised_features[] list.
> Also cpu 'definition' is mainly governed by its initfn() and
> properties mentioned in cpu_model_advertised_features[] are created
> only by loongarch_cpu_post_init() , which is part of la464 and max models.
> The later call however mutates depending on accelerator, which
> sort of contradicts 'static' description and feets more to 'full' category.
> 
> What I'd suggest doing is to support both
> i.e. do keep 'static' for compat reasons  and run the same code for 'full'
That is a good idea. will keep static type the same with full type for 
the present, and implement real static type iff all basic features are 
implemented and compatible machine requirement is added in future.

Regards
Bibo Mao
> 
> In nutshell drop if(type) check or explicitly allow both types.
> 
>>
>> Regards
>> Bibo Mao
>>
>> On 2025/2/13 下午5:16, Bibo Mao wrote:
>>> With full type for query-cpu-model-expansion qmp command, it shows that
>>> it is not supported. For instance,
>>>     query-cpu-model-expansion type=full model={"name":"max"}
>>>
>>> Here is is output,
>>>     {"error": {"class": "GenericError", "desc": "The requested expansion type is not supported"}}
>>>
>>> Since full type is not supported and only static type is supported, Here
>>> replace static type with full type for command query-cpu-model-expansion.
>>>
>>> And there is result with this patch,
>>>     {"return": {"model": {"name": "max", "props": {"lbt": true, "lasx": true, "pmu": true, "lsx": true}}}}
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>    target/loongarch/loongarch-qmp-cmds.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
>>> index 3fde5a5a20..429c6d35fd 100644
>>> --- a/target/loongarch/loongarch-qmp-cmds.c
>>> +++ b/target/loongarch/loongarch-qmp-cmds.c
>>> @@ -56,7 +56,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>>        const char *name;
>>>        int i;
>>>    
>>> -    if (type != CPU_MODEL_EXPANSION_TYPE_STATIC) {
> 
> 
>>> +    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
>>>            error_setg(errp, "The requested expansion type is not supported");
>>>            return NULL;
>>>        }
>>>
>>> base-commit: de278e54aefed143526174335f8286f7437d20be
>>>    
>>
>>


