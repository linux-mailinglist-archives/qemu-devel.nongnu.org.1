Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03C799962
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 17:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf0Ls-0006Ji-4J; Sat, 09 Sep 2023 11:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf0Lp-0006In-S4
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 11:58:25 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf0Lm-0003Z3-Dv
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 11:58:25 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-57756115f08so98919a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694275100; x=1694879900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k7lyftKjpac+B4tW5zU2gSfyT8PFFD7P0aqODmN+Lnk=;
 b=Z6x1g+48n1tXEw9ugJQlrJBu+FcMJz2ytM6zSKL/5w5JxAVrDLV6kaqpStpA2eHV9t
 kYBWxeamrwvEmtzZ1kEFsDfz+i100PPiWzZuBpqFHdMgmxCImy52D9ai8eZNrCFuBKRQ
 6WOoORYyRcjwg8LPMXwQ+kjftslr6i6SAdqJrkcjWYExVpH2HAfLqn7n3YBbOmKDUUP7
 KGioY05V0PkHMwX0cfvxorv9QJTfFd2xDGOP79oZ9CRqgBLQlurjJ6Tk+fnaf7TpOqA+
 /JW24drJ4LYd8+NiXifBqnrauMakIO2bTQI99NgOBw+wrwCjTowYuTEsrSRfJ2LoT5t4
 5h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694275100; x=1694879900;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k7lyftKjpac+B4tW5zU2gSfyT8PFFD7P0aqODmN+Lnk=;
 b=vKQ5J987CUcrl6LtHyT3foRLP3QIwvQ8WoR9LGtJmzXC/qTsEVOJdHaMnEzGWd8lhJ
 wH7+b7s5MW4+zUB+1oOHm/3F7QsXgmKuEqIk1EncxWcLLrLprsdW7J+eGlw0gAgD+9w3
 Uro041Mweo3H6KbaWGy23IyE2A6/H9wfC79aDRQ6/37/hRDGSv/cUC6AGTSCc3taxlNU
 seOJzwgtXfha8v6jOwBmDvLo9bo3Ju5I7QmA4jQdDf/6BMwsZwfjuwUBz1Jj5Bil1HAr
 N02RshCeoIQYHDM2qy0A36aFogxJ04TqFmyU/13bl6uvNwR3gesVdKdJpv+/briIlwtx
 3dwg==
X-Gm-Message-State: AOJu0YwrIlb2D76XjkjEckboDujCWiYyTZS9SAcsEP/N5sgE3d7hBxp4
 R4E5OqgD6AKB7Mds23BKN2ObOQ==
X-Google-Smtp-Source: AGHT+IE1cMAACVQUH8OCSJnL96oXgb1VbClPN1t0ORm1vdIeF48GmOgAnjFNE4Fajiu1ehebaBNc/g==
X-Received: by 2002:a17:90a:2c9:b0:26b:48e8:cd76 with SMTP id
 d9-20020a17090a02c900b0026b48e8cd76mr5387094pjd.37.1694275100374; 
 Sat, 09 Sep 2023 08:58:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a170903100b00b001b895336435sm3445710plb.21.2023.09.09.08.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 08:58:19 -0700 (PDT)
Message-ID: <fc2e99c0-2301-38a7-f20e-7c9176ffec00@linaro.org>
Date: Sat, 9 Sep 2023 08:58:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/14] target/arm: Implement the SET* instructions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 09:03, Peter Maydell wrote:
> Implement the SET* instructions which collectively implement a
> "memset" operation.  These come in a set of three, eg SETP
> (prologue), SETM (main), SETE (epilogue), and each of those has
> different flavours to indicate whether memory accesses should be
> unpriv or non-temporal.
> 
> This commit does not include the "memset with tag setting"
> SETG* instructions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    |   4 +
>   target/arm/tcg/a64.decode      |  16 ++
>   target/arm/tcg/helper-a64.c    | 323 +++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c |  49 +++++
>   4 files changed, 392 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

