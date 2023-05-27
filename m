Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64787130D6
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 02:17:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2hc6-0007uE-12; Fri, 26 May 2023 20:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2hc4-0007tq-67
 for qemu-devel@nongnu.org; Fri, 26 May 2023 20:16:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2hc2-0001Bu-D9
 for qemu-devel@nongnu.org; Fri, 26 May 2023 20:16:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae851f2a7dso20467595ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 17:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685146608; x=1687738608;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uBzFWJ42rTjH4iuxU0aea0aikK+z7L4cBJsGvXo3a78=;
 b=TdezumPchJfRwgVaJHfZBSpPyVqGUXjte4/R4HP4a6rt24r0h//gFCWSbgHiS79h/u
 /AfWv/fo56y583/wmyCN16vKIRrxHC1xpfLEwbWujNDplkvB4rueBVE9dX7p5B0OguZA
 uMFV6PaB3ghXNZJ/rJGOd1EW4CaMmr95mFoE1jzYC4mfklfRptqgExIn8puyDonDI/DW
 lAJmi3cc0+pbTBU+lXBOR/DXikx4TFUhs5FlC2XJofJSg1oFznX5F6gBra9qs/No3wB8
 9BdnOqmwut7wH7xe8SEJYNYCwHwxx2itS8u2/cumFCwF4VE3huQN+PWJjScVnM127ROy
 ktJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685146608; x=1687738608;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBzFWJ42rTjH4iuxU0aea0aikK+z7L4cBJsGvXo3a78=;
 b=lhwgG86JInQPxNLxcH5PwIUUaLnAhAY4I2HRXSciXPXEVFQfognw6UwJ2lOP/RsSPF
 9i+edIhAUNf0E+FjUJG940nE8sWH3WrEUnHhb6mnHpzTZlIDyk0lqd3vmHGr/K491gk+
 5VE9Sq/mn+BuRPJIE1J6MgSzEjMe2f06+ASEWUC9XPycmJTIEhoc0Zr5x6nAp1LyhXry
 xmXoYIoU1Tz4VTUIBlqMJ7tmWywlXh3do2iT0oWvcQLMTvMnRHoONlj124LeaiBJPpv/
 cL6dkJsZvDImAMWByuwkttsAGQQhskdMxy1YIqAKTRVJUhb7XZWExFtOgc5dPUWMLkee
 szSQ==
X-Gm-Message-State: AC+VfDwaD/RtR/Fdqi0uJu23O2EOxjZjKmr6LYFbiPmKYq13eiGiXJlK
 BzbDIO/ZHQmZw6gABU7U0bMStQ==
X-Google-Smtp-Source: ACHHUZ5ULpqVgyn14BBKckiI39Ly/RQUPryhgQjIt15SpMLYpRsicl4AjIG/WIzKC1mrNGwXWbiKog==
X-Received: by 2002:a17:902:ecc2:b0:1ac:750e:33d6 with SMTP id
 a2-20020a170902ecc200b001ac750e33d6mr936605plh.23.1685146608542; 
 Fri, 26 May 2023 17:16:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a170902d4d200b001a1d553de0fsm3740391plg.271.2023.05.26.17.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 17:16:48 -0700 (PDT)
Message-ID: <87334f23-1f01-871b-b7ba-7eb81e43ea84@linaro.org>
Date: Fri, 26 May 2023 17:16:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/12] (Mostly) build system patches for 2023-05-26
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230526160824.655279-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/26/23 09:08, Paolo Bonzini wrote:
> The following changes since commit a3cb6d5004ff638aefe686ecd540718a793bd1b1:
> 
>    Merge tag 'pull-tcg-20230525' of https://gitlab.com/rth7680/qemu into staging (2023-05-25 11:11:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to b17bbf835c8998e93fd99b06164f1d63843fe8c9:
> 
>    configure: ignore --make (2023-05-26 12:36:20 +0200)
> 
> ----------------------------------------------------------------
> * build system fixes and cleanups
> * use subproject() for the dtc and keycodemapdb submodules
> * fix virtio memory leak
> * update slirp.wrap to latest commit in the master branch

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



