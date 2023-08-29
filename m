Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95878D01B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n2-0000oZ-LR; Tue, 29 Aug 2023 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3dl-0001no-Du
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:40:37 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3di-0001GP-97
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:40:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so37265755ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693334433; x=1693939233;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eT9kLeB0ANgFY4J67/AYE2DnR7xL9lIhfjOaZLgwOgo=;
 b=AECNp57KhvIvTWLuB4VXe2NzUXF2OqEGpT/aH3/jT8gRFcMrwoshdgyO3W8S7P+CCA
 48M8uY/m90F2za6oH2jxZqwvoiemU/IEcMAYk2Fa4WMc4oxAVk7ZSMakO+M1s+MnFMr0
 SOgGGw+PTR9WPtq0GRph53jNXYt7cXmhTq5fw5eYPnqzUBKdUbnLCmn3pA5tc2kF1vsS
 YzOUqXAvyWGqJI95BK8O8CA3zXbFyJGMtCDiejAqSrHSn91/ma9LB/xyC/ujfLQNKRV5
 XDldaqqejWUFPP+0YE/6kuLPnkLdX2XDv6L8CRwjIb7eXBntFBInC2iXiUaylEqVGNZp
 e0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693334433; x=1693939233;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eT9kLeB0ANgFY4J67/AYE2DnR7xL9lIhfjOaZLgwOgo=;
 b=aHcaxs4LWYlnph/llpLM05SO0OrSdGpmRkeboJz6CtvZlEcBm4TUaHk92ZBL8pD3mR
 /KuoL75wP1b5gAjQKS4LaFVMTsx5ZWt9h4lS7r3onzbaQSxw1x2mLFaBViV/gl8g8ONk
 gpkCifWcKG1ODE0fWZbiLujDmX220EpleLpqPPkMngFKDlHgXGLomEQMS/TpLk2uyyRS
 ayZ7bZtlSUYJ86eXJGe5DXNXlLE06n59cI1KASw2PKh/iuGMFOegW5C0dfvG6YCWcvx8
 Ue6dDLXBiH+1+LMtsl16aN+vWGwZrK5VfDhm9QhzTj+U8CP0uxAg+8neWbgN1ZamYTHo
 67Lw==
X-Gm-Message-State: AOJu0Yw/x5VwspwFHYLmbCggX/kTQymX41lLegoMRaWFSEZvtptyNczb
 nrK/Z22xMvHpy1zY0KI3nNkFY+rWECwu9YCw6g0=
X-Google-Smtp-Source: AGHT+IE0/kBt0YVlMRuXO8+JKUnztLxHbXAAx5hj1KPMM0f+B0dMAIBuNl8UH13N06s5ADRpgCKwCA==
X-Received: by 2002:a17:902:9894:b0:1b7:fd82:973c with SMTP id
 s20-20020a170902989400b001b7fd82973cmr28313681plp.39.1693334432747; 
 Tue, 29 Aug 2023 11:40:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jw21-20020a170903279500b001b06c106844sm9629599plb.151.2023.08.29.11.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:40:32 -0700 (PDT)
Message-ID: <ae4f5b82-26f0-9c05-9051-57d7b65284f4@linaro.org>
Date: Tue, 29 Aug 2023 11:40:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/10] configure: remove HOST_CC
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829082931.67601-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/29/23 01:29, Paolo Bonzini wrote:
> $(HOST_CC) is only used to invoke the preprocessor, and $(CC) can be
> used instead now that there is a Tricore C compiler.  Remove the variable
> from config-host.mak.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure                                 | 1 -
>   tests/tcg/tricore/Makefile.softmmu-target | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

