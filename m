Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A575123E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 23:10:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJh5Z-000085-7g; Wed, 12 Jul 2023 17:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJh5W-00007o-Hx
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 17:09:30 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJh5I-0000vB-3L
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 17:09:30 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b7474b0501so6449529a34.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689196155; x=1691788155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ZcV8mBt2qeqq+YHcHVaAJrKmunmDJsI24PFdshb0Yg=;
 b=GqYezGvauGxPT/wpJKbbLb2kvshllIPjAHknRobdrj7eyhljPxEux+nNvv2XgoaS3b
 tEqnnnObou52QmCpJ94fn394ENYueccrHqxI1vYZuJsmTSG1IzeK+7byJdUK1gx8+DEL
 ozMIwnCVibzdpV1WWQmC3plx7O3l3a9ZGWZHrInHasLNxB2h0Dlh968WPQuQTFvAhKi5
 CpbNsqEMbi7pNplcsJRGC0QQ1UHEGKmxaEiPTYvNthEoOi/etWpdPMj2tzpyM5WIEeLw
 GBH1nB6N3afHThMunkjvRoC6/CgX0ODp5rLaO9kAyfMY+0yWOTo51p/ZzpRPnv/CkOWw
 qwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689196155; x=1691788155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZcV8mBt2qeqq+YHcHVaAJrKmunmDJsI24PFdshb0Yg=;
 b=GJZUNii+Iay6MP/whHmlHQwm1zx2OVrn41NixLbKDN0T1XQ7rsG/TA1dSPHopiyTCA
 P4uriDzeQiy1h8yynejBOF2vObPldWYcbh3kXLuCEkddXCxU/49W51qUYemC4ke2GWzP
 8ImharmqeOAH2OBQQ98o/uNSgFqkpqpFT6XC+sDpjKG/GcReNLGITpa29a6DI/sMtcmg
 UE021uLC2MTryGnVTsCKUU8Yf3GU/z/AmMHMH6LQkEl8dwAde6+z+GQdAc8X4QAxn7F8
 uihbe8pNL4lUTCsHVaEXsxnuiouPM3yF7MuDeY7XXRJrQA0DkyX6nuH4QVnc7uGJYHCF
 w3wg==
X-Gm-Message-State: ABy/qLbdUchKaw8qCzO71bQ6uCSBg4n0F3FK7Tqd+e1ptkXpUi/I2qND
 cqzqrhiZbSglWHYgTkbJ9ufcYA==
X-Google-Smtp-Source: APBJJlGxRtSdcuzWlz+0GyVuLhTn7hsxlMMEq7HRX4MVn9vQ6QrghoFM/3R1DvdEzuhltj5DLlhNoA==
X-Received: by 2002:a05:6870:fb91:b0:1b3:b8b4:4aba with SMTP id
 kv17-20020a056870fb9100b001b3b8b44abamr22204001oab.1.1689196154670; 
 Wed, 12 Jul 2023 14:09:14 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 m10-20020a4aab8a000000b005660ff9e037sm2026738oon.25.2023.07.12.14.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 14:09:14 -0700 (PDT)
Message-ID: <744cbde6-7ce5-c327-3c5a-3858e994cc39@ventanamicro.com>
Date: Wed, 12 Jul 2023 18:09:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.2 6/7] target/riscv: add 'max' CPU type
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230712190149.424675-1-dbarboza@ventanamicro.com>
 <20230712190149.424675-7-dbarboza@ventanamicro.com>
 <20230712-stench-happiness-40c2ea831257@spud>
 <3e9b5be8-d3ca-3a17-bef9-4a6a5bdc0ad0@ventanamicro.com>
 <20230712-tulip-replica-0322e71c3e81@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230712-tulip-replica-0322e71c3e81@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 7/12/23 18:00, Conor Dooley wrote:
> On Wed, Jul 12, 2023 at 05:30:41PM -0300, Daniel Henrique Barboza wrote:
>> On 7/12/23 16:22, Conor Dooley wrote:
>>> On Wed, Jul 12, 2023 at 04:01:48PM -0300, Daniel Henrique Barboza wrote:
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
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>
>>> This seems like it will be super helpful for CI stuff etc, thanks for
>>> doing it.
>>
>> And Linux actually boots on it, which was remarkable to see. I was expecting something
>> to blow up I guess.
>>
>> This is the riscv,isa DT generated:
>>
>> # cat /proc/device-tree/cpus/cpu@0/riscv,isa
>> rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_zfh_zfhmin_zca_zcb_zcd_
>> zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zk_zkn_zknd_zkne_zknh_zkr_zks_zksed_zksh_zkt_
>> zve32f_zve64f_zve64d_smstateen_sscofpmf_sstc_svadu_svinval_svnapot_svpbmt#
> 
> Of which an upstream Linux kernel, building using something close to
> defconfig, accepts only
> rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zba_zbb_zbs_sscofpmf_sstc_svinval_svnapot_svpbmt
> so the set of possible things that break could break it has been reduced
> somewhat.
> 
> btw, I noticed that the default marchid/mimpid have changed. Previously I
> used to see something like:
> processor       : 15
> hart            : 15
> isa             : rv64imafdcvh_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zba_zbb_zbs_sscofpmf_sstc
> mmu             : sv57
> mvendorid       : 0x0
> marchid         : 0x80032
> mimpid          : 0x80032
> in /proc/cpuinfo, but "now" I see 0x0 for marchid & mimpid. Is this
> change to the default behaviour intentional? I saw "now" in "s because
> I applied your patches on top of Alistair's next branch, which contains
> the changes to m*id stuff.

It is intentional. Those default marchid/mimpid vals were derived from the current
QEMU version ID/build and didn't mean much.

It is still possible to set them via "-cpu rv64,marchid=N,mimpid=N" if needed when
using the generic (rv64,rv32) CPUs. Vendor CPUs can't have their machine IDs changed
via command line.


Thanks,

Daniel

> 
> Cheers,
> Conor.

