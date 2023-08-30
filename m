Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4578E0FD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbS90-00072F-Ea; Wed, 30 Aug 2023 16:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbS8y-00071y-J0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:50:28 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbS8w-0003bD-F8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:50:28 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34b0f3b792dso645545ab.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693428625; x=1694033425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q+WMe0wWWyEoQ/obY/JPeaI+mjyB0iMzeLaGLRRAziQ=;
 b=tBvSfe2dSYssXLb9H4UxHxw7C+rR8zKZflQPkmeUFCB4jy/t1FLBLEArU8HPNUJvLx
 2QXSUeTRNAc8Jj3LqTFQZFrM4U9BGfihn0AKyheQT1qLniyEh/Qp/O0dZGnMUGAP5rRT
 cFj0f8ZWP7oc+Iorg0gcYuUEYhOq1E+uLEKh6Gh1J5GHiEQluvuH6Lu5dglOa+NF8i5x
 giVGalFIAMeVWOUS8mFLYJDykQ1gNED5uf3rGiJMhgvduetqiZONUl1WTuom/j8tmdqF
 bpxnrQXT3Ko2NODu4wTyH3Zb4HLXWIrlfLuMWwPe+FLFqxSlEAwjcV7eiXV5hZ6FBVEt
 Fu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693428625; x=1694033425;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+WMe0wWWyEoQ/obY/JPeaI+mjyB0iMzeLaGLRRAziQ=;
 b=bJg2hqHxKs8sdVjJ5jCrAzd3c7VPIiXqtd+VFGlj1Hgb7einv2m1a+fsYVNtIc95Ty
 WoJa4955oAMBrZQRHcU40/DfJ7Fw5E/iSyhihGAaiMiIdU9qrDPSzWh9ZcVkKzVxNTVz
 7/WxIBwJptp9+EkwTK3FVB7V3vr9VWTAEYedjSqP5oqGv78AuPJ18UKEC7N6Qivikqf3
 uXGVDA6Q1M4ACRnN1A/P9aQriwrDqMf1XRabhsiOn7HBSHNK5UomZ0W+klWFcV5upw7p
 WNIXhDrnYIwRgGKNsPwbdv281+hjOzsQ0/AFG0RKHB7RMm3KqEhtz91ZuaYMzZvww/la
 X08Q==
X-Gm-Message-State: AOJu0Yx4cLGSDhOQNcgQvdS6tVlAQUVRFC7X4dnFAJXR4kicKdPhz13q
 orup7jnk3BFqwz7ZZv03pjj4bqd3qTOrQqwzrJc=
X-Google-Smtp-Source: AGHT+IHJr4jIV1YAhrRL9KO8umdLVL//mffsoWjDtwPhziGx/MGbLixFnKhJApjcpxhZot3JLoi7jA==
X-Received: by 2002:a05:6e02:1a49:b0:348:cd6b:d593 with SMTP id
 u9-20020a056e021a4900b00348cd6bd593mr4023671ilv.27.1693428625181; 
 Wed, 30 Aug 2023 13:50:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a63aa4e000000b0056c5454105csm12941pgo.93.2023.08.30.13.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:50:24 -0700 (PDT)
Message-ID: <70311784-328e-2cda-8688-613aab2d7f7f@linaro.org>
Date: Wed, 30 Aug 2023 13:50:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 16/48] target/loongarch: Implement xvmax/xvmin
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-17-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-17-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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
> - XVMAX[I].{B/H/W/D}[U];
> - XVMIN[I].{B/H/W/D}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |  3 ++
>   target/loongarch/insns.decode                | 36 ++++++++++++++++++++
>   target/loongarch/disas.c                     | 34 ++++++++++++++++++
>   target/loongarch/vec_helper.c                | 26 +++++++-------
>   target/loongarch/insn_trans/trans_lasx.c.inc | 36 ++++++++++++++++++++
>   5 files changed, 121 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

