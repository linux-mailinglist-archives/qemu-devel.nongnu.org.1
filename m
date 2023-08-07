Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9337E773066
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT6y8-0000dF-UI; Mon, 07 Aug 2023 16:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT6y1-0000cg-NL
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:36:42 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT6xx-0003jV-UE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:36:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a6f87b2993so3653745b6e.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691440596; x=1692045396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rm/mpGHF2I1fxXmGf5G9MCV0FugkJF1izpS5Kw1coGo=;
 b=A1z3/U3eyzDCjBu9iTqla81UQ/PRgY1UtkHJF695T//GzR/0i/wq77gX3/6TGwjBJ+
 w/LsgyJfRlvp/q319+7RYT1u8j+9judBbCm/ojArB1FKak6lWBASSL9Lj0wopdbQejYK
 304iHaQqsax+5PXM9UKN6X5jQmuJ7TAhKfLttStf6jroDWHWDVkZnGVovmAt9+j9D9Fz
 VOzmxiT6hhzZro3dLSgDxO24EIL5uf+Qy25QMSq0suq8wJr1wOyaEn4SlzyMwRnOmb6q
 2+zNoG4egGjiUpXtpUa6DzztgZF3v8uY4vOVecq1JEuYHxDQ8GMOTvmysAqa3FpWGZa7
 4Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691440596; x=1692045396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rm/mpGHF2I1fxXmGf5G9MCV0FugkJF1izpS5Kw1coGo=;
 b=SZ/cK3Q0x5G5vp1t4aAeqOnXvJ5dH4ldgMJnsFo3yPUGB2sqlTTU70hdP+A4JqVbru
 nYMnyeQtN2DynqjPYpkNMuQL2dQ8XYsF6K0Z7uZKzNL5PFk3Qs0SQ+p3d9Nf4nuvtIB9
 GiFA5bTyM19InkWc+23+ssgWMwKF3LvrrTKQ4Aj+0yOVtwE+zj/QDZAdvUl+3ypMzmj0
 00UTMU9ukcEwKJ9W2iJ0IKzSfTIC9wHO6s+a2s3QnTe9OlHSO27FNTsJb1uokP0UPnXY
 dNbybTq2sXkjpRPs2ICIoJCDXKl41MFfOnegJaVvYXB8neU3ChoRSPdRmeru5x4V8KEq
 MSnQ==
X-Gm-Message-State: AOJu0Yyf8exgmLut0LY+5Y6Z+Q+U0UDXuPaiHexbgHcAOBHta3VHnfXF
 5hnMQHhu58f5byrChOoojIIyIg==
X-Google-Smtp-Source: AGHT+IHRUrnYjYyBVb05xDlWDQYsRltMfHW2YMI/LfKJkantnoJM2E63zbsD2vGeRMqmJ6jpLRJeOA==
X-Received: by 2002:a05:6808:1386:b0:3a7:94d3:43fe with SMTP id
 c6-20020a056808138600b003a794d343femr6112823oiw.30.1691440595875; 
 Mon, 07 Aug 2023 13:36:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a170902a71500b001b558c37f91sm7307582plq.288.2023.08.07.13.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 13:36:35 -0700 (PDT)
Message-ID: <6532b5ba-3ebf-5ed1-8430-e2816812da3d@linaro.org>
Date: Mon, 7 Aug 2023 13:36:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] hw/nvme fixes
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230807115359.123-4-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807115359.123-4-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/23 04:54, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:
> 
>    Merge tag 'pull-tcg-20230806-3' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-08-06 16:47:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git  tags/nvme-next-pull-request
> 
> for you to fetch changes up to 6a33f2e920ec0b489a77200888e3692664077f2d:
> 
>    hw/nvme: fix compliance issue wrt. iosqes/iocqes (2023-08-07 12:27:24 +0200)
> 
> ----------------------------------------------------------------
> hw/nvme fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


