Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E5712A79
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2a8Q-00069x-Ei; Fri, 26 May 2023 12:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2a8J-00066k-UP
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:17:39 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2a8I-0004XD-9c
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:17:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1afeec98a00so8760855ad.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685117857; x=1687709857;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wVWG/1nbYWYDvuI4RqY4rl/HM6odc/gCNCclPNadGBM=;
 b=dzz93B1ntpfPO7n87xafxwF6yoc5t+SLJXOuXq7i5+kR7J4FnXI4bjSo2Yy6WtUa+y
 fu3L+I0HuYmvn0m5aAgPjOLz2GE8EpeCGS8oq1K+jOt5QnOTVgz7bHRx8390e3rzSdYY
 9fYPdfPZ6DSUg1my3GWHu6N3QaCKwJgJ2c+SrWJlXWmJZE4PGrdsdqj42K8ZO2u3tkAU
 pa5DJqOTwuOMsU5GpMmgH8Yc8+Qoul9hRJYPiE7XDBACYwngKiAMWjGB67/Ny1/DJWHX
 AV5xmoO2jQZY68Olo8cbO4qaqz65pjneAQTfU4zaNDErpR0E98BocLG9SEG5AWL5Heja
 MmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117857; x=1687709857;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVWG/1nbYWYDvuI4RqY4rl/HM6odc/gCNCclPNadGBM=;
 b=Srudsw1gotlSbq/qEQY5MYOGzWyIezPAcfBle8t42gZlZ4vYap3j4+GkBWigACheZp
 2lFPidC7rTaeVG9MfY9F0SyF5RhDrtu8fJjvUuTNAUx01Mz2fx6pT5kdHjkphdnYI5NQ
 3nRGsM1138QDqMHexPpbrENm+6M4rvKtwicLxLtBy78CMsvBY+x2N9qTduns8gnAfATP
 c/+zwaSKUulmbDxU9fRT/onIm8FJ5+/GjBkX22AQy3TvGNVr+kpFnFDzmL4825tgXAXa
 zp++diRDpqvnaxNwG7poPi8K59EWI3k4Gnzy0Ful725YeeDi9nUd2wZChTLf2oX82NJl
 2ISg==
X-Gm-Message-State: AC+VfDwh9TKa1tC4MCU5A4DnNoOPLg3f/YHwgMZPfw8tSM1eQ1sqlNvm
 2aP5tPQp96laIrXqsR6QzxHNtvhuE8O4YgBp1iw=
X-Google-Smtp-Source: ACHHUZ43vedxsGY0E8+VLUGlRZX14ooINSLhdKBL8kEf5W3nIDvyzGWEA3kIzB1ZPO+sI+Svqewt8A==
X-Received: by 2002:a17:902:dace:b0:1af:feff:5a70 with SMTP id
 q14-20020a170902dace00b001affeff5a70mr3822865plx.11.1685117856858; 
 Fri, 26 May 2023 09:17:36 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 lg13-20020a170902fb8d00b001ae44e2f425sm3439594plb.223.2023.05.26.09.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 09:17:36 -0700 (PDT)
Message-ID: <bf83bbd0-1932-9d15-6d9f-be306263524e@linaro.org>
Date: Fri, 26 May 2023 09:17:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/2] loongarch-to-apply queue
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230526092735.2549714-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526092735.2549714-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/26/23 02:27, Song Gao wrote:
> The following changes since commit a3cb6d5004ff638aefe686ecd540718a793bd1b1:
> 
>    Merge tag 'pull-tcg-20230525' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-05-25 11:11:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20230526
> 
> for you to fetch changes up to 65bfaaae6ac79ebc623acc0ce28cc3bd4fe8b5e5:
> 
>    target/loongarch: Fix the vinsgr2vr/vpickve2gr instructions cause system coredump (2023-05-26 17:21:16 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20230526

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


