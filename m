Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DA82822E
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:42:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7fi-0003Eo-8i; Tue, 09 Jan 2024 03:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN7fh-0003Eg-EX
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:41:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN7ff-0001VC-HB
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:41:17 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3ec3db764so7847435ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 00:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704789673; x=1705394473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SmXcImIVxWxiPq142HoSGr/nabmNhgAEQtTOPNP71MM=;
 b=Q/wfSXb7OAYFJgdSjXIC6psySyeCU9ozHHFMmZiK4QuGnsJgbyqZIboBqcPT7zful1
 E5fKJyizArhNoGJC8ZPrG1zmDClk4MYhtiRfv4iXz3/FpnQf/qW7z32JjK7oKdjJZK3B
 wxPVzGM3kcJnDb6kobn4tD1hLFTVNwro7KWSTzI8jfofSBJACsqhFx9/0T66P8jTq1Fl
 EwQQ3SO5L5GqF4DMZoL5T6bJLEuDX4Zig7fOKBfxcfZGdnFibLXgZRON96WnOgn4Mf+n
 fVNPyYC8xqWKvxH2FvxOgVW6rFdVnKHPjri2mATsrxM2YnLixHf0L7p01UItoffLTMCw
 upmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704789673; x=1705394473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SmXcImIVxWxiPq142HoSGr/nabmNhgAEQtTOPNP71MM=;
 b=JPjxUTi2u+9af/XQ8oTH7RnW1ggP2Zs3uSK8ap+NOmWJ4eZ4QMY3UGZVTkJpYdy6R+
 tKEH/I/uxaPA4hKPt80mzmsUL0MXLJOLDhJkPH4IWBnwpt57c8k6eqsSMF+e0uvdiRkQ
 znwuW/3pxCfWFTSVSuM4EGsjVQaVD11Kmq/bvsOUENVuvGqVZ8uguuLdS5vPVI+LxkL7
 WOg3ZtfSojH1s77kRgs+My2Hs1n5gfqc89+pCUxkdqWjJM5Zs8Hd81VncBPW6SEMm5IW
 yxGeG89HJQcdexlk3j/+PCvb/bwjEFsMPhecDYm1Tl7COMnpc7aEIstqf6dmxOSQAiWK
 Pplw==
X-Gm-Message-State: AOJu0Yycuk7dEjXd8yI2LSZU77ZhiKXGhtRBGXSbgpIILWKtU2xR/dVT
 uV0n7zC7e7LQHzjW/KBQUbHhQuSYTAVEVA==
X-Google-Smtp-Source: AGHT+IH46VRV7mzJhj+H+DMot1xhoV3gLF5U/yWCrmmRWKEoFbk8OT65b6eCRU+wtE0Z07IuOTOjUA==
X-Received: by 2002:a17:902:780e:b0:1d4:79b7:b8ce with SMTP id
 p14-20020a170902780e00b001d479b7b8cemr2247199pll.44.1704789673639; 
 Tue, 09 Jan 2024 00:41:13 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a170902eb4a00b001d4ca3087dfsm1205827pli.234.2024.01.09.00.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 00:41:13 -0800 (PST)
Message-ID: <dd1ea56b-8347-4536-bf2b-1be63f260496@linaro.org>
Date: Tue, 9 Jan 2024 19:40:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/35] target/arm: Implement FEAT_NV2 redirection of
 sysregs to RAM
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-27-peter.maydell@linaro.org>
 <88dcdb40-2fa3-449e-a3f7-41d75269a968@linaro.org>
 <CAFEAcA88=EjttEfaVdthnn2vLgWRY1NqYd3cti1VE+4EqsboMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA88=EjttEfaVdthnn2vLgWRY1NqYd3cti1VE+4EqsboMg@mail.gmail.com>
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

On 1/5/24 03:23, Peter Maydell wrote:
> On Wed, 27 Dec 2023 at 23:55, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 12/18/23 22:32, Peter Maydell wrote:
>>> +    if (s->nv && s->nv2 && ri->nv2_redirect_offset) {
>>
>> Again, s->nv test is redundant.
> 
> Fixed, thanks.
> 
>>> +        /*
>>> +         * Some registers always redirect to memory; some only do so if
>>> +         * HCR_EL2.NV1 is 0, and some only if NV1 is 1 (these come in
>>> +         * pairs which share an offset; see the table in R_CSRPQ).
>>> +         */
>>> +        if (ri->nv2_redirect_offset & NV2_REDIR_NV1) {
>>> +            nv2_mem_redirect = s->nv1;
>>> +        } else if (ri->nv2_redirect_offset & NV2_REDIR_NO_NV1) {
>>> +            nv2_mem_redirect = !s->nv1;
>>> +        } else {
>>> +            nv2_mem_redirect = true;
>>> +        }
>>
>> I wondered if it would be clearer with the "both" case having both bits set.  While I see
>> that the first defined offset is 0x20, offset 0x00 is still reserved and *could* be used.
>> At which point ri->nv2_redirect_offset would need a non-zero value for a zero offset.
>>
>> Maybe clearer as
>>
>>       nv2_mem_redirect = (ri->nv2_redirect_offset &
>>                           (s->nv1 ? NV2_REDIR_NV1_1 : NV2_REDIR_NV1_0));
>>
>> ?
>>
>> This is more verbose for the (common?) case of redirect regardless of nv1, so maybe not.
> 
> Yes, my motivation for the notation I used is that I wanted to
> make the specification of the cpreg structs in the common case
> simple and not too long-winded. If offset 0 does ever get
> allocated, we'll have to come back and revisit this. But
> new entries clearly seem to be being allocated at the other
> end of the table, so I think our chances are good...
> 
>>> +        if (s->nv2_mem_be) {
>>> +            mop |= MO_BE;
>>> +        }
>>
>> MO_BSWAP is host dependent -- needs
>>
>>       mop |= (s->nv2_mem_be ? MO_BE : MO_LE);
> 
> Fixed.
> 
> With those two fixes, can I have a reviewed-by? This is the
> only patch without one, and all the fixes seem to me like
> very minor things not worth sending out a full v2 for.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

