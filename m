Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A483E70DE02
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:53:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SQR-0004fR-3V; Tue, 23 May 2023 09:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1SQK-0004Mg-Vx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:51:37 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1SQE-0002GQ-TZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:51:36 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-510d1972d5aso1459844a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849889; x=1687441889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfscCTbdmN2yfoE2s7O+uig1XfvqHdnwKPHBDoX4nZs=;
 b=z8TU5XPn/tB0G7xiqmt9iuWv4rvZ89q6e2NHEpTdDQSzK/Ku3xtpM5eTgB84pJTkyg
 33m+mTGvsIys6sYd8ruK2XIQTeXvq00+lwc8D+8hbWv0WD2A1JwUrFDhhV3GV2KFPKig
 KY9DivDZ25ubpynrbBQ/WqUKID2RE18ws1strLYLoJVnfOyfqomQx05apl0qgF4Lvm0D
 1PcMuIsNl/5qzekoP1jJPp2eubzeLTcOEpK+ojo4Hj3uD3l/NqEyD+WUfgWBTvmTXIxS
 k/1r9XCoss+tWGl/9lJ9M42hRwZ3j3/kF1WVuFEMgVu9ZCtmc5V98ufmRjlYFwt0AslY
 CP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849889; x=1687441889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BfscCTbdmN2yfoE2s7O+uig1XfvqHdnwKPHBDoX4nZs=;
 b=CWOoyZCUNe8F3usOZ7FWS6XDDesvzy2ivSRqc+0925HGrw1dLywPvV81zgOlqncElT
 tWcU/DlqxUlLwmPIkelhi88OjoeZWSmvMQdc3c0STjh/yQaVpYQPdkY0xoBNGaRux0PL
 pthI6RmYg9DvJUYPCbjG1fDpJ3SnsiafxydPyLTGalB3exQkhsA/7loDaGFjnjo+OFkL
 LskS6npt05ytxOi58tk/KC22BYlBsYIT/A6zGmo5I9aedpD5EmiK3slHn26LBLBxwK9y
 DER6I8yvudNM51X7oa12MgZQtljik2Var/3PJckzab+MPK24fjX1mCQopyFvndC9b56Y
 apPA==
X-Gm-Message-State: AC+VfDxo5ep6FGAUdpEYt1+GvSaGs5cZFISXFAX8YazuFmpgXpzF7RmF
 oHh9OLlYqCeSsDvQvRPwG9L1NX3Bz5AdLPxVSuBOlUe5pZgI9RDS
X-Google-Smtp-Source: ACHHUZ79HGtM4/zTvioBuSL1BxduJFKKkHFs657R5vgczKdWa7ypiIwoGLXBa3Cvk2rIuv6AtgMY56h/e+Vfch087S0=
X-Received: by 2002:aa7:c90d:0:b0:510:da8d:2cf1 with SMTP id
 b13-20020aa7c90d000000b00510da8d2cf1mr9940963edt.18.1684849889462; Tue, 23
 May 2023 06:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230519062137.1251741-1-tommy.wu@sifive.com>
In-Reply-To: <20230519062137.1251741-1-tommy.wu@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 May 2023 14:51:18 +0100
Message-ID: <CAFEAcA_4dW6eakYv9O2hxd-pSF_BOkEd7GjCjV6UZwhdESLOxg@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent
 infinite loop.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 19 May 2023 at 07:21, Tommy Wu <tommy.wu@sifive.com> wrote:
>
> When we receive a packet from the xilinx_axienet and then try to s2mem
> through the xilinx_axidma, if the descriptor ring buffer is full in the
> xilinx axidma driver, we=E2=80=99ll assert the DMASR.HALTED in the
> function : stream_process_s2mem and return 0. In the end, we=E2=80=99ll b=
e stuck in
> an infinite loop in axienet_eth_rx_notify.
>
> This patch checks the DMASR.HALTED state when we try to push data
> from xilinx axi-enet to xilinx axi-dma. When the DMASR.HALTED is asserted=
,
> we will not keep pushing the data and then prevent the infinte loop.
>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>



Applied to target-arm.next, thanks.

-- PMM

