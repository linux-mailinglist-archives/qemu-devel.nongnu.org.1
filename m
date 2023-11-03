Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5E7E0B51
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 23:55:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz33a-0000DZ-Ly; Fri, 03 Nov 2023 18:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qz33Y-0000DI-A3
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 18:54:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qz33W-0001eM-Nb
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 18:54:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so21843295ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699052061; x=1699656861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tg/cw4LXc0tMMNs3T3vgJTvIB6uCccpDKw/eII0imKg=;
 b=a43Bs+RX4w+yiT37mOPEikBa9xurAtxf/6l6uFnkQtue4x+U2Cu0cYq21NIqPCU6AV
 1KYuHPKMrQo4/8XN8mt0bkIGxdBjsgxq064yeipHz6Yg1Zx4HJBUR3pxOTd/S7vUfwCw
 Lrscw9nBQzHYfwn07j6fq13W5hD/bGSGss1B7/K1RFDICxfuIVTMHkB1XFYKwmQkIC3z
 GleC37v4WTyXiIHdEWQEW9v+t4qb9Rjz//gpwxWC3vDuWwA/syHj6lLYez+LedP0TzJO
 JdJeZfW5JGxBtW8jVoNSGZXIdtBs7j4xR7zyIvhtqRIzDq9F/ktfqNXMqqBLIoNOrEzM
 ap+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699052061; x=1699656861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tg/cw4LXc0tMMNs3T3vgJTvIB6uCccpDKw/eII0imKg=;
 b=tXX5KXWVr3LWuS5DIMN9BdEg8Hasq1eVsItcqbbjpSNndPjmGYmFr9JYJQVSekiqwu
 Ugz3l4cAi7N2uqUa5bTZACmojzPP7vOt0jVWt94Ts/HFaweoZrkLNdIsO2iykrWaxfpB
 4HD+cfOUyHxql0wAl07nMm/SBAnwBBtGGF5CKPhMAAb4lTpCIlF05RP6noKzN6bpbozV
 Q7DyfE6BTSMerpIbrmLCfY3VWxXuLHN3SHbIoNrXuONwTYahDa2HPcujyXn86WdtrMIx
 XdGfDomhyfoAee2ulCKWE02CcoY02CJOItJhySYMnpwEf3S7wihraQX1KQUkt+0UkFmS
 DtPg==
X-Gm-Message-State: AOJu0YwDkSJKsskAA20vYNS+lpcl6M3LK1auZE7YlfSt/GlywOzFAcBN
 2zh5YpEGtl9T2d27juMoKP0+SQ==
X-Google-Smtp-Source: AGHT+IGNj+lTStvUZEpwlME9z1zze3DvYzle3VDuOGoAL+I0XtQxP7aWeYamZSS326o/25qDj6Rjag==
X-Received: by 2002:a17:902:e741:b0:1cc:5e1b:98a7 with SMTP id
 p1-20020a170902e74100b001cc5e1b98a7mr17498339plf.45.1699052060672; 
 Fri, 03 Nov 2023 15:54:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a17090301c600b001ab39cd875csm1830242plh.133.2023.11.03.15.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 15:54:20 -0700 (PDT)
Message-ID: <cd6c7a5f-b02f-428f-a973-cb5b71f9cded@linaro.org>
Date: Fri, 3 Nov 2023 15:54:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/94] target/sparc: Move RDASR, STBAR, MEMBAR to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-44-richard.henderson@linaro.org>
 <CAFEAcA-eyWiRFD_h+CFJC1vyouUSGroQ27iLxnF--B6HhXkM8A@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-eyWiRFD_h+CFJC1vyouUSGroQ27iLxnF--B6HhXkM8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 11/3/23 12:07, Peter Maydell wrote:
> On Thu, 26 Oct 2023 at 01:25, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> +static TCGv do_rdgsr(DisasContext *dc, TCGv dst)
>> +{
>> +    gen_trap_ifnofpu(dc);
>> +    return cpu_gsr;
>> +}
>> +
>> +TRANS(RDGSR, 64, do_rd_special, true, a->rd, do_rdgsr)
> 
> Hi; Coverity complains (CID 1523706) that we don't check
> the return value from this call to gen_trap_ifnofpu(),
> whereas we do check it on all but one other call.
> Is this OK?

Yes.

While gen_trap_ifnofpu may or may not trap, we must return a legal value for the calling 
wrapper function.  If a trap is generated, the read of cpu_gsr will be removed as dead code.

For do_wrgsr, we *could* avoid generating the dead store to cpu_gsr, but avoiding that is 
not critical.


r~

