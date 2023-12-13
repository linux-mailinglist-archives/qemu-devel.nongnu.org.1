Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D181143B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:07:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDPsd-0001nf-2R; Wed, 13 Dec 2023 09:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDPsZ-0001n0-HA
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:06:27 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDPsT-0002fu-J7
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:06:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c25973988so71148575e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702476379; x=1703081179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6xlab4qqvg7voT5rA1azW8FGqGkyWQc2wXdDNGexjTE=;
 b=nIQTTCeT3fVexP8qM61ynZrWQozjeHMb03mdC8BvYtuLBZGFxVrceKwItGTgWXGX2x
 7Roj76V3M59L06BkDsWF5FKYcKvBy5vuh9aexi9d9KUqF4DK3oA3HCzMT977PyK/hxAR
 q51BBD8w2ckZ8phRjclrdG3oCU3ZfwwIvZQro0Ne2kEYiwWDXXSWed1UPguvRrIo1xa/
 MuM084MXICizipSfSomsNIIDV+098wG94vGmz3xavDeREm1R8RlI5JdGAClqcD+4moa4
 TOLUAwzJA109wdvgG9PUNdLZ017v9GAltpzi0Cb0zpTmvhI84oc16I3SQye6bAd+i3y7
 hW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702476379; x=1703081179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6xlab4qqvg7voT5rA1azW8FGqGkyWQc2wXdDNGexjTE=;
 b=EkEKbTLz2RF95EYHamJbPIkhnpnNx/8k5Z90MmNmYTHnvBGAxbr5SrrCksrikjTkFO
 19yoKds213ZT0idRX4ZCnE8MehLB+4FCctrBYhLNhAykD/M872f2Uq6DUM45lQxUU11M
 KB24Pme2ihNbNubG9qGFGOu996iwMwkiSONe8Z9LclasR3z/VGLAdjFQKU6lpi7OgwEx
 IKsTiQ8KIa6rs06rw1rb5CuLyc5WOgTGgcTybavmfC8b6fJ9xpuW17bXhxNUgSc6vby/
 ygVZzR7IrxvYNuWkyGJK+ButuV/R+yAgDGIdzY5+Pba5NTwrgdTao8a4clFGaSrAIEwN
 0TPA==
X-Gm-Message-State: AOJu0Yy4xaw7HWvjJB7ccX97jj3IBnAKCyrZt59OKrWn74yTFc8Yu6G+
 S63AmwdLP5ZsYqNmAP6uKrQqrQ==
X-Google-Smtp-Source: AGHT+IHwPDXUPMziR9VU2/0vt0XpiyJgtRExKVMXQqmGFkrBVCuzLMu10c+g9wpHR77kjb8AdYfjSQ==
X-Received: by 2002:a05:600c:2e42:b0:40c:314a:426 with SMTP id
 q2-20020a05600c2e4200b0040c314a0426mr4147007wmf.156.1702476379030; 
 Wed, 13 Dec 2023 06:06:19 -0800 (PST)
Received: from [10.123.141.145] (sncfv6-vip-ucpctl.hotspot.hub-one.net.
 [213.174.99.133]) by smtp.gmail.com with ESMTPSA id
 bi11-20020a05600c3d8b00b0040c2963e5f3sm20412218wmb.38.2023.12.13.06.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 06:06:18 -0800 (PST)
Message-ID: <4f34578a-5bb6-422f-a408-fa457644ad05@linaro.org>
Date: Wed, 13 Dec 2023 15:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/35] tcg/mips: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-18-richard.henderson@linaro.org>
 <cbd8f4e4-351c-442c-9ddd-a2a8505a7232@linaro.org>
 <0696de2d-5d9c-48e9-b7f8-4d3673ffd9b4@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0696de2d-5d9c-48e9-b7f8-4d3673ffd9b4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Richard,

On 17/11/23 17:36, Richard Henderson wrote:
> On 11/16/23 23:46, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 28/10/23 21:45, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   tcg/mips/tcg-target.c.inc | 41 +++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>
>>
>>> @@ -1053,6 +1071,14 @@ static void tcg_out_setcond2(TCGContext *s, 
>>> TCGCond cond, TCGReg ret,
>>>           tcg_out_setcond(s, cond, ret, tmp1, TCG_REG_ZERO);
>>>           break;
>>> +    case TCG_COND_TSTEQ:
>>> +    case TCG_COND_TSTNE:
>>> +        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
>>> +        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
>>> +        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
>>> +        tcg_out_setcond(s, tcg_eqne_cond(cond), ret, tmp1, 
>>> TCG_REG_ZERO);
>>
>> Where is tcg_eqne_cond() declared?
> 
> tcg_tst_eqne_cond() is in tcg/tcg-cond.h.
> This is a rebase error when I renamed it; I have fixed it since.

Looking at https://gitlab.com/rth7680/qemu/-/commits/tcg-test/
commits the patch is now quite different. I suppose you plan to
post a v3, so will wait for it to finish what isn't reviewed.

Regards,

Phil.

