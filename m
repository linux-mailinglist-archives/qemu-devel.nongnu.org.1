Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335457414F7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX70-0007Dr-Nu; Wed, 28 Jun 2023 11:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEX6x-00079P-TT
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEX6w-0005QW-4P
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so10520205e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687966176; x=1690558176;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0TjoZUdrKl1IePho6q7GENf7J6Dc8qImit/0FWvm01U=;
 b=TMBU380VGofEo6FV9fF0EE4ys0HOVBeeaCJBekp1IxwNmOMMk8uT2o9FmND6ofanUx
 iCQi02eJR0RsKtcagHMICNviBkj+anjrVZYGKZBKFUZO1dHNsIti532yYzTKUfssVPpc
 rg+RDYbCamhfYBiDKNxGXpUkQecuTAGhO/EjZwd2dyG8g9AfmU2j+elGVQSw1tA8TLD3
 OP6wPLS/gouqSmPOE4VPZZU87pBwA9feVP9goQYiXIs+sXYDVSLuf/zhl0msC80AArQR
 l209/jpdRxAV7RYluXwKPOKhuK8/jdL1y6pcKGsODX7HkqDKj+yGNie6xIvPkp1YZiO9
 VgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687966176; x=1690558176;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TjoZUdrKl1IePho6q7GENf7J6Dc8qImit/0FWvm01U=;
 b=lzGP47JVCA9Ri7z4E/ae2CYR2CWk7dUczRx5m4trvhgtpCwUTNOMGeqPnDFoFq3IT7
 vmqA8R4ydLpcj38zGa7pm97fT+iWHb4sqWUntJU86PRzLS3l09UlG3RyuaJwCkB5Efl9
 73AclmLHzNqRLRPn3fMfshpzLX2KLB0LvynatI8CQVnIwEmexwJCXY++Vb/WWV2QrVKb
 n+PVDd2lBWkKslnfC97JT8uDJZtRKOtIF52Cgsswf4jhxGrwEWfHe6w1poywmKq+JJSG
 2yjUN/M0eJvwhw3B8CG8VNJHa5jmfkt7amU7XQxd3xnmv6U3nsHqLOfvQwE2XKcrHq6E
 IOCw==
X-Gm-Message-State: AC+VfDyf4tcNtQPyXRRQfcpMKG9wNuAg28DGlPdxucx33iUPeTAaQF1E
 tIAv8OPGfxqsrmk2gFT+IN1MBeW7527q2/M20gMlEvi9
X-Google-Smtp-Source: ACHHUZ44jNGcGsXRpbfm6kDwyynPvN1StCWYVRB9N/OH814yTuW5r+VgVxP//CKTAe4Z+U40pr6TPQ==
X-Received: by 2002:a5d:4bc3:0:b0:314:99e:af46 with SMTP id
 l3-20020a5d4bc3000000b00314099eaf46mr1856035wrt.20.1687966176690; 
 Wed, 28 Jun 2023 08:29:36 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 r11-20020adfce8b000000b00313f3c11512sm8201868wrn.89.2023.06.28.08.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 08:29:36 -0700 (PDT)
Message-ID: <d4c91f4f-d41b-6a90-1780-b5a5ab5ccfb3@linaro.org>
Date: Wed, 28 Jun 2023 17:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/10] qemu-sparc queue 20230628
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/28/23 13:44, Mark Cave-Ayland wrote:
> The following changes since commit b111569da9f82fdf05df03184836a4564adef599:
> 
>    Merge tag 'ui-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu  into staging (2023-06-28 08:42:32 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git  tags/qemu-sparc-20230628
> 
> for you to fetch changes up to 6b90a4cdc04ec7ca94c3f664d63ee43c2046a875:
> 
>    escc: emulate dip switch language layout settings on SUN keyboard (2023-06-28 10:54:25 +0100)
> 
> ----------------------------------------------------------------
> qemu-sparc queue
> 
> - This contains the target/sparc updates to use tcg_gen_lookup_and_goto_ptr
>    along with a fix for the sun4v niagara machine, and a patch to allow
>    the keyboard language layout to be set on a SUN keyboard
> 
> Please pull, many thanks!

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


