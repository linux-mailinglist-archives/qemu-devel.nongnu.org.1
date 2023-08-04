Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5EF770044
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtvm-00006t-Cr; Fri, 04 Aug 2023 08:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtvk-00005u-8J
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:29:20 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtvi-0000sr-MY
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:29:19 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-522c9d388d2so2507647a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691152157; x=1691756957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FnExB2MV1pntH7llMmGCpsV4XSVEHHmLdXoB5g1Ii6U=;
 b=l02KZutNU64wBkmWvYLHKRIMtk6uRH5Vq4Alob/PmXVAZj2DqF812iEP5ACze8nGgE
 tE8HBtMqHYkjgsVgFK8EteSZBzgrPQX337Ls6xXg5rUJeLSnSYAZ7NpI/sDZnrpDh3NO
 iLjWClZ2XgRa4gWwv7aBJj4d3dc8dK1y0dm/n7WVThscfGdMayZfQrEybY61J1Wj+N0z
 GlEly1sbffF6raYMbCKU8PG16qccmp7kiz99uoZzklFwg+zBRD3scG29uQZUt+0dLZgV
 bH0KIRLqv8FLM65rdNECmCdIk6PmnL3F2pUKujaEs24TLPEYCw6+D5n9E2ZwIHSPWNr3
 78FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691152157; x=1691756957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FnExB2MV1pntH7llMmGCpsV4XSVEHHmLdXoB5g1Ii6U=;
 b=LjKlNteWAbgwy9A4X4rljDInzH7p0v2Acchfrnd/hqtQLqHHGQtHLRrBbfZqy9h6vx
 Q55TBgrl8VIsabGBd7mU4i6tXUNHnIlJN6ePnuXaLREcD/BOCavd0ivdKp5vK4pi5YOX
 0TPiNyreeoXCGP82FZ2EuyGmjylQ7Hna6Ch3Ve+1xTAi7C2X/EJlXcpgKIOES5Hk1YRH
 6fbFVzxvVHVg3GHF8Q4Jf6n39qwO2N7ODGdKL264g6DmGvFgwcMAnTzWftZjqkNz120V
 cHRi+ewwMOynvXvmvCPxaAcXJpbKQRfdzStCDs87vTyuCWjVbXlF32dqe1GujKg70wt0
 uBOw==
X-Gm-Message-State: AOJu0Yzii+j1XIDJsEaSEDzmtJjY0YRrJY6rzi44166YIzOVbptChCBm
 hXJPZGWKNFu6DWdtZCMInmLcqBj2+MEW4P2TUJEPqQ==
X-Google-Smtp-Source: AGHT+IFHJQ3EnEsvg/kfxIBz36TBvo/KBb6URAVlxCBK3ZHy5sAXO8sppqv6Fm/sIcPzrDMIZUI93hhCa0YTT+0xuuA=
X-Received: by 2002:aa7:dc0f:0:b0:523:1053:9b50 with SMTP id
 b15-20020aa7dc0f000000b0052310539b50mr1245671edu.20.1691152157068; Fri, 04
 Aug 2023 05:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-10-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-10-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:29:06 +0100
Message-ID: <CAFEAcA9O1AVA7gU_6yR6c8y8TKgX+fq7sCp1o6SjxE+KvMTojw@mail.gmail.com>
Subject: Re: [PATCH 09/44] Add GPIO and SD to BCM2838 periph
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 26 Jul 2023 at 15:38, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 140 +++++++++++++++++++++++++++
>  include/hw/arm/bcm2838_peripherals.h |   9 ++
>  2 files changed, 149 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

