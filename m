Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC787EBAE3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:18:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34XL-0001mu-CF; Tue, 14 Nov 2023 20:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34XJ-0001iD-H9
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:17:45 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34XH-0001RM-Tf
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:17:45 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35742cbb670so22473405ab.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700011062; x=1700615862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aUYG/dW5lLbainLS7iUos/M39ErWn8UXL3WljceCSXA=;
 b=rfyrgOJIutjjBGpDGWgh+5CY6UevcDZIS5clVORweEizb3yLML9i9+sTnAPXz6Ks6C
 AN5xnaQveMNSoJENP570ExNC0XQbcxpq9j6XSsIhvmErM1ZWAIevYU1cuj369prDuScA
 S5oC4apbxu0q7mMANfPIdUXu8KGtTy55zk1/1Dq98xI2X4tgR+YYGCbBjp6vjngObMNE
 1CsXvJHBn1A3t3EFqjyf00TiQMSMMnwmKsaP19vftURrl3h2tddTqC/NhqxGu+ViwnIj
 DpzpbdumM0qzT32doSS0jyyE6QMJBanAqD1HLY+1fW6cdYjo92MyyWROamBLfMgopUb+
 sEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700011062; x=1700615862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUYG/dW5lLbainLS7iUos/M39ErWn8UXL3WljceCSXA=;
 b=VU0FU9E99Xvh+PaR09Ppk9OdDpPw2T9Svp68+TB50KVCarBS1QB8fJ0A5nH/itlYDQ
 ClssuWTEqYAb6vB6rUBXeoDO7B7zY8NbZAaDeGtcuQFbM2RrsHgielw2z2sHckoOShVa
 oAFtX57/zuVpT9/4aD85QjDqvcgRb2tLtmTFkmyiqviwfGuZW/IakGgunFqPjqM7l4CT
 z6cskX+upbv0UhWMAy62T+A8m6ThLBzozFpmyU/CdfibCt42adpETF9x/AoeyLtzndQJ
 ZbZzmti5KQCbIOLIsNGHQQYBNQskVoL31u6LiicPNzaZMDuyk0Knx2AmufhELfoxyuKj
 rvXw==
X-Gm-Message-State: AOJu0YxE8m1RnWkk8Z++Yls0Ly/CqE2JJ8ch+0jUUvox5W87SEegMjkl
 bt26U20T4t73w9JkQjXU8KJ/Kg==
X-Google-Smtp-Source: AGHT+IG+yMZg9oSz/S0iGBWOZhTpRCn/m9jGJMJ8Uer47rAV5BpdGC55B0z4SBb7OcR4FJXikRmw7Q==
X-Received: by 2002:a05:6e02:1645:b0:35a:b3d4:e4b1 with SMTP id
 v5-20020a056e02164500b0035ab3d4e4b1mr14000004ilu.26.1700011062493; 
 Tue, 14 Nov 2023 17:17:42 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k6-20020aa790c6000000b006c5da63556dsm1867085pfk.178.2023.11.14.17.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:17:42 -0800 (PST)
Message-ID: <0930c8cb-02b7-474f-bade-737cd273b20c@linaro.org>
Date: Tue, 14 Nov 2023 17:17:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/31] machine: Constify
 MachineClass::valid_cpu_types[i]
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-24-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-24-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Constify MachineClass::valid_cpu_types[i], as suggested by Richard
> Henderson.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800.c      | 2 +-
>   include/hw/boards.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

