Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C42277CEC5E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:53:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtGLV-0005Kp-3t; Wed, 18 Oct 2023 19:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGLG-0005JM-3i
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:52:46 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGLE-0005wC-4z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:52:45 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d81d09d883dso8297834276.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697673162; x=1698277962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjfoBd+om0ODEuMyksjfYohCj2uTX2efCaRHn1fBosc=;
 b=g0B/Lxv/hYh11nr66oaw46ZSKuTvwsuAEik+7GQFmi/KLNmw9PE7OFVaTDm647uk9z
 53SyQcZOgj0pf/QKHbH7qB70byQUDK4yNWdn4bduWA2lcsRsT42LLVp56yEtDnBD6vqq
 UA/CxCXSydJUp3CEA7zWvvn1ME+H61x1G3+5qdGn59qeuvU4ZdcqlXtKJM2AGXwuH0XK
 4eaG3HZZzyQLqKPOorvO7Ry8LPdgv0odJqsivh0ap407hwA767X9WGL/zSTzEtGvr/ba
 UajaofDPYYNatrpBfJ3IIACsIcGQSSILlATUyI84xE9ailVqYgB/IB0Q0PYO8Gaz/l66
 Irvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697673162; x=1698277962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjfoBd+om0ODEuMyksjfYohCj2uTX2efCaRHn1fBosc=;
 b=EN+Df4mLeQ8GNP6HhUPLvyQDaT9Cnb8KEnsqttBmrbOTDKxUKELuuyG6hYPB9dFRbS
 7Pyjog2QBJYSFx+m7JXXlhQkyV1cnZuXWGUoVROZ0eKuiPJvW2aBvRQflOtA3R7HRlJ6
 pXpYdnGql+76fHrxx0/DKVMPcHA9Gd+SW3shNXMy5we7RwTa0lLgtz/qisQ3xN1wpZ+o
 qSAvUXad9FHBkMoPOwIAPxJHL20ATklvmMPuNj2GEJSxMLwddqIPHVI+t+3TIvcnmwb5
 VP5cgqzPjNlZsAPgVuKEc1zO8OoTnx/FWLGNfgCxb8qqetEtHKUbicxsdOzkslrwrRX9
 44BA==
X-Gm-Message-State: AOJu0YwM7tTlyeOnDaCwHvqrSn8wSKWyAq4wE7yHjwuRpTemlykxuUKu
 J5z6Paut5kYCD0HmbBlKOMXz2w==
X-Google-Smtp-Source: AGHT+IGyuRyc38nLgJ/guQmzZ65gd90vknMEM+WIc2FrdJPzcOYZ9TXak3or+Ok5KLTyHEGMPmav7g==
X-Received: by 2002:a25:2bc1:0:b0:d9a:43d9:a12e with SMTP id
 r184-20020a252bc1000000b00d9a43d9a12emr952505ybr.2.1697673162057; 
 Wed, 18 Oct 2023 16:52:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 f17-20020aa79d91000000b0069342d58ea0sm4007651pfq.90.2023.10.18.16.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 16:52:41 -0700 (PDT)
Message-ID: <07311b80-e43f-4d4f-bc2e-1e1a366e8fd2@linaro.org>
Date: Wed, 18 Oct 2023 16:52:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/ppc: SysBus simplifications
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org
References: <20231018133059.85765-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb29.google.com
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

On 10/18/23 06:30, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> There is no point in exposing an internal MMIO region via
> SysBus and directly mapping it in the very same device.
> 
> This series replaces a sequence of:
> - sysbus_init_mmio()
> - sysbus_mmio_map()
> by a single call to memory_region_add_subregion().
> 
> Philippe Mathieu-Daudé (6):
>    hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
>      pnv_xscom_init()
>    hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
>    hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
>    hw/ppc/pnv: Do not use SysBus API to map local MMIO region
>    hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
>    hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region
> 
>   include/hw/ppc/pnv_xscom.h |  2 +-
>   hw/intc/spapr_xive.c       | 12 ++++++------
>   hw/ppc/pnv.c               | 26 +++++---------------------
>   hw/ppc/pnv_xscom.c         |  5 ++---
>   4 files changed, 14 insertions(+), 31 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

