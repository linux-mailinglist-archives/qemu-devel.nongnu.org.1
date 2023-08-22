Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FC78469F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:12:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTyY-0003Z5-HB; Tue, 22 Aug 2023 12:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYTyX-0003Yo-DO
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:11:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYTyU-0007vf-R1
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:11:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso710326f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720681; x=1693325481;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fYXOxCO8GCfJ+uJeY+lM2xEQWVhSlqX7B6CBlP/rDRw=;
 b=k6njMkkDDgSKtykAiW2sykCWDPGt4ZOWHGn+6pHzR7EZB+3R6gveFge3obp6bhsxEh
 QpnkhOTnoc7saRf0V9pvs2cjniV4Dr8bxuNmK8mJLsK1RrIXRYwqEs+O/VE6BhiE0EPq
 pG5X7AuT/glrKVY09mOSZxqpfdhfTpK5IOhd/HQt3Ut7KcaX150ZlppnQHHRWkSmEb43
 hpqHzSD47oqDzSs8z5SrgiyvhhruY/fwAZTTzuLBnWAuYYuzarGL4bWS9vLEeNjuwpBz
 kyzQeHbiXXKMZnS6DR9TDZc4PfhvlAk0PWMK9ckOmrKGMf41GENt7AEv1uQQxMr/Q/DH
 1ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720681; x=1693325481;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fYXOxCO8GCfJ+uJeY+lM2xEQWVhSlqX7B6CBlP/rDRw=;
 b=OOQZD64H31xt20NcxfSD/rmO0GCVBljv3NRM86e4OsgxtcAROD972PUgR9FGnvtVQt
 zM89EhlgqvAHeVrO0PUvCGd/+T9tqr2qLMyi/j4EgFvL9+g5nVP+HR2EXdPFflSLRiSj
 ktlNkEXz6pVRRM7NuM01N2gLt9lxUdk94uDcD5axqV7n6P3IY2phiBe4D8LTF8rSuS+t
 BdFIx75YEW+DXXM1J7N5/Ai7hOfUSswBTOTqRDNsfFX6vPHKw1vXBam4fyzfUFG6/k57
 tNl5/fb/tSv0zO3g/6vN5W6GAXHb/Wol7vdpUR9P9xJwU974gUBaJuy9Xc+9yBTBC2v1
 dM6Q==
X-Gm-Message-State: AOJu0Yx+P1jDzJkGKhKeacsvQcZ+LsGCcX/HwXf5pdRqEdwF+smgrypc
 7v+ZEXa2UMOgotWTS5I/r7dzmybzGX9NzquvlJHcig==
X-Google-Smtp-Source: AGHT+IGe5ZiEHDsp66p8sD7i0Bd9o+kBffg9WgIXN22aFtC3D3t/6QrFOsOyAmupdqhX+Df3IVgjQQ==
X-Received: by 2002:a5d:4389:0:b0:306:46c4:d313 with SMTP id
 i9-20020a5d4389000000b0030646c4d313mr6435045wrq.28.1692720681057; 
 Tue, 22 Aug 2023 09:11:21 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 b4-20020adff904000000b003197c7d08ddsm16289194wrr.71.2023.08.22.09.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:11:20 -0700 (PDT)
Message-ID: <9ad24cdc-adf4-0a38-9362-e46c559fae7d@linaro.org>
Date: Tue, 22 Aug 2023 18:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 11/12] target/loongarch: Use generic hrev64_i32() in
 REVB.2H opcode
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz
 <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822125221.55046-1-philmd@linaro.org>
 <1ea2097b-fb72-29c4-622a-79f96f69c2c1@linaro.org>
In-Reply-To: <1ea2097b-fb72-29c4-622a-79f96f69c2c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/8/23 15:30, Philippe Mathieu-Daudé wrote:
> On 22/8/23 14:52, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/loongarch/insn_trans/trans_bit.c.inc | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/target/loongarch/insn_trans/trans_bit.c.inc 
>> b/target/loongarch/insn_trans/trans_bit.c.inc
>> index c04806dc21..9d564a0999 100644
>> --- a/target/loongarch/insn_trans/trans_bit.c.inc
>> +++ b/target/loongarch/insn_trans/trans_bit.c.inc
>> @@ -111,19 +111,6 @@ static void gen_revb_2w(TCGv dest, TCGv src1)
>>       tcg_gen_rotri_i64(dest, dest, 32);
>>   }
>> -static void gen_revb_2h(TCGv dest, TCGv src1)
>> -{
>> -    TCGv mask = tcg_constant_tl(0x00FF00FF);
>> -    TCGv t0 = tcg_temp_new();
>> -    TCGv t1 = tcg_temp_new();
>> -
>> -    tcg_gen_shri_tl(t0, src1, 8);
>> -    tcg_gen_and_tl(t0, t0, mask);
>> -    tcg_gen_and_tl(t1, src1, mask);
>> -    tcg_gen_shli_tl(t1, t1, 8);

Looking at 
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_revb_2h4h2wd
the sign extension is missing, so the next line:

>> -    tcg_gen_or_tl(dest, t0, t1);

should be replaced by smth like:

         tcg_gen_or_tl(t0, t0, t1);
         tcg_gen_ext32s_tl(dest, t0);

>> -}


