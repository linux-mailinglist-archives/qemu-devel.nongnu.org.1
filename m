Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6D7CAA7A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsO0Q-0007da-DM; Mon, 16 Oct 2023 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsO0N-0007bt-SG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:51:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsO0L-0005QJ-AB
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:51:35 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so711634766b.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697464288; x=1698069088; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVpxvUcwpRvAxrR21URLQFCpbPsuvRm2tKb/nD6hj98=;
 b=uP0j7v3+iQY0cM322bT9d0hkdM9yksamcGsdCTdSkmTGwx8RxcAPjDia3JgsH5nqtQ
 SUJfiG3js2mufNaxQ71FggF4yvavs29AoLcLJrYsW1Polepe24FdcLiP5VQDO8ED6Trw
 tPbC6Pl1QG7GtuCh2Y+LBaAR+F/TObXu+d2QIobj58NqvN83Wwt461O5alOqcFoOOL7x
 NpArVdOOXYHtxknjqdW0D3HbF0IrRbddCsZs96MWONKwYD7Y+7VrYv8n7O2bkRTtrw6M
 ONSw7VHe2M2DFfRcRQiQRL8TXGp/LsyM6iAU7gPVMRQkVL8WDVQnSdhu8V3IDRCFGOA7
 /vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697464288; x=1698069088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVpxvUcwpRvAxrR21URLQFCpbPsuvRm2tKb/nD6hj98=;
 b=QaVpWp4N/kPfFjbjbwhZvC2XYftfLpzNCbovQzv87WbHLFId2eLk7ypc9kbRhog+Cs
 i8Pk4lu9S9B3YWapMUelYmLCVNLUWukL3gARiMdjKsT4Jrfgi1jdupPTB1+IZtJ0THSl
 zDtLUlRntB53c0xvbSIa5aqsF7dje7MpIwihKQ7S2bG2fUrrFKu980AFC1YL+kcUPLYX
 VGI02jcKct61hhNaP/9WhGcllxkHAFnQFFD/kxqhnceEoFK2VE1Gobd2UA+mrrY4VsQ4
 5pBjMq2CujCMCrAT1uF5oRYrGzEoAgGiw7g1+k94jzTbd4UviRBF5/X6hlQTWy8OzoQs
 Bcwg==
X-Gm-Message-State: AOJu0YyHwkfusXPZ/yfpiPp6X7N3k309jRC7CZtZNKkEnvgRCzGce6eT
 M0IAjPFvTvDMGaaHoSV211G4y9tP8Ra91WphN5pawZyAaTvJj0yu
X-Google-Smtp-Source: AGHT+IF6fUk7iWmoS7B0eEp74NrWlmHc4c6VrDPQ1e5LRf+DaFXYe6co0+n4XnSOeU2hEzftTAJQ4mK+qVC1JLPtvLI=
X-Received: by 2002:a17:907:c24:b0:9be:40ba:5f1 with SMTP id
 ga36-20020a1709070c2400b009be40ba05f1mr8059138ejc.60.1697464288212; Mon, 16
 Oct 2023 06:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <GV1P191MB21946E51ECBE3A5CADE0B208F0CCA@GV1P191MB2194.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P191MB21946E51ECBE3A5CADE0B208F0CCA@GV1P191MB2194.EURP191.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 14:51:16 +0100
Message-ID: <CAFEAcA8yNkE5PMrBr9u-LzwfRhcxe86HRHDud5CRbzLm-RJfcw@mail.gmail.com>
Subject: Re: Running cross-compiled binary using QEMU results in segmentation
 fault error
To: Asad Javed <asad.javed@basemark.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Wed, 11 Oct 2023 at 14:34, Asad Javed <asad.javed@basemark.com> wrote:
> We have cross compiled a simple hello world program for QNX SDP 7.1.0
> on Ubuntu Focal x86_64. Running the binary using qemu-aarch64 results
> in segmentation fault error. The qemu-aarch64 version is 5.2.0.

This is expected. qemu-aarch64 is for running *Linux* userspace
binaries. Trying to run some other kind of binary will not work;
depending on the binary that might include the guest binary
crashing with a segfault, as here.

To run a QNX binary you would need to run the entire QNX OS
as a guest OS under system emulation of some machine type
that both QEMU and QNX support.

thanks
-- PMM

