Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BD7655F2
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1pt-0002lq-LI; Thu, 27 Jul 2023 10:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP1pr-0002jT-37
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:19:23 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP1pp-0003CZ-FY
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:19:22 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bb14015560so860618a34.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690467560; x=1691072360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E1PuD7O2Y5uZPoXE7K0CIDKX1lYtZjaQgTsFN9Fbcp8=;
 b=Nuivl3ObCXttOG/lXWqlkWgZ2uJ2NRF55nwW0SDUkzLEKmvHv9w7Mm2tSLEVkCGfhG
 CR5tzEoWhjWhGthTLkjnvHISwD95lP/SwanVoEdHFlUqcI/EGR+87/2earJo7FoTTtE3
 fc+ojad1aHjuUzblQXXW+8W/7CbhLe8wBDwimi1ILI2b7Vs0pqhYnySuo/eEUKgunP3j
 ZN0dXgNLofaSZFQepgD6hEPxH3e3+60SOW9cvpoK3bXYrm/Mpgwy5tDorcjSmgxk5P/M
 Kh+lgWRpJoBgdZSmnrKCuSCrime6192cs8pXLRL8c/OdmlvcgpBkNQvmA841tWxX8B+P
 gZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690467560; x=1691072360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E1PuD7O2Y5uZPoXE7K0CIDKX1lYtZjaQgTsFN9Fbcp8=;
 b=gh3Ys/r/U5XCQx3bq2A62tt7Yq+THGsKE8/O5rDNtlnd2RqZhIskrUcFH97HrygU6z
 QJ3MaQ16tu/U6xqxfIK7GbLsKD0+36jNEmdj3O8C8t9ilPYTtNqHVoTFGrzQK6AQ0Dcf
 dQz45391DvjyjmYmCUWmkdZ/EgSTAu+hDj+tfVVIgZSEq59smq++ZC/k66Jcpjbuj/IC
 w+QljOQ9tttpZkFuBiimYQMKk1NP18dBtCxh5JaiMLYXfbCuU90mSvVkD4+MRg7xGvZS
 d1k2QImhiGigvov2Gs5a/ELi+m4vaOMYbwtGXL59gS9SY7did/6421B3wQ0wNqzj4C4f
 FFSA==
X-Gm-Message-State: ABy/qLaxCo/P2il+weiFy+IO0Aa0n0RbICRnuQjob1aZ5XaCKxlWx0X9
 zJkkJa/aufIVnKMdHk1kJB2os8OU8WEFpcmaeMFFag==
X-Google-Smtp-Source: APBJJlHIC7O1NyMO28pTEqYtXirjG70Xu3c0rekR+pCmf43SCSybO0rrXwMsHBUXmI+T+2qWHJ4NBQ==
X-Received: by 2002:a05:6871:591:b0:177:ad57:cb36 with SMTP id
 u17-20020a056871059100b00177ad57cb36mr3217151oan.27.1690467559663; 
 Thu, 27 Jul 2023 07:19:19 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 r3-20020a056830134300b006b9b0a08fdasm652663otq.59.2023.07.27.07.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 07:19:19 -0700 (PDT)
Message-ID: <06ff46d8-eb7a-d568-1f69-3255e5c8944b@ventanamicro.com>
Date: Thu, 27 Jul 2023 11:19:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v5 09/11] target/riscv: add 'max' CPU type
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
 <20230720171933.404398-10-dbarboza@ventanamicro.com>
 <20230727-armful-french-e572d80fcac1@spud>
 <6b4981c7-72d3-2e29-3eb2-b8fd76047e44@ventanamicro.com>
 <20230727-flashy-obsolete-7a1c81524429@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230727-flashy-obsolete-7a1c81524429@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 7/27/23 11:16, Conor Dooley wrote:
> On Thu, Jul 27, 2023 at 11:12:34AM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 7/27/23 10:59, Conor Dooley wrote:
>>> Hey Daniel,
>>>
>>> On Thu, Jul 20, 2023 at 02:19:31PM -0300, Daniel Henrique Barboza wrote:
>>>> The 'max' CPU type is used by tooling to determine what's the most
>>>> capable CPU a current QEMU version implements. Other archs such as ARM
>>>> implements this type. Let's add it to RISC-V.
>>>>
>>>> What we consider "most capable CPU" in this context are related to
>>>> ratified, non-vendor extensions. This means that we want the 'max' CPU
>>>> to enable all (possible) ratified extensions by default. The reasoning
>>>> behind this design is (1) vendor extensions can conflict with each other
>>>> and we won't play favorities deciding which one is default or not and
>>>> (2) non-ratified extensions are always prone to changes, not being
>>>> stable enough to be enabled by default.
>>>>
>>>> All this said, we're still not able to enable all ratified extensions
>>>> due to conflicts between them. Zfinx and all its dependencies aren't
>>>> enabled because of a conflict with RVF. zce, zcmp and zcmt are also
>>>> disabled due to RVD conflicts. When running with 64 bits we're also
>>>> disabling zcf.
>>>>
>>>> MISA bits RVG, RVJ and RVV are also being set manually since they're
>>>> default disabled.
>>>>
>>>> This is the resulting 'riscv,isa' DT for this new CPU:
>>>>
>>>> rv64imafdcvh_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_
>>>> zfh_zfhmin_zca_zcb_zcd_zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zk_zkn_zknd_
>>>> zkne_zknh_zkr_zks_zksed_zksh_zkt_zve32f_zve64f_zve64d_
>>>> smstateen_sscofpmf_sstc_svadu_svinval_svnapot_svpbmt
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
>>>
>>> I was giving this another go today, like so
>>> $(qemu) -smp 4 -M virt,aia=aplic,dumpdtb=qemu.dtb -cpu max -m 1G
>>> which lead to a few
>>> vector version is not specified, use the default value v1.0
>>> printed. Should the max cpu set a vector version w/o user input
>>> being required?
>>
>>
>> This isn't exclusive to the 'max' cpu code per se. It's the common RVV handling
>> code that is expecting users to inform which vector version they're going to
>> use every time we activate V.
> 
> Yah, I figured it was not exclusive to it, but it seemed "thematic" for
> the max cpu to silently pick a reasonable default rather than complain.

Fair point. For the 'max' CPU it definitely makes sense to pick a good default
instead of nagging about it.

I'll send a new version. Thanks,


Daniel

> 
>> I believe it's too late to change the command line handling to force users to pick
>> a vector version, so the second better approach is to silently default to v1.0
>> (or perhaps to the latest RVV version available) if the user didn't set anything.
> 
> Honestly, I'm not sure why it warns at the moment. Seems like the
> default is what any reasonable person would expect, no?
> 

