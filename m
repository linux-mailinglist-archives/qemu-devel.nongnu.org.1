Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 936CF7CF29A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 10:31:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtOQ9-0005al-A4; Thu, 19 Oct 2023 04:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1qtOPz-0005YS-Im; Thu, 19 Oct 2023 04:30:11 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1qtOPw-0000Zr-6w; Thu, 19 Oct 2023 04:30:09 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9beb865a40so4524908276.1; 
 Thu, 19 Oct 2023 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697704204; x=1698309004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azB/bEUShrQ5hTR+PRzy6WH8INe1OtS+PYWKl5lTkmE=;
 b=NvecTgabGbesP4B6FYZd5I+uH/mYU7h73v3eu0v0+3wPnziJcdpOfHf1bPObykkoZA
 Hk+9HxmX9w+QoLkIBd2yJ0WHzwe5kMW08hP1UGTS6lZQZUQNBjfDZ4OTTmSwaat6QZ4D
 5UnOVLtWuqlGyeYB0fbTOyKUhsC7eiD2L4ZlpE078RbYROSTF9JIsCli+CXwBOi7eL4o
 +3Y1YUTKvzv2esqy31Chwt4hB3MpdZ+48eQqrJ0fGZoSMtVzN3vRSy2Dn2+iPNiTb4S7
 Kn7i2ri8pl2DCC5tD+Ii0Cb+s41JeGIvZfN8ha0899xeQsvzIb9ZDsV1n+fpeUgMgzo5
 c6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697704204; x=1698309004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azB/bEUShrQ5hTR+PRzy6WH8INe1OtS+PYWKl5lTkmE=;
 b=YernkgD23xnHTfn3kJDESiEZVn6UKpySnb0YzRyARiXoSWYzfEH0+x8M1J06XYRtJu
 BAvhSm6aNb0bP8cWdgzuLA/JSCH18oHK2Zty8QNSEU4gwwJfNMdgrQUsf6Urmrf7t+xM
 T3ppvGWwdzYvQPHXNVlYS1+wG6NOiqnVnKKKt8L8o+oswDd4qouoOlcmVRb3QoZsKnfR
 7fVGA7eZlc4PLDHT+QOzStmSP6GEeXbMQCn0ye+LQP7uDneV/dsdA5RuXBzPSv5omopl
 zBBUh10cmpno3NgNh8mCeyAlpWiKGlZAvb3XTCR63LCNFUemhMXm3rZmiJQvqFQqdTn7
 DFOQ==
X-Gm-Message-State: AOJu0YzHDoX7jumeogKsTlWe7gGbHsdvWXVIFFl2ggvWjxFPhEXd6KWd
 XBUoKKOz2841ziC5W6mlFkM=
X-Google-Smtp-Source: AGHT+IHJ1MjE7E+THlmj04Ck4ddAct9EXrQW0GJtcx7DJusKmbSFe44vaWSaSDeEUu+I4Vvo9HfOFA==
X-Received: by 2002:a25:6d05:0:b0:d9b:417:139c with SMTP id
 i5-20020a256d05000000b00d9b0417139cmr1434791ybc.60.1697704204470; 
 Thu, 19 Oct 2023 01:30:04 -0700 (PDT)
Received: from [30.221.102.131] ([47.246.101.51])
 by smtp.gmail.com with ESMTPSA id
 e1-20020aa798c1000000b006933866f49dsm4708656pfm.19.2023.10.19.01.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 01:30:04 -0700 (PDT)
Message-ID: <7256b2f2-c03f-4915-af30-5c97ad11074a@gmail.com>
Date: Thu, 19 Oct 2023 16:28:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/ppc: SysBus simplifications
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org
References: <20231018133059.85765-1-philmd@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <baxiantai@gmail.com>
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=baxiantai@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2023/10/18 21:30, Philippe Mathieu-Daudé wrote:
> Hi,
>
> There is no point in exposing an internal MMIO region via
> SysBus and directly mapping it in the very same device.
>
> This series replaces a sequence of:
> - sysbus_init_mmio()
> - sysbus_mmio_map()
> by a single call to memory_region_add_subregion().

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

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

