Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC080CC36
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:58:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgnH-00017Y-1V; Mon, 11 Dec 2023 08:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCgnF-00016F-0d
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:57:57 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCgnD-0006JD-EF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:57:56 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bf7bc38c0so5046698e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702303073; x=1702907873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GRqEWOlVm/72W1Afzs3U276v00YvT14/dS4HQ+3Bzt0=;
 b=WxYFVKxlNy5sd/I3FPCesjaV4mdD6eiBdepZiikc+aNEecKRjVpvn5PXjmBgNfCvmR
 i3528xD0ziIpvVm1J/NG1HWbozfclWovQ2F3YL0XKwh2e1RoXqDWf4BRZN3kSoE3qcZI
 ZBLRL3ivANI1foWvFzYSLfxsVb2t8QVZDabujzGBa6+7DrjuBtxZT3tThqBg1Y5LI2eR
 VYIKn3ZDeV6vShrG1ss4BvczCoY0EY8L5Kq+mktkWDOG0o1w3nQ2LyOSAuS+ntyHDJKj
 Q1jfAnGRplW5kt74beVrkONHwUWDTPGNZ4B5mnOSyenRhTu5Hssh4uIauZnDXQPjz6Tg
 8yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702303073; x=1702907873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRqEWOlVm/72W1Afzs3U276v00YvT14/dS4HQ+3Bzt0=;
 b=Z+spnlHAuYx79Dr+jS6sPPGFm3EXev3/SfN4cRJs40bOI6JNmOwm17Dv8qALFo41bZ
 tyPXe7C/FmkAap94SPaeC6nwoLNn3EbmMtX+6V2lyNU2ZR8tOnLUkyDQiq8O6DN7LNo8
 CIkx4SNNQlf8bbV+XOfMd/GD1xfXRpkDZw2NRhp4DFIKXJriN1zUWmR7DvQ3eFTGVS7z
 n3HPAluN6GN0IeRPBAj7MJSl2/rRYPjezaMoAaEMQACADV7FsE2eyKXx3gMEq95oJQQs
 e65XwJ74ASN8M2fYMmUYITOa+FgH7OVb7Sqd3VpaD6ZsGLVjoA6huJzVNyLlezkwsmdI
 Uvtw==
X-Gm-Message-State: AOJu0Yx6qOoUc/+w7X9z0PVbnDiBaqGeqSs3/idVHmQ75fSYqLH1wsYI
 6JEmItLKOd3t9FXbnhG+gWHFUufFzbSt188QHQVgtORDb15DY4fz
X-Google-Smtp-Source: AGHT+IEj1WiHjFrBNLGDr1kKpSBZXv5swHV6OE+CWsdQrQXNMuyfJKzyRemfA8vdU2NIl405T2DBfET0na5BoKXYfiw=
X-Received: by 2002:a19:650f:0:b0:50b:e302:597b with SMTP id
 z15-20020a19650f000000b0050be302597bmr1960679lfb.12.1702303073617; Mon, 11
 Dec 2023 05:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
In-Reply-To: <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2023 13:57:42 +0000
Message-ID: <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/hcd-xhci.c: allow unaligned access to
 Capability Registers
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Mon, 11 Dec 2023 at 07:13, Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
>
> According to xHCI spec rev 1.2, unaligned access to xHCI Host
> Controller Capability Registers is not prohibited. In Addition, the
> limit of access size is also unspecified. Actually, some real devices
> allow unaligned access and 8-byte access to these registers.
> This commit makes it possible to unaligned access and 8-byte access
> to Host Controller Capability Registers.

We should definitely look at fixing the unaligned access
stuff, but the linked bug report is not trying to do an
unaligned access -- it wants to do a 2-byte read from offset 2,
which is aligned. The capability registers in the xHCI spec
are also all at offsets and sizes that mean that a natural
read of them is not unaligned.

thanks
-- PMM

