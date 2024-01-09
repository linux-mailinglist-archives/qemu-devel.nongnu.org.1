Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308E8281DD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:37:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7bG-00010y-QW; Tue, 09 Jan 2024 03:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN7bE-00010h-Ie
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:36:40 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN7bB-0007dw-WD
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:36:39 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3eae5c1d7so11269085ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 00:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704789395; x=1705394195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrNQc4nUn38P9xnLxpS/uxdLLjaCdgcsBJ1PiNeRlO0=;
 b=oKI3bC3N2IScuW8vyR/8XR65tW2hqOaJ6UaPfnjqx8uCYNuGgusBkjjXuOcC38jBGP
 +rVZTIQpnYMvNHwq8TGsj0KmU+Wo/24aCup+68xQtCX53uTGjoLgMuj11xY7rfqb/OoQ
 B0K1fe6yxQ0B1A1H85bvY910AYB0w672sEwTCbRfyEBHZihPE+WJvX60eLSUbD6m3rVo
 C2pdE+MnrBdf0K+/be83y0U6VO8uWHRMB7Wv7SrAaKMAQazojJ/FCDp8rq6VoYHfkhFG
 q9G/DuotpBtiLEi2KP3fHYJXkhGVWPeZHdqCXMg9VsLdJ8Ih5EtGWgdSKR17rbIgCWqd
 swkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704789395; x=1705394195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrNQc4nUn38P9xnLxpS/uxdLLjaCdgcsBJ1PiNeRlO0=;
 b=iFk4nwBfyyzzzkMsu4ZGmMplRfKbeuI6YAjAafwzEbLk6VJ7tDL0y7ANk9VljtRiBo
 xCniyM6bqomuETEAbsKQUccaYeVvnHITbL78Icu9DzaS1kVvVFh6+YjB8lZZE+pKqFZk
 jBlnytV2u4fF1Ag4XKbGeDQR9REdiHhsFLnJbbOzQfiejis8vMXYyzxWx75WqqDlHu6f
 n0dRHeIAYJHu+zhORRrKnZ3wfGL2qESZjQZClRIOxA58FZ9MRzkuHPTPIvIC9rdkW2t2
 tvjwJlCEe7HazCRZzHrOXc8OkYFwJYpC5UqMAkyNdsy/HTdVEM8YI/3rvuH/SgJ8oQZN
 zXBA==
X-Gm-Message-State: AOJu0Yx0BYyIbvx61Wq9jDqeX66JvohvSIOsBK0/d516mDOPlkFw66h5
 4+CN87vYt1cupSiBYAjD4D2zMAEOW3aR0Q==
X-Google-Smtp-Source: AGHT+IEDgcHdbjQG/SBb7Y8jucxZ4g3Cfy4vxN6pEXpRnCHL3WY6LM8R9Y7kI2gWSKRXkWRv8/lTCg==
X-Received: by 2002:a17:902:bb16:b0:1d4:e234:a3da with SMTP id
 im22-20020a170902bb1600b001d4e234a3damr2155942plb.139.1704789394874; 
 Tue, 09 Jan 2024 00:36:34 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a170902768a00b001d5595514d1sm764591pll.307.2024.01.09.00.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 00:36:34 -0800 (PST)
Message-ID: <c217a8af-66dd-4423-9a2e-68e0b0192bf6@linaro.org>
Date: Tue, 9 Jan 2024 19:36:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] tcg: Introduce TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <CABgObfZme6gNZG=3ibXb8=+yAg=LHPeHYdncdx2LgN741bk_7A@mail.gmail.com>
 <6327ac54-6394-4648-b4b8-2294a37b1588@linaro.org>
 <CABgObfYE_L=oF0-bKESJVcPhNr_-R3Yw4Uoi7vtV3iW6Q5=26A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfYE_L=oF0-bKESJVcPhNr_-R3Yw4Uoi7vtV3iW6Q5=26A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/9/24 09:55, Paolo Bonzini wrote:
> 
> 
> Il lun 8 gen 2024, 22:45 Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>      > I was thinking: a lot of RISC targets simply do AND/ANDI
>      > followed by the sequence used for TCG_COND_NE.  Would it make sense to
>      > have a TCG_TARGET_SUPPORTS_TST bit and, if absent, lower TSTEQ/TSTNE
>      > to AND+EQ/NE directly in the optimizer?
> 
>     Probably best, yes.
> 
> 
> Ok, I will give it a shot.

I'm in the process now...


r~

