Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6057A038A1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Jan 2025 08:14:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3mh-0003uH-N9; Tue, 07 Jan 2025 02:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3mf-0003tN-D7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:13:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3md-0006da-R2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:13:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4368a293339so119046175e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234026; x=1736838826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rDTyknYG/n4p0CQdZNm0IL3NjHV/iSJa6yosIDlb+0w=;
 b=NclUlQmYzFFkjZJW7Ju97o1yFbmCDHiOZl9MIZYC/uLMNQICk4nq3NjKTSOGMR9Bu9
 +3qQwBt6hzqUrX0gLlE/eN+9Gg1NqVGEyvPCijlQbxAsaQD91DNHuaBeRXHNDXXwxd1f
 AiOQkJP8orTNrNy5dVOH3cOgACs7R4OpCpgEzABl85LLicEeHplrafxv4eZPVtaMe+rt
 IcxVm4ybOc8oqBBf90X7mzCqQr5fp37Vd+SiAfiFYfiWNc/IWDb66xZXCDnjxf0tebUV
 9NpH87Xpet3cLbU8H+JB2JgFl7aqUUZM3NvFbsP5Tk6rv/g3IM3EoE1eaX4O7K3gE7ba
 B+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234026; x=1736838826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDTyknYG/n4p0CQdZNm0IL3NjHV/iSJa6yosIDlb+0w=;
 b=PEa06kPNF6xa8dVmg7t2Bz75VlbOgAyhvregj2zgyf5G6pvTLf2MlmgsV96bFGXf41
 Uzdi8+Uq4FsGMCZXrWhHGNmhqN6QcZaq/usZXahxr2Cdsnd+VHPrupJgoxELrWL5VCvq
 qO7lem/GH6Z6ukpE3RZqWwsEGRlvlSYBbeuT2mOVxwVAp3yKhIYgDbUy44E9STDiVRxr
 uW0VrNF89hPLwyrxILRpE8v0KMmFJgFk/RlwcPyWTEDFF6od5KH6QFVqfQNlvEF2b68E
 ppbHH0OPPHNx/tLrtwpkNLx9UJDPiICGFjc1DMGu2Y2OcM9wKergdrTNUwA61X6Bx8/W
 Z6HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWIvmTghMPhQi1TYiDvI5XE1b3BJ7UXMYx8fc8ubdmRSXFsuvOdhPkl1oDwIld6welYjb0RkkWTlxo@nongnu.org
X-Gm-Message-State: AOJu0YxhoKQQN2cIcyaQuFNZlgmfw2h8WbRSVbc7cy2KubuztGco2L6E
 edPDUR6bkrE0KnKirs9ze6pkUzpamBaTnJpARUL0ww0nsBQRkpXc/hvYnQku76U=
X-Gm-Gg: ASbGncuNMCMeVZ/GJTmek+Eogr59sgetWU9ZyRssM26De8V9wsmhw9P8toX+V3BZxSk
 NmuUihYUzHYhR4Q27vuCNYU0uB5hCEy3uWkhcDKpMQ0S744UNdbXuSsf7VdEWO897Z3G/jP0odA
 5SH1/h7ldolsFnLvHWibLBczeSCyAf9R0+vLvdghmpygIPJx+MIC9wQsFGKOBMmqlIfvEKGgB1d
 OGxwpFwuj2KIusEKegrVXfS55eIG/kqaMZm0x1mYH6PtQMM62wClEN24nagstCXWjmF7PhUw5Yd
 5dnRWVOYHZR8NL03mwDfYtMk
X-Google-Smtp-Source: AGHT+IEJWmIEybnfrgUmTwiX6A1+izDL0dd+arHFQnwWdX7j+0rU4+1Wb3YYQHo0R4ygxZPuwnqo7A==
X-Received: by 2002:a05:6000:400c:b0:385:f23a:2fe1 with SMTP id
 ffacd0b85a97d-38a221f92c9mr56475687f8f.26.1736234025844; 
 Mon, 06 Jan 2025 23:13:45 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832b32sm48929904f8f.23.2025.01.06.23.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:13:45 -0800 (PST)
Message-ID: <28ce2adc-b992-4837-9a40-da31b42ece41@linaro.org>
Date: Tue, 7 Jan 2025 08:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/73] tcg: Add TCGType argument to tcg_gen_op*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/1/25 19:05, Richard Henderson wrote:
> This covers the balance of opcode generation.
> At this point, TCGOp.type is initialized.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h |  13 ++---
>   tcg/tcg-op-ldst.c  |  26 +++++-----
>   tcg/tcg-op.c       | 119 ++++++++++++++++++++++++---------------------
>   3 files changed, 85 insertions(+), 73 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


