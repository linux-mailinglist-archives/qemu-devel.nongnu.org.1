Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63D7FA4B9
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:29:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dXE-0004zQ-NH; Mon, 27 Nov 2023 10:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7dX9-0004yH-TB
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:28:27 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7dX8-00034R-G5
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:28:27 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54b0e553979so3379281a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701098904; x=1701703704; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTiLm7FDOYgVyvB+1MRn5MRXQ5p38RB29/sXJrRP5t8=;
 b=ezxSa4XAxhrOv/2mNEXteTb5Z5C9LNWDa0x2xSsGo2qUO6In+MNlOXv5Vb62K6Ix7I
 B753DY/4L9x7zz86FxTqEhFzlb4hrM9d8L8nx4hKSQvx5r0Tl/3TaAwNqq6IL116X3oT
 D18JnltiPyoPs2ztSn7iNE0TItPFmUxAgsOWM7eH8ULgayIFqgbWrVtQFzW4q72jHBXx
 VnuJzzovtA1D3kDDD4TaVId01Z1uzrL6S73RB9DR06iZc6thtBLEY2CLo63gbDci+MfD
 NzapSxFZ5eskHyzEmZHiouZm3MURkGhchxEtDhSwhhheSqhciRJnFuT856flSwKZPR0x
 yZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701098904; x=1701703704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTiLm7FDOYgVyvB+1MRn5MRXQ5p38RB29/sXJrRP5t8=;
 b=gm9JdEdUUWUFqyOMWZCUAatRzijdhEBuGcyEzGMS2NRuPl9jI8GvZBb6CK/X8+lWCp
 JD5MX//jF+0EpxALqnK+DS0H4Kvl0ouXjca/UrlzdUOge0sVfPPvUiZ9aQFetTYsESTV
 6lOTwn/z4M//yPSwE2QR1REGUh+h0akGIj6lf0/FbINovBzKEB271VXIckxwi0R7Cvzl
 ncH3dP7Zm8vElWkizabDB8/86mBQK3XvWKFfkC+ToeT8yjPGX5n3SEuhDlPGAXjIxPwN
 i9l3inVs1zXV6TDqdl6jP8RMnM6Pqow+NB8Mp/hr9UVipeBu4cjnA8gwlanMua+kmk8x
 Q8Yg==
X-Gm-Message-State: AOJu0YxLwqRy4kUCMhx7a0a37uGXrusuCmKRp01PmyI+BluBJ+njc5GI
 2L8Xb6lIOd2/hbId1y8I0Iu5EctiBH1GwfbGmMXf3A==
X-Google-Smtp-Source: AGHT+IH2dVW1+fkBA98vF1kWQYtYWiq9ID++TmyrxUDqdQHtIpnDd6kM/hcVZI+RcqnVjj5ZSWHH3WaHptk8TXLdQf8=
X-Received: by 2002:a50:8e42:0:b0:543:bd27:f4a9 with SMTP id
 2-20020a508e42000000b00543bd27f4a9mr8963153edx.12.1701098903837; Mon, 27 Nov
 2023 07:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20231121174051.63038-1-philmd@linaro.org>
In-Reply-To: <20231121174051.63038-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 15:28:12 +0000
Message-ID: <CAFEAcA8qz=785qBAxwaDmyPkWbMbiYA=vzSS1Lnf8jvRgxBktQ@mail.gmail.com>
Subject: Re: [PATCH-for-8.2 0/6] hw: Free DEFINE_PROP_ARRAY()'s arrays in
 instance_finalize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 21 Nov 2023 at 17:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In few places we forget to free the array allocated by the
> DEFINE_PROP_ARRAY() macro handlers. Fix that.
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field
>   hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
>   hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize()
>   hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finalize()
>   hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock" array
>   hw/input/stellaris_gamepad: Free StellarisGamepad::keycodes[] array

Applied to target-arm.next, thanks.

-- PMM

