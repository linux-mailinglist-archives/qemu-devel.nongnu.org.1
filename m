Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98771176F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 21:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2GhR-0005e4-OX; Thu, 25 May 2023 15:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2GhQ-0005du-4q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 15:32:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2GhO-0006R9-Dm
 for qemu-devel@nongnu.org; Thu, 25 May 2023 15:32:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d2981e3abso116243b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685043152; x=1687635152;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0/0ClbhdrVAyhzVx2E007MZ2yNN8oHL9lqxbAD5zSk=;
 b=IXxqr7u0nzLzCg9oghEM9LcMRIGCVOWzqB3dXCY+40kgOT0+Vz1nNBTrDm1ucwjcGT
 ppX1gUveOuK8Xhj7Nh7zYSS7LcFsjiRT6yC14wh1bp51ZWfx+pp48MbL1LSuJMj33DTI
 sYwa0qZlhiCrteQ+AglBhkUnU0geDdqH99mvx6DRgwqfpuzZcATnkqGuGvYARpxOtD1C
 aE/eo4mi/4Sp8M0L3EEmfMQcomlyHQUtW0/3/ygdHxazMg6ucE0vYs4FEKJc3pRCSoyN
 ItXpEiCQsTc/BvHx7RQOg+yBs2fZUIfkbIDf7atW8LZ9kTTU5B1gK9j+zHId7yvzl2xt
 KnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685043152; x=1687635152;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u0/0ClbhdrVAyhzVx2E007MZ2yNN8oHL9lqxbAD5zSk=;
 b=WlMhArYoRzMkWBoUMaH6jUKXDGjsJmAfQckr6VDcNBSvH5zspKCu/sCYYtnt1prGAR
 Y5s7cc4adhQkdn5p3FS0Jy08ZeWOIXFH7YELbH9eNzo9KcFHaUp79GpTRAWEHLnj+pXJ
 DJd+vwc64Homd+m31YWT+BGBAc5+/FqdlmVje6mRrl0kigiuMzsqR5omIHQEnVAvuHet
 BuaMJxHf5Qjl+MbmJim/wvnVrI/THcNgcVeTIxLP8RGT0fZd57VmilBzn1NiOMHDC/xi
 STSRD0Q6xD7LziR8bJ1oai/4Xn6TEc/G1MNmj7Kt5EdAexM569LvCFnDJlUI6Y5uFYnM
 K7Eg==
X-Gm-Message-State: AC+VfDyubP2Y+6NC/npb40sgnAjDabZLr4t4LoopAYtJiJcE5LVaafvI
 t3ZvS8gGTg4bbIqAND27CNHTNH4rNhTovsaBxYY=
X-Google-Smtp-Source: ACHHUZ5mE17iVsFWJfONe0/FMMJfZJOSfJxRJJilWBy0UsJdXmw3XMWgHyEJBgNq/NZT0BKEXs7Uew==
X-Received: by 2002:a17:902:e746:b0:1a6:8031:59e7 with SMTP id
 p6-20020a170902e74600b001a6803159e7mr3317197plf.46.1685043152378; 
 Thu, 25 May 2023 12:32:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a170902be0b00b001ac45598b59sm1763756pls.163.2023.05.25.12.32.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 12:32:31 -0700 (PDT)
Message-ID: <a453d8d2-732b-4e44-1c1a-44103fa41630@linaro.org>
Date: Thu, 25 May 2023 12:32:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/23] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/25/23 11:10, Richard Henderson wrote:
> The following changes since commit b300c134465465385045ab705b68a42699688332:
> 
>    Merge tag 'pull-vfio-20230524' ofhttps://github.com/legoater/qemu  into staging (2023-05-24 14:23:41 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230525
> 
> for you to fetch changes up to a30498fcea5a8b9c544324ccfb0186090104b229:
> 
>    tcg/riscv: Support CTZ, CLZ from Zbb (2023-05-25 15:29:36 +0000)
> 
> ----------------------------------------------------------------
> tcg/mips:
>    - Constant formation improvements
>    - Replace MIPS_BE with HOST_BIG_ENDIAN
>    - General cleanups
> tcg/riscv:
>    - Improve setcond
>    - Support movcond
>    - Support Zbb, Zba

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


