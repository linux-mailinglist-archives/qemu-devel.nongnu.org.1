Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3988CF258
	for <lists+qemu-devel@lfdr.de>; Sun, 26 May 2024 02:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sB1uY-0003vV-J8; Sat, 25 May 2024 20:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sB1uW-0003uv-Dz; Sat, 25 May 2024 20:38:52 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sB1uT-0005My-Ek; Sat, 25 May 2024 20:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716683923; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=8fTXhcVxrfpa1PLWX0Fuv82F+ZKmRjbkrehuOijZaks=;
 b=ObtkmR4HRJZQ1xjwqCrac8zuQPWpA7/1IxQrLjooLzz2/5YaL5vWBQRAhvy+i1vz/XyXti9vrAgNSGO8uVDEeFmANSN3HefMNaytkTbALIU9GjuF3OxbFOokPlWaF95MHIdYG2VKDospl4HJ2whJDKdaYytyyPGPldA0Pwwen0E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0W7AKT5X_1716683920; 
Received: from 192.168.3.95(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W7AKT5X_1716683920) by smtp.aliyun-inc.com;
 Sun, 26 May 2024 08:38:41 +0800
Message-ID: <fed99165-58da-458c-b68f-a9717fc15034@linux.alibaba.com>
Date: Sun, 26 May 2024 08:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/riscv: Support Zabha extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <8cc80b22-d159-4c8a-8860-30d229bae8d6@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <8cc80b22-d159-4c8a-8860-30d229bae8d6@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/24 19:44, Daniel Henrique Barboza wrote:
> Hi Zhiwei!
>
>
>
> On 5/23/24 09:40, LIU Zhiwei wrote:
>> Zabha adds support AMO operations for byte and half word. If zacas 
>> has been implemented,
>> zabha also adds support amocas.b and amocas.h.
>>
>> More details is on the specification here:
>> https://github.com/riscv/riscv-zabha
>>
>> The implemenation of zabha follows the way of AMOs and zacas.
>>
>> This patch set is based on these two patch set:
>> 1. https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00207.html
>> 2. https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00212.html
>
> These 2 series doesn't seem to apply on top of each other, doesn't 
> matter which
> order I try. Applying zimop/zcmop first, then zama16b:
>
> $ git am \[PATCH\ 1_1\]\ target_riscv\:\ Support\ Zama16b\ extension\ 
> -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0613.eml
> Applying: target/riscv: Support Zama16b extension
> error: patch failed: target/riscv/cpu.c:1464
> error: target/riscv/cpu.c: patch does not apply
> Patch failed at 0001 target/riscv: Support Zama16b extension
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>
>
> Applying zama16b first, then zimop/zcmop:
>
> $ git am \[PATCH\ 1_1\]\ target_riscv\:\ Support\ Zama16b\ extension\ 
> -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0613.eml
> Applying: target/riscv: Support Zama16b extension
> $
> $ git am \[PATCH\ 1_4\]\ target_riscv\:\ Add\ zimop\ extension\ -\ 
> LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0329.eml 
> \[PATCH\ 2_4\]\ disas_riscv\:\ Support\ zimop\ disassemble\ -\ LIU\ 
> Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0329.eml
> Applying: target/riscv: Add zimop extension
> error: patch failed: target/riscv/cpu.c:1463
> error: target/riscv/cpu.c: patch does not apply
> Patch failed at 0001 target/riscv: Add zimop extension
>
>
> If the series are dependent on each other perhaps it's easier to send 
> everything
> in a single 11 patches series.

They don't have dependency on each other. But if we both rebase them to 
the master branch, they
couldn't be merged at the time, as them both modify cpu.h and cpu.c in 
the same place.


I will send them as a whole patch set(RVA23 patch set) after I fix other 
issues on implementing the RVA23 profile.

Thanks,

Zhiwei

>
>
> Thanks,
>
> Daniel
>
>>
>>
>> LIU Zhiwei (6):
>>    target/riscv: Move gen_amo before implement Zabha
>>    target/riscv: Add AMO instructions for Zabha
>>    target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
>>    target/riscv: Add amocas.[b|h] for Zabha
>>    target/riscv: Enable zabha for max cpu
>>    disas/riscv: Support zabha disassemble
>>
>>   disas/riscv.c                               |  60 ++++++++
>>   target/riscv/cpu.c                          |   2 +
>>   target/riscv/cpu_cfg.h                      |   1 +
>>   target/riscv/insn32.decode                  |  22 +++
>>   target/riscv/insn_trans/trans_rva.c.inc     |  21 ---
>>   target/riscv/insn_trans/trans_rvzabha.c.inc | 145 ++++++++++++++++++++
>>   target/riscv/insn_trans/trans_rvzacas.c.inc |  13 --
>>   target/riscv/translate.c                    |  36 +++++
>>   8 files changed, 266 insertions(+), 34 deletions(-)
>>   create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
>>

