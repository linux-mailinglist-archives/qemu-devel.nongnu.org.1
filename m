Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5C7BD31D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjV5-0006ww-Aq; Mon, 09 Oct 2023 02:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjV4-0006wd-AI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:12:18 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjV1-0000ex-G3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:12:18 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533c8f8f91dso7217064a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696831933; x=1697436733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vXC4vjRurkWAquiFqYJbLTG9LUebIfAgebLC0Y3e+3I=;
 b=zy8OZb1udnRYiRX/5E013QMRvG40yoztSyUMJMpJIAIHFdlvAHPzRy15jJATf5zmUa
 1j4V5Rr4nfCby36iYAMaaoWW7geAO6JJ8iWYpVme8IsfhPNZnhwJyOwBC5677ekDRQ0N
 V4h40ho0yN5odg2WDh6mz3uISgPqfE4HQdNFS4dMJQ3zy4qmB9/3yJXwbXvG0oHRaLYw
 kRRz2lyX2FysAcRpa2FYgggo0svrQbMaZdBnbF7nkod2jp1TDiDxUQLDJSj+njIQdwvI
 EPbCTULDk0OJVwE9gfgzETAijYipPwJWMQM98rQ8a6QqnbSxhqooqfD94JRxwquzhCNQ
 +IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696831933; x=1697436733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vXC4vjRurkWAquiFqYJbLTG9LUebIfAgebLC0Y3e+3I=;
 b=R9GsWCknJf/Vwk7zWpPqQRlVQ4wOP8oDzLouJkwumeAdAa1iRx5KM4ojXzW/8fpPgw
 9gTk/QriwpR/7Pf1VqdwCz6Rx62iNjhhcicQpwVsC80x5IRQXbKhb9J2NgUn6/YQYH7b
 cVmb6olFygfMgBrYK61fgTLRaPGDe6rNAoHiDyP1MZSPw5039Rg9gL7pO9qfaem9iEqo
 9IQcCBbCYXMPdL3jc6NB4eexuaWE/Wnwckl5d9UfVvvHgYRmP/2OfGuIiRnlEZwg11Hv
 ULTq7Ea14EUPTv6XcGOcOGx0C/ClKgAKvD14y5jisaWFFHKH/MocViMCENW6pnLUho2p
 uLiw==
X-Gm-Message-State: AOJu0YynJ92nmziLAh1IJtHCtS1x+XNQTg+Qkjo/2Q7dT3KhpkBPNCHI
 Jk6sT3lx+PTGsGYje18ZzK8l4g==
X-Google-Smtp-Source: AGHT+IEoD8BNuxhD2yMUM3oRlMLVtbZuewVYl0weUgcJqEqyzuwG2AsX+EkO9Pj0fRcv63Cm/q4Vvg==
X-Received: by 2002:aa7:c248:0:b0:534:6b51:83a3 with SMTP id
 y8-20020aa7c248000000b005346b5183a3mr13570130edo.1.1696831933438; 
 Sun, 08 Oct 2023 23:12:13 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 y20-20020aa7d514000000b00537708be5c6sm5764043edq.73.2023.10.08.23.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:12:13 -0700 (PDT)
Message-ID: <c36a2922-7cfe-1099-7ceb-e4780f4c63f5@linaro.org>
Date: Mon, 9 Oct 2023 08:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] target/hexagon: fix some occurrences of
 -Wshadow=local
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20231008220945.983643-1-bcain@quicinc.com>
 <20231008220945.983643-3-bcain@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231008220945.983643-3-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 00:09, Brian Cain wrote:
> Of the changes in this commit, the changes in `HELPER(commit_hvx_stores)()`
> are less obvious.  They are required because of some macro invocations like
> SCATTER_OP_WRITE_TO_MEM().
> 
> e.g.:
> 
>      In file included from ../target/hexagon/op_helper.c:31:
>      ../target/hexagon/mmvec/macros.h:205:18: error: declaration of ‘i’ shadows a previous local [-Werror=shadow=compatible-local]
>        205 |         for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
>            |                  ^
>      ../target/hexagon/op_helper.c:157:17: note: in expansion of macro ‘SCATTER_OP_WRITE_TO_MEM’
>        157 |                 SCATTER_OP_WRITE_TO_MEM(uint16_t);
>            |                 ^~~~~~~~~~~~~~~~~~~~~~~
>      ../target/hexagon/op_helper.c:135:9: note: shadowed declaration is here
>        135 |     int i;
>            |         ^
>      In file included from ../target/hexagon/op_helper.c:31:
>      ../target/hexagon/mmvec/macros.h:204:19: error: declaration of ‘ra’ shadows a previous local [-Werror=shadow=compatible-local]
>        204 |         uintptr_t ra = GETPC(); \
>            |                   ^~
>      ../target/hexagon/op_helper.c:160:17: note: in expansion of macro ‘SCATTER_OP_WRITE_TO_MEM’
>        160 |                 SCATTER_OP_WRITE_TO_MEM(uint32_t);
>            |                 ^~~~~~~~~~~~~~~~~~~~~~~
>      ../target/hexagon/op_helper.c:134:15: note: shadowed declaration is here
>        134 |     uintptr_t ra = GETPC();
>            |               ^~
> 
> Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/imported/alu.idef |  6 +++---
>   target/hexagon/mmvec/macros.h    |  2 +-
>   target/hexagon/op_helper.c       |  9 +++------
>   target/hexagon/translate.c       | 10 +++++-----
>   4 files changed, 12 insertions(+), 15 deletions(-)

No change since v2:
https://lore.kernel.org/qemu-devel/45707b6e-6835-421f-e89b-6c1b0c50e35f@linaro.org/

Please carry reviewer tags so we don't re-review patches.

Again,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


