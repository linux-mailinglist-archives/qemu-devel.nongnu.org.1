Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB8789B71
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 07:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7ze-000183-Kd; Sun, 27 Aug 2023 01:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7zP-00017j-R5
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 01:07:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7zM-00080x-N8
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 01:07:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a1af910e0so1552334b3a.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 22:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693112821; x=1693717621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rU/Vbq7XNpdEAnE+30Dowll4mzHIzoQpcu5A7DzBvxw=;
 b=oQiflfGRbYyGmVPpqUri5WjokxNV+FuVsKRlxsPM4pE9Lio5PKTSoiHAunUrRtzBb6
 X76ncBRKCtPi8aZTyKtbp4cZRV1Pg0O7gbihylLqLVnKt86ClUGo0dRCyUVrkL0VUkJw
 pTmdA/SIMVaUu8INT7LDwdzHKW2HPXA4bkrKdVwxIaZ6C3UZrLdeOM2/3c7RICZtng5e
 76MouxMOxE0RIfP35iNyxeqdd8WierOE44Xam3nwaqHNFw8eaJCfhrDzYR7w/2Dqdcf3
 eycgvktTanAZr+Q1pS7S/Po6IxSyviK4SKLQE0mh+uv2tuw2mfuQPlEbLIbNZkdV6nzN
 g8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693112821; x=1693717621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rU/Vbq7XNpdEAnE+30Dowll4mzHIzoQpcu5A7DzBvxw=;
 b=k2MagBAtOTzxRvwXU3JzATqmrJ2dLam319hi27OIuS1uNv8FwU7TaQ79dj1pUtSylU
 tvoYBtT4LHuO+V9EGErxUsa/5r1gqJny3VXfoQR8Fcdm64PIhBGxgE3jiLemgkOFdC6q
 qnaKPBM9F07jUYGFM5egA1koL6suMmotb0A/coEVS6HGe1x+cpibKJwx7WK84kPKvSvL
 rIUlJDDoATIXLdLnmYWyFddzDNWj5s7f3AEkZ+eKVOT32IMOdSOdKa7ayFEIDeVh5779
 8ji8PW8GD9PwAX+zjxWX82iiVPI8WLNGwPfWB7Hmfj4cmRWVGARg52OmL9ygyPfak6oO
 g/ig==
X-Gm-Message-State: AOJu0Yz1QZ5duLXtSGuBEuqjZ7QKt/Rxx4PBRC0OGYl3J14WvLZ1e8pX
 /j++lp2UdPAZ6gF8C/oFBYAfT0i+T2ndJrVG2S8=
X-Google-Smtp-Source: AGHT+IGZG3a2nmsdkspMEpj6eLP4bFExKtM8oz/lGdYc0fOHtCp64GdYTzCi9nP0ILbJ4jp/SvVYSQ==
X-Received: by 2002:a17:902:ea09:b0:1bb:f11a:d372 with SMTP id
 s9-20020a170902ea0900b001bbf11ad372mr21473942plg.40.1693112821581; 
 Sat, 26 Aug 2023 22:07:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001a5fccab02dsm4580208plh.177.2023.08.26.22.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 22:07:01 -0700 (PDT)
Message-ID: <40f00ca1-02bd-fbff-bcd4-2ab3cf92f095@linaro.org>
Date: Sat, 26 Aug 2023 22:06:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/10] target/tricore: Fix FTOUZ being ISA v1.3.1 up
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-11-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-11-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

