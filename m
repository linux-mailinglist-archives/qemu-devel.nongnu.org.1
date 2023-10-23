Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C17D3A61
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:10:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwYv-0005lP-C9; Mon, 23 Oct 2023 11:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwYt-0005i7-B2
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:09:47 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwYq-000672-2g
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:09:46 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so542554266b.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698073782; x=1698678582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4kBmqv5WsJlz2C+5Eo2ECwrJUekntZpwTm7LVzlQXoo=;
 b=zTHyhrSkCvoa569MRj8gudzwEEQsS1Ev/VrcgUMwJRWAg2pPOf7l0tS+edGqG8RFZr
 RHWS2Ih5unyJtVmgGZPXtjh3Ha6EMJJHrAB8xE/RAAUB3Jq48merdAytiSkrU8LA6QhX
 fAevEmKATd1fopzXI48rkfnuU9jUFyVFcPDXShwXAqi/NpXT9yUnCNLD+Pa7n7HLhK8d
 2cEpFW4SsAGAlMOlXMJqEEnWlUHLG23AkPZZjPDgXknNYDuJ4jnl4fyGVBvqT5qQ99Jt
 tIyllMwxNpDe+vLlUUtqvY5kpL9dD0XpAZ3kCK8GChypgv5OgZ8IEvxXp2mw2/b0NtgR
 pwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073782; x=1698678582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kBmqv5WsJlz2C+5Eo2ECwrJUekntZpwTm7LVzlQXoo=;
 b=p9mp6cBJ/6GN7iqD4u9MIzN0WRv6zMr2dqRemdMpF7V0SxcLWqLXXwnE6piXMMAcs2
 nqKDTG538O6km3T82SDA3pcGltpmW+qMBSIBDTGdT3uaK788aYYNht5T1fmEqCNxPzL8
 nWiBU293HNdq88SqcQ+fYSE0So+HdYNmIJ6aKxRysqNkCFnzPuyzLnRevatuEymd+BxQ
 l5DFZZGwBiC0Vsz+nUsMY5qUsnGpYCwGSF+dI5FWAS5n/4RjUSw5S9uHOzNMUXgyPu0m
 5jn/VnBytCvnPD5PMnHlXQAPfjv+3AQUhDWbOt7L1TdWJmL6ssIzOj+dvLPCH8nXfXWA
 MV1A==
X-Gm-Message-State: AOJu0YwzdV5wXuRE90N+UZDatUvi2vYBr9Gh39s2uoQ8cxZ3rYghoKa0
 duxkHVCnOmptEgXs5jTctGcZQg==
X-Google-Smtp-Source: AGHT+IFeIahGQXVhe1uj6sbq3zPTBbAaBkM0l7jh0+4g4X87wx5Ys7zuebQ0jxdA8XVY21ybNbLjpg==
X-Received: by 2002:a17:907:9815:b0:9be:7b67:1674 with SMTP id
 ji21-20020a170907981500b009be7b671674mr8253518ejc.3.1698073782286; 
 Mon, 23 Oct 2023 08:09:42 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a17090613d100b009a1a653770bsm6692588ejc.87.2023.10.23.08.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:09:41 -0700 (PDT)
Message-ID: <43e3492c-4c07-0542-20cd-8ca8af6e6277@linaro.org>
Date: Mon, 23 Oct 2023 17:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/7] target/arm: Use tcg_gen_ext_i64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-3-richard.henderson@linaro.org>
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

On 19/10/23 20:29, Richard Henderson wrote:
> The ext_and_shift_reg helper does this plus a shift.
> The non-zero check for shift count is duplicate to
> the one done within tcg_gen_shli_i64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 37 ++--------------------------------
>   1 file changed, 2 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


