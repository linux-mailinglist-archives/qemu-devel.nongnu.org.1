Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01954765CDB
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6YL-0008PP-BS; Thu, 27 Jul 2023 15:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6YG-0008OX-GM
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:21:32 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6YD-0006Bv-3m
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:21:31 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1bb89ac2013so1021706fac.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690485687; x=1691090487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hlWdPAZ549TvKjo+IYOx2FfMDiM9i+0YPUX4XOYoAyo=;
 b=Io1yep/3Sx3ALymGR8UFAsiVrhsBbGKhpsgfcwJoQtn6a7BLn0ZcqB7ggNv0Y/pIwk
 m2+dfTiujXYc40IhFPRVS8lwBikj27u6B3+TNbeUKe0eBXcbNnH4Zbxfyy+PO2MAcnB2
 WjYGoy050hxRbaAJNaKaCWNgb7af2TrZJhmMrmlKgyvc2w+vdLqAdQxClwFkwQxNU0ga
 cMlbElzBx7TW3HGmJkXiaw7/PSHkpB/KmvkdUWM38aJ8iGQrOve1sepAnmFB/NHF+j9y
 fvQpZU4AGPEWrT9M/IONBXmUXhDsjdf6JSK7Z0AKtSyke0Iq52LSIxMX2vSvOMSo9z2C
 qnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690485687; x=1691090487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hlWdPAZ549TvKjo+IYOx2FfMDiM9i+0YPUX4XOYoAyo=;
 b=S2/hzZ8qXoWnoC4AzHW1o0LQXLuDhFj1RD/MNyxKSB0duChecWlyRVEurS2oxsPm5E
 DIl83VvxwZSeHJeKWKxJqJt66OP6PS5KOO8ihxPfUwh/Ycvleilm4kaGDRg454C6a3g8
 XE4CEBNvNrAhkV+p9dxCrsTas2REk56Hv9a6L+6la7GTfYXzLG+RcDBTx3jwsikkYLCU
 KgKt+UWDPzYUynw7pn8M8MLEax+1YyAl/VS6erg4q+o9zM5ypwzAB2DlsJUlKknb1bMD
 jYLdbgKEGeP2p1wZw8ALsClL/OZJ6LVOu7oM3sgK0dhgic1ddidd4xiTa7SWXGI8I40s
 43+w==
X-Gm-Message-State: ABy/qLZobtn1/vK4Cv0Hly+1sKEzYGEEbnsaLFeTE4hk6EWfhKmuEg0k
 EbtdB4h6xEql+uhSeXJn6he1XQ==
X-Google-Smtp-Source: APBJJlEu+4ZbfeNQSvbPS/YCBR88v3nIKHdDgdLQfhtzyisbVrna4Xef6eaIr8p5b/0b1lcqKvmUqw==
X-Received: by 2002:a05:6870:40c9:b0:1ba:cc77:1d81 with SMTP id
 l9-20020a05687040c900b001bacc771d81mr445194oal.46.1690485687513; 
 Thu, 27 Jul 2023 12:21:27 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a638c51000000b0050f85ef50d1sm1886827pgn.26.2023.07.27.12.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 12:21:27 -0700 (PDT)
Message-ID: <88f34612-738e-a490-6836-56bc9b3ede92@linaro.org>
Date: Thu, 27 Jul 2023 12:21:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/9] accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-2-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> Widens the pc and saved_insn fields of kvm_sw_breakpoint from
> target_ulong to vaddr. The pc argument of kvm_find_sw_breakpoint is also
> widened to match.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/sysemu/kvm.h | 6 +++---
>   accel/kvm/kvm-all.c  | 3 +--
>   2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

