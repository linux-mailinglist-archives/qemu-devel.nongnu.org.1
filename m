Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F777507A
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 03:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYDT-0007Js-M3; Tue, 08 Aug 2023 21:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTYDR-0007Jj-MW
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:42:25 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTYDP-0003mb-Bc
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:42:24 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-26824c32cfbso320189a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 18:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691545341; x=1692150141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ALSbk7LPRI16JuO8i+GWyfLxWcR/0f/W0UbTHzqCI2o=;
 b=amg85yzPfetY1sUiTkJ/m4q8qZGubh7jfJiWgmnTY7atRdF+4TH2d8ua24C6aojg1k
 Efa7RbIVxrG7qMDEcmMMfUpEIVS2i0l0XQeiqmRoba+A/mCIRSwIkChVeZFStgRDJtCD
 LJkt7jkOxpPbpRDVJ7SYgeqMmmxcoHdHw+oHKxhmhwa7iP7FuHIxH5wj4cLxLZvjqfTw
 +3sIa0ZwpJlUm9pRLn/lvkg0kkyvoJoe+6F4cjaWW9osxByUtfXFd5SkCp5+n3h3+wCT
 3rx0zdRTi4wxV8bQ340QjkVKfbSJMXCSo4pd3v7ho2Y1Ye4nHBWS6cCTBimIQB5bWs+u
 CLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545341; x=1692150141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ALSbk7LPRI16JuO8i+GWyfLxWcR/0f/W0UbTHzqCI2o=;
 b=RMEySaXP0D0luVutl75TyDupGC5FqRFPQIhwbw7GPA9YCjMgRKKoRg6Er2p1TCGbL0
 aWsL9rwHSn0QL+nRpS+uz+vntN8ONSdlIG/vNCY7DHde0NRWdhsfpg2amcO9/zyFXgPH
 6EJ/yEGfZXWH1wI3TI9Ry8M4l9YH/wZOREWNVtcn33a2svQaPQm1Gng5fkKFnBQyU5vU
 fNb72LeKm9ollnR820pgGD2pThQn4ZC+SQInmrBjbSiWH1TeLLh1z+KOCwhn27z1U8HU
 jHuogyuhR0gLZ74GmNc6hnKj0I7gVv6KGdbZzXPm/1CN7Mb70kCNqLdBZa4zMlyMxy2L
 8bOQ==
X-Gm-Message-State: AOJu0YxqIQjndIKS3h3/V4bIQK8sleHLci6k6EgGJnAP+dTxC+LwEIdv
 pyiMMXoO5Il+sUxhcwF2pSAAoA==
X-Google-Smtp-Source: AGHT+IHVMPmW9Id9LvqyGd9V4JDyR40g89JwfuLA8Psg/d1yoYPrGw7vTwOfT/o9WDS4ZHabBaBd8Q==
X-Received: by 2002:a17:90a:f0c2:b0:268:2862:7414 with SMTP id
 fa2-20020a17090af0c200b0026828627414mr1851572pjb.0.1691545341632; 
 Tue, 08 Aug 2023 18:42:21 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a1709027d8200b001bc39aa63ebsm9682663plm.121.2023.08.08.18.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 18:42:21 -0700 (PDT)
Message-ID: <d0aee74e-3974-dc88-c504-cde684dfe483@linaro.org>
Date: Tue, 8 Aug 2023 18:42:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2] hw/nvme fixes
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230808133552.77650-2-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808133552.77650-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/8/23 06:35, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> There was a small typo in the last pull. This replaces it.
> 
> The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:
> 
>    Merge tag 'fixes-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu  into staging (2023-08-07 13:55:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git  tags/nvme-next-pull-request
> 
> for you to fetch changes up to ec5a138ce63ce460575a44cf9ec3172c33eb0fd6:
> 
>    docs: update hw/nvme documentation for protection information (2023-08-08 15:28:05 +0200)
> 
> ----------------------------------------------------------------
> hw/nvme fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


