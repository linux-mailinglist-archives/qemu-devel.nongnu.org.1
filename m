Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77507776E45
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 04:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTvsc-0008EI-B7; Wed, 09 Aug 2023 22:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvsa-0008Ds-LW
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:58:28 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvsZ-00009A-5Z
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:58:28 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1bb69c0070dso438286fac.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 19:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691636305; x=1692241105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xKTKMEGsB4wnesraOkwZHRHaMsl5OdZ7+1h1UW1f1l0=;
 b=hTftlknXwPkNMjCts1umTVDKc84CLVoF+XY0TbPgLxpv+zakHbGRzn2FoHxEAxyc9U
 Xw7zJBLnAzvTGYALZgvZnc03MhZdQC+KTiLPQlGwd2SvTZjnIbjEnHNMtlHWSaUaNPmk
 h0HMSqeefLWv6HSZegTmZP1iHokT1BF2XO8IvpnTs67psQxqDdhKkvmBXK5nKB6qQN6y
 0+CJKA8BW7InkTebxmXY39SMrSqHxOZ8nVWY3yzykPWLmlvu9pdTwPkcErEAiRZV+ZMQ
 xBhp9qZqwV5beRfHX+AI7Zv1WguG1KYAEkNcxk+5xlXuFdYKydfspYXd3WSnRZpfFpJV
 8Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691636305; x=1692241105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xKTKMEGsB4wnesraOkwZHRHaMsl5OdZ7+1h1UW1f1l0=;
 b=S1gcpyyAyLtktNn9bVHXYmNgJPeH/PnmxkH9QmwyMjBl24ZCeqyDKWnje5p3KuaeA2
 ZYtz9qrDDniQgrB7h0+iMQhyILTDLF+tOh2FJHkH+9tO/rvY6tdLkTplQ7ejjthVNi0m
 df/W9bGCAhWQObaZDrIc5Z58Lze6MRSFbLsRlbjDAz3X1KA3B6iWrOsvGri5QghLPYf2
 zx4XRUDI/d9HHM47Gh+odjiFL1u1jBGw0dqT9fjFiSLaD4vIYq9G09n0q4iyxAvZvEM2
 AP9csyL+l+eYmvCXKmOPDY3Dm3E1P5XzC4OFF30eA5tay1eq3iT198fYsTeJQNF0aw0N
 GiEQ==
X-Gm-Message-State: AOJu0Yy4fxqrFUrd7jD2RlgKma/yxpMMUBEjSxZehji7GGFbrmYTv0ma
 cEEJHJRauXwkRcZMQfzcq9QgOimIYYYPxm7vI5U=
X-Google-Smtp-Source: AGHT+IEmfOHWqME/NOxZK78WggyJgBCH+Ms9XLn+cRvY9gRue8JvLkBBbJlmoV9LaZDilniK+SrYdg==
X-Received: by 2002:aca:280f:0:b0:3a7:b500:6f97 with SMTP id
 15-20020aca280f000000b003a7b5006f97mr1087315oix.56.1691636305520; 
 Wed, 09 Aug 2023 19:58:25 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 29-20020a17090a195d00b00268385b0501sm2332258pjh.27.2023.08.09.19.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 19:58:25 -0700 (PDT)
Message-ID: <c33bfbca-a5fc-6eb2-2db7-8c39569ce94c@linaro.org>
Date: Wed, 9 Aug 2023 19:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/11] target/loongarch: Reject la64-only instructions
 in la32 mode
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, i.qemu@xen0n.name,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, maobibo@loongson.cn
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-9-c@jia.je>
 <8e84ef00-7272-c26a-9e97-c135d577cf08@linaro.org>
 <44bcb982-f086-94d8-d281-36707bdaa00c@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <44bcb982-f086-94d8-d281-36707bdaa00c@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 19:38, gaosong wrote:
> And, I will send a patch to Check CPUCFG.2.LSX, Thanks for you suggestion.

There are similar missing checks for CPUCFG.2 FP, FP_SP, FP_DP, LSPW and LAM.

Also note that loongarch_la464_initfn misses setting LSPW.


r~

