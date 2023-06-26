Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F36AB73D93B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:10:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhIi-0002fQ-H7; Mon, 26 Jun 2023 04:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhIf-0002YW-1J
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:10:17 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhIc-00005O-Cg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:10:16 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b6a0d91e80so9202951fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687767011; x=1690359011;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oC2Ta8wbbBS4siz+u9rZcYATiHtDI+Ljl+UoMf2GpDo=;
 b=Kjv1UoNnWmpryOFHDLoPT24yYdpc2Z2wMdh1mjSaUSv39Oagnp5oIhp8v4ni/qtPXX
 FmdqQK/utTiDU6F8pKnkZaBfHgVDXcCwq9vCAmH1G0syMcAJAWdgNUYfperql1xMCvSx
 7Tf25DqHcNfDL5wERuv2R2GlK/vE+YKYMUFjBNkc+d8HYAqKgOhTyTyWeEwYXHA/NDkX
 1EqBR0tY0ASfs0Ppvmhu4B4Q3BjYHJ71iD+yUCrXQye7DoMcQ+a3/Gk+zZXaM8YUPTIS
 ZG+zYmEQ0Z9y5ILSZiF+NsYRTfoZ0u70Fpt05XwbwhbSDaBlZ5UwdK8tdVfwtqJ10rAq
 l6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687767011; x=1690359011;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oC2Ta8wbbBS4siz+u9rZcYATiHtDI+Ljl+UoMf2GpDo=;
 b=dCmBt8RJtmNcDB1syJvckPINnp618HBG7s4WTIXyrjw1BZQlEuEhJ6+iQR+YI9J8RX
 o7Zya8Prp66Ek+lP52uPXhmUOI5LJBYK1Mb3gffYFrl83w+Seoz13lnx2W/Jf8xVFqMS
 KqmM8H8O8at7DLqPT8bCQeJB0eDJqDlA/BcBHp3CPUdBSGhwnGkPCzC1yQkd00ui/8LQ
 XvOU4VpA3b9xoGotgmo1pbtAblq/0NvKJ1L4YxeEAQ3CBadgw//nfk3MZDbmYDpEkFUM
 HNuuKnGiLgl/JWivRrhvlAX+anyU5f4zlIsxWZAEeLy+0ybNz6lzmqur57reRDs/dF6a
 kONQ==
X-Gm-Message-State: AC+VfDy9qEL7zfe7/C2wRw43gPv7MxI7f6KnsNa+kzot3DqD6i2KhoJl
 3ctpc2J2mRnK1Ehy+1VNKC8dmg==
X-Google-Smtp-Source: ACHHUZ4Xy7QaCtpcm+LqSYc9ySNmD0pumPUBa2zaJ/2OWUsXD8u3F1gp5Jf3NLHr51fnpFrj4HoUpw==
X-Received: by 2002:a2e:9081:0:b0:2b6:a6c4:b848 with SMTP id
 l1-20020a2e9081000000b002b6a6c4b848mr61866ljg.31.1687767011599; 
 Mon, 26 Jun 2023 01:10:11 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a7bce93000000b003f9b53959a4sm9682356wmj.43.2023.06.26.01.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:10:11 -0700 (PDT)
Message-ID: <035c4562-ab43-0dcc-443e-94aed53c37ff@linaro.org>
Date: Mon, 26 Jun 2023 10:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 14/26] tests/lcitool: add an explicit gcc-native package
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> We need a native compiler to build the hexagon codegen tools. In our
> current images we already have a gcc as a side effect of a broken
> dependency between gcovr and lcov but this will be fixed when we move
> to bookworm. See
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987818 for details.
> 
> Update the packages while we are at it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

