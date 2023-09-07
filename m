Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCA797B33
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:08:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJPV-0006qd-VB; Thu, 07 Sep 2023 14:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeJPU-0006qL-ER; Thu, 07 Sep 2023 14:07:20 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeJPS-00036Y-2g; Thu, 07 Sep 2023 14:07:20 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1d544a4a2f2so794917fac.3; 
 Thu, 07 Sep 2023 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694110036; x=1694714836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vgLDjdzieyCms1osOMV4Aevk7PTVs53zv9rJ+hSvciU=;
 b=hpolAwGwDB7MAJyN+AzFdCeCJmxuKB+W22WGV4wn+rjR59GzitOAE6GIcOUGCZqGnD
 JX9WCrpPE2ARk3Ma/vHpp3BJ4w18Wp2KEOMsFhG1kExzn/i8T2bFbz9JaQWF0fjISyyv
 2cjZIGN4yy3TwisRtlhn+CtNEpo7AHIuSp5DeFDyWdkwfZ6Q+HQCn9R61/7zL7a5yZG7
 cpz0lK5AO1+KFwwvcGniONFEZOSNBHhFXV9evjgHGC6Opvyg81MPBugUuzWXy4qsr5rr
 e2PEL/xsq9KczAa36hvfgQHW4ix7swcc7ASbVT5yY+UQXX3bAkVYIkyxXCVGDpVowB6Y
 NM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694110036; x=1694714836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgLDjdzieyCms1osOMV4Aevk7PTVs53zv9rJ+hSvciU=;
 b=H6doIiVXg4spbK8QeUwXbwnglzPdbt5cdfjDsm9obsI/QspObtL98b+MA07cKXlKA6
 jz1wjSjpmxWUuHc5JhNsPj9isa14wfHuEZ2Z/duhnfTMIWsYx56NwmAxB578oRgTNCPN
 gOPBuYNcc/07Bctr9HzY+Z8ReUTd8SIMswN/DPDT3wcFmG2DXURrrCBr8xFUZ1VcoSYI
 Hq79TWeYLjlyXu0nGhYqGddmExOEpl8CxiexWE4ut2nX9cpiW+oVPhownTAf4I2JpNhq
 2GelWZL7hbbWeeRLqxiM+sWWKhDF36OLhT9W4beO3jeDVEftOUh9Hwm+DIyaXc0haLje
 JDBQ==
X-Gm-Message-State: AOJu0YwUiPx/q/ZFObC8XH58hFcHVCAzyPUDsyb0jgo/cf41py7wo9x+
 XGvQmOBmF+0rtBm+PEqIpYH7TXtj7G98LztfWbc=
X-Google-Smtp-Source: AGHT+IH9dcIuAwukEHDuvxG6qKqCT/q9R9n/6IRcH9knv5DCDEEoepOSV3LcDpZ0W7ULiLvLfwfMmzf9AdT/WAQSG80=
X-Received: by 2002:a05:6871:1ca:b0:1bb:5480:4b4 with SMTP id
 q10-20020a05687101ca00b001bb548004b4mr334475oad.8.1694110036436; Thu, 07 Sep
 2023 11:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693980783.git.jeuk20.kim@gmail.com>
In-Reply-To: <cover.1693980783.git.jeuk20.kim@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Sep 2023 14:07:02 -0400
Message-ID: <CAJSP0QVXhyiQBzQCT=2k38aKhBsvz2iwdNk+pogOTi4PYs=ezQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, fam@euphon.net, 
 hreitz@redhat.com, jeuk20.kim@samsung.com, k.jensen@samsung.com, 
 kwolf@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 philmd@linaro.org, qemu-block@nongnu.org, stefanha@redhat.com, 
 thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 6 Sept 2023 at 03:45, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>
> Since v9:
> - Added the "UFS_" prefix to all define and enum defined in block/ufs.h.
> This fixes
> https://gitlab.com/qemu-project/qemu/-/jobs/4977255992
> which is a win32 build error.
>
> - Fixed not to use pointer type casting (uint32_t * -> unsigned long *).
> It causes the bug in the find_first_bit() function on big endian host pc.
> This fixes
> https://gitlab.com/qemu-project/qemu/-/jobs/4977256030
> which is qos-test failure on s390x hosts.
>
> Please let me know if there are any problems.
> Thank you very much!

Applied, thanks!

https://gitlab.com/stefanha/qemu/-/commits/block

Stefan

>
> Jeuk
>
> Jeuk Kim (4):
>   hw/ufs: Initial commit for emulated Universal-Flash-Storage
>   hw/ufs: Support for Query Transfer Requests
>   hw/ufs: Support for UFS logical unit
>   tests/qtest: Introduce tests for UFS
>
>  MAINTAINERS              |    7 +
>  docs/specs/pci-ids.rst   |    2 +
>  hw/Kconfig               |    1 +
>  hw/meson.build           |    1 +
>  hw/ufs/Kconfig           |    4 +
>  hw/ufs/lu.c              | 1445 ++++++++++++++++++++++++++++++++++++
>  hw/ufs/meson.build       |    1 +
>  hw/ufs/trace-events      |   58 ++
>  hw/ufs/trace.h           |    1 +
>  hw/ufs/ufs.c             | 1502 ++++++++++++++++++++++++++++++++++++++
>  hw/ufs/ufs.h             |  131 ++++
>  include/block/ufs.h      | 1090 +++++++++++++++++++++++++++
>  include/hw/pci/pci.h     |    1 +
>  include/hw/pci/pci_ids.h |    1 +
>  include/scsi/constants.h |    1 +
>  meson.build              |    1 +
>  tests/qtest/meson.build  |    1 +
>  tests/qtest/ufs-test.c   |  587 +++++++++++++++
>  18 files changed, 4835 insertions(+)
>  create mode 100644 hw/ufs/Kconfig
>  create mode 100644 hw/ufs/lu.c
>  create mode 100644 hw/ufs/meson.build
>  create mode 100644 hw/ufs/trace-events
>  create mode 100644 hw/ufs/trace.h
>  create mode 100644 hw/ufs/ufs.c
>  create mode 100644 hw/ufs/ufs.h
>  create mode 100644 include/block/ufs.h
>  create mode 100644 tests/qtest/ufs-test.c
>
> --
> 2.34.1
>
>

