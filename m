Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0C716647
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:10:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40yY-0008KC-42; Tue, 30 May 2023 11:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40yV-0008Ah-Et
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:09:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40yT-0004hH-Ou
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:09:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso3596508b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685459364; x=1688051364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YyVqbzMv110LWYWyqyeFqYv5nFiAxNJktsmCE/ovvzQ=;
 b=iqfuNwuKbbIYbLZLSsGE+r/CCpVt6K7anJY3gbNSPMAPqBGlcK8Qowz2V8s5qJ22nC
 oZ8eI/FMYu8EcdDYAPkUkQ78n56fbjYYR/YkmeXtf3MjsrOaVRZCVXCcRqvTWQ4WOYKD
 pcRu2cU3Ahcd17sfXPVqVaBL9+G99pPu3bM0lN/E02nxM1etzh+VZQNSooi91kZAwmIS
 9xpp/jBXt0ECGkt/M1eNpKwsIWQ3kA7KpyiTsUzoeHSEFZTQbbIWM7fvpRxduhq8Hwoq
 Ho8wkppZqx+E9oNiJEptiJOhq3NoocrREQ0DWWUFDr73Qqa7GaKcRoihdPHU2BxabwPW
 PRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459364; x=1688051364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YyVqbzMv110LWYWyqyeFqYv5nFiAxNJktsmCE/ovvzQ=;
 b=C4DeGC3dgXs5v2CTNVFiVFve4C8ya+r69GTpnKIrxc9VVBHlUiNa+3Tb0HSBYgflG2
 qYntmAkEfxJwt9/6ZV21/jlmIlOMI8yWOp46ehl13piy8bxcOofNEVU971ZHB3ndHtP/
 Np5SMxA61myumVGzj4nK2Wk3vmXDDoNk+1prIZc+8+2EAx/FgMW0us6Ul3Cxe5yHeopy
 c9HmXi4Fsz4B+6mJ/c+c+rDwBDni8I+37Spc1Y/0SxXusrty/5Ko7M07pUcZZ5IkcjjY
 Oo0ClXBqNm4DLtxYApx8+CbgokuSWH0xUNYYVtaef1vmhWcdmBZoFigzarMXOGzR6g1E
 n4tQ==
X-Gm-Message-State: AC+VfDxYPpPNdcF8xxYciZL9FmpgfW3Edaeax4bRu393txc4mqXd0ZDU
 5hpC5tKoX8l4tGaMVi3QDiwfLA==
X-Google-Smtp-Source: ACHHUZ7DwiOujVh07NXpFpw1YisN6a+pLaYZLcnv2tKDeLvti1PMOiNSr6JmCL+QSYSmYVPF8pB4Eg==
X-Received: by 2002:a05:6a20:ce44:b0:111:c8a6:88ca with SMTP id
 id4-20020a056a20ce4400b00111c8a688camr2699946pzb.58.1685459364163; 
 Tue, 30 May 2023 08:09:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 125-20020a630583000000b005348af1b84csm1117065pgf.74.2023.05.30.08.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 08:09:23 -0700 (PDT)
Message-ID: <528627e2-f4d5-fd44-a57b-23b37ca79935@linaro.org>
Date: Tue, 30 May 2023 08:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
 <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
 <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
 <CAFEAcA8tPuFMz8BZ5P-SJS42q8E_TZ1_5DJL-0kOvzeT-Fymmw@mail.gmail.com>
 <a7ba5e1c-ca59-b114-229a-07930f6ba683@linaro.org>
 <CAFEAcA_BS4b1MR=7zwVXB+eTXcVc2QhvzcvsoQn9mZ-xeps41w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_BS4b1MR=7zwVXB+eTXcVc2QhvzcvsoQn9mZ-xeps41w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/30/23 07:48, Peter Maydell wrote:
> On Tue, 30 May 2023 at 15:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/30/23 07:06, Peter Maydell wrote:
>>>> This is about falling through to the cmpxchg below: if !PAGE_WRITE_ORG, then the page is
>>>> really not writable, we will SIGSEGV, and handle_sigsegv_accerr_write will kill the process.
>>>
>>> Right, but if !PAGE_WRITE_ORG then that implies also !PAGE_WRITE,
>>> so we do that even without this change ?
>>
>> But !PAGE_WRITE does not imply !PAGE_WRITE_ORG.
> 
> Hmm. In what situation do we mark a page writeable when the
> guest didn't ask for it to be writeable ?

I don't know -- it seems backward, I know.

I *think* it's a race condition, where PAGE_WRITE changes.
That's what the test case is trying to provoke, anyway.


r~


