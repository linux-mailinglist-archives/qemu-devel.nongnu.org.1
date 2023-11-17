Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E67EF650
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:37:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41ps-000528-GK; Fri, 17 Nov 2023 11:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41pq-00051i-7Y
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:36:50 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41po-0005qg-O6
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:36:50 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso2056711b3a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700239006; x=1700843806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q9CUKFUTK0kQMllOu5U3Q2c/kh7+DkNaN6KbymwJmME=;
 b=B5vcb+ZhgwCH70jStLJ6dtlidbcaL9ppyaWy5fWiHMHfBYO8xwCMvkE1GqLcP5jNRg
 I7Ap23LmgItFAwM3Nw0GPlzxvChxAbTF1YhfhitefCX0h43fzlxY9dUWbAtTpQzbn8HS
 LJ6BigDZ5SUXdHfLLzTpqfSDArkm0wVbKQJn0mNRzyTcOU3c39RB4rYmElfjAiLckBfg
 Ko+OSjKjk2Pg0nSkqisdEzIm1ybh0uoeoFLmtqIKA8V3m7Jnz72AmKahLKCOWNcPxWDI
 V/R9Z+XIzaqwhENgtkBhcOwhXs0KRx3IeIz6FDdv9oP5cg/N1tMyQzSpoeE5fJ1h0NXP
 pNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700239006; x=1700843806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9CUKFUTK0kQMllOu5U3Q2c/kh7+DkNaN6KbymwJmME=;
 b=FS5nbvpwlUzRaHmO8q28w6DtE9idxr/0obMok3+IfpYqxVPESncNP9HsGWYde1UIY4
 3owIL7M0C+w8LC7B4LmDJcLnGG8x+c+Bhsu6/CLW5Fv2x7MHl5taYQ8f9ZJhX/ikl9wM
 WDiaNqQiFGU78or9N8ZGJgVTX+nh8YpzzmMPRGGXi3JHl4DbtCVsWJ7XaWnQ9vdkN1pd
 +aHiPVcs9364b+w+QRBQIfQ//OxInIuArTLewTGJt7wV1I+ZOUHRrKnX0arDMwc+Zwu4
 fbiYOfcWsh4EoQwkdyGVfTPh1Yh6hzqtdf/SSryZdg5li71IxC9dXvQSG1VEsdHWETjX
 pVSw==
X-Gm-Message-State: AOJu0YyTbanK79pW/7bEKNKJI594noh1o19b6QiQyKe/QEnE9UkRIrZi
 EQXPKGwI3ePgReGqcBFsiIgEaQ==
X-Google-Smtp-Source: AGHT+IGByRWqkUAmR7WgZFosfC76H0SPLdahHwpbrCf4z27uktaW9O5s+esov+NQlg+AHVAkOrsk7A==
X-Received: by 2002:a05:6a21:6d88:b0:187:9521:92bc with SMTP id
 wl8-20020a056a216d8800b00187952192bcmr8213158pzb.58.1700239006042; 
 Fri, 17 Nov 2023 08:36:46 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 20-20020a631054000000b0059d34fb9ccasm1597481pgq.2.2023.11.17.08.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 08:36:45 -0800 (PST)
Message-ID: <0696de2d-5d9c-48e9-b7f8-4d3673ffd9b4@linaro.org>
Date: Fri, 17 Nov 2023 08:36:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/35] tcg/mips: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-18-richard.henderson@linaro.org>
 <cbd8f4e4-351c-442c-9ddd-a2a8505a7232@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cbd8f4e4-351c-442c-9ddd-a2a8505a7232@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 11/16/23 23:46, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 28/10/23 21:45, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/mips/tcg-target.c.inc | 41 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
> 
> 
>> @@ -1053,6 +1071,14 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg 
>> ret,
>>           tcg_out_setcond(s, cond, ret, tmp1, TCG_REG_ZERO);
>>           break;
>> +    case TCG_COND_TSTEQ:
>> +    case TCG_COND_TSTNE:
>> +        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
>> +        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
>> +        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
>> +        tcg_out_setcond(s, tcg_eqne_cond(cond), ret, tmp1, TCG_REG_ZERO);
> 
> Where is tcg_eqne_cond() declared?

tcg_tst_eqne_cond() is in tcg/tcg-cond.h.
This is a rebase error when I renamed it; I have fixed it since.


r~


