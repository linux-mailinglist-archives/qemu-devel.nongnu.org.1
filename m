Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7B8360A9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:11:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRsBZ-0002N8-VE; Mon, 22 Jan 2024 06:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsBX-0002Jv-3U
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:09:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsBV-0003QE-3n
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:09:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e87d07c07so38888805e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705921783; x=1706526583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bxBi0L20Wf25OqO7FzXYeNRKaIiDcQR4ub/AEzt5bCo=;
 b=mC64NV08bNsGzyBz4f+xQ6DGnTNC4hOLiiZr4IZ9HXK63x+tO/GYceG/CjuV8g8jrO
 Rma3i3hSPtzvwvSGvhlhPwWx0BwWnEFKtXaiRh2mrFuI0xzZ5mBL4eNuCkERyIsP7aDP
 QvTt00mGvVTZeYjtRoECk8kI11cRhsj9mHJXd3s/cILRK4WSfWFs/qk9WUg04oipu5f2
 IH5uPJX0nX1cMfA0/4Hs1sVW2FXszAKEIRFGkTKJRcJMa08ZxNAR9GX1SkbXeWV367tV
 /FRUH7ns22Hc37dQGySAseXUlpE5EU2J1KwNRDurRPV4HgPxFXBzxFvDEnQlOlTgSrYI
 1/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705921783; x=1706526583;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxBi0L20Wf25OqO7FzXYeNRKaIiDcQR4ub/AEzt5bCo=;
 b=gJYk4iP168dTOi9u0peHKFsV7droaX5UOzzc6SpjrdzkZbck7dWBHB2TXs+A9fy89h
 bFaWKGJRmztobKZtmMCooRK017dn9v1BJy81qmdSFaE+zgQUrrDqWQpjhjCrYRjfIlCn
 2dvjNV1QejN0PPpLOR6/Ch10SMrc434VOKuQz9jd6fb0wFoQ/tvLeWEaheWuYtAYypcY
 9XBQcDHwKFUxFe5qxI1uKPkDRxh1DcOhseFOZmjGgogUyVejqI51hsVGCKWa2C9/AL9r
 T3g/PC0c/Aoe6vs+2OdLoAVKdOGzPX2+yw10/CfzRUYaq/0tH8mfTMUxC7PVe1sRu/sp
 tppw==
X-Gm-Message-State: AOJu0Yw8qJlQoqe3GQYaRrfmyekJAaGsxknumXp4rfI9k9n/R8Yh616D
 7h23dsiO+wNMZJ84NZhLCNxdnmTCVG02SAUNdgyMka16wQFrbWFB/q4bUezDG5A=
X-Google-Smtp-Source: AGHT+IHaIz7VGmTa8FmBif5lEiRaOCK87uGCq4NWSfrryBR73PdKPllzjhcpZo3iilo4qE/mO1P3YA==
X-Received: by 2002:a05:600c:a008:b0:40e:8704:6833 with SMTP id
 jg8-20020a05600ca00800b0040e87046833mr2434637wmb.87.1705921783348; 
 Mon, 22 Jan 2024 03:09:43 -0800 (PST)
Received: from [192.168.149.175] ([92.88.171.62])
 by smtp.gmail.com with ESMTPSA id
 r8-20020adfe688000000b00337d97338b0sm9261510wrm.76.2024.01.22.03.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 03:09:42 -0800 (PST)
Message-ID: <aa777c77-c55a-4737-afc6-d8c2a3111814@linaro.org>
Date: Mon, 22 Jan 2024 12:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xtensa: require libfdt
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240122094230.283653-1-pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122094230.283653-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Paolo,

On 22/1/24 10:42, Paolo Bonzini wrote:
> Always allow -dtb in qemu-system-xtensa.  Basically all other targets require
> it if it can be used (including for example i386/x86_64).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/targets/xtensa-softmmu.mak   | 1 +
>   configs/targets/xtensaeb-softmmu.mak | 1 +
>   hw/xtensa/xtfpga.c                   | 9 ---------
>   3 files changed, 2 insertions(+), 9 deletions(-)

I've been wondering for some time why not requires libfdt
for all sysemu targets. It gives some pain with MIPS machines,
and I wonder if there is any value in not including it.

