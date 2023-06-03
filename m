Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE227720DAF
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5IHJ-0007Li-G5; Fri, 02 Jun 2023 23:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IHF-0007LP-N4
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:50:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IHD-0002Op-Ue
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:50:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d57cd373fso3018777b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685764201; x=1688356201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nIyjmi92rBS1EqtCe5eFBgTwSnYgfO5rolKI4VvG2mM=;
 b=ahEjj9GhT1OH3DJd0St4B3COr7JApjelzl+AokE1LyNaFMYq3r6ETRgJ5tUTWLO6ws
 X7efRk4v8bs28VVo7h4QdAPR8eeTx/5c/GhRkxweckQlmRHHofSg81knEi4wYGNloTvs
 617oSFW6T58KQzkQ7IFgGnz3MWdcFXs4KRV/o/tjjnPwyQyMeQ1hg/e5A8ccFbOX2zqI
 m9si0+4SQi+OaeS6JHjS7DjEj2MSzUBKenJ1nfQrYDnJvXNPSCPMP/Nqyg0J7Jr3Bxwq
 YInFeeiPl/8jVnu0z6GMOvfza9pI13tUJD3g76V7RYkoLVE6f4dmDkIgU0vByf6ekVDZ
 3RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685764201; x=1688356201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nIyjmi92rBS1EqtCe5eFBgTwSnYgfO5rolKI4VvG2mM=;
 b=k97EDenDMKdWTKz7c48ajNbJzi2bE2xX2D+INy1xoSvGHM3LdF2mmNJYAvQRDSip+X
 mejP/mFuwLW8F8oiPybN34I4eJ93Ypcc20GC9lxNIm85LbN3maDasSYtM4xGeoLCoczQ
 NdLOfWVZSQKjTQPMMrT3RfmiI3eN2aKb0UXb08RH5yxiLPf/nqjZlxSn16fBAwSzerBH
 sKXHFFQtUdc/btZ78uVGBSEO9NvzDFDE6oMaVoMWwjJ8uN8ZB9TYuWNl9QyUDSAoafem
 p0DxQaVZPf1xzk6kswK1f/VeO9bHOzKgw/470uh2DctyyQ+vHBszIlGjL0wWvEfq2IuM
 EH4A==
X-Gm-Message-State: AC+VfDzqo/pT7IMYzQK7/oJEUglynyPnDbdPOcShYie6YnaHq6py6Iaf
 Y9I/POP0QyfdP3YgSkYyrHGmeA==
X-Google-Smtp-Source: ACHHUZ5rdnf0ws4gKJL0HquZnkSDtoXpNfmnT4g+k6K4x3GdfBYLjT14TYBM05H16Z1BjphHbuYhTw==
X-Received: by 2002:a05:6a21:6d89:b0:10b:d70d:f971 with SMTP id
 wl9-20020a056a216d8900b0010bd70df971mr524099pzb.3.1685764201487; 
 Fri, 02 Jun 2023 20:50:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a63d110000000b00528b78ddbcesm1946804pgg.70.2023.06.02.20.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:50:01 -0700 (PDT)
Message-ID: <7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org>
Date: Fri, 2 Jun 2023 20:49:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/2] bulk: Replace !CONFIG_SOFTMMU -> CONFIG_USER_ONLY
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230602225811.60152-1-philmd@linaro.org>
 <20230602225811.60152-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602225811.60152-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/2/23 15:58, Philippe Mathieu-Daudé wrote:
> CONFIG_USER_ONLY is the opposite of CONFIG_SOFTMMU.
> Replace !CONFIG_SOFTMMU negation by the positive form
> which is clearer when reviewing code.

CONFIG_SOFTMMU should be reserved for the actual softmmu tlb, which we *should* be able to 
enable for user-only.  It is the only way to handle some of our host/guest page size 
problems.  Further, CONFIG_SOFTMMU should go away as a #define and become a runtime test 
(forced to true for system mode).  Pie in the sky stuff.

It is quite likely that all uses of CONFIG_SOFTMMU outside of tcg/, accel/tcg/, and random 
bits of include/ should only be using CONFIG_USER_ONLY.


r~

