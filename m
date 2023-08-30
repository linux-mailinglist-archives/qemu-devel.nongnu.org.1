Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D278E2E9
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbU8J-0006GT-5b; Wed, 30 Aug 2023 18:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbU8H-0006Fu-8u
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:57:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbU8E-0003IO-80
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:57:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so1214785ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693436269; x=1694041069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PnU4D7g8cxsfjE4/5+vh/l2mJrVoUHd5nMXq0KJMiYo=;
 b=kmDt9ySZeA2aPYr7uKFWJeyuCOgxnZ89jF6HKnR3/W/1a6MnFGe+nT3j2jeqdsm4Pk
 mUJZbeaGCUlau2b7TMtfOGzD68X7B1URkAxS3t8be74ivtoazk/3Y4noTomVp09qhLVC
 pygA4XxoQvIA3SY0qr4wQBvUPCBUtUhHzxYdTNKoMHEPmG/Bn0qhtaRMuap82wQd2A/s
 lKg0Y/7S3pduTkqR+bBfQd9M6b3BHqkq9/HameGqObetXZAEazdVZTLBgxDiXdgn7Oem
 pUau9Sh4pauMq4yRlB+8UMNhLnvuzqNmM3WB7wbQM7yAXCF2dLYrwd47RJBOXuXJvKkr
 ZMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693436269; x=1694041069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnU4D7g8cxsfjE4/5+vh/l2mJrVoUHd5nMXq0KJMiYo=;
 b=Bsczi1dpvnRClRpmWkh2qkFtk5TRv2m5Oj5+GH52B0RAoq7v3DHukvPZY0vd/BGE5P
 RL77a6zCaBKVXzxRIxYaaVDkkKk+MvwTlaqS2sZ1fRFUV6ksqWv4a8MRsY/1ybpyEsO0
 urjpwbJjB3nOKYGQRpzsARA3EV0UYAZ1FGuLJf9XqQmYVLa4YPvFMyCSLhFpL2tnKRRw
 esxWFPqLiM7q/4pQyABdcYzr82PCM0OP5I5DMlpin1igVB81EtdoSiR9UevwVO1rsJJU
 84ImiyGzVz/0/lnt8asczDFNhzMABGdjXiZLKQaK1rayneoigG5DA35VAwMQuj0jziHr
 trvQ==
X-Gm-Message-State: AOJu0YzxJcQqWPkMGv9f+PS5SnR/AEjhRyHihniA4CIvbjR2wUKUHHt/
 1+vVAA1h6OboTiAiucHj/IUo86f8Dn4e5y3iRv0=
X-Google-Smtp-Source: AGHT+IHleNW2pGqhT4hSZAOoVbHeZeTqU8Mey4k7TkteBgHW7kJnD/apajbVXtOHg0fa6AQtj/qTNw==
X-Received: by 2002:a17:902:e808:b0:1c1:e818:1e76 with SMTP id
 u8-20020a170902e80800b001c1e8181e76mr1383232plg.6.1693436268737; 
 Wed, 30 Aug 2023 15:57:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a170902dad200b001b39ffff838sm28290plx.25.2023.08.30.15.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:57:48 -0700 (PDT)
Message-ID: <45566684-91c6-03f4-542d-7bd851247d85@linaro.org>
Date: Wed, 30 Aug 2023 15:57:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 30/48] target/loongarch: Implement xvsrln xvsran
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-31-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-31-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVSRLN.{B.H/H.W/W.D};
> - XVSRAN.{B.H/H.W/W.D};
> - XVSRLNI.{B.H/H.W/W.D/D.Q};
> - XVSRANI.{B.H/H.W/W.D/D.Q}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |   2 +
>   target/loongarch/insns.decode                |  16 ++
>   target/loongarch/disas.c                     |  16 ++
>   target/loongarch/vec_helper.c                | 168 ++++++++++---------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  16 ++
>   5 files changed, 141 insertions(+), 77 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

