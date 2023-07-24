Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FA75F36B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNssx-0002Qg-7r; Mon, 24 Jul 2023 06:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNssu-0002Q9-B8
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:33:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNsss-0005Ob-GZ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:33:48 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso5970324a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690194824; x=1690799624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AGwqb9B+J25M780CzEB+Hzhg7XfYrwU/NcI6FIP/Z1Q=;
 b=bt+IZjmFCgYKQyS66d7DtfwFMp5y62G1ZsOAWW3X3itVzRE9Ly4Rp8z03VDB4QCcIq
 pLFqzJ3k7TUcihVPgsd2Or7tRrkm/Uzku6+KGPyDe6y3qQ87br0jlIu1Rk2BCFYzTFIv
 7WDgrtbrogg6MiQVoWTBeSwWj3IowraxLr4V2ljj/EBBfGsckDPwvkcWiTjtsEzrgn59
 V5u8wOL5efDS9I6/KM/QkmkK4o6Xh5+eZM+KNXZHuSI3/Ndk5Z+Pe20+6A+YIKqWKfRC
 jmlIXsXXKWmutCf93iCrKlt7X4nyMGeHCXLlnjm9yLTt6r6+gG5z1vgdr8gopp5oNLh2
 +ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690194824; x=1690799624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGwqb9B+J25M780CzEB+Hzhg7XfYrwU/NcI6FIP/Z1Q=;
 b=Hk8WxBCnWzmSU2NTr5am1B3z2RTWUtDeI/Bv2M9FIkcXFgDE98/OEV0/4SMypjTnEX
 RsefOHzJI6Hn2Mj37GWfrnD7Wym7wZIr8d2myWffe1pskIVvfRQRq8RZUgS6vfTkE0Ti
 g94tkK6N3USjy4Y0mHjwpOYGUmLQYyg/s2+OGA71kxdjaEzW4F6GtF+4yw+ye6pA1n3k
 ACUqKMP/KawHfBM+mrkQgsY3kVXNftUNhdPqs1SxkJqkz2SnPC5MSmiaSL/pZMrtrxJx
 f7IudMaIn7LNopRxhkdR42LUyZQSBfashdIbBE78H26ryX8DG77mbjwvPyrrD2QjNJZr
 LxnA==
X-Gm-Message-State: ABy/qLawTfVh/zw5RXHs0IAFpiGEZN1Ravh4Wm1b/ylpboFVo7rvTHHK
 QUs26cVoXdH9bqHT8h3e4+Z6aBL9lHvhLMEmfRg8fA==
X-Google-Smtp-Source: APBJJlF3NogZ0cU1KSQodv1VuBOcV0TVEebVrDh0hN1F/MpgPKTKZ5BN2t/m0rrxV2yoSg3HchSC8Gfn3dAhzFtJ0nQ=
X-Received: by 2002:a05:6402:31f6:b0:522:3849:48db with SMTP id
 dy22-20020a05640231f600b00522384948dbmr870774edb.3.1690194824651; Mon, 24 Jul
 2023 03:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2307211804380.3118466@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2307211804380.3118466@ubuntu-linux-20-04-desktop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 11:33:33 +0100
Message-ID: <CAFEAcA-FREYpYiX4qbvzkUjnkyCuD_oTkBJ5Yw7heNB7tf4ZsA@mail.gmail.com>
Subject: Re: [PULL 0/2] xen-virtio-1-tag
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 22 Jul 2023 at 02:10, Stefano Stabellini <sstabellini@kernel.org> wrote:
>
> The following changes since commit d1181d29370a4318a9f11ea92065bea6bb159f83:
>
>   Merge tag 'pull-nbd-2023-07-19' of https://repo.or.cz/qemu/ericb into staging (2023-07-20 09:54:07 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/sstabellini/qemu.git xen-virtio-1-tag
>
> for you to fetch changes up to 6bb48c66946dfbd653f06ad5f3fc957972333b56:
>
>   xen_arm: Initialize RAM and add hi/low memory regions (2023-07-21 18:00:29 -0700)
>
> ----------------------------------------------------------------
> Oleksandr Tyshchenko (2):
>       xen_arm: Create virtio-mmio devices during initialization
>       xen_arm: Initialize RAM and add hi/low memory regions
>
>  hw/arm/xen_arm.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

Fails to build, multiple targets:

https://gitlab.com/qemu-project/qemu/-/jobs/4726472678
https://gitlab.com/qemu-project/qemu/-/jobs/4726472642
etc

../hw/arm/xen_arm.c: In function 'xen_set_irq':
../hw/arm/xen_arm.c:78:5: error: implicit declaration of function
'xendevicemodel_set_irq_level'; did you mean
'xendevicemodel_set_isa_irq_level'?
[-Werror=implicit-function-declaration]

../hw/arm/xen_arm.c:78:5: error: nested extern declaration of
'xendevicemodel_set_irq_level' [-Werror=nested-externs]
../hw/arm/xen_arm.c: In function 'xen_create_virtio_mmio_devices':
../hw/arm/xen_arm.c:74:5: error: 'GUEST_VIRTIO_MMIO_SPI_LAST'
undeclared (first use in this function)
74 | (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
| ^~~~~~~~~~~~~~~~~~~~~~~~~~

and others.

thanks
-- PMM

