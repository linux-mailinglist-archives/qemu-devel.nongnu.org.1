Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A26766C6E
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 14:02:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPM8E-0003hu-QY; Fri, 28 Jul 2023 07:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPM8C-0003hW-Et
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPM8A-0001mL-MN
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690545575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQoe252ie8jNfmmYlJDCVnlTCDBl2AUuA9WMnu9cfQA=;
 b=RpYQvYukVxfbFrdrPdThbksGpTTQCgQs+b9TLgaziNSedvL6vuGU6GKdTiXjdn/+P+spqj
 IKNTT+ocq3vjo+HU1QXpUG6vCHjgt8d1H3xaRM5PjE4nEJOuRJNGKO5xtLKjln9uPZqNgH
 JBpMQDHwkArCZWR/FFLJG36bHY1kQQI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-B8vgCUvCMNqE1MHoAGIuzA-1; Fri, 28 Jul 2023 07:59:33 -0400
X-MC-Unique: B8vgCUvCMNqE1MHoAGIuzA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-521f84b8c42so1501832a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 04:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690545572; x=1691150372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQoe252ie8jNfmmYlJDCVnlTCDBl2AUuA9WMnu9cfQA=;
 b=cDB0vgfDfPyh90FdqfPWFIXMjrZ/RaqfEKuWXBKHWJEn8tdA/44McCUy0U8doIgQYr
 qshympPrbfcdMhbLdokLcCD6C8aSjUD8wszHXNo3R8PBpM5g5I1jp1NthMBaq1Y/S6g/
 GluLl0y1R6Cna+eqtB3wNG8Arhru52o88eSpG71kXo+0nfho6vRmhtWsfOvp9yvVaPJa
 z3h/ojK/vliRHlkpRyiUk0Y5tzDSjExM2Q3u8QyrFixPO7mhNizJQAP6CJs3cemIVsd6
 2LnzLDy+sB6KVVdn+HPhG2ObNJTDbxd+xk4bbYN0+L6Z/E/DUFK7LqJ/hE0D5lZSlwsE
 cTcw==
X-Gm-Message-State: ABy/qLaTintW6p8CJZD16RiJBU+HlzStvx+8WbxFr39ZctNWcTBD6lWI
 4pWnPzP9y5Rhn8i30PPgeXCTUyItLTIkQXvLKAzbg9Mn9TiSmV1GKAR+EiB+9Z60kHDKdM7v83Q
 HwQX2aKtk23l4aCs=
X-Received: by 2002:aa7:d889:0:b0:522:2bc7:1c57 with SMTP id
 u9-20020aa7d889000000b005222bc71c57mr1626413edq.33.1690545572607; 
 Fri, 28 Jul 2023 04:59:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpJ3VoTVXAiZgLfXcngoGxFzhOW4mlvYgDnhDs0GHOGG4+nLpOhwCBQEeeoEkSnC1XZrSf0w==
X-Received: by 2002:aa7:d889:0:b0:522:2bc7:1c57 with SMTP id
 u9-20020aa7d889000000b005222bc71c57mr1626390edq.33.1690545572277; 
 Fri, 28 Jul 2023 04:59:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i14-20020a056402054e00b005219de74217sm1775201edx.43.2023.07.28.04.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 04:59:31 -0700 (PDT)
Date: Fri, 28 Jul 2023 13:59:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song
 Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 3/8] Introduced a new function to disconnect GPIO
 connections
Message-ID: <20230728135930.456842ad@imammedo.users.ipa.redhat.com>
In-Reply-To: <6f3c91ecab2d61c2cfb2d1a34a0f2120138e28ed.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <6f3c91ecab2d61c2cfb2d1a34a0f2120138e28ed.1689837093.git.lixianglai@loongson.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 20 Jul 2023 15:15:08 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> It introduces a new function to unwire the
> vcpu<->exioi interrupts for the vcpu hot-(un)plug cases.

it's not a new function.
You probably wanted to say:

subj: make foo() public

it will be reused .someplace. for ...

>=20
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
>=20
> diff --git a/hw/core/gpio.c b/hw/core/gpio.c
> index 80d07a6ec9..4fc6409545 100644
> --- a/hw/core/gpio.c
> +++ b/hw/core/gpio.c
> @@ -143,8 +143,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev=
, const char *name, int n)
> =20
>  /* disconnect a GPIO output, returning the disconnected input (if any) */
> =20
> -static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> -                                               const char *name, int n)
> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> +                                        const char *name, int n)
>  {
>      char *propname =3D g_strdup_printf("%s[%d]",
>                                       name ? name : "unnamed-gpio-out", n=
);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 884c726a87..992f5419fa 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -739,6 +739,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev=
, const char *name, int n);
>   */
>  qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
>                                   const char *name, int n);
> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> +                                               const char *name, int n);

watch for proper alignment=20

have you tried to run ./scripts/checkpatch.pl on you series?
(it should catch such cases)

> =20
>  BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
> =20


