Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291DD717BEE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4I8E-0005Yl-HO; Wed, 31 May 2023 05:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q4I8C-0005YX-KO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:28:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q4I8B-0006ul-2H
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:28:36 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-397f3aec11aso519181b6e.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685525313; x=1688117313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ycEeIxRqgkRIW4MGkFCnucdnGd5u7XIlHGBP7fmPjk=;
 b=cX76OKLXwm6KUuSwL3oJhQDYjX/+9IxV/Yol++e0jPYLNzpb0NtOM6K0eMPnCaZwLy
 KGJUZ9gx9IOrcN0h35v3ErZSxUbgltYlutakt9G9j4RRPXSSEdgo5Itm9Kv6eXUDH5Nq
 HIAZKb8Y0AV9VMZxUJqcHF30w7ZDCPGJDKvsZtuhE9ybHMDkTZ1GmYmRWZZRJuHi/tfB
 6hiFap2He5Eaw3EVnAeMyZei/yobZRKVbl5I/Qzv/XqUAES6qvQZ+PnyRNBdh263cS8I
 fPDTDayQSaLZsUwdDmTyheost47SbRXi8etLGnLcPNfHkeMMh5P83dWKHoElPrJoLgUR
 ZqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685525313; x=1688117313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ycEeIxRqgkRIW4MGkFCnucdnGd5u7XIlHGBP7fmPjk=;
 b=gKSpZdvh0qsVE0mKzREYOhMS3TkSTdxCo+QqqkdF9zvUNZvZmi+NtfB8Cz1i8jFllO
 5ZjUs79AdMx4wE9EVxhlJ242eH0XVAHtzZcJOCXoDHMeJKdqKXW+9XfQ9P+wkeNpS92q
 9VFOT6AgYOlEki7BIzJ2uTPQy9p/8Sfv5i3jx/U5D1hzJFm1PTcFfbVhqN8iTrojaBlP
 IH9hLxNVQFKzAL+Dp6hWCeHyGz97GFLgNqrU2osp9kOGSFZuIZBqRx8FaxAy2VHZS7oW
 5f+dS6rRa/SXOW71VgZUhHM0aFTbbvu557TO3Xd/lYsOK0CHWWeMbeo/TxNDPFtb84od
 cZrg==
X-Gm-Message-State: AC+VfDwLnNVQZmAudjwbZGbnDUA3xgzVpaBzZtCTiwRSEVbL9DL5EXDD
 cEMitR08KoZqUTwHpCCWosBgmw==
X-Google-Smtp-Source: ACHHUZ6J12TFVOuWDTrX5qAoSkvtJnGQjh+2xXSOtzIqC6Zah4Pa5qFbrlQEfPZq/PO9vhd71rQiDw==
X-Received: by 2002:aca:c20b:0:b0:39a:3dbd:d26d with SMTP id
 s11-20020acac20b000000b0039a3dbdd26dmr1899633oif.5.1685525313454; 
 Wed, 31 May 2023 02:28:33 -0700 (PDT)
Received: from [192.168.68.107] ([177.198.100.141])
 by smtp.gmail.com with ESMTPSA id
 q133-20020acaf28b000000b00399ee6330a9sm329684oih.52.2023.05.31.02.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 02:28:32 -0700 (PDT)
Message-ID: <9f6f15a2-4592-a05c-48ca-1077576ed292@ventanamicro.com>
Date: Wed, 31 May 2023 06:28:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] target/riscv: Make MPV only work when MPP != PRV_M
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-2-liweiwei@iscas.ac.cn>
 <d0a208a3-9973-b7e4-8fcf-d71ec0eab9b1@ventanamicro.com>
 <a669092a-8ef1-a70b-9896-5e7b6c78bb4a@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a669092a-8ef1-a70b-9896-5e7b6c78bb4a@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 5/30/23 21:27, Weiwei Li wrote:
> 
> On 2023/5/31 04:23, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/29/23 09:17, Weiwei Li wrote:
>>> Upon MRET or explicit memory access with MPRV=1, MPV should be ignored
>>> when MPP=PRV_M.
>>>
>>> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
>>> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
>>> ---
>>>   target/riscv/cpu_helper.c | 3 ++-
>>>   target/riscv/op_helper.c  | 3 ++-
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> index 09ea227ceb..bd892c05d4 100644
>>> --- a/target/riscv/cpu_helper.c
>>> +++ b/target/riscv/cpu_helper.c
>>> @@ -46,7 +46,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
>>>             if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
>>>               mode = get_field(env->mstatus, MSTATUS_MPP);
>>> -            virt = get_field(env->mstatus, MSTATUS_MPV);
>>> +            virt = get_field(env->mstatus, MSTATUS_MPV) &&
>>> +                   (mode != PRV_M);
>>
>> This change makes more sense in patch 2 where you also removed the 'mode'
>> check for MPRV. As it is now I read the code above and thought "but mode
>> is guaranteed to be == PRV_M, so (mode !=  PRV_M) is guaranteed to be
>> false every time".
> 
> No, this 'mode' (get from MPP) is not the previous 'mode'(the current privilege mode).

Oh, right:

>>>             if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
>>>               mode = get_field(env->mstatus, MSTATUS_MPP);

'mode' is being reassigned here.



> 
> Regards,
> 
> Weiwei Li
> 
>>
>> The change in helper_mret() below is fine.
>>
>> Thanks,
>>
>> Daniel
>>
>>>               if (virt) {
>>>                   status = env->vsstatus;
>>>               }
>>> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>>> index f563dc3981..9cdb9cdd06 100644
>>> --- a/target/riscv/op_helper.c
>>> +++ b/target/riscv/op_helper.c
>>> @@ -335,7 +335,8 @@ target_ulong helper_mret(CPURISCVState *env)
>>>           riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
>>>       }
>>>   -    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV);
>>> +    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
>>> +                             (prev_priv != PRV_M);
>>>       mstatus = set_field(mstatus, MSTATUS_MIE,
>>>                           get_field(mstatus, MSTATUS_MPIE));
>>>       mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
> 

