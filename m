Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5128107A9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 02:32:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDE5U-0002w0-4W; Tue, 12 Dec 2023 20:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rDE5S-0002vp-6R
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 20:30:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rDE5P-0006c6-SL
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 20:30:57 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax2uhICXllG4cAAA--.3261S3;
 Wed, 13 Dec 2023 09:30:48 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx3+FECXll4poBAA--.11180S3; 
 Wed, 13 Dec 2023 09:30:44 +0800 (CST)
From: gaosong <gaosong@loongson.cn>
Subject: Re: [risu PATCH 5/5] loongarch: Add block 'clean' and
 clean_lsx_result()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
References: <20231025092915.902814-1-gaosong@loongson.cn>
 <20231025092915.902814-6-gaosong@loongson.cn>
 <CAFEAcA8c27SyPOt80zakmAX9tXnyQoxGaA+VDm5j56Z3uOimKA@mail.gmail.com>
Message-ID: <29c635bb-f1d5-cafc-9935-d0602c24ebb7@loongson.cn>
Date: Wed, 13 Dec 2023 09:30:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c27SyPOt80zakmAX9tXnyQoxGaA+VDm5j56Z3uOimKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx3+FECXll4poBAA--.11180S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WrWxGFy7tr1DXF13ZFy5GFX_yoWxCr1fpr
 4vqa43CF4ktr9rtw40qr15tr1fK3sakFy7ZFWjq3sF9rs8XF1vqr1DKrWxCry2qrW09ry8
 XFyrG34SvFy5JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.535,
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

在 2023/12/12 下午8:39, Peter Maydell 写道:
> On Wed, 25 Oct 2023 at 10:29, Song Gao<gaosong@loongson.cn>  wrote:
>> The result of the LSX instruction is in the low 128 bits
>> of the vreg register. We use clean_lsx_result() to clean up
>> the high 128 bits of the vreg register.
>>
>> Signed-off-by: Song Gao<gaosong@loongson.cn>
>> ---
>>   loongarch64.risu       | 2121 ++++++++++++++++++++++++++--------------
>>   risugen                |    2 +-
>>   risugen_loongarch64.pm |   20 +
>>   3 files changed, 1405 insertions(+), 738 deletions(-)
>>
>> diff --git a/loongarch64.risu b/loongarch64.risu
>> index 596de90..531470d 100644
>> --- a/loongarch64.risu
>> +++ b/loongarch64.risu
>> @@ -64,26 +64,26 @@ mulw_d_wu LA64 0000 00000001 11111 rk:5 rj:5 rd:5 \
>>   #div.{w[u]/d[u]} rd,rj,rk
>>   # div.w{u}, mod.w[u]  rk, rj, need in [0x0 ~0x7FFFFFFF]
>>   # use function set_reg_w($reg)
>> -div_w LA64 0000 00000010 00000 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> -    !memory { set_reg_w($rj); set_reg_w($rk); }
>> -div_wu LA64 0000 00000010 00010 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> -    !memory { set_reg_w($rj); set_reg_w($rk); }
>> -div_d LA64 0000 00000010 00100 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> -div_du LA64 0000 00000010 00110 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> -mod_w LA64 0000 00000010 00001 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> -    !memory { set_reg_w($rj); set_reg_w($rk); }
>> -mod_wu LA64 0000 00000010 00011 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> -    !memory { set_reg_w($rj); set_reg_w($rk); }
>> -mod_d LA64 0000 00000010 00101 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> -mod_du LA64 0000 00000010 00111 rk:5 rj:5 rd:5 \
>> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> +#div_w LA64 0000 00000010 00000 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
>> +#div_wu LA64 0000 00000010 00010 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
>> +#div_d LA64 0000 00000010 00100 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> +#div_du LA64 0000 00000010 00110 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> +#mod_w LA64 0000 00000010 00001 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
>> +#mod_wu LA64 0000 00000010 00011 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
>> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
>> +#mod_d LA64 0000 00000010 00101 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> +#mod_du LA64 0000 00000010 00111 rk:5 rj:5 rd:5 \
>> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> Why do we comment out all these patterns ? The commit
> message doesn't say anything about this.
>
I will drop them.

These instructions, test need patch[1],  but the patch is't merged.
[1] : 
https://lore.kernel.org/all/3c401d0f-a34f-bd29-03a3-dddfae94ce0a@loongson.cn/#r

>>   alsl_w LA64 0000 00000000 010 sa2:2 rk:5 rj:5 rd:5 \
>>       !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
>> @@ -615,665 +615,1248 @@ fstx_d LA64 0011 10000011 11000 rk:5 rj:5 fd:5 \
>>   # LSX instructions
>>   #
>>
>> -vadd_b LSX 0111 00000000 10100 vk:5 vj:5 vd:5
>> -vadd_h LSX 0111 00000000 10101 vk:5 vj:5 vd:5
>> +vadd_b LSX 0111 00000000 10100 vk:5 vj:5 vd:5 \
>> +    !clean { clean_lsx_result($vd); }
>> +vadd_h LSX 0111 00000000 10101 vk:5 vj:5 vd:5 \
>> +    !clean { clean_lsx_result($vd); }
> If there are patterns that need the clean_lsx_result
> handling, then add the support for that first, rather
> than adding a broken pattern and then editing it to
> add the extra block to every pattern, please.
Got it.
>> diff --git a/risugen b/risugen
>> index fa94a39..8a67fdf 100755
>> --- a/risugen
>> +++ b/risugen
>> @@ -43,7 +43,7 @@ my @pattern_re = ();            # include pattern
>>   my @not_pattern_re = ();        # exclude pattern
>>
>>   # Valid block names (keys in blocks hash)
>> -my %valid_blockname = ( constraints => 1, memory => 1, safefloat =>1 );
>> +my %valid_blockname = ( constraints => 1, memory => 1, safefloat =>1, clean => 1 );
>>
>>   sub parse_risu_directive($$@)
>>   {
>> diff --git a/risugen_loongarch64.pm b/risugen_loongarch64.pm
>> index b3f901d..97f00f3 100644
>> --- a/risugen_loongarch64.pm
>> +++ b/risugen_loongarch64.pm
>> @@ -81,6 +81,18 @@ sub nanbox_s($)
>>       return $fpreg;
>>   }
>>
>> +sub clean_lsx_result($)
>> +{
>> +    my ($vreg) = @_;
>> +
>> +    # xvinsgr2vr.d vd, r0, 2;
>> +    insn32(0x76ebe000 | 2 << 10 | $vreg);
>> +    # xvinsgr2vr.d vd, r0, 3;
>> +    insn32(0x76ebe000 | 3 << 10 | $vreg);
>> +
>> +    return $vreg;
>> +}
>> +
>>   sub align($)
>>   {
>>       my ($a) = @_;
>> @@ -405,6 +417,7 @@ sub gen_one_insn($$)
>>           my $constraint = $rec->{blocks}{"constraints"};
>>           my $memblock = $rec->{blocks}{"memory"};
>>           my $safefloat = $rec->{blocks}{"safefloat"};
>> +        my $clean = $rec->{blocks}{"clean"};
>>
>>           $insn &= ~$fixedbitmask;
>>           $insn |= $fixedbits;
>> @@ -448,6 +461,13 @@ sub gen_one_insn($$)
>>               $resultreg = eval_with_fields($insnname, $insn, $rec, "safefloat", $safefloat);
>>           }
>>
>> +        if (defined $clean) {
>> +            # LSX insns only care about low 128 bit,
>> +            # so we use clean_lsx_result() make sure that high 128bit is 0x0;
>> +            my $cleanreg;
>> +            $cleanreg = eval_with_fields($insnname, $insn, $rec, "clean", $clean);
>> +        }
>> +
>>           if (defined $memblock) {
>>               # Clean up following a memory access instruction:
>>               # we need to turn the (possibly written-back) basereg
>> --
> The handling here is exactly identical to the existing "safefloat"
> block, and 'safefloat' does nothing floating point specific and
> the new 'clean' block does nothing LSX specific. I think we would
> do better to have a single block type for "do anything you need to
> do to clean up after the insn", and use it for both the patterns
> that need to tidy up a float register and those that need to do
> this new LSX related tidying.
>
> Open to suggestions for better naming, but my suggestion is that
> we call this block type "!post" (because it is the hook for
> doing things after emitting the instruction). In future if
> we ever needed it we could add a "!pre".
>
> That is:
>   * rename "!safefloat" to "!post"
>   * add the clean_lsx_result() function before adding the LSX
>     etc patterns, so we don't need to add the patterns and then
>     change them later to add a "!post" block
>
> thanks
> -- PMM
Thanks for your suggestions and review!
I'll send v2 soon,

Thanks.
Song Gao.


