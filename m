Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5DD7D0422
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtamM-0006mS-LV; Thu, 19 Oct 2023 17:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtamJ-0006bu-0C
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:42:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtamH-0000t3-HC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:42:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so1270295e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751719; x=1698356519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJaGa6xJu/JHhh5O53jFh8ALYoJ2QIrqMEDbhV9uQG8=;
 b=CgNYXbm0gbp5R4vlbyxtbkLUDDOwWhW1NOshsIpNOtKr0FXtdz3mh1RZIVLwIo6Jko
 3wT9REdZo1evt6SdmIogAEFcmLLQtZROuniZoWSb4rfUuf5ShcBCLG90v0hAvI9J9KNN
 oUBT/LZxv1cdNPIN2D/nlxUSx1ICuFTcXYsWkb2auLnxhHfTp9O0VgRsTsT7Z9TjKmsg
 jyoe7ufIO6IeRvk16VXcTcU6Y5yUWbX2Atm+fGtKSRz84rr3IENDUY/vlMe/3lvzyybA
 z5HguTKRpfLFiKjCwYhwYc0yUPQdGHi18JvvMqmJK9j+Sl+cLliUwxbaxUgQeSf0MZJG
 Reng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751719; x=1698356519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJaGa6xJu/JHhh5O53jFh8ALYoJ2QIrqMEDbhV9uQG8=;
 b=ZNTKugPRBCEeTE7GxyGroIj0RfIMcaI1cq16+pfaONBlzA/vrFrgOUs28DKvjYxxzT
 A5w2U4cEgBoXa8+uoS8x6JbWvUpXch1xd89SaVniSv2ojDXyvkFgwQlLLHAdvynAHAHJ
 hlOOUwdHjSy1GUq094QDEg/Gb7ZRIRMBG0kty0iX7dBKBeXfsdVVmMNPfy+XhenbRiEK
 A8nBjx0ZGlOVciGuQVxcaXIOUsZQxYEcBgJurMnSWV5SUYOrqbiMSepyn8Sw6ZkgdCzu
 ukVHkz8pulMWUu1BMvEr2RYo/TLjFj+vie4n6v1BvQ7wi//KE6T2KiKSWaU09x4+013I
 4yGA==
X-Gm-Message-State: AOJu0Yw1T35c53DbkJXGk5GU3ewElhhgQmia/S4ljJSZi7fRu5q8tLp/
 TsNdYbDdQTDrJYBQyFpadimVelmVqGggzEi09eLxDQ==
X-Google-Smtp-Source: AGHT+IHEpSb8qMFYR/UNiwgXEvUWR6SZOmri7Z/lqFEqynWCIvvjYl1tIO0mfDodPRspcpTnTik5Bg==
X-Received: by 2002:a05:600c:1f83:b0:404:fc52:a3c6 with SMTP id
 je3-20020a05600c1f8300b00404fc52a3c6mr78062wmb.25.1697751719502; 
 Thu, 19 Oct 2023 14:41:59 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 n15-20020a7bcbcf000000b004060f0a0fdbsm5331241wmi.41.2023.10.19.14.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:41:59 -0700 (PDT)
Message-ID: <1562189c-2aab-993d-2240-304cabe6f62a@linaro.org>
Date: Thu, 19 Oct 2023 23:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ui/input: Constify QemuInputHandler structure
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-ppc@nongnu.org,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231017131251.43708-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017131251.43708-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/23 15:12, Philippe Mathieu-Daudé wrote:
> Access to QemuInputHandlerState::handler are read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-input.h | 2 +-
>   include/ui/input.h               | 2 +-
>   chardev/msmouse.c                | 2 +-
>   chardev/wctablet.c               | 2 +-
>   hw/char/escc.c                   | 2 +-
>   hw/display/xenfb.c               | 6 +++---
>   hw/input/adb-kbd.c               | 2 +-
>   hw/input/hid.c                   | 6 +++---
>   hw/input/ps2.c                   | 4 ++--
>   hw/input/virtio-input-hid.c      | 8 ++++----
>   ui/input-legacy.c                | 2 +-
>   ui/input.c                       | 4 ++--
>   ui/vdagent.c                     | 2 +-
>   13 files changed, 22 insertions(+), 22 deletions(-)

Patch queued to hw-misc.

