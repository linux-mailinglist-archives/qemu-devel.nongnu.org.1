Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D28127EF665
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:42:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41v7-0007Ca-FJ; Fri, 17 Nov 2023 11:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41v5-0007CK-4h
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:42:15 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41v2-0001Jk-Iq
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:42:14 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso2238510b3a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700239330; x=1700844130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qBW5p0dR6I78mwoX8/sr0ioAsEkRBHWuQ4Xs0hQzD4=;
 b=npYk8NXFmOc3Rq1SgFL5FjqPSHAZERm/H3QjinKLgWfQuH1NPw5ADdpKUUG4tIBEnR
 Dgsq4K8BApBJ+Q+cNZiyu9kEIoHvqf2rOyfdqn4dMs9gdekFD8J6gBmBWmb/NtNU/Jqf
 z9gWaY0tkKfdVjWkwi6ieJgLh/e+P7O+6v4xYfqqMFaN7f1Ox3j3WjOAoBFw5dU1l2K6
 LoQldZ8jRQ8eddW1Qqad0RXBcEex2nNZApNtRdfoNr9+RJHqthSFMblafZnkInrR/s0z
 HXys4kL7NzqD2jDZPbwsG649wyz+7Yb5xHpXUKN8LC5Igfa9It7orP9lhCxNrcIq8LB3
 Sn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700239330; x=1700844130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/qBW5p0dR6I78mwoX8/sr0ioAsEkRBHWuQ4Xs0hQzD4=;
 b=FiEDk0fg757bCJMAcIiTSXbWOG9OZcpbXSKTpV8PsMRkLB94mWMXPnA5K0gYQ6zsmv
 rY0W5K8aMCMVW//EAyGvD9EJTbiyiAdDXQzKu+Txa0JxuZ6My8L+MKm5UX+lQg5U5KaS
 qxvg4YYZgvKD3oDIvNg75FGedbTmSErmMibEnKbZG2Qae64FMGEaD2vlBZ2P/WDKWzKe
 ETedH1xaaU4Oq5YmZZsGT4QgiSihNLmUzmq+IRp00p8o3741YpLxn11LmZ/BnNPjITAi
 DBF8/AtGe7fkMMLKx9WKG31PwnNcBuq+X8wJE02QO8jbXcu7oG3hNtdAMDIRRZLFlZvn
 s9Ew==
X-Gm-Message-State: AOJu0Yy1ft/bvOqkjiY9XrUvlvWpJ3D4sZfzyqUiioPpZiqKMOfgKY0g
 bXMKrrE25dTSOiozSHgAAAEYyw==
X-Google-Smtp-Source: AGHT+IGloY72omWCxuuCzq7NvtvpOD2+2hmzTpuwDrQ9YkBEiXmnq6LSmvefjQggSTq8aK7PGdLFig==
X-Received: by 2002:a05:6a20:4412:b0:187:c151:6e13 with SMTP id
 ce18-20020a056a20441200b00187c1516e13mr6750388pzb.24.1700239330688; 
 Fri, 17 Nov 2023 08:42:10 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d12-20020aa7868c000000b006c34274f66asm1613696pfo.102.2023.11.17.08.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 08:42:10 -0800 (PST)
Message-ID: <5e95b0fa-606a-4ed6-9345-190b47e4ac97@linaro.org>
Date: Fri, 17 Nov 2023 08:42:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/hppa: Fix 64-bit SHRPD instruction
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20231117105309.149225-1-deller@kernel.org>
 <20231117105309.149225-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231117105309.149225-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/17/23 02:53, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> When shifting the two joined 64-bit registers right, shift the upper
> 64-bit register to the left and the lower 64-bit register to the right
> before merging them with OR.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

