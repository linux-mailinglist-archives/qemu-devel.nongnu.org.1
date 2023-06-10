Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED172AC88
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 17:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q80M3-0006n9-O3; Sat, 10 Jun 2023 11:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80M1-0006ms-7K
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:18:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80Lz-0006Xr-Ie
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:18:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-651f2f38634so2937934b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686410290; x=1689002290;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6ETqLbxyg7PA9i6A0+pP0LbOaQdNxsN3gM90eGAP28=;
 b=euTtFmAkSNlbmDfVteFmHFBLtOC31oHlJdLTbUCThkNvDhizYCvXErh+LBGElaK7KO
 IS3U/kqbOJjNIBjsiYmK+aPbf7FjGJaKSKkGDAhUdXWYIEvKMXhpMQJmi2yiyxm33v4e
 8shJqgJuysMEPvvi8ZUzO/94VWqKRb56H35N020N05wpIdUTA5pP2xxImBoljYFV12f4
 5pdLxMdPVR3GYiYcdngKA/xmMGZcRWjo5roet7dfjrjgAkorvmcSAM88Nwyn8zOiSxP1
 rRkebD8/s+DF4tZ0x+aBjg8yzV0RaSxM4DPtdRckNpVROp2KztaWvR6vVQVgQFHXHlC9
 jU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686410290; x=1689002290;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6ETqLbxyg7PA9i6A0+pP0LbOaQdNxsN3gM90eGAP28=;
 b=d0tayaap0Xyg2/MESBQzqK84XIL5gRwkhH1fjhqen6lXxRbhe6OvUNurVE4RL8ECCk
 gjaWWDRZSckQhzGdndR/GUi89EoK4bw2H/u69P+qRRMkfQTxetC3xzDcyFw+uTvkD/2U
 SAo9D/VDQfjOiTMzrEd8p9X/8sdcA1coprXgzXGd5ZT91A5EVAjwlawR4ClSWntKcX41
 GboQ2Wbet/Q9QSjzDqv4v9ucEX4EiUXpb8Bpnzr+xWrUApgOCEIko+Nlo6RA3nzZNgPT
 MDiXF5RRorYpe17++UwzAxM5nhu5Eru+P3thyHFO3WnDuCV1IE/ggcJKuJqb0fSIvONs
 4REA==
X-Gm-Message-State: AC+VfDxgmpfIAdrAPrPLbV6fxgaMON6cn4crhCAl0iS3qdSkmh2hwMx8
 r0b/BYAz4WdSeWxbR1KS54b99LHlkH66wyIIVC8=
X-Google-Smtp-Source: ACHHUZ4Ltk/jl8cuOJ7KOrfnOV0Fq4kv6Z2H2Ot5nNTZ0n33oVND72o27hI9Be9Fky2i175iEodTJQ==
X-Received: by 2002:a05:6a00:189e:b0:657:bdf1:cce1 with SMTP id
 x30-20020a056a00189e00b00657bdf1cce1mr6190452pfh.25.1686410289880; 
 Sat, 10 Jun 2023 08:18:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 j15-20020aa783cf000000b0064fde7ae1ffsm3108829pfn.38.2023.06.10.08.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 08:18:09 -0700 (PDT)
Message-ID: <76aad4a8-4dff-0ba2-7c68-aed7495c7ec7@linaro.org>
Date: Sat, 10 Jun 2023 08:18:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/6] target/tricore: Add crc32l.w insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
 <20230610105547.159148-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610105547.159148-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/10/23 03:55, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/helper.h          |  3 ++-
>   target/tricore/op_helper.c       | 10 +++++++++-
>   target/tricore/translate.c       | 12 ++++++++++--
>   target/tricore/tricore-opcodes.h |  3 ++-
>   4 files changed, 23 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

