Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD177942D
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUpV-0000GC-4b; Fri, 11 Aug 2023 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUpS-0000Ax-SL
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:17:34 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUpR-0002pg-E2
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:17:34 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1c0fff40ec6so1353891fac.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691770652; x=1692375452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xrD7e2u9SOcfyz+wvkjY7hsjoIJI6nO0lMAN7gQhPlA=;
 b=sCzxGtVWk8eBz18gi3ALGO1QQbRwnvXsReptsDSVsLbLK96M/psCJQ6nsMSNaprZyQ
 qh/EASFNRE9vFsWAAjvaLFze+Tysgq2l+Lks4cfANqTwsTy60XYjKuGa5ecIGpFzuIKM
 orHwq9r8FtmSCOe6hyh6NekVUBh/Tgs995hfs2lHTf8clF4+EYda+Bd7962abV9SIbP5
 e+sst4aIz+eGKCKkpRGnnghIbjJ2rgtR3WdKlabvPc/2z+U1kDSYso3RN7fXcbuDKqOh
 P0mvc/k9k0UE7j/mLmH7pr0Ps8bt6YDKT5FOUFv6/QH29ys2IiPJA10U3hMSS98DKst/
 4hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770652; x=1692375452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xrD7e2u9SOcfyz+wvkjY7hsjoIJI6nO0lMAN7gQhPlA=;
 b=YKrq2jFe4YC7AzMlaXjjiOFsSgY17zOj4wzvLKgmnzR2ZLoBXJaEl8ir1n2rGifuog
 boX2IIP+S4EBPwyOGDatAWJIxap3zuvZ65hDuV4DTowmGV1bWjQJK2vm3t0RvoXYfOCF
 tbVd1JyRu5nuGBN3JyDw13kcRx1g9czH5dkZ8XXL+m0hd0RwZgPSW/TLrsIfSEqqOcxB
 o/ZfsSX2tMgxGxcshiBQnzDNEwHEAg6jTdgkBaeK+lHdvEgnVZ/WA7PkpqN1h0tpcto2
 RWxAu+lcBp87VeX3F1dhqI9h4icD85tf2UnTgoiNn3xbAd/7oaK+wrlTWLZ+URrlJLLD
 qv2Q==
X-Gm-Message-State: AOJu0Yw8xutqbcX/cG/MvCetZDJbDLo30A5CgHlIJGLfXcIjW42r4wjx
 oqPVW9QcHjtr2dcFl27SUh8s7w==
X-Google-Smtp-Source: AGHT+IGXv63VsYk3i4ypeEEwDetg94veqReqdC9KULBoNxgv7cBQ2z28tEGPSSHKhZezClUm2GmrIA==
X-Received: by 2002:a05:6870:468e:b0:1bb:867e:caeb with SMTP id
 a14-20020a056870468e00b001bb867ecaebmr2589904oap.51.1691770652198; 
 Fri, 11 Aug 2023 09:17:32 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 ne10-20020a17090b374a00b002682392506bsm3540556pjb.50.2023.08.11.09.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:17:31 -0700 (PDT)
Message-ID: <25ba9b6b-14a5-4233-34d6-5e9023a45309@linaro.org>
Date: Fri, 11 Aug 2023 09:17:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/8] target/loongarch: Add avail_IOCSR to check iocsr
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-9-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 03:02, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   .../loongarch/insn_trans/trans_privileged.c.inc  | 16 ++++++++--------
>   target/loongarch/translate.h                     |  2 +-
>   2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

