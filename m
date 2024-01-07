Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D982665C
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 23:25:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMbYf-0001hL-GJ; Sun, 07 Jan 2024 17:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rMbYd-0001hD-R3
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 17:23:51 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rMbYc-0001lB-5V
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 17:23:51 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a28d61ba65eso122806366b.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 14:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704666228; x=1705271028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okdT+KNoBgif36UAtw8WXdBt5hDoM90c9Cso6/SH3SI=;
 b=fuvU5Pb70glOZr52zNdX+Js8ZYxLcPrshKRaAwTfBHbTCrmuEwl6X3PQ6r8Qga+gnL
 8KVRJwv8FKKwt193aLGa+RwvpvUfEEn/EMWceN21Jav6H43ZhK+5AvKhJO3zRV310Bth
 ZH0WjS0V/ODJwOlQQTm37KulCB+AsK3WIsPCDQ5CCST3HLnh+k8lULebizrROaUzO5p/
 QT/eVhmLtayvF/55zIbs4Gb+lF3QTVCHM/Y1SytQBCJFL4JxrU6Y8JWaMziPQkKCe8n9
 kecuEtNp2n/zUrH6BSL7AeGSK3HsI/F2NdLpjmsrLwjg/Tcn3xC4txLXh3iOvOvk2wuL
 9UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704666228; x=1705271028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okdT+KNoBgif36UAtw8WXdBt5hDoM90c9Cso6/SH3SI=;
 b=RGUH/wxy4Bj8i6Hbbpc7PTaEBwwomrSKlDkuWEY2313NjqkYaBMK1Ask24tsu84Oj6
 Xg1O3somW6NDSfL8bgdVoBDBI5T4Bs9E1wN1grrovM5f/omYcdn+io4AgqT/XnU6Sl95
 T5vLF17AA/YOMeHalKDMD6Dw/JHsLP2JkGOQSWuDWEPuDSK+zhQpgraTfFMTzAw/d6BD
 EJxjTnzQJuyWJlAtUBNErp3nfxtmQHzwm1QO8nJJ+m3g1GqhyYcZZ1lBYJy8wgEV5rNB
 pQk8xVYR1gvdhCwvGz8bx1+hC5lqdd9HXNkB7XzqbSTOEq57Kak8tpYQBtWoywgejyZC
 1KWA==
X-Gm-Message-State: AOJu0YwnlVwoOCPsh+I8T9I22i8XOV6QCE7U+0klM8hlNap+/6hh35Pg
 lz6wg1j4vS8KXoPONOhyOqNhpHmNVRfR+fpsw8AFwVMSx9P8RQ==
X-Google-Smtp-Source: AGHT+IF+iKGXija7X9xl8tOhd6dW+cP5x60qvf1hvYiehxo50+J2wbjdmdnV0pL2rbhoX3RriSyjJRoK1euZlmFelI8=
X-Received: by 2002:a17:906:787:b0:a28:f771:ad03 with SMTP id
 l7-20020a170906078700b00a28f771ad03mr589644ejc.101.1704666227912; Sun, 07 Jan
 2024 14:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20240106223546.44460-1-wsh@wshooper.org>
In-Reply-To: <20240106223546.44460-1-wsh@wshooper.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 8 Jan 2024 06:23:36 +0800
Message-ID: <CAEUhbmX1anAjH9sp06ygft5wrR-QPD_6c9Jtze2ZKw9cm2KKuQ@mail.gmail.com>
Subject: Re: [PATCH] net/vmnet: Pad short Ethernet frames
To: William Hooper <wsh@wshooper.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Jan 7, 2024 at 7:19=E2=80=AFAM William Hooper <wsh@wshooper.org> wr=
ote:
>
> At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
> host's ARP replies, to the minimum size (60 bytes before the frame check
> sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
> drivers may drop them with "frame too short" errors.
>
> This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
> and net/slirp.c.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
> Signed-off-by: William Hooper <wsh@wshooper.org>
> ---
>  net/vmnet-common.m | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

