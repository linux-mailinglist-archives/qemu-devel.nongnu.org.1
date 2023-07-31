Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63A7697ED
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTDt-0000yu-As; Mon, 31 Jul 2023 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTDj-0000lJ-CU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:46:00 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTDh-0001rh-SB
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:45:59 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so7282273e87.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690811155; x=1691415955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BDioFdyOKNBAC/5ktGE7rEx9840GVQkINa2od7dedX4=;
 b=ZISYPyoDOvfQhMsahedqmyHFlIFnV2eGD6/HXJ6wyLfMCVusXmpXzJag3p6UoA8yVw
 o3meNMHSTunai3oECBVwETP+FA3fXrtqFUSIonZp1dfVy4LZmQjTFlU/M7agjizQPzop
 yY+U0drxKCOsS+2C/kI+6o6lO3UjO9PRjg2D7yxCKa49A1ptbFin2el1VnojFgEfNnot
 ZVkp8aDqe04ame19KVgIcQRDeOk1Xz11PLRdywfnDnbgcffo7v/VROIloN22gyYezs67
 4P/W6MKjuTbMz2Yoty5FtGCMzfwGpTdbcR1RMpABeyozX6sFbkevAVt6BDyXG3rCXjQu
 Rjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690811155; x=1691415955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BDioFdyOKNBAC/5ktGE7rEx9840GVQkINa2od7dedX4=;
 b=cZlPUCP7NyhqNTEMbPfE4ezjGfGp1YxGWKrdM1lym6z6x0MO+e9sCR4G3qS2Lxk8UY
 qtc20CP8NXu/M92EYX3mW7DFk2DtgAvEQT93HAQHjEgO2jn3xU7lptcbZendtcBsA0fh
 pWQPyJ7t404uQwcXaTs3gSK/QnJtI54YrRgDcuQJADHYb3EDP0ApOXT1OpLsgLOcq5B1
 m5Aa+O0uUrpQVB+yUOUGdhvhsKQ2XaVoydvZA40BTlyFpZQpPTRW4pmknq/+/hdRwvZ6
 hS4MdW+FQ4kaYXxVDXfj8XqZoRPo7hjK9pzdsRPmQjxvD8vWQkilACL6g2Vpae9OTJT1
 56Jg==
X-Gm-Message-State: ABy/qLbm6SWGUfzDjUTVsZFQZetQqpKG1ZBDre8g/4qiWtPogXCHAyUo
 ElD7Q9qtgYfyVSDfCjS4Qz82a/4kuF8glXdjM6+ReQ==
X-Google-Smtp-Source: APBJJlHNEVVCp2Cx0DjZW2me4IB9ONCsOO8MNrOuHt7tGH2ugKxl5tnVxRrU3L1+Qhe1IC2lIRdqnZdaMUsL7Adz6q8=
X-Received: by 2002:a19:9116:0:b0:4f8:6625:f2ca with SMTP id
 t22-20020a199116000000b004f86625f2camr5106812lfd.61.1690811155000; Mon, 31
 Jul 2023 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-4-akihiko.odaki@daynix.com>
 <CAFEAcA_gdK_nSkiaJQ2mDPeb3Se39AYN+DkDg1U-D2CJ1vUOuQ@mail.gmail.com>
 <9f2a49dd-75ce-4e23-3873-0ad4fd78277b@daynix.com>
In-Reply-To: <9f2a49dd-75ce-4e23-3873-0ad4fd78277b@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 14:45:43 +0100
Message-ID: <CAFEAcA-Ljap52x8NB0h0PvNm1mmy85gA8zetqc8LXVuDV+PaVA@mail.gmail.com>
Subject: Re: [PATCH 3/5] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Mon, 31 Jul 2023 at 14:32, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2023/07/31 20:44, Peter Maydell wrote:
> > On Mon, 31 Jul 2023 at 09:04, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>
> >> MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
> >> concerning that the new mapping overwrites something else.
> >
> > MAP_FIXED_NOREPLACE only came in with Linux 4.17. So
> > I think we still need to handle the "mapped address
> > is not the one we asked for" error condition, because
> > it can happen on older host kernels that ignore the
> > MAP_FIXED_NOREPLACE flag.

> MAP_FIXED_NOREPLACE is substituted with MAP_FIXED before passing to the
> host with patch 1. The NOREPLACE constraint is still ensured by
> inspecting the guest page table.

Oh, I see, this patch is a call to target_mmap(), not host
mmap(). Sorry, I misread that.

thanks
-- PMM

