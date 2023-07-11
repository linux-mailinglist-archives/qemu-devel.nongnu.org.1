Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064474E92B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 10:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ8nx-00076n-SY; Tue, 11 Jul 2023 04:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJ8nr-00072I-L0
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:32:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJ8np-00026k-LT
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:32:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso55583995e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689064372; x=1691656372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+f/HQUrfmF/f14X1aZYIvQyJzED5OY7kpFSvwgb96U=;
 b=G3iQUwipTaaIgAbULosdw9v93+GjRH5FbupVCRj6/DxV0NzGroy61vttFtW8wRLsd1
 RU+5ZweUcFtF8pvHFH/3w7a42vARXgIqkQ9bf/CK41KHXJ5zDf0Rc3BrKSnSWGdJS2L6
 RYts6tXC7khF8BH/ef2XTPozLkLeUcLuIUrHcDc0HmpZy2GAsD66nVbpXJOMfCh1ommF
 /MWcnINWUWFu2xvy51nnp+ZXjZYHqwg3eipCymWa+HFcmD2updDjKexeRY5qxLury6RI
 kDNhifP0cr5ZN850lOBgC+bK9lqrEIVdJ0/KIPNM2Z0njzLWe6IIoPVofRqVLbHSSIGR
 9Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689064372; x=1691656372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+f/HQUrfmF/f14X1aZYIvQyJzED5OY7kpFSvwgb96U=;
 b=jb+ObMEuSdEKrKvyYDdOgIvHnPO3b6N9zSBcL+kJmROzXu/MAgMon1Vd6DQX1CKCLE
 6Jj/etsBcJ8hGnmgWnOMLplJuWthZDqewrVr2FbnwZwTgncnE6ZOnkeQoIVBvTozAWWC
 JYwLHUyzC+migQpRWGtw1OA/Nyr40nB6XzsFsd05c7SuGWl6jZYT+hBVoWW22eEEicxs
 SLK3EpHHOjhXmg+KKWQj4PnLMCvloZRIXJ0S/GIuCYNmBvfOvefC+DT0CR14qGqloVJa
 qWam1Soe7ydYcs9rUgM6oocFWaIN1VLLC/AGBM5ea9Jx2hB0VDrECAYL8hNZuzd4efrV
 kkqQ==
X-Gm-Message-State: ABy/qLZbbtj1H2cRZmrd/wssgad4QJH/xu4z7kBUE2bO2+ANMd9IiLO6
 JQb39S7QdFywNs34oexvx9T85Q==
X-Google-Smtp-Source: APBJJlGO8gHvJhlxyBw7fGvNbV+p5De1DSVDgs1/wVqYoIj/5q2CmNVPZnImrSraw6S8eCVT6F9Llg==
X-Received: by 2002:a7b:c3d5:0:b0:3f6:91c:4e86 with SMTP id
 t21-20020a7bc3d5000000b003f6091c4e86mr12696607wmj.3.1689064372285; 
 Tue, 11 Jul 2023 01:32:52 -0700 (PDT)
Received: from [192.168.8.133] ([85.255.236.57])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003fba137857esm1861865wmc.14.2023.07.11.01.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 01:32:51 -0700 (PDT)
Message-ID: <05fbf7e2-3f74-9d17-f80c-049f327fe911@linaro.org>
Date: Tue, 11 Jul 2023 09:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/44] MIPS patches for 2023-07-10
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230710222611.50978-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/10/23 23:25, Philippe Mathieu-Daudé wrote:
> The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:
> 
>    Merge tag 'pull-vfio-20230710' ofhttps://github.com/legoater/qemu  into staging (2023-07-10 09:17:06 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/mips-20230710
> 
> for you to fetch changes up to 752dfff5ecf35a38145c2dfbb842224177fd1afd:
> 
>    hw/ide/piix: Move registration of VMStateDescription to DeviceClass (2023-07-11 00:11:25 +0200)
> 
> ----------------------------------------------------------------
> MIPS patches queue
> 
> - Use clock API & divider for cp0_timer to avoid rounding issue (Jiaxun)
> - Implement Loongson CSR instructions (Jiaxun)
> - Implement Ingenic MXU ASE v1 rev2 (Siarhei)
> - Enable GINVx support for I6400 and I6500 cores (Marcin)
> - Generalize PCI IDE controller models (Bernhard)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


