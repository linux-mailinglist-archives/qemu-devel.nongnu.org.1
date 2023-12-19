Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF8581864C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 12:26:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYDv-0000Dw-O7; Tue, 19 Dec 2023 06:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFYDr-0000CX-OR
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:25:16 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFYDl-0005Id-IW
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:25:13 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e23c620e8so4175821e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702985106; x=1703589906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5SaXnUXmMqvm0EDM8x1yH11gCRyWV5uAr8hLy1MvP4A=;
 b=cKWoKZKTpSOSKVxhRSn9uc3v903KjaRRf45wsizh0kF6lbClr1KxvWS2t9GCg94+9r
 V9ae1cDevAMcQpQCCUDcPSOI3SsvcNwcoRnGrYP/EEBBlah3l6mMQQgy/d+HRgmtZF3T
 fjFBZ9148c4eWoU5UNtkpb0s366G71sTF1J942Y/s0SqAvwdccYtZug0RXux+gTtdpxS
 ABR8VHed9uWthwVZfoqNrMFwiniMwrxUIkPBWlJeVHek+XHihIo0xJTMke2JS7BqV+3T
 5KIayA/5n61Ztzlu4PkpwfCETpSSDnmC7rmBpbmgEU6zbq+1gfFFTo9zp/083H0vNmka
 XUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702985106; x=1703589906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5SaXnUXmMqvm0EDM8x1yH11gCRyWV5uAr8hLy1MvP4A=;
 b=GYuJVA4NTWvgMnDyK3rUebVRooYg4Nk3ZfH9cG6tvdrKozb2gIiK90vggPVG3A0H7P
 NnowPwNcy9TuZMagEdbdKWvTvTVbmNveVZJOaD1wZyuobV+6ANGSKZ6SF0VRQ3ni0EbV
 7UX8f1ldSAA+bpLdqYTsVPtzQMFiIBNGy0OoicyQGueL9gvMONIeeUXvI32OJENM0aFC
 HWkrVZj7kxB6P2chDgiMIxLkbt+ChzYa+RZoAts8bA7NlGXN53zN96MDqjhxggy7FAaP
 45pydj+QES7KJZLoixU0IXzt/ksws6dZnFtwfJm/yDZ+wB3xE2h6KkAhfPtILIkmSbu9
 bMFg==
X-Gm-Message-State: AOJu0YzLjtaBsxJgPeBs4WU2FAz+HkFpL+qNNSX6xdhv0sVjAkjsD4Rz
 Ho2oMOagKvnM5Ydedi4Gz3h9Ugq3UjK4e4pYwFoZkQ==
X-Google-Smtp-Source: AGHT+IHwOXRUzIuYEGCfhaj34x2jg/GeFRrqT1dJ7w4B8muWlNh0l8OR2Blf2DRFrKVLau2sfgkDefRQtRqGiRJOwUg=
X-Received: by 2002:a05:6512:2386:b0:50b:e995:d9e6 with SMTP id
 c6-20020a056512238600b0050be995d9e6mr10571413lfv.93.1702985105799; Tue, 19
 Dec 2023 03:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20231218162301.14817-1-ncopa@alpinelinux.org>
 <dfb9bf4e-820a-4e7e-b62b-8df952099e7a@ventanamicro.com>
 <CAFEAcA_znj3yGXYB6OsTAwg5dT8kE154ZS=YRtye6dmy0TeKDQ@mail.gmail.com>
 <941c9369-3cee-459b-ac28-4b5f1aecbe82@ventanamicro.com>
In-Reply-To: <941c9369-3cee-459b-ac28-4b5f1aecbe82@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 11:24:53 +0000
Message-ID: <CAFEAcA_EgQ1a9DGgFXoJ0AW2=51ECOR9juTB+S3v=xa0sMXNGw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: do not use non-portable
 strerrorname_np()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Natanael Copa <ncopa@alpinelinux.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 qemu-trivial@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 18 Dec 2023 at 18:34, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> On 12/18/23 14:53, Peter Maydell wrote:
> > On Mon, 18 Dec 2023 at 17:22, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> > We don't seem to worry about that in any of the other
> > KVM code -- accel/kvm/ has lots of places that
> > use strerror() or error_setg_errno().
>
> I don't know how this is being used in other parts of accel/kvm, but in this particular
> instance we're handling the errors from get_one_reg.

Yep; compare accel/kvm/kvm-all.c:kvm_get_one_reg(), which does:

    r = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
    if (r) {
        trace_kvm_failed_reg_get(id, strerror(-r));
    }

-- PMM

