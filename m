Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6985B75E405
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 19:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNcpo-00062f-Nm; Sun, 23 Jul 2023 13:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNcpm-00062Q-6C
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 13:25:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNcpj-0000ED-M6
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 13:25:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3163eb69487so2859470f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690133125; x=1690737925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X1hFIWlZw/Lg5W/4p4kfui4BJlEV0CNNkx7phlj8cBE=;
 b=Ut76xmoYiDzGZqMg3LXd57UQNvUmERC44kg3Ca/SRzIltyEuBfm6iwGORAYCwiuctQ
 rhj9hmG5aV0KXD9VumfmvGmTQ0bL/hL2PeHR++XXLu+NVN7DDyppT0Ud3WU05cyEGofU
 pQvbv1Q04pp9XhnuQ16Kr9pnDor2Pb90UZGtW+m8D/vLmR/7/2AuhStlIE1uCUe/6d28
 vU2X3jVd7rblMedyiq0PNiI3gQudaVlZjZ2D87wVTrNKEQJzIbS/FoRJM8lz13RKcp5H
 6ATYZ5dWOnSuOSXKKxqhiKmNjxe3UoC/zodvOoH1gLI395VMtZ5EUcauTszyNqB+uTyz
 dwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690133125; x=1690737925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X1hFIWlZw/Lg5W/4p4kfui4BJlEV0CNNkx7phlj8cBE=;
 b=Mg1whYMrkaRhTYokwOhVizuLOgYR7/xO5qk5tp6eSo/RIoXv7HHiE9bEW1j2W8nsq8
 lmJUYAXcPSvHQ03mnkysP3D+gBo+cwUdKSthey63Vin2J20aCKAAWeMDpDEBuFvQrITE
 pT7Ye7KpM0KJAZgvKjsD7dj++bfEeqHyky46CXXZSCtp1D8uq7qM3EUdCY5uq/Q1kFWn
 v2a0/3Dn7pNqMHAfsPnVrBpAuTfEFzTDeJVb2JfLsYjz1Cwr+97Bxx9LT2+o6kffVAMY
 7Y433/5ZRa9O08QDWDRHB3RnNh8vo9cj1xeN98P+tmJ+HKjCN84/Ck8yrkljT3M4JDdl
 pPaw==
X-Gm-Message-State: ABy/qLYkmjCQozH7Bm82hocunrzF8ej2/949t1d8CilowZ2d8aRDvNfL
 6QNnHXgwU5MvgK66SGXZAUFgNw==
X-Google-Smtp-Source: APBJJlF+vdvLBvgv96dH3XrL7VuuWnUA0uRtjEEptFzuJH9/Zitu/z4PRw8W2qfIXm1zVLBJKaKT2A==
X-Received: by 2002:adf:f242:0:b0:315:a235:8aa8 with SMTP id
 b2-20020adff242000000b00315a2358aa8mr10201657wrp.2.1690133125581; 
 Sun, 23 Jul 2023 10:25:25 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 p15-20020adfce0f000000b00301a351a8d6sm10243936wrn.84.2023.07.23.10.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 10:25:25 -0700 (PDT)
Message-ID: <3af8bb3f-75a6-ec68-7560-e8113ed4acf5@linaro.org>
Date: Sun, 23 Jul 2023 18:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] accel/tcg: Zero-pad vaddr in tlb_debug output
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230713120746.26897-1-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230713120746.26897-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/13/23 13:07, Anton Johansson wrote:
> In replacing target_ulong with vaddr and TARGET_FMT_lx with VADDR_PRIx,
> the zero-padding of TARGET_FMT_lx got lost.  Readd 16-wide zero-padding
> for logging consistency.
> 
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   accel/tcg/cputlb.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued, thanks.

r~

