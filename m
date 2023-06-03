Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E138720E08
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 08:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5KOk-0000oG-Vy; Sat, 03 Jun 2023 02:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KOj-0000ny-Da
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 02:05:57 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KOh-0005ki-Qm
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 02:05:57 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53fdae76f3aso2665800a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685772354; x=1688364354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FADIxIHmBMNLtJmxMbSrvT2vPZQy9hAkfTzrNk4CT70=;
 b=BApfHduhNBIT4ttXVbUZfpTVTgKOY/gGG09tbTB6qxhNrPiV+YNdKjxK020gCC784B
 z12dW5pJfmLudMqz3sXan39w6wb/jDLk/5CQOj72gnXLFWdUc3yZ62245APZhwi63tIv
 +d2NdZOOPvdpq5ftrIUREJQ1EmEhf6Jkx93PC5h0bfWNPXqheJ1g9CQ96cwK9QzsYtIr
 LIN66zClwsoBjb5SliBjULoJC5MEGIlQ9yCAQIedXfd02lUoB5gOdgB+Fb/8eUA96l1T
 QnzdkfJIMKuj0e3Q8Ru62IA9oJtAFmQo9ZK3yOjZEzI5qw2iLrBGAxcgJQfuHkeKiOKW
 r3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685772354; x=1688364354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FADIxIHmBMNLtJmxMbSrvT2vPZQy9hAkfTzrNk4CT70=;
 b=HbS6rEOpfCCdXPFQTTuEZTeFqRUANlQhq02/zB6esFEjQSHatHt0TL+kRJVFxVE8GA
 ghYJwFLfVj/M4Aqk8lR4FprjCBJiq9GJLYcw6RcuBqYFGEjZO4Ionz+iuGhF918IWBDT
 anaULhunaIb/Gq7ehZvdoxIPbDhheppY8Vg0emfcUeMhduC+8rVAdjiVJBJTZWY+fUu/
 X4Rmz/pfEtYCWG8qBWKtB3hqatjcuz5cwx9jy/yIRSaLY3Udk/8AplhRU6Fo5myzA3ZN
 9WFgp71GtCN0icRJ+iTXLiOb4r5NisAR9V9nYaP5eemC9wfeC7g+p0LD7Trfe6pqKhZ/
 a8Hw==
X-Gm-Message-State: AC+VfDz3OZ8AzoZZY9R6N3zzDNpOypSIi8olw0fY5s3d0GE0djYimBXM
 DWW75tcpVUS38qNwJ8x1J0LrkSmSEzzJ1kFWlUQ=
X-Google-Smtp-Source: ACHHUZ6ydWA6PsFmM9VHyJ1+8Zorg9V/6wo2vUBu4XpNrhXYBuTRgMXockdTsBJauhFMJDCT947AjA==
X-Received: by 2002:a17:902:7613:b0:1b1:b111:dfe8 with SMTP id
 k19-20020a170902761300b001b1b111dfe8mr1972445pll.66.1685772353964; 
 Fri, 02 Jun 2023 23:05:53 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a1709027c8d00b001b045c9ababsm2331149pll.264.2023.06.02.23.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 23:05:53 -0700 (PDT)
Message-ID: <ebd564a1-2b63-2062-1472-0464b4419c59@linaro.org>
Date: Fri, 2 Jun 2023 23:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/20] target/arm: Convert MSR (reg), MRS, SYS, SYSL to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert MSR (reg), MRS, SYS, SYSL to decodetree.  For QEMU these are
> all essentially the same instruction (system register access).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  8 ++++++++
>   target/arm/tcg/translate-a64.c | 32 +++++---------------------------
>   2 files changed, 13 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

