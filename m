Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5F720DA2
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5I0j-0000vr-T2; Fri, 02 Jun 2023 23:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I0a-0000uy-Kh
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:32:53 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I0Z-0005vo-5w
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:32:52 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-bad102ce9eeso2976545276.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685763170; x=1688355170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQdoEU1YQjw3fKrTJSosmhfMRKRdHVRUZJOz114GVCY=;
 b=htxCZihb4MyjX2myWSe/UEcz6rVrnKU/YXJywdgCnQtAzEs8R0ecPL1CXe1KQzaf6A
 66izbG7km59hDO4ZpKQJiUBmMlJyKnzQ7yRiYM75/3IN6TFuAhbnbB/st/FEcs+pxzlK
 fnJl4EOh62o8kBZQKkGVicjd+32NzJ6gg5cns8irK6Dq03+3uItKOzaql3WiU3sGaIcS
 Sknl2r0dWu380vkDRSsR2mATP70CIeA7yz+0lvDNlHIsYTm0dNYles527vkuWbEZknK/
 HBuVlxHYLFlf+yIzX9fBWiBJK1dQpMx2dMsBTR4PoRIaRsver9VvPV4Pgn6I3rPYcd8o
 UWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685763170; x=1688355170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQdoEU1YQjw3fKrTJSosmhfMRKRdHVRUZJOz114GVCY=;
 b=C+XLh6TW3o+acwiRBjqqXEl5KCEnGKY6iViW8/WdK/4ycKtqAlc3eMT6dRyXcwr7Pj
 Pcfcd0Zwn6IV8Zqfm9IhmnS/NzNqbJhmo1Ded8B4Wn1QIsy6NsSRNwBxkgnIqT2etuPc
 4AS0LF3XghDARXBoAKH3kFeQnU6uBHV0nPrAGzbDiDP80KBSeK5ZsSv6SbFUs9qn4KGv
 YUGgcxQG3NfA5RQeRXSH7AvI5+5DpLISnOnLTfpofYjD615MimVdUdON0erMQJAcM965
 65nQyP64ja3MhunFmH6qDLpdpOOdbsslLXRWZBhWSgaOe7pGfVzYdvpc33jXTS3AxvyA
 mMdQ==
X-Gm-Message-State: AC+VfDyaZ9FVTGVXmb3ttEV7E7DUlDyFniJPbhHFxFpyjzBJJrA8ezGI
 7pQ0Zplj1Fl+CeakfatPU/E12g==
X-Google-Smtp-Source: ACHHUZ6ZfFYF6mLRaGnkWbA/PG4J7GUatJynMkgLO1c0QKSXVy28vaZzgtS5Dt8uteEa/HoVai/T0g==
X-Received: by 2002:a25:ca07:0:b0:bac:b8bd:65e2 with SMTP id
 a7-20020a25ca07000000b00bacb8bd65e2mr5432029ybg.37.1685763169985; 
 Fri, 02 Jun 2023 20:32:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a170902869000b001ac591b0500sm2082971plo.134.2023.06.02.20.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:32:49 -0700 (PDT)
Message-ID: <f2e110a0-9e35-5576-e4d0-91c377fbfd08@linaro.org>
Date: Fri, 2 Jun 2023 20:32:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/2] target/arm: allow DC CVA[D]P in user mode emulation
Content-Language: en-US
To: Zhuojia Shen <chaosdefinition@hotmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/1/23 14:53, Zhuojia Shen wrote:
> Zhuojia Shen (2):
>    target/arm: allow DC CVA[D]P in user mode emulation
>    tests/tcg/aarch64: add DC CVA[D]P tests
> 
>   target/arm/helper.c               |  6 +--
>   tests/tcg/aarch64/Makefile.target | 11 ++++++
>   tests/tcg/aarch64/dcpodp.c        | 63 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/dcpop.c         | 63 +++++++++++++++++++++++++++++++
>   4 files changed, 139 insertions(+), 4 deletions(-)
>   create mode 100644 tests/tcg/aarch64/dcpodp.c
>   create mode 100644 tests/tcg/aarch64/dcpop.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

