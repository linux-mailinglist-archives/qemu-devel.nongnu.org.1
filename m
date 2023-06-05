Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7F07226B1
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69nH-0001zn-MT; Mon, 05 Jun 2023 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69nF-0001vI-Lv
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:58:41 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69nE-0007XQ-0e
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:58:41 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f619c2ba18so2565156e87.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969918; x=1688561918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSvxahwLuFUdnjLc5TEPp0lwfNL5X2lLrSbh3NI135c=;
 b=nexA3OvGESoVZQ0+4E22JA2e/lJIjkO226IAsYDM2xtc8xZwlSWRvUcIbpwDhBrKHm
 c7i5pAzvXDe6gpRD1nlzL8GFj5So/UruK0vVutOwv0GscOE8Bzo0zuBQC4KbGD+z7UF6
 Icd/ACyJ1cxK2v37U2ACjW3k+csicHUJVLtidS04+25MoGeTlJQkd/gHV45XH6L1Qdn1
 zLRgTL3aDc5nbaPk50mxdU1hYZ3QYBCqfvb3rdl4zMBIGCn81hVqVrOMlxY7D/Fdk5kv
 Lwe1mderht26Zu6Xfrb3CGqkQXqxBPeD/DFU46hNPxgavGM55y6jaoE/kPvSbz1SBUYA
 j74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969918; x=1688561918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSvxahwLuFUdnjLc5TEPp0lwfNL5X2lLrSbh3NI135c=;
 b=Rzz3LxdwgCLJ1Sm5g52Lm/DCtPmBvqHiSnys2MWxflG1VgVjauP8RwdH/0ZMpr4vMD
 9Xwloma3nfFOIrr23nfmYKOpxekG9Wzu93SCUCm467kDY9M+6VGLrLXfc2DGBCh8RkWT
 4rx61d4GadA3NoXBlwwweoX7BuIhwxOzBPjdNsQTtCWjrgRNLRasACjuCAlWXsXxU9zU
 Fa3sbal/RWlU04Wc8DbYiHuETV9fWX+h+cZW2hxdGKIVuGGY3GCVxcoC6O2dFXjOzkvK
 tQeZKzTAMLMQYwq45GrIB7ju+BX4Sn00PjxLmhOC5dJaCOeojIfQAa6nVdLxRusflGzk
 NsEw==
X-Gm-Message-State: AC+VfDwisudzPGBshB+esggb43QV6Gaz4QGtfe6gp3dESA/Ec8+ZOBsb
 ZqyvfpWBql71J6rQeTYP0/WGrg==
X-Google-Smtp-Source: ACHHUZ6GA4iT9y76VvIe5Oy/7P0V7ZkaW24CxzOokg7Xtd2ersqG5nvWi64NrA1Mo4g5UuMo+ttLhA==
X-Received: by 2002:ac2:5dc4:0:b0:4f6:19c8:ef13 with SMTP id
 x4-20020ac25dc4000000b004f619c8ef13mr2660104lfq.30.1685969918064; 
 Mon, 05 Jun 2023 05:58:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a1c7c0b000000b003f60faa4612sm10715626wmc.22.2023.06.05.05.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:58:37 -0700 (PDT)
Message-ID: <b268c025-33ce-f222-1e60-7331081f4092@linaro.org>
Date: Mon, 5 Jun 2023 14:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 02/15] linux-user: Remove #if 0 block in syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 4/6/23 00:23, Richard Henderson wrote:
> These definitions are in sparc/signal.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 24 ------------------------
>   1 file changed, 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


