Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E7D7E6C94
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:45:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16Go-0000XC-Vw; Thu, 09 Nov 2023 09:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16Gn-0000UR-1j
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:44:33 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16Gl-0000YX-CE
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:44:32 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so1582565a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699541068; x=1700145868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VovdA1XYVOBSHnYUjjsDosCFdi0dbItblIgDu0vjIxk=;
 b=M9aVvtGWxWePHq3uLWHfIeEb+VDglALvUYbp6fDEqd46uY+5fDw6CXIfAcq8sKZVVb
 mKJLx5HcdV+pSFsfy4CMez4PYSI7ye7A4vRh8Vdth1rS5fnMtFvfNyeqfgFplw01lHc1
 t5BGHnyazkd7gPb9od00ZYmhc8bErTfgmZXU9mu4LU40MC7e5NhXJnpLItb1iOGLa6kz
 Y3IkajiTFOPjzUk8d0JYbjFWcGb8hc9100YaiBlF1KGAOIBGwh7bwZ3DvbxZNyEvCVf1
 zcD9G8l9m8BerwdtiubKS+RDYvg2d0E0QESoYFnrAY7CZT9MXCTz5IpeQkAbj441rf+4
 A8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699541068; x=1700145868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VovdA1XYVOBSHnYUjjsDosCFdi0dbItblIgDu0vjIxk=;
 b=JaqMB/CeBKInS0//6rgvhTKV7Vo5uPP964c/egiuvh8AkzpRqrGnpJPDXDmRnBrxUT
 Ymvkk3AadsBk1RtshUnJ5qWrFHrVzYkYJf6DHzHg4/4L7fRVgYMuQbBhonQTBJ1p2EsI
 G+j+xee4dS5TNaV0l6H1va91uiCPptK4rWYU3rgA8oGwPJe/5I/kEmjJNaaPggVv/dfd
 Pg0KIl0M0cEMhXFoiTjRuAmWC0ywd4OT5GD93mcbXfP7U2RNR2lju41uWMhszdomsT9S
 LKi6T3kN3YSMDfS2c4RDhcumnWKQEWKcSHJGPgROHcR0pbhvQEZ6DhXpBu/SQgWJM0y+
 A2IQ==
X-Gm-Message-State: AOJu0Ywwx7aRWHwTB+60a7nC4+heu5mWaUTc4P1B5vcxAYDQ/HttAHr8
 kOiIHmQAuyIPIDAhFh4tMTPvCdWXY9d3JkSvTyKSBw==
X-Google-Smtp-Source: AGHT+IHdk39ojq58pZ0cUkr4kVBLv8ugRxrTw2vRrwEqvEpRWlpWUBJd/1eCHBmYr7iWwNyxfGb7uD0nW/FbAMTyvQM=
X-Received: by 2002:a05:6402:404:b0:545:4bf3:ac89 with SMTP id
 q4-20020a056402040400b005454bf3ac89mr2132850edv.23.1699541068266; Thu, 09 Nov
 2023 06:44:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699351720.git.mst@redhat.com>
 <221d2cfbdb5301f8f0cfbf26baf76544a5d71c27.1699351720.git.mst@redhat.com>
In-Reply-To: <221d2cfbdb5301f8f0cfbf26baf76544a5d71c27.1699351720.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 14:44:17 +0000
Message-ID: <CAFEAcA-4UhUkokA8mbtk0D4NnJ7kShO9M60nOahLS1f=vFY=Kw@mail.gmail.com>
Subject: Re: [PULL 55/63] hw/cxl/mbox: Add support for background operations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 7 Nov 2023 at 10:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Davidlohr Bueso <dave@stgolabs.net>
>
> Support background commands in the mailbox, and update
> cmd_infostat_bg_op_sts() accordingly. This patch does not implement mbox
> interrupts upon completion, so the kernel driver must rely on polling to
> know when the operation is done.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Message-Id: <20231023160806.13206-12-Jonathan.Cameron@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; Coverity points out dead code in this function (CID 1523907):

> +static void bg_timercb(void *opaque)
> +{
> +    CXLCCI *cci = opaque;
> +    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
> +    uint64_t bg_status_reg = 0;
> +    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
> +
> +    assert(cci->bg.runtime > 0);
> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> +                               OP, cci->bg.opcode);
> +
> +    if (now >= total_time) { /* we are done */
> +        uint64_t status_reg;
> +        uint16_t ret = CXL_MBOX_SUCCESS;

Here we set 'ret' to CXL_MBOX_SUCCESS...

> +
> +        cci->bg.complete_pct = 100;
> +        /* Clear bg */
> +        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
> +
> +        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> +                                   RET_CODE, ret);

...and nothing here changes 'ret'...

> +
> +        /* TODO add ad-hoc cmd succesful completion handling */
> +
> +        qemu_log("Background command %04xh finished: %s\n",
> +                 cci->bg.opcode,
> +                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");

...but here we check whether ret is CXL_MBOX_SUCCESS or not:
the "aborted" half of this condition is dead code.

A later commit adds an "if (ret == CXL_MBOX_SUCCESS) {" block
where the TODO currently is, and that is an unnecessary check,
because ret cannot be anything else at that point.

> +    } else {
> +        /* estimate only */
> +        cci->bg.complete_pct = 100 * now / total_time;
> +        timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> +    }

What was the intention here ?

thanks
-- PMM

