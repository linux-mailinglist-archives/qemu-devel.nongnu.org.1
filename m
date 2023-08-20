Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58881781E6F
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjzd-0002HS-HZ; Sun, 20 Aug 2023 11:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjza-0002Gs-97
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:05:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjzX-0005hg-JS
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:05:25 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so499111b3a.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692543922; x=1693148722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgQ5j9DStC31gUgU4AeKIRfVM2UMWogdzdmNkmxJ1Lg=;
 b=LJGpmTkPbQYk296g/dm/CZ9p3MeOd7CBWnnCVK80WlVXuwlz7eyrE6DcXKbvXjtHgI
 DWrXSte3FV+4uhhoZTEbrpHHr6ZWcGL/i+UrbUedbrIADVoSGwlWMUv1FL5Kgcn1wBD1
 FDVjlAgqyp5Fn364AY61WpCRt8FO1Hp4ERdhS02uLajVzZCDOMhgRrMUrqC75KcHQu8Q
 0M4HEhn2kxE48ac647qWOco8qL1q8LFzPznZKdGZzLadmW2m6eNv5JN7gIXTrjUmRJZW
 A6aRhS4qUBOx0SS6AzvjRmDTGN4/uvFXwyZsB0f3bfzNLN916Lbu4KsfFN/BxusXDkAT
 vuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692543922; x=1693148722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgQ5j9DStC31gUgU4AeKIRfVM2UMWogdzdmNkmxJ1Lg=;
 b=iRq0+eQyC5Hr/W4gId3KeaahRekEsn5t50zRcZq+dru0GlfMw44i5VWhP8E/QZXStE
 HIMsLRyS02b/Nz4YTtM3mw/hJXPkf33ZVpbF/6bA7DTi45IcU2AUMPg4vPEEj77LaM3z
 31I0p/Dm+nMcTlJJmi8k3050jyyItQQRJi/s3liWQTuOr6RWMzWIdjhiDZ6ioX1eLg16
 AgiTnxAmvjOM+nfaqYLqTXLlG6hKW4vzK6SItDMoyyWBn/bGxe58y/7GMW6Vkuug9EMr
 eMubqQk6KFtbTouoN+y19xH9etH7dyt6JDaPLsofrulGUzfFs4SGGMrIsySAMfOaXO8u
 zbeQ==
X-Gm-Message-State: AOJu0YxkRP3OkMwB1HEIiFqqD/E/QUjvl7KQqKsdDc0rLcikS/EkHOfQ
 3PK7POWs5qrhhX2DYuHWxMvQ8w==
X-Google-Smtp-Source: AGHT+IF0X6TOdIP/ioocAb+nEKwKsTKwEFD8dsf+roCMkWSg5z6aCxU1D0cH61I7KAVlCq3lH370vw==
X-Received: by 2002:a05:6a20:4414:b0:12e:44:a1a6 with SMTP id
 ce20-20020a056a20441400b0012e0044a1a6mr7031267pzb.11.1692543922192; 
 Sun, 20 Aug 2023 08:05:22 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 p21-20020aa78615000000b006889348ba6dsm243855pfn.93.2023.08.20.08.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:05:21 -0700 (PDT)
Message-ID: <70ee3cd9-0c52-59af-8968-6f997bc2cf02@linaro.org>
Date: Sun, 20 Aug 2023 08:05:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 19/22] Implement shm_unlink(2) and shmget(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-20-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-20-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:48, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++++++
>   2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

