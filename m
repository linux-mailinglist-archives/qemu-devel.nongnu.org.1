Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D0723F9C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6U0Y-0005ZH-8v; Tue, 06 Jun 2023 06:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6U0V-0005Yg-2Z
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:33:43 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6U0T-0004Fc-ER
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:33:42 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51491b87565so8980081a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686047619; x=1688639619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UtMNCttpfqoi5t87Efr7w5vHGCoYi/seg68FhgTgFd8=;
 b=ZfSKsSmoCBXuVRm3lGAZBosLMnLEtO2cw6QIoT8uqzt2Z+He4SMS15KBTH/xFwX90D
 IvhaEt/yuSKz1+HurQds1lD8CKKJvCu8FeKgQjuxlmvi/QDyYwlan0vsUDvIHlJdMr7g
 96x3DZi6ace3z9EMRZtFZqO8khe3v0AGMFD1uzQHe7xX4EZzqsYAOwjyymK0f3hbczG9
 KRY4lSFbne9HMZhpXAQaOpb6x/szDtlMwVfQuog9lPqrh5r2Ibch8EQDNKjOmXaddiZc
 kRJ5bFbudR4TQ1vhV5qwFvLUd4PMw+spdj/+bLMy9FT3wLGrTLQFiF+KNQ3p+WfEy0Ja
 ZTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686047619; x=1688639619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtMNCttpfqoi5t87Efr7w5vHGCoYi/seg68FhgTgFd8=;
 b=NCdC2QJkPU/Y1ecrYZW4I9I05GRE+VkT+zHBB9UA2visOavU6kgTBoLWOiAUxqcPXP
 SdEWsb5+W6YYIbFwNwePV9r3o48YTJ+5TRV9q/fwM2YhTNAHsFSShp6EUVwDpfpipUMp
 rNvi1dlDIdQpTzbVo51ELpfM5v5VvSSZOi+6V+NvBmeqLspmQlLXCQOfxVsK6I+9d9HM
 16gpq/QhMc8Ia4Lp2xnaDNht0pwC/yTR5OZxr2CifavKuwfG1emLGKtHKfExy+EMu81J
 DVXEZwxNENfCJ6jZgU9vDJn40lTaDZzoTrhKSaVNnFCsDcxILCbhlAaalFpmN1F9vshs
 2ikg==
X-Gm-Message-State: AC+VfDymnfB3BajC4Rt6axHSKwZi2J45L2oqlkCvxz8kyxjzrXQxMb0Y
 OacNmKpTic1Hd7oYLaY5gGWBOstiAvR693KJYHYWuED1LEAHXg23
X-Google-Smtp-Source: ACHHUZ5jdlWRZgk3SWI11fMTxAwLT6vhX5TQdox5q/TZoWsgriMds/xVdr/0u0jjTsXZJ2aNbprKW8XQY0UKpkKn3N0=
X-Received: by 2002:a05:6402:70d:b0:514:9239:49f2 with SMTP id
 w13-20020a056402070d00b00514923949f2mr1543280edx.37.1686047619444; Tue, 06
 Jun 2023 03:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230502121459.2422303-1-peter.maydell@linaro.org>
 <20230502121459.2422303-32-peter.maydell@linaro.org>
 <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
 <a77c864f-f571-b0a8-3c7f-dadbbf8c8185@tls.msk.ru>
 <4377a8d5-54d1-e0b3-e87a-0c04ec3b1360@roeck-us.net>
 <CAFEAcA_L8XCdRLGU_xeMC3JGzK_4h0LDWXz0VFLMgdkWigc1VQ@mail.gmail.com>
 <0196226c-39a9-8bab-1543-34d5412f926e@roeck-us.net>
In-Reply-To: <0196226c-39a9-8bab-1543-34d5412f926e@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 11:33:28 +0100
Message-ID: <CAFEAcA9ZO5whHnQL0uAU2LNDJBLtD7UCxwG_VmHWVLLHceQdMw@mail.gmail.com>
Subject: Re: [PULL 31/35] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 5 Jun 2023 at 14:35, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/5/23 02:40, Peter Maydell wrote:
> > If you can provide a link to the zImage and the dtb to reproduce
> > as well, that would be helpful.
>
>
> Please see http://server.roeck-us.net/qemu/arm-v7/.

Thanks. I've identified the cause of the regression; will send
a patch shortly.

-- PMM

