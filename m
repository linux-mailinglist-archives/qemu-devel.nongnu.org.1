Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D52707CC200
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiYU-0002KP-KK; Tue, 17 Oct 2023 07:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsiYS-0002KH-UH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:48:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsiYQ-0003RA-Ai
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:48:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so976655766b.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697543283; x=1698148083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1o0aOrJZ61ugD64nbIrECyQhTjmYZ/f/X/xNN/b4bFs=;
 b=dW90mQgBxiW8yi6YOR/UxLxanUlrzreSD4IsV48hWgZZH3J713pvNb6wANGOdTSxpn
 nPvJ4QBMD+jmGKHy9ML9RmNqRuEsb1X8zbfLyjEeMqljuJpz2qRAKHlFmFZceSlRR6E5
 bFf/5fr2A0xlS2trYCYd0ucqS8RrigU28e17MYkHoziHCq11E02oGpU+24kI48CsRGFN
 +M/CsfQSXPQILlyjtwlZF7Uh57run0s/sHH7UEB0NwJOVMjJjxxdl/RYWuczg1RVyq06
 OJQs/OLZB0tabJJCtGqnJadWzss/Wu/xFnU3IXS63pC4iuWe9eob+Be81BD6sR+c8xHm
 wysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697543283; x=1698148083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1o0aOrJZ61ugD64nbIrECyQhTjmYZ/f/X/xNN/b4bFs=;
 b=THvuosCuiJHDyakEYRplzoon4p/njjACeSdi6/ew1SgZSf6/79lyWMt8Nm70w0ayE8
 hliA3Qq5mIijkGYlL5rzLOJOfqSHlVsAF36sI8RhR9sB19lwestihgT7As+yRgTDzjIh
 b9hmBBe9EiT14Ocio13j4W2mLpEBiVwT7dLk5KYdOCKyc3ZPG33K4aE3tvSwSlpP2X8m
 VTvJ1SXIVKX8dSgbg2PsxAwLR2oXxc8MivwFDq/K1A0JjF4JpB2qiugW58HxLFGSsvjp
 P7fJtID4aqidzZNO+2iE8IKa9fI8ysZOPBoAUrtQMoHHSOLcko3Enex1tDujNPQ8A2Bp
 4k3Q==
X-Gm-Message-State: AOJu0Yz+kwI+l4J8a/jt6WcueoVpk2baedp7tOVyeoe86+fDOR0BnUuh
 cN097gr9d/OKsocAdCPx63piRA==
X-Google-Smtp-Source: AGHT+IGN1mogwc8AIdEoXqD2S79Ii844uRngAgmtRC4Eddu/qEe/qMX0FmS2oSgb1re/KOKt28A1vA==
X-Received: by 2002:a17:906:fe4b:b0:9ae:6388:e09b with SMTP id
 wz11-20020a170906fe4b00b009ae6388e09bmr1478612ejb.40.1697543283599; 
 Tue, 17 Oct 2023 04:48:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a17090655c100b009a193a5acffsm1110080ejp.121.2023.10.17.04.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 04:48:03 -0700 (PDT)
Message-ID: <385640c8-601d-65fd-118b-c69fecaa8a41@linaro.org>
Date: Tue, 17 Oct 2023 13:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] tcg: Add tcg_gen_{ld,st}_i128
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231013175109.124308-1-richard.henderson@linaro.org>
 <20231013175109.124308-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013175109.124308-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 19:51, Richard Henderson wrote:
> Do not require the translators to jump through concat and
> extract of i64 in order to move values to and from  env.

(extra space)

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  3 +++
>   tcg/tcg-op.c                | 22 ++++++++++++++++++++++
>   2 files changed, 25 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


