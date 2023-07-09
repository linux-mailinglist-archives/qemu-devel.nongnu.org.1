Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92374C6C0
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 19:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIYEm-0006JN-4I; Sun, 09 Jul 2023 13:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIYEj-0006HE-0Z
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 13:30:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIYEX-0008H4-Lw
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 13:30:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso41630575e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688923804; x=1691515804;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZDIjkZBO/G2zgxR/nP4f3LV1PpzbQ7ZAqEq7oOCqD4=;
 b=kjW9Jh9Xte/w6CAq5Ht+RoTAj+sKFyJ0NJ8XECRnJcqqLogfoPIVXLFXGOgdQpiJBf
 Hz+F1lvE+FUS0sUSQFY3yyNt9oQiUHZM7Qu9DV7QmbPl2MurYGJgPGBzct2RD4fz8ROJ
 WbtDuoqv+/+mMJ/QEFW7jyVNkZ5NhsewKVtedm5VpZ60xIa6eL7/iZl4HWKIYKubbr5i
 0hvyao0J7GOul5WEsPdvInOAVm+mbLA5IjTPVPXJgchCNOnp202pboaCgjLQuFtU1+8f
 TcAmid1GEhbjb8NrNaDeO+VDs8N1zVdX9WQAiK52jS9fKjFWSdp3qNnMZ+ePULVuduYW
 Nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688923804; x=1691515804;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZDIjkZBO/G2zgxR/nP4f3LV1PpzbQ7ZAqEq7oOCqD4=;
 b=S/wU/KHyCVuSQKmmjwvpvjxdffhiXRHEDK1lk5Dn6UJ7EhLU1WKnuD+aPFuOqyOcNe
 r5sv5acw9QQ2NlPoq6yvaRVGLe7ykfvR+bOzGMdmvFACozt2JjlEAFGFYvPzLQm5X+9/
 lvwznl64aKijUquqXA5NT2MMujjVqtL+j0FDJu2++NHgdFOww6gKGq4IPaKzOuI0Wx6E
 dHTZqnewrDdwd7TUvhZDOzUt8U/Udyb6pNyUbu4Fu5foB866Jet8zeFMfB8N+lHO86Sm
 Jlv29M1nd9CxBkYmZLAnkzLeIxxuaN6fKcywv1dqSohvcGlbwrlLrMpuqNZY6F31xPaQ
 P1Qg==
X-Gm-Message-State: ABy/qLaSg9gVIk5BzkXpTUnI0354Yht5VdEBPyIZHhxv7CXlm0NBwg3P
 f09FHi7i3TfkuDigssOzSRtA7g==
X-Google-Smtp-Source: APBJJlESBcjuYUVAG7dOMYnKNw9/Ph+0RKfHSAoC7cyly9KtkGTxhXC1P3eESxmCplPfAtIYzjz7aQ==
X-Received: by 2002:a1c:f712:0:b0:3fb:e643:1225 with SMTP id
 v18-20020a1cf712000000b003fbe6431225mr9309634wmh.13.1688923803918; 
 Sun, 09 Jul 2023 10:30:03 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a7bc3cd000000b003fbaade072dsm8140847wmj.23.2023.07.09.10.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jul 2023 10:30:03 -0700 (PDT)
Message-ID: <6ba78223-afa2-24f3-a841-6ff7a9cd7a97@linaro.org>
Date: Sun, 9 Jul 2023 18:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/3] Linux user fcntl64 patches
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230708145720.136671-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230708145720.136671-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/8/23 15:57, Helge Deller wrote:
> The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:
> 
>    Merge tag 'pull-9p-20230706' ofhttps://github.com/cschoenebeck/qemu  into staging (2023-07-06 18:19:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git  tags/linux-user-fcntl64-pull-request
> 
> for you to fetch changes up to 036cf169a3484eeca5e17cfbee1f6988043ddd0e:
> 
>    linux-user: Improve strace output of pread64() and pwrite64() (2023-07-08 16:55:08 +0200)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


