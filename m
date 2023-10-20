Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81E7D2092
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 03:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quMs4-0000OM-OL; Sat, 21 Oct 2023 21:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs2-0000OA-Kx
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs1-0006kO-02
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcea0so1611458b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 18:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697936586; x=1698541386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Viw3V9BmxIPUP4OzjfOAJwhqirsHsFg4WT303wKFZT8=;
 b=Znz4ET9BGMZN2G3qy98uUIug4cKs6lFCoctCA0lviJ5Jq6IW7GPE9vU9Ci7ZKHvBdY
 MdtMc63+l6ug1P98+Gn4HTvbDyl7ZjxY3HX5q/nU3LiO5hnlmWwkJnrUwH+Jr4JkSnGH
 NXuh866y0swjacMtUZrralGFJiHvqJ4OWBjpuJEOq4kEVsmy+Mk2KUDaxOqzL4DznCPK
 foFppcvawAhXA77ToYVcIXAjvm7fXc55WlSQhShdVvDb6WfbFiutU7MqQhnyOK0xK9u3
 9hQSVo9DuIiMFwmpGwnIrEl54NczwGmajVXDQmMdeDWzAqwzpkHChyiZO16T+jpB1XxS
 OPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697936586; x=1698541386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Viw3V9BmxIPUP4OzjfOAJwhqirsHsFg4WT303wKFZT8=;
 b=CUofo0Bw+xWhtLtZzU9GQPlZo3vz8O/3KUx9DUbSqSiv2QSHG4OoQbXRNN4tB65KvV
 j5hkE1OiAo+IhCgdXF7Xfv1INqYHqvw5iFT/xxmTuFitSUIlqrGq76G022oZglHMV2jJ
 tKCZGgZzGYENGGmUZu6c2NuyxbInxQLFD+AT7pi4dXXcAFT9SB6OMtdcAZhxu2PBto/c
 ctF2xTWl98sU+fgFNWUKgjf1AhKmWGJxTjbNYM65UKuUEgsPaD7Px8dc8JvfApmYT/hB
 Jks65u8TzKHudRlgnU/e6LL5HbdzQ0g7HIrn9VdX2imX0aUDwwZGAD2AE41dBK2pL9+/
 1fGg==
X-Gm-Message-State: AOJu0YwDb3IaXN322ffHwlqSt0VFk28w7mvBY8koHiWEa8AOEPa56dvD
 R2ChSkNSpPB/eHlFJbjayiEj3w==
X-Google-Smtp-Source: AGHT+IGUPiO7A/qdvapP8Qhp77zvat9v1tkAJ/wKoMMF50CGYrk+rg5NhmR/zzgaTFr8myjBuVNDXw==
X-Received: by 2002:a17:903:124e:b0:1c6:1ab1:93eb with SMTP id
 u14-20020a170903124e00b001c61ab193ebmr4955768plh.17.1697936586414; 
 Sat, 21 Oct 2023 18:03:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb14-20020a170903258e00b001bc21222e34sm3704336plb.285.2023.10.21.18.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 18:03:05 -0700 (PDT)
Message-ID: <1dd41410-3649-4f5f-9cf6-0e7c8b963f61@linaro.org>
Date: Fri, 20 Oct 2023 08:50:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/audio/pcspk: Inline pcspk_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org
References: <20231020105447.43482-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020105447.43482-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/20/23 03:54, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Propagate error in hw/i386/
> 
> Philippe Mathieu-Daudé (5):
>    hw/i386/pc: Pass Error** argument to pc_basic_device_init()
>    hw/i386/pc: Propagate error if HPET device creation failed
>    hw/i386/pc: Inline legacy pcspk_init() in pc_basic_device_init()
>    hw/isa/i82378: Inline legacy pcspk_init()
>    hw/mips/jazz: Inline and remove legacy pcspk_init()
> 
>   include/hw/audio/pcspk.h | 10 ----------
>   include/hw/i386/pc.h     |  5 +++--
>   hw/i386/pc.c             | 17 +++++++++++++----
>   hw/i386/pc_piix.c        |  2 +-
>   hw/i386/pc_q35.c         |  2 +-
>   hw/isa/i82378.c          |  7 ++++++-
>   hw/mips/jazz.c           |  5 ++++-
>   7 files changed, 28 insertions(+), 20 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

