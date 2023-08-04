Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18855770020
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtoA-00029S-LE; Fri, 04 Aug 2023 08:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRto6-00028m-0W
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:21:27 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRto3-0007ER-Kd
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:21:25 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52222562f1eso2658744a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691151681; x=1691756481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b+2RejFsW7GG6XTrNt7Ulg3EG3QtR6PZwEeBRFn3KA8=;
 b=SoAq+dWT8Grsg/BbNxWbIKubtxsPzJJpINbrHCWDD3HM9IQsoM0HoD/t5DE+MTiFXF
 OxqlKwbpVKnMTCxU6lJQF1lDM6GG2ScQwaSTTRrRHirmTHaVEQx8OhPyI5U1uba76jg6
 DOtqnw5qR4Vdk5ezxZaiP5wJB1rePy8yCx9g3ruXYPgowNaN3Ep0Lihn6KPeeG8+88gz
 qpjKxEvUiUYZgQE9vknJ8eZpFeXx6bnCKzMF97BzJ04MeUfNqKVcgs+fN1frayn3SXIk
 7yYit2HALwFRSar/m2CQn+JtZ7nDvsOH8TnaaSEUKS1pYZBo4EB1YeWZLZpAAlkVcbY0
 sIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691151681; x=1691756481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b+2RejFsW7GG6XTrNt7Ulg3EG3QtR6PZwEeBRFn3KA8=;
 b=RvLmRuuAO0aYAhausQGTi36B3Kx+MNCW1OqR/OjjbhiTv0U4udIjNwDLUGl4/rnzUS
 JD09wkshEmYJkjka2J/9MIGOFPz0XPyXr12BPvAV/qH3kPHGO1sf2Zd1VxpIbKT8Tl9v
 nSSxozog/113mUxNPexgSkG7Pv/Zhg4F3vV5uExRTf6W9hmD3t2TXZXwPaxc8c7YWq/4
 D+QHGtFnVAztUx6RliTRFRjT3KrXz1/wJrdi5EWbO8ZKqgl7FjAYcwUa61YMvHZtQhO1
 cUeqNjtuJufqApC0+SYHts0pHrG7kpHjR+sSJjMHCszLHi6XU5nqjmrjIlyiZRjdrdAU
 wHkQ==
X-Gm-Message-State: AOJu0YwDAm+R4y1SfwYHJjNE3ICWqjnb0PoTNfA1QXtky3YR1oOzjRVY
 BqBaryKbe0SFw7+E/NBsVd1F5ah74+xxMBXsjInWMA==
X-Google-Smtp-Source: AGHT+IHoIGoj6QcXS//cQbmbsFESF6WvDe+rFuowy6xWErcvkAYl2CSso3hjXhTI7JcAp9YvqR0Fwvcm3zyzbdYRmxw=
X-Received: by 2002:a05:6402:282:b0:51e:1af0:3a90 with SMTP id
 l2-20020a056402028200b0051e1af03a90mr1367114edv.37.1691151681471; Fri, 04 Aug
 2023 05:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-8-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-8-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:21:10 +0100
Message-ID: <CAFEAcA9bj7U2LQFCPGDMB9p66ODhUH2SSnDKmSJ+y_i--7zgHw@mail.gmail.com>
Subject: Re: [PATCH 07/44] Implement BCM2838 GPIO functionality
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 26 Jul 2023 at 14:51, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c | 197 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 4 deletions(-)


>  static void bcm2838_gpio_reset(DeviceState *dev)
>  {
>      BCM2838GpioState *s = BCM2838_GPIO(dev);
>
> +    int i;
> +    for (i = 0; i < 6; i++) {
> +        gpfsel_set(s, i, 0);
> +    }

This is a rather inefficient way to do
   memset(s->fsel, 0, sizeof(s->fsel));


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

