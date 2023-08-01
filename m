Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE876BF75
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:46:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxBS-0003Y3-Cb; Tue, 01 Aug 2023 17:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxBP-0003W6-Om
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:45:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxBO-0001jh-Bk
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:45:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso27722545e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926333; x=1691531133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EeGOinFLu1r//7lfo14LZaY9B8WVqgqTawEmzkRRgJY=;
 b=Nji8lGitlREZXj006AwpngtKqRO85ltkTRQCI7vxd85+4oROrH/lh/pJuuDFMhrdUi
 ktdVNwReCv4VUg7XGt1cpVttbiBraLE5KTDkuS1UiMp16JFM49azr043YGsSaAoNScwr
 VxFSjaiSdHM2FQAubE6dAYel3cNXyAZv1etwcUR2ZiGesPConuMoLW9ydwqrIv7DywLi
 lW+U/yLZsIxo2brwnfIEXYoFH+gOPgzUICIF1WQTyWqtkyEbxTO079PcdpDKX7oIy8zc
 PBMHjoddM5z2o1ZZ3IIATgOUCZ1M+Nyuh7ONf6cGFnFH+ltkfhqSQFfIqBvtDLuG4rxe
 EHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926333; x=1691531133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EeGOinFLu1r//7lfo14LZaY9B8WVqgqTawEmzkRRgJY=;
 b=dHDketvKd3FQstoZ6ffUY5egrx2Kh/j3MHiNSEln7iPVxrrDj6jvPWMIS0gRFNgEN0
 6JItFqJ/YS1WEm2wcMcUQJ4WfvsYS96NJE9CW+btkKJ8ctoZRNK2Wwi0eT/jsnU2tgb1
 O7UTKnrxHo6MvE5uYf4mlgf9AGxgksNFssuw9zTTaRs4Z1fzpo+IJW27GH3nB8pWA4zX
 kDWOG9kwFZkjTvbYBidR0NPs6m6ofyjIEntzlxJLXaf5YQWG1tJ0eo2VcY9i4ralfYwI
 TGxabmKKJFC5skeMnTSMYd9MhiYgkJpy4r2EA85lXy9+4WwTZszmdnjXxabpOGrxq57d
 FFYg==
X-Gm-Message-State: ABy/qLaz4uzw9X2WU3BvC9gXm+Bsy11/CTQikM6jtYD3BW7e2Xg9MhjM
 JheRIzo2cjsCPNCEbe+Qyk5gWg0HPsutFKMBw6c=
X-Google-Smtp-Source: APBJJlH02NPv5oOvFs1uA4SAiu3Sd9LUAJOqp75WJGdLXllRwn2kxERm7rlPjLMFemJ+eRyrH4Wwzw==
X-Received: by 2002:a7b:c7d6:0:b0:3f9:255e:ee3b with SMTP id
 z22-20020a7bc7d6000000b003f9255eee3bmr3603938wmk.30.1690926332866; 
 Tue, 01 Aug 2023 14:45:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a1c4c13000000b003fe20db88ebsm6526188wmf.31.2023.08.01.14.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:45:31 -0700 (PDT)
Message-ID: <fc11cd94-6d0a-5a1d-a9cf-c3f6be0513be@linaro.org>
Date: Tue, 1 Aug 2023 23:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
References: <20230801152245.332749-1-keithp@keithp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801152245.332749-1-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 17:22, Keith Packard via wrote:
> Instead of using R_ARG0 (the semihost function number), use R_ARG1
> (the provided exit status).
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   target/nios2/nios2-semi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, queued via misc-fixes.

