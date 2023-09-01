Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D978FC48
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2KP-0002SS-5D; Fri, 01 Sep 2023 07:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc2KM-0002RW-N3
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:28:38 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc2KK-0003LG-IX
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:28:38 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso2500260a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693567715; x=1694172515; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FO7H9E6SndJpylR506Q1WT68aVLxk1+SMgQ1AdsDVO4=;
 b=FlwVOjda2eZdX0eQiZPiTG/haig1U62ARBCFLGDfYiV+fbAyn0ij+bf+xzZTZM9TqB
 utTnF6j0Ai8HkV36O1TYvzwKWt1mI0IJh0SQNrAl3aLrJTlp2pYSAM20madIiYS4voQK
 HSGpwVgc8NI03g/alFRKQgKw/XmfUA7nV+Ul/lYCdh7xxmCDpE3MhlRdVJPBfWvSY4o/
 Cm/UaBYhXqZVgaPxX95Ci50ZULDhzAKvlY6LypZbqK0V+MvrWVdUeTr0b8JcxgnXhEoY
 v2rdHwDii7Xw0D/lFwCgqWTRBCVCbLuDRjJFtDPorFykrbVkCjmU6ZmvRFzSZindmluB
 kZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693567715; x=1694172515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FO7H9E6SndJpylR506Q1WT68aVLxk1+SMgQ1AdsDVO4=;
 b=VI0fYqI7ox7kGAOP7yYWHMVIs2m1To1/WX0iy5TPThuP5drvywyxncZ7k9Cg/yod6E
 K9+f6GHlcVGU1HS1U0fBHzOgHy07zdth1AbEwQbIc9SoBLIT8L3hnQH4Zu+UHhq4zjC7
 X+PY08X3zz+z/fmc6udiMSaUKFt9Beg8/d//cMWJ3L2v1CQmFC2my5jFe+LerALHIk2b
 RRMvaxps0OilYJxzbTv/SCkXA/KgusXFsyXXi9tT820gWdGjKWioa+DCRu9PkHDzhwre
 ref8beb/UFNccmp1/WLgm3/h0+sSsBOikShTMtLDCS9UqKwZihV8EhOk0W/Qu9ka4pIO
 r0ZA==
X-Gm-Message-State: AOJu0YxXdctseP7Mmk+bDgTvTus3nqqoLZAZEMhNbxqOalDPuBJFayoD
 HVrewQbehOEAi1J7Da5MqqMK0MHK/9M/X9wwaUivbw==
X-Google-Smtp-Source: AGHT+IGiAYkzNdjIe1J5S2BwEeFFNZLIiVsLHFn6at6XpXWXfQf5YmNpUR48CZDhnEIq65ATafuCuVbkWTrgRS8q7Mc=
X-Received: by 2002:a50:ef13:0:b0:523:102f:3cdd with SMTP id
 m19-20020a50ef13000000b00523102f3cddmr1931446eds.19.1693567714683; Fri, 01
 Sep 2023 04:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-6-philmd@linaro.org>
In-Reply-To: <20230831225607.30829-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Sep 2023 12:28:23 +0100
Message-ID: <CAFEAcA_mLqoOPWz_SSR6E0KBhnV6hvMPXbv2cbgYCqDS4dfO-g@mail.gmail.com>
Subject: Re: [PATCH 05/11] hw/arm/virt: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 31 Aug 2023 at 23:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   hw/arm/virt.c:821:22: error: declaration shadows a local variable [-Wer=
ror,-Wshadow]
>             qemu_irq irq =3D qdev_get_gpio_in(vms->gic,
>                      ^
>   hw/arm/virt.c:803:13: note: previous declaration is here
>         int irq;
>             ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

