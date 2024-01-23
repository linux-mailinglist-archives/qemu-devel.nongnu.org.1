Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191DC83860D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 04:33:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS7Vu-0005vg-NH; Mon, 22 Jan 2024 22:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rS7Vs-0005uv-SC
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 22:31:48 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rS7Vq-00031k-2H
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 22:31:48 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ce74ea4bf2so2448575a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 19:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705980704; x=1706585504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rst7CkaOi1dkozdL9S94SxZycocSuZNQ9dDJxL/wk3Q=;
 b=DXXMK7JAkWD4dEwubpNQwRTlSMoKDzEg+YssXViEm3RqQ7w9y7DR7pm/QFKBZVUPbW
 PayYFxsCi1zQBEYYgG91GIbyobX3ecreKrs08MU/w35hw8XcoWDNyJwF5wW24QiD/1P8
 GOUXDZnSwEEgo701Qjx9YghB55rd/anI4uTG3zP4uKgXPvkroWBAv5Fd4bRLcTTAC5B6
 Hu5dSuMzoPB4qxPWpLwkifjhy7TWSB7CZchJGTvDV1TCPU+dNje4DNNzrHKVHmyXltTY
 KIyLRJJoP9mLdpHApN0BmOgQpsZQ2hE2rsRVvvdbs0s0v1XrqJtFFeIz4a00MBMlIijd
 96rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705980704; x=1706585504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rst7CkaOi1dkozdL9S94SxZycocSuZNQ9dDJxL/wk3Q=;
 b=TEjr8Z7GqC2HgDAwKaWji9ahxeB+EqS8onGA54tUYbHDKMDQN1ZxFDkDZyL6vzQzwH
 RnC0sZQgTjGyJ+aDKytjj3G4oMtjX3MBQXgi/68IHeg3Tq3PqvhZDNcDxFBvso8UFln9
 1tg2I7/9Ane6K5Ic1g0Bjay/ZUqCeV6KDZDVvMihTu4sQpRfgGc9EN0pCch53BLTRXDc
 8HHabHBj254zcb/yQ5T3r5xGcHz38pGL9zNipdYksExmCLag6eaun9j1gTobJ6Vjq0qZ
 0WDv5j1lF3qccUn7KC1LiYI0RvZZ5U3duT8ahg+jFqTVI5BGc2RMIcP1cW/64+i2lkfU
 cTvA==
X-Gm-Message-State: AOJu0YxELDNyQtZTIvofeXYdCD8oL9Lm5GMEiArme7o+OAFycHwQLLMz
 lULZvqoGjexgiw6NP6dnSLvYdj7NpUQ4ujew5iwpTJxlhEXjn5lS/4KthBcOMMI=
X-Google-Smtp-Source: AGHT+IF8unYWD5gH5Ig0xfYav3agJAn1YG1XlxsDQjKfmFnwAprqGmjd+hs8jWN2z7a/DFfuY4iZGw==
X-Received: by 2002:a05:6a20:8410:b0:19b:42ea:314f with SMTP id
 c16-20020a056a20841000b0019b42ea314fmr6431938pzd.16.1705980704173; 
 Mon, 22 Jan 2024 19:31:44 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:2a49:979b:9002:98e6?
 (2001-44b8-2176-c800-2a49-979b-9002-98e6.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:2a49:979b:9002:98e6])
 by smtp.gmail.com with ESMTPSA id
 fa20-20020a056a002d1400b006dbdfb7624bsm2775699pfb.170.2024.01.22.19.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 19:31:43 -0800 (PST)
Message-ID: <d2a08d09-5ad3-4ca9-a113-b481dbb5c866@linaro.org>
Date: Tue, 23 Jan 2024 13:31:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
Content-Language: en-US
To: Joseph Burt <caseorum@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "open list:ARM TCG target" <qemu-arm@nongnu.org>
References: <20240121211439.100829-1-caseorum@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240121211439.100829-1-caseorum@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/22/24 07:14, Joseph Burt wrote:
> When tcg_out_qemu_st_{index,direct} were merged, the direct case for
> MO_64 was omitted, causing qemu_st_i64 to be encoded as 0xffffffff due
> to underflow when adding h.base and h.index.
> 
> Fixes: 1df6d611bdc2("tcg/arm: Introduce HostAddress")
> Signed-off-by: Joseph Burt <caseorum@gmail.com>
> ---
>   tcg/arm/tcg-target.c.inc | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


