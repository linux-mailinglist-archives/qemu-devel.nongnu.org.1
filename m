Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58685766DDB
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMlA-0000wZ-F4; Fri, 28 Jul 2023 08:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPMkW-0000qM-SA
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:39:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPMkP-0007ED-F8
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:39:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso2665607a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690547935; x=1691152735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kYkF3fs/8OSj9tOCqUjHX5qqa+EgTWeQIdGoJocM1U=;
 b=gid9TxYGZfpylaRb395lNn6FhvYBHhUOp8cTQeGd+qvrqVnjGHXN+EOh9R6ei5mmHa
 nOE0qR9GNT/w8OhF2rYves6mV3VPX6oTK5hdCldgQeUaqJE+qX9jx3EBGQNdbWDZl2aa
 rnJIkmYn8fB6+DQQ9xo9xFPQXKBAzc/yimCxBZjwDA8CRnCLqPJ2aTkIfjN8legUe+T1
 W84CSlpeVIDMzh6oUkrSyq97jlAVonYoMDRa/Hk9vikBILRVNo3mvBtfm0fR+lsoCWMa
 9YgcehAbPP6rnc4TCsh+MJSsBDwtTrWmLrlziwQphB0Ty0erj6jWiPjT0OygFJLM9qy7
 mHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690547935; x=1691152735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kYkF3fs/8OSj9tOCqUjHX5qqa+EgTWeQIdGoJocM1U=;
 b=gZ5+Bpg+x3Q23MR2GtSgmRhQS9okG3GwWgHGamkbaGtXwCaeHPYv3hZiZk+lGj9gI0
 0AVixbJNoCI0lOflsDreFXArt7nfujRhqe7v5ScRlD/2c6/beQb0Pay4kqFYNIAK3ris
 zrcAHB1p+8qZM7dtqj1uSr+DNt7m8VTeKkeTjufsf0e0xJd0d65rC7T80EUWyPf+P7jt
 TGkwDSBVrjAbUEVuzKrRPQFggpqQGzIjTPMrCwh+eWm7JT5qLdUu2o/ANvYBtizMz8W2
 aYdxRmMRexDsB1PK9X1h03+y//CDfTB4go/hCTFyuZx7XnV2ahqjF8XLGsf+qvTnS/kP
 HlhQ==
X-Gm-Message-State: ABy/qLa/f8ZhsNPy4qAFmZCIpAnBGuRmb9croAQ2PwylAU1xJ68WUVbT
 uAb2AAMIvSLo+/t1K7yCOLJVwxJpMgVlWHqJ9JzkxQ==
X-Google-Smtp-Source: APBJJlHSSa1nIUOxWi0d5FTRx47lRiwaqdp+qSc3+AUbwhXvBDOE4yRGPjCb1c/aihMN2Jrz6WuD/9OYgN1EoHFAxgw=
X-Received: by 2002:aa7:d712:0:b0:522:946b:4e46 with SMTP id
 t18-20020aa7d712000000b00522946b4e46mr1623201edq.24.1690547935011; Fri, 28
 Jul 2023 05:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <6f3c91ecab2d61c2cfb2d1a34a0f2120138e28ed.1689837093.git.lixianglai@loongson.cn>
In-Reply-To: <6f3c91ecab2d61c2cfb2d1a34a0f2120138e28ed.1689837093.git.lixianglai@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 13:38:44 +0100
Message-ID: <CAFEAcA9_yJki9Ntp-diviYHfxts-eJawcFiV1tYvpB2V0e7Mqw@mail.gmail.com>
Subject: Re: [PATCH 3/8] Introduced a new function to disconnect GPIO
 connections
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 20 Jul 2023 at 08:16, xianglai li <lixianglai@loongson.cn> wrote:
>
> It introduces a new function to unwire the
> vcpu<->exioi interrupts for the vcpu hot-(un)plug cases.
>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  hw/core/gpio.c         | 4 ++--
>  include/hw/qdev-core.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/gpio.c b/hw/core/gpio.c
> index 80d07a6ec9..4fc6409545 100644
> --- a/hw/core/gpio.c
> +++ b/hw/core/gpio.c
> @@ -143,8 +143,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev=
, const char *name, int n)
>
>  /* disconnect a GPIO output, returning the disconnected input (if any) *=
/
>
> -static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> -                                               const char *name, int n)
> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> +                                        const char *name, int n)
>  {
>      char *propname =3D g_strdup_printf("%s[%d]",
>                                       name ? name : "unnamed-gpio-out", n=
);

This function as currently written is intended only for
use in qdev_intercept_gpio_out(), which in turn is there
only for qtest test case use. I would be a bit cautious
about whether there are unexpected issues with trying
to use it in "production" functionality with a running
QEMU (eg when perhaps some device might be trying to
signal the gpio line in another thread while this one
is trying to disconnect it).

thanks
-- PMM

