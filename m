Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D06C76566E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1jT-0000eG-OG; Thu, 27 Jul 2023 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP1jP-0000d7-Q6
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:12:43 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP1jN-0001ry-2I
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:12:43 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1bbdddd3c94so361333fac.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690467159; x=1691071959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGNYNym7CPG7P82yIxID+feNFr4ORJdXTXNq2DaJX7c=;
 b=FAKkoAzSG3TnrhSCPNmna15sHHmwM1cO5+7g4OjjWROtFLM6S3rApQd2MhbGVh1Z/B
 N5wCAf3QcDVZNEHLDQrJnxMLQjYLcN+5YX+I6KnR4TyG0ZOji6a0I6KKzH+stVnu6LVC
 K6R/ONiu+FScPEpDKZcwlc6tj6eSlT3xnj7eTUIM6kxp0KPYjQrratSEz53ANegBlldO
 JmpQV/BkmkYoFf3lCLy/0C3ruaSH2zijuTRQpBgTtxfxXmeBUJmqfKs36VzVOAbjBRO+
 Qh6E5+XygjdxWgv5/38b1GrlX74gObIw7GD2J3jQ4VMHXiVhyK7nMUTpYuFTavxFWJq4
 S4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690467159; x=1691071959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGNYNym7CPG7P82yIxID+feNFr4ORJdXTXNq2DaJX7c=;
 b=A02Y3UJZnGLt5wLyCpn6EAvcum/Tbn3TZVv3YwD2qHq+p8CcegclWvQ58md6hGyyaR
 A8FpwYagenBNy8I/RrX2byX1KOGSxvgZcfG8UP8bCdoeZAJIPu+OOi3+3R/JKhDmUwcj
 JFOy0iR3kPtWJYS7RloUBP1CzQ61/7Zi6/+1ywpUhsRDJ477k65eG8ObCR9EZCu2nvwT
 DrxxNisAz5H8hv90ZOcCGOvPg+6udcf8zJlhwF4GTBTOGy+msPRdnlovXRvMIHG9q1X7
 9i9Q7hq6oVeAvZujdqk9Fa6mpJ5DFdOBsgHVJlnveeOEnu4epFlAOm/KUguMekb5II1+
 +93Q==
X-Gm-Message-State: ABy/qLb1tpICHLcUaplfcYQLty8Pm2sQQ9y2tUTW6lJzvDU5XF/XIv6h
 lEmgpG0QEuwBuKy/o2D5T7cvVQ==
X-Google-Smtp-Source: APBJJlHCY5Vt0jIhWS5/lQAyxruckUsVbBtcAdFqjoeL1JbGhxy1hWXlAn4LOwAO7zHH1xdmLRgT4w==
X-Received: by 2002:a05:6870:9108:b0:1b3:b6c7:ab1a with SMTP id
 o8-20020a056870910800b001b3b6c7ab1amr3235930oae.28.1690467158883; 
 Thu, 27 Jul 2023 07:12:38 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 wh16-20020a056871a69000b001bb58a346b8sm730588oab.18.2023.07.27.07.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 07:12:38 -0700 (PDT)
Message-ID: <6b4981c7-72d3-2e29-3eb2-b8fd76047e44@ventanamicro.com>
Date: Thu, 27 Jul 2023 11:12:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v5 09/11] target/riscv: add 'max' CPU type
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
 <20230720171933.404398-10-dbarboza@ventanamicro.com>
 <20230727-armful-french-e572d80fcac1@spud>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230727-armful-french-e572d80fcac1@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 7/27/23 10:59, Conor Dooley wrote:
> Hey Daniel,
> 
> On Thu, Jul 20, 2023 at 02:19:31PM -0300, Daniel Henrique Barboza wrote:
>> The 'max' CPU type is used by tooling to determine what's the most
>> capable CPU a current QEMU version implements. Other archs such as ARM
>> implements this type. Let's add it to RISC-V.
>>
>> What we consider "most capable CPU" in this context are related to
>> ratified, non-vendor extensions. This means that we want the 'max' CPU
>> to enable all (possible) ratified extensions by default. The reasoning
>> behind this design is (1) vendor extensions can conflict with each other
>> and we won't play favorities deciding which one is default or not and
>> (2) non-ratified extensions are always prone to changes, not being
>> stable enough to be enabled by default.
>>
>> All this said, we're still not able to enable all ratified extensions
>> due to conflicts between them. Zfinx and all its dependencies aren't
>> enabled because of a conflict with RVF. zce, zcmp and zcmt are also
>> disabled due to RVD conflicts. When running with 64 bits we're also
>> disabling zcf.
>>
>> MISA bits RVG, RVJ and RVV are also being set manually since they're
>> default disabled.
>>
>> This is the resulting 'riscv,isa' DT for this new CPU:
>>
>> rv64imafdcvh_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_
>> zfh_zfhmin_zca_zcb_zcd_zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zk_zkn_zknd_
>> zkne_zknh_zkr_zks_zksed_zksh_zkt_zve32f_zve64f_zve64d_
>> smstateen_sscofpmf_sstc_svadu_svinval_svnapot_svpbmt
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> 
> I was giving this another go today, like so
> $(qemu) -smp 4 -M virt,aia=aplic,dumpdtb=qemu.dtb -cpu max -m 1G
> which lead to a few
> vector version is not specified, use the default value v1.0
> printed. Should the max cpu set a vector version w/o user input
> being required?


This isn't exclusive to the 'max' cpu code per se. It's the common RVV handling
code that is expecting users to inform which vector version they're going to
use every time we activate V.

I believe it's too late to change the command line handling to force users to pick
a vector version, so the second better approach is to silently default to v1.0
(or perhaps to the latest RVV version available) if the user didn't set anything.


Thanks,

Daniel




> 
> Cheers,
> Conor.

