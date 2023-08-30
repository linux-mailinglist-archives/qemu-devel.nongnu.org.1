Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7CF78E2DE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbU4o-0003ko-Ik; Wed, 30 Aug 2023 18:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbU4n-0003gZ-3C
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:54:17 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbU4k-0002cj-Ps
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:54:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso1330325ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693436053; x=1694040853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ogBeAXlw/UkuLhoEvGB88jNZTY0XDx7Ml6u68Z6xAxA=;
 b=vrbuVWyM6cOR9Duv5eRSmnGQLaeyN6SjrmxvAoNvrqgHYcxjITI69FSx61uhkrGW/X
 vciPOnUmGWpGrZDszfKz/CZRcuKLE+72s/CW3LzXCRUpz8leBpKZWwkambQGBhQGg6cU
 yfFRDnC1s6zAg75mEs7m3/mfTO/vH44OV2u8YWHYN0a4IYRAehtMqGYFHZ9saZPRK5G7
 zSAu0r/5Le7GVeiUwQFrZ2m5XCGHVwRML8/gUbIIOlMKs+NI1XnYTisf92kvEah7hgPj
 ZtW9kVha8DJgCF8EFSPumRGFK6pL2WfbTGa+b0DkQ3e1/t++ylBjuY+XM/Jj6Ii++KiN
 2zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693436053; x=1694040853;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ogBeAXlw/UkuLhoEvGB88jNZTY0XDx7Ml6u68Z6xAxA=;
 b=cqUTZu4nHqWbrEW1/r53hacXzgLiSgRw7kyLDP7kC5Eo58vIEcpeVNRixlX59I6HrO
 tBH1cwPC7ip7rgWwsdxBwFXzSHZWIGZHmmaH8Pqs9sgIi3n7oqhstmPd7irJ9x3N0+oR
 SXWngM6iImoM7cSASQWG0FrtMgICIfT4gm1JwiLXjvJWsk3pdSMobdAB6ekO9cHuvL5B
 rAMwpHd3j/3x0edPnWxT4BxcxYA/qrDtGdbY+h2FEsy9SlqfnhaRMrh20DCzhD6FH466
 58ja+omkt17njbcGRqZbKDDUtJo/xVYw2sFD/Jcz4Zkp5lvyNeqIlLm1ZgWYG4KIpmg0
 mK/A==
X-Gm-Message-State: AOJu0YzoKGdmNt86p4HYJLEzhTazJVrtt8GL/qURkMoWQWIPX5Xi6kUp
 rN8iTKGnsI6gxp6GWIW/rBovfQ==
X-Google-Smtp-Source: AGHT+IGhgKhFfzqsWU8Uyp3rk+Xcx4Woe7TmlW986EcEo23Twlzab2MIrcSxDHFf+5uY4PzpYLHPwA==
X-Received: by 2002:a17:902:d4c3:b0:1b9:c68f:91a5 with SMTP id
 o3-20020a170902d4c300b001b9c68f91a5mr4249234plg.6.1693436053433; 
 Wed, 30 Aug 2023 15:54:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b2069072ccsm26262plc.18.2023.08.30.15.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:54:12 -0700 (PDT)
Message-ID: <82e48098-a8e5-85e6-da90-3f5c12b7ae6e@linaro.org>
Date: Wed, 30 Aug 2023 15:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 29/48] target/loongarch: Implement xvsrlr xvsrar
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-30-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-30-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVSRLR[I].{B/H/W/D};
> - XVSRAR[I].{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                | 17 +++++++++++++++++
>   target/loongarch/disas.c                     | 18 ++++++++++++++++++
>   target/loongarch/vec_helper.c                | 12 ++++++++----
>   target/loongarch/insn_trans/trans_lasx.c.inc | 18 ++++++++++++++++++
>   4 files changed, 61 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

