Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A027DA8EF
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwp1N-0001Fe-K5; Sat, 28 Oct 2023 15:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwp1L-0001FB-5f
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:30:55 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwp1J-0001sx-N1
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:30:54 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso2283880a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521452; x=1699126252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9EXvNpqEeIzzlDDjMVJD1oPFXt6ObumXC4xH5/sJV24=;
 b=v7dH8etonnoNc14BW210pPCrZJ1eSvIHhqXddoPYmajbd4jABt6DGh8cJC1Hw2jzWs
 BlDT3Y+jWzcyTbwi2kPDH5qo3qw/z8mxtoYFlq9HcKw4aCmrF9BPe1vZVcIq9r5umFAZ
 U0hvly8nRIUYTB+rgWOzBNnriTx1jVw1FFQ8hdidQeDZPB3MUegqcQJ4PZDKfvYpy9ln
 sbeYvNvOCN+96rbExPxygv5kUjyU6rBEA+d1pm25uv3cBsvYNPkxabMasoZXa5xztYaP
 n4moZCojUId6z7qPyzB7aZAIb2TXifQkcl3blthM/mYH4XmrC9s41F6Kt/YM4mJCZh+a
 6/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521452; x=1699126252;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9EXvNpqEeIzzlDDjMVJD1oPFXt6ObumXC4xH5/sJV24=;
 b=KG3vuomhijjpnrZNJ6GOPOmwWxpSxHXVpJFAwpJ8ZEk7eQdVQ8Sq5f/xocTTLCinFT
 6oeku2oC8eArbXaUuanpBxKdU+ygARh9r52+ojgp5v997UepkV48KBxWlSZ0dsN4duHp
 g//uzA0aR/sROqXAD6p+sT99IoihAS1/pcO/PT2GGNtPZjRYp777dfoBgx+LOzNxoDL+
 PHbjBHQ37QgjDAmuDkoEd56ITDY4zLXcTQb+eRHI4DoA8iCfOXHBCw874NeubRVML8NC
 7d/m14ZpS5m8M43QwhvJWJ3nkKTWA75cLIQZAJjx6+3epLmxoq7eNjUb2g9LbiIfSYgS
 URWw==
X-Gm-Message-State: AOJu0YyuLeqjXIn3RoYOIrejBX2Onzg4YwjtNFOnTWBKHMInHZFvZjUg
 6pnnyOlOw9i5tcmZv5WckzGFTA==
X-Google-Smtp-Source: AGHT+IEOAC06sPZ6itsg00/ywobQhfar8W5SMNbbXpC88SMWDFfNZMbgk5KKzpt8XexjNk0enMABXg==
X-Received: by 2002:a17:902:a40d:b0:1cc:3af4:fac3 with SMTP id
 p13-20020a170902a40d00b001cc3af4fac3mr793716plq.10.1698521452487; 
 Sat, 28 Oct 2023 12:30:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a170902ea8300b001c3267ae317sm2073072plb.165.2023.10.28.12.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:30:52 -0700 (PDT)
Message-ID: <107be7f7-e2d6-49a0-9a1a-ea19484c2e2c@linaro.org>
Date: Sat, 28 Oct 2023 12:30:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] gdbstub: Check if gdb_regs is NULL
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/23 03:33, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> cpu->gdb_regs may be NULL if no coprocessor is registered.
> 
> Fixes: 73c392c26b ("gdbstub: Replace gdb_regs with an array")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20231019101030.128431-2-akihiko.odaki@daynix.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Fabiano Rosas <farosas@suse.de>
> ---
>   gdbstub/gdbstub.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)

I ran into the same thing myself recently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~

