Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99297E2EAD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r06pr-0005no-7X; Mon, 06 Nov 2023 16:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06pk-0005mm-BP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:08:32 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06pi-0004zA-SU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:08:32 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso8232261a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304909; x=1699909709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dVS5jLDuL0WfBd53KkYAz7IK7YEI7aLHgiiHzgy4WvE=;
 b=kP5aC7T3CPWniXPUz44YZ+pZDqTuAAZBD1P3fwVTwNNdviuzXIaENPZrAiMm2t7Pel
 QqKdDhHe1giw7DltNEnnZFHn8i82P51GFR73UmeRMPaQ/jT3fKh7tdR3q5hascsM6UUg
 Hsgwn1nlfUQsi36ItSp1GrDWLPfbd/bt9zXqELWWoL39MqXtN68DbJ34txMTVZg2jqPC
 Uiw5TR12FVTYxAI4O3kQiiJSib44iWb0r00EZam20mBT2MMIELOLDK1Tqm+8paR97hED
 II0eKbss5dTXDVwqIHBVlpI1+kO3Op5mQOb3VfkcF7mnHtfXFoWtuWBUie5ImiTSnVx5
 r43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304909; x=1699909709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dVS5jLDuL0WfBd53KkYAz7IK7YEI7aLHgiiHzgy4WvE=;
 b=p53Q0R3roNQs/3a/h1K3gexNN/uhAPFZqA3uPdvwj+ZyzhWjSFcdRwfy3bG1i/bMnj
 mRwhNkE92R92gxKkXAz2GNH8Hk9KqZvLc6cwYJPXTlX17sT++s4v6PRoAS54TRDGG2PC
 VOexiKnEmH6RnyzwgzqHOADHF7qfl2QcCX+3m+h388ol2ifnYy5n6HL6M73mMv+Mnk6v
 bXsr7s6xabii6bHz6H/9PM/DsCTlhkoMmgmeYGWe2l9c1XPP48BQN8UBcB9chpTLW6GP
 EVSFDoS+9uJXqBjlrnHFnHvPaYbQHg8Fc5JFTk4IsiiGkqd1i71yjmuO9cTwaSKTl5vF
 KrlA==
X-Gm-Message-State: AOJu0YyI6KoJVz1N4BNWDuPLLl3VgvYVD+MUXaviUdbsqTFen13Afqvu
 Dcc/vpWagF3GpNinEkxp8+0JoA==
X-Google-Smtp-Source: AGHT+IF/8XfhwdUuvKua66GwyLXz9NZjhDAVfnIXOQuhPhVYZx6M6DDBrOajI8HM/Jx2C8oT6k3zrg==
X-Received: by 2002:aa7:c98d:0:b0:53e:323a:274f with SMTP id
 c13-20020aa7c98d000000b0053e323a274fmr19905265edt.42.1699304909350; 
 Mon, 06 Nov 2023 13:08:29 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 m30-20020a50d7de000000b00542d3e470f9sm4837923edj.10.2023.11.06.13.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 13:08:29 -0800 (PST)
Message-ID: <8c7ec240-334a-4373-95d9-db957afdedd0@linaro.org>
Date: Mon, 6 Nov 2023 22:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/35] tcg/ppc: Tidy up tcg_target_const_match
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


