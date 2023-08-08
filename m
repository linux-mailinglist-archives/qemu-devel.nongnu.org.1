Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F196D77397C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 11:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTJRN-0008I3-8T; Tue, 08 Aug 2023 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTJRI-0008Hq-L1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:55:44 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTJRG-0004N0-4p
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:55:43 -0400
Received: from [172.20.10.3] (unknown [112.97.82.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 5B39E43E5D;
 Tue,  8 Aug 2023 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691488540; bh=swPJTA2Zi4UDX41kPOjk91cONdSHzPkMWjBUYosVBjw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=H79Bagu0MULQF2dFuhoGPZUfzPv4WukboeC1nIb9iE3ywf4T3YI+j4wakdtfvRqaT
 M/9/ltzVZC1i+K+nkuPIajAKvEjIltcfEWo0tcUYcuukBC3mhRHeM0pzI1nERsC49v
 X8w3pa8ymQAHFU2jCO5G+/jqXjfqc3vFtBrKB4m4=
Message-ID: <df8ba12d-684b-b379-6991-8e958b8bc311@jia.je>
Date: Tue, 8 Aug 2023 17:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/loongarch: Split fcc register to fcc0-7 in gdbstub
Content-Language: en-US
To: bibo mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230808054315.3391465-1-c@jia.je>
 <70c07fd1-51c6-56cd-af40-04a8323b06c5@loongson.cn>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <70c07fd1-51c6-56cd-af40-04a8323b06c5@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/8 14:10, bibo mao wrote:
> I am not familiar with gdb, is there  abi breakage?
> I do not know how gdb client works with gdb server with different versions.

Not abi breakage, but gdb will complain:

warning: while parsing target description (at line 1): Target 
description specified unknown architecture "loongarch64"
warning: Could not load XML target description; ignoring
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
Truncated register 38 in remote 'g' packet

And gdb can no longer debug kernel running in qemu. You can reproduce 
this error using latest qemu(without this patch) and gdb(13.1 or later).

>
> Regards
> Bibo Mao
>
>
> 在 2023/8/8 13:42, Jiajie Chen 写道:
>> Since GDB 13.1(GDB commit ea3352172), GDB LoongArch changed to use
>> fcc0-7 instead of fcc register. This commit partially reverts commit
>> 2f149c759 (`target/loongarch: Update gdb_set_fpu() and gdb_get_fpu()`)
>> to match the behavior of GDB.
>>
>> Note that it is a breaking change for GDB 13.0 or earlier, but it is
>> also required for GDB 13.1 or later to work.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   gdb-xml/loongarch-fpu.xml  |  9 ++++++++-
>>   target/loongarch/gdbstub.c | 16 +++++++---------
>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/gdb-xml/loongarch-fpu.xml b/gdb-xml/loongarch-fpu.xml
>> index 78e42cf5dd..e81e3382e7 100644
>> --- a/gdb-xml/loongarch-fpu.xml
>> +++ b/gdb-xml/loongarch-fpu.xml
>> @@ -45,6 +45,13 @@
>>     <reg name="f29" bitsize="64" type="fputype" group="float"/>
>>     <reg name="f30" bitsize="64" type="fputype" group="float"/>
>>     <reg name="f31" bitsize="64" type="fputype" group="float"/>
>> -  <reg name="fcc" bitsize="64" type="uint64" group="float"/>
>> +  <reg name="fcc0" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc1" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc2" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc3" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc4" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc5" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc6" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc7" bitsize="8" type="uint8" group="float"/>
>>     <reg name="fcsr" bitsize="32" type="uint32" group="float"/>
>>   </feature>
>> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
>> index 0752fff924..15ad6778f1 100644
>> --- a/target/loongarch/gdbstub.c
>> +++ b/target/loongarch/gdbstub.c
>> @@ -70,10 +70,9 @@ static int loongarch_gdb_get_fpu(CPULoongArchState *env,
>>   {
>>       if (0 <= n && n < 32) {
>>           return gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(0));
>> -    } else if (n == 32) {
>> -        uint64_t val = read_fcc(env);
>> -        return gdb_get_reg64(mem_buf, val);
>> -    } else if (n == 33) {
>> +    } else if (32 <= n && n < 40) {
>> +        return gdb_get_reg8(mem_buf, env->cf[n - 32]);
>> +    } else if (n == 40) {
>>           return gdb_get_reg32(mem_buf, env->fcsr0);
>>       }
>>       return 0;
>> @@ -87,11 +86,10 @@ static int loongarch_gdb_set_fpu(CPULoongArchState *env,
>>       if (0 <= n && n < 32) {
>>           env->fpr[n].vreg.D(0) = ldq_p(mem_buf);
>>           length = 8;
>> -    } else if (n == 32) {
>> -        uint64_t val = ldq_p(mem_buf);
>> -        write_fcc(env, val);
>> -        length = 8;
>> -    } else if (n == 33) {
>> +    } else if (32 <= n && n < 40) {
>> +        env->cf[n - 32] = ldub_p(mem_buf);
>> +        length = 1;
>> +    } else if (n == 40) {
>>           env->fcsr0 = ldl_p(mem_buf);
>>           length = 4;
>>       }

