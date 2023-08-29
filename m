Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BA78C6EE
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:09:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazP8-0003tQ-Tz; Tue, 29 Aug 2023 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qazOk-0003sL-Nz
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:08:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qazOh-0006OP-5r
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:08:50 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso5705077a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693318125; x=1693922925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPKJXzcH+N2qfZUCo88vGLiMpG2dypyl4l+05+TWiXY=;
 b=rEIzw3lJzY0ZMCg023DEucM5996RPKrmljRSqcpOVRks/+R87gM/QYFiLtkT7SIAPy
 7gVNLN+ok3CueU09WokbJc0VDQn0KQ50ZWvpMYf7LLlZNUfFK5F40JWkefcyLJbYvWYB
 QSgwLeGnx0aYABiD4pvxF17x4pQbGRUaWKXG6QR7zNoedbqVT5bmJF0VGxewM17+wylx
 hsa4rF7H4LDj5WPWUpgxK3bUWNvcrRc6las3z3GQlbGopOowilTyXwz3rDIB+TX1zDSJ
 5sr2M8v0g0w8HKeO4dixCqVcLXyXKO0vwm5evWtGN6fOEA2jAyIc/3YwiqlycN7LxyVK
 1hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318125; x=1693922925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPKJXzcH+N2qfZUCo88vGLiMpG2dypyl4l+05+TWiXY=;
 b=Fs3PeykpFLe7D5n20juceYcSnf7z4St8+IZ0o6y+A0v7zA6x0WUEJkni7oV2ehMMgc
 itNr2PHv9xuqewasw7NRxSmiieJuW5L88gXA78H75gSEpQrFdVCIxVP0Eags+q4VP3Dt
 MVHHu8VObVdlrr1fK7Ot8Qw+Zr86ygyLToirFgtuHQe+xXiS21qx0FTDgY/fC1lsyPWD
 cMTAXWJMw1v+DogiNRV29Bw+kCwAo1oH4XBQj/i2S62/ErJAzYu9ZJ2VbN47pXlchM8R
 ty2owH1maCLKnLlqMIajJNDhc3NP5CtZohSAbZh6q+fXYEptd96ZINPF7+M3Ar3lZ91c
 0Vfw==
X-Gm-Message-State: AOJu0YxKvxs0ECLTgElNSjUVEg7dAAo6rKdpTWzErxemgq6mDga2HJnQ
 0PNwGMlC1080ebgOgX1bGrgH9OQkT3x0r62GucxtfQ==
X-Google-Smtp-Source: AGHT+IHi9a//mBv0QHsyrXq+gT0e7yo9vH04sh/zr1bZu6ptpCi/tpLG3oQDRsHbU35gR0+tGUpLyskKNc52H4AvreA=
X-Received: by 2002:a05:6402:202a:b0:52a:47af:97a4 with SMTP id
 ay10-20020a056402202a00b0052a47af97a4mr12290529edb.5.1693318125385; Tue, 29
 Aug 2023 07:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692964891.git.jcd@tribudubois.net>
In-Reply-To: <cover.1692964891.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 15:08:34 +0100
Message-ID: <CAFEAcA8_rL8pGbr_imDL2vX=UkphL9d1PXbWZN5Xmor9+Xtthg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Complete i.MX6UL and i.MX7 processor for bare
 metal application.
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 25 Aug 2023 at 13:21, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> This patch adds a few unimplemented TZ devices (TZASC and CSU) to
> i.MX6UL and i.MX7 processors to avoid bare metal application to
> experiment "bus error" when acccessing these devices.
>
> It also adds some internal memory segments (OCRAM) to the i.MX7 to
> allow bare metal application to use them.
>
> Last, it adds the SRC device to the i.MX7 processor to allow bare
> metal application to start the secondary Cortex-A7 core.
>
> Note: When running Linux inside Qemu, the secondary core is started
> by calling PSCI API and Qemu is emulating PSCI without needing access
> to the SRC device. This is why Linux is using the 2 cores in Qemu
> even if the SRC is not implemented. This is not the case when running
> bare metal application (like u-boot itself) that do not rely on the
> PSCI service being available.



Applied to target-arm.next, thanks.

-- PMM

