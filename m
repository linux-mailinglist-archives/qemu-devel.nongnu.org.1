Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C936971763A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ER1-0002qa-6h; Wed, 31 May 2023 01:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EQF-0002jj-72
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:31:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EQ8-0006ub-Rs
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:30:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso54804385e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685511051; x=1688103051;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMftQD5A7bPM5SEm7o9Vr3iwpK/wiRSnqJB5dM5eTRA=;
 b=HrjeIQFUGGdNW4wB19HvquuV/kZz6O5Slcidv/y/6ZBWmVjdKtET54eaPxz/PnUJmV
 1laaZfudiii2ZO3vqa0o5Ky9DshPT04FfTW1Qfk6WazBllYgCngf58Ae83YjFjGR7iUd
 fX4xj1u6m7wAV7HgAEZd34LrT2tQ8EdqCzer+0hrjcU6C+dljb5wqmcJ8DisdvpjO7P1
 JJfm/3rRA1kV5X8OfOkbeuGDsLLLnsxmIHvgDPwVPlHQdkwLQQnHJuHqQJgRpQqnB5hn
 MSR4aDv5XTfXZgxqa1D2yUo3MhnXXA3izM+p27wKjyXHfAa3R1Ao48VVpUSCenJzSgWU
 90sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685511051; x=1688103051;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mMftQD5A7bPM5SEm7o9Vr3iwpK/wiRSnqJB5dM5eTRA=;
 b=NsbLChuEEqpQpX2t3e+90XSlAo9lRwJ4PIYxm5GiYwe2t5EeOnVgf6Xwo7ls7wia4a
 T+AuRMEHGxhbFvHxfBe+sclFS+nxLJG8v3myBmLXeP1DCUs4jRTwrv99mo1OW8A1IGRP
 IUCPETRdOZeaYDxR/CAgPDdXxsi/71YgbVZPxOs/oCnhdLfZZc3Hs5HAmZsNNsfhAAsi
 XZNP8sSR/d4p9RKbf+p7Qi5AvaJFKtld4rTA7vlFw4MOR9J5HL7d6Xl6GvW9lHp6odDZ
 fNMrqTToESpg0HTbtp3Fcd/4XM0YUJQ0BU/s36Hd4yA+TXHHK1Aif5kvVKyIeMNP34WT
 n62w==
X-Gm-Message-State: AC+VfDwqvxpyHh/ivihNeIUlDFkypdRETvc2Tt+w/yDgQv3lTezfYBPv
 XtZYMJ3tUJ4EGPX7VYn7JeGdgSyUQJ+v9hfaQa+zkg==
X-Google-Smtp-Source: ACHHUZ6wH9msFDYvj7A/pHiva5fmM2liHHBsohF7T8mOdmtCB5BBhe5joQOEULzYmi6ly6bUmOqrmw==
X-Received: by 2002:a7b:c048:0:b0:3f6:8c0:85b3 with SMTP id
 u8-20020a7bc048000000b003f608c085b3mr4473396wmc.12.1685511050950; 
 Tue, 30 May 2023 22:30:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c1d1200b003f61177faffsm1563577wms.0.2023.05.30.22.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:30:50 -0700 (PDT)
Message-ID: <932dbd18-2a5a-db07-2f96-6c7d65c5ab21@linaro.org>
Date: Wed, 31 May 2023 07:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 48/48] tcg: Build once for system and once for user-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-49-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
> Create two static libraries for use by each execution mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/meson.build | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)

👏🏼👏🏼👏🏼

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

