Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0E6737B95
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBrns-0007ve-6q; Wed, 21 Jun 2023 02:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBrnq-0007vT-CN
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 02:58:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBrno-0001Dl-Et
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 02:58:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a2160a271so6972777a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687330730; x=1689922730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E6PL92Aj37EXof9+kIdFd4VRvCS5xnNnWcdREktSuO4=;
 b=J8fGk0OLUOGemjCrXmUUtnjJesYv86K2kaB3vFhHuhqP0Qjk4JGF2AWFWzn5XKZYEy
 lCKHwK65LZVxQI5gVShfEd2/BZjf/Bjf+SQzkZ5pTcPIaqmOI4yzxO5NQ3ao57YeGFmp
 YvzGmtvYCdjEMEyBu2b+9TGi3qAS0Tkgq21z5SWlN0eEVlgFXV+V8mhTH/Jjut7zTgbv
 Bu4bC4H/rDPR34jGimUzSzbHh/Jy3SOjuuQ/gntd3ZsJcMqCcTNXQx+y+SwbF+kj8FHn
 5MhTK+Zo1YRhiyysbOGYk856lOYXGgO61KlcHdo6u0kzGFPr5IM/0t7kNYj4Zyd4Oxp0
 HORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687330730; x=1689922730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E6PL92Aj37EXof9+kIdFd4VRvCS5xnNnWcdREktSuO4=;
 b=dR9vrgDcgdA4gFTRtOWFtcuFBmPpNz2Vdwun8UQQBrOFH+xW4mfdOhPs7fZpUDS+oV
 7and4c2goWXxxt3ZZeWrqITKc9fuBcHqC2HhpxrYiPuzfQqOrmslpdG5hsPLShmACIVm
 DJBqWoXjt7ZiWRwNKZmFkyptuS+pW0wu1pCdADx3HTK3+OHUmt3HGg+tLmzxqtseiww7
 +op+dRyEr61Sq8YHXE+5qlAG11IK1EW+PHQSpHBCaxhOO9cGDmyR7eNjD58cBuwOc5h3
 FtNEtWik5gl1guJPuX9LmtCeioWomLPmbYnqUNqxEJw3SaCQEx6PN5fBdV8YxkMf//bo
 x7nQ==
X-Gm-Message-State: AC+VfDyj97eqjRU9PyQUnKXmkspGLmP81IChvtvvC1mXwYtSBfJoqep1
 HzUxAajD0A3vCEmpdrqb5wgQJg==
X-Google-Smtp-Source: ACHHUZ7irf/VPJX7j2EaJb8jIH/fVZ2TpGyzUgSiD+MQOj7Hqz1E7bYF9k6Oj2KSqoNd7tJ9SFU/DA==
X-Received: by 2002:aa7:c544:0:b0:51a:46e9:27d3 with SMTP id
 s4-20020aa7c544000000b0051a46e927d3mr7697286edr.36.1687330730449; 
 Tue, 20 Jun 2023 23:58:50 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a056402515500b005187d2ba7c1sm2088449edd.91.2023.06.20.23.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 23:58:50 -0700 (PDT)
Message-ID: <aef2dc31-c130-00d5-3275-6677032ec365@linaro.org>
Date: Wed, 21 Jun 2023 08:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/1] Seabios hppa v7 patches
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20230620195817.119401-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620195817.119401-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 6/20/23 21:58, Helge Deller wrote:
> The following changes since commit 327ec8d6c2a2223b78d311153a471036e474c5c5:
> 
>    Merge tag 'pull-tcg-20230423' of https://gitlab.com/rth7680/qemu into staging (2023-04-23 11:20:37 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/seabios-hppa-v7-pull-request
> 
> for you to fetch changes up to bb9c998ca9343d445c76b69fa15dea9db692f526:
> 
>    target/hppa: New SeaBIOS-hppa version 7 (2023-06-20 21:39:47 +0200)
> 
> ----------------------------------------------------------------
> hppa: New SeaBIOS-hppa version 7 ROM
> 
> New SeaBIOS-hppa version 7 ROM to fix Debian-12
> CD-ROM boot issues.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> ----------------------------------------------------------------
> 
> Helge Deller (1):
>    target/hppa: New SeaBIOS-hppa version 7
> 
>   pc-bios/hppa-firmware.img | Bin 719368 -> 719376 bytes
>   roms/seabios-hppa         |   2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> --
> 2.38.1
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


