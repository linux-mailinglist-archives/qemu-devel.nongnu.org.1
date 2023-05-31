Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06093717DED
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JuX-0008QW-M7; Wed, 31 May 2023 07:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4JuN-0008Q8-GZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:22:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4JuK-0006Kl-4n
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:22:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so57833145e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685532126; x=1688124126;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIBmlGEg+Q1FJaJAx7WHyIzbXYqOUa7NlGW0hmlJ2Ts=;
 b=veCZHy3DfSvFl+X5guvCJcPxEu7MFMFZsONWQL4DIyjxHS7x9VdcNhcAQqgID7WdXy
 dS3s1E/Edxnnj2D3ZlSew+8FOnF+u976uX7LVZEn2FabKjGUy+mSYKPuGJykxI0h2ZTn
 UpViTIxzLY8vzu0GGHsmaeDoTAXiqfGe93a9B+TuwKivY/h0vst8JkR4WeLUvx1e7Q6z
 RlKhyd/gN6xrHsg9BhXjAuVYOJE2llZ02hlskOuYrp4+UXJAtlrHYWnDP8jdabYZLsif
 OBQmXvZ5ftRuWQ943Syap0WAEO1No0Q2Ypa1D2L8PQQWksGpAanHBDgergNLdyhliwnU
 EMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685532126; x=1688124126;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SIBmlGEg+Q1FJaJAx7WHyIzbXYqOUa7NlGW0hmlJ2Ts=;
 b=Lt73HFejDh6SucvatDEOVw58//Lcbh3fwMGpnY5eIQuzBjafb8KwZFcDLZA/6iGI+b
 +a0WAdun2j4VPLQs8b5JBDgI5Yd2rPD9p+/+ykAfhfe1PVkWkS0TB3scmQhoUxj78RWd
 K/teqoEDBClh+l3IhC2ZXqAstQwTAueb415+EyETuoJrKxdy0+T2vA//9dEXUaIAJ2E2
 P00kdOBCgJN6GT2GI/jWAUDp1zq+extZ/P08JuLyhZ3xI4xSlVP7mepumvFIgxskiU0Y
 ZMhTVOVF6pUbKy+wwzCS7T7ttv30KUEdm80BVZ9VwJjYctT4DRi/71mL4EWUVL0JyvK8
 WMEg==
X-Gm-Message-State: AC+VfDz97K953t2wQqj/geNVTYiT+SitrYaZOQa8LtxgmNezMO5vlV6H
 OmWsCZ3GYZ8xFEh+HayZPCLhPA==
X-Google-Smtp-Source: ACHHUZ6pSgn3o1zMmEoLcC4iH/qk5DAmCoFenvQugX2oLv6LzL/wBfsbXhzKBtjSnOmBfVBCds/c2w==
X-Received: by 2002:a1c:6a11:0:b0:3f6:e13:b266 with SMTP id
 f17-20020a1c6a11000000b003f60e13b266mr3900187wmc.13.1685532126417; 
 Wed, 31 May 2023 04:22:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a7bca4a000000b003f70a7b4537sm6177744wml.36.2023.05.31.04.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 04:22:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FCBE1FFBB;
 Wed, 31 May 2023 12:22:05 +0100 (BST)
References: <cover.1685476786.git.mzamazal@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Milan Zamazal <mzamazal@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, stefanha@redhat.com, Vincent
 Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/4] Add SCMI vhost-user VIRTIO device
Date: Wed, 31 May 2023 12:19:19 +0100
In-reply-to: <cover.1685476786.git.mzamazal@redhat.com>
Message-ID: <871qiwd9uq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Milan Zamazal <mzamazal@redhat.com> writes:

> This patch series adds a vhost-user VIRTIO device for SCMI.
> It's similar to other similar vhost-user VIRTIO devices.
>
> I'm aware of the work in progress by Alex Benn=C3=A9e to simplify similar=
 devices
> and avoid excessive code duplication.  I think the SCMI device support
> doesn't bring anything special and it can be rebased on the given work
> if/once it is merged.

\o/ - I'll try and get the next iteration done in the next few weeks.
Out of interest have you tested your scmi backend with those patches? Oh
and also which backend are you using?

Vincent did a bunch of work over the last year or so on SCMI although in
his case the backend was a RTOS running in a separate domain using some
shared memory between the SCMI domain and a couple of guests.

> Milan Zamazal (4):
>   hw/virtio: Add boilerplate for vhost-user-scmi device
>   hw/virtio: Add vhost-user-scmi-pci boilerplate
>   tests/qtest: Fix a comment typo in vhost-user-test.c
>   tests/qtest: enable tests for virtio-scmi
>
>  MAINTAINERS                         |   7 +
>  hw/virtio/Kconfig                   |   5 +
>  hw/virtio/meson.build               |   2 +
>  hw/virtio/vhost-user-scmi-pci.c     |  68 +++++++
>  hw/virtio/vhost-user-scmi.c         | 306 ++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user-scmi.h |  30 +++
>  tests/qtest/libqos/meson.build      |   1 +
>  tests/qtest/libqos/virtio-scmi.c    | 174 ++++++++++++++++
>  tests/qtest/libqos/virtio-scmi.h    |  34 ++++
>  tests/qtest/vhost-user-test.c       |  46 ++++-
>  10 files changed, 672 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/vhost-user-scmi-pci.c
>  create mode 100644 hw/virtio/vhost-user-scmi.c
>  create mode 100644 include/hw/virtio/vhost-user-scmi.h
>  create mode 100644 tests/qtest/libqos/virtio-scmi.c
>  create mode 100644 tests/qtest/libqos/virtio-scmi.h


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

