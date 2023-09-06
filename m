Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705C979400F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qduDu-0000iz-6z; Wed, 06 Sep 2023 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qduDq-0000iZ-C4; Wed, 06 Sep 2023 11:13:38 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qduDn-0004Xp-Kx; Wed, 06 Sep 2023 11:13:38 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bcb15aa074so578127a34.0; 
 Wed, 06 Sep 2023 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694013212; x=1694618012; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPkxpoUJvc03U+X3snqNURx6zBnG/HU80kRQduOp8Uk=;
 b=NtHBDHekxEqFjG5eayYmpPGccXepw/GBE0jm1m7XR83N974h+rACK1RXLPZcbro+0w
 whb9Dtvxjy6x/2A731uu0XuGlXwXMGR3T9oHjXMZa344OWL4mWh88QWWhx1VmNnA82sz
 Df3VZzFkRRfmqUeRMJOvtWYoTVle6aT8wuVuI2kyqo4lzkCZMYwccRA/2zJqj6pGv3ij
 tse1BUVs9IPcTU/AxHsEmRDKRacMvPzs4r2gSbA6VuKmmBD1JlNxVl3T2u9L4xg7XlQ4
 pHFiZGS1dZdsHN6R2nuoZRSefwq2gnnF0L0oreaFUHpI4YN0TXJj6ixqraxpjthDrUbP
 mJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694013212; x=1694618012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPkxpoUJvc03U+X3snqNURx6zBnG/HU80kRQduOp8Uk=;
 b=ZEDCMbYrfOIvFrCRXFn6sFcNZ2U2B7nzOhTQTOo8S1PhxWIJ/YYkV7jbD8goKAFV5z
 FhvMuLvX1MPv7tbHrMtOeRHnDC/fHauueL7B0MSeNiK5bjM3m7NdPMHdVlESbCmaUG67
 VMAobpyHvfNk0gYfhM025V1/nbyESuzQsUS2WrGAIV+HQESwHOzplR5VREGAF8FeQcSj
 lBJwmoXw0tdc9zcXBvFXxSEZMi0JD5aSmaZcQVRFVIawu+9WAktjs+gbkZA8VJBdeOlE
 fGBZLSBDc1pmXSkSkHP/rAvlkrvhrWufiVRwd4Whz/Ez/oipqEFD2UlBkY3ww93UUNV2
 O1LA==
X-Gm-Message-State: AOJu0Ywbr7K1DMDKSDlXI/ZuMNMYC97yvvLvKrY4lHGu0FCNRS6oR+0g
 fgFE03Wh/G1d8hm7jaEPo4H/SyPiWuKM1V0cd8M=
X-Google-Smtp-Source: AGHT+IEVvfJOrygkc+diQ7UCtQgIla9cXNdHhwTTja3zWPb9RUyO8ioDd2367lGQNrkUjjLHzmF5CuLFD0q16TlaEwE=
X-Received: by 2002:a05:6830:24b0:b0:6bc:b26a:8939 with SMTP id
 v16-20020a05683024b000b006bcb26a8939mr10358154ots.2.1694013212648; Wed, 06
 Sep 2023 08:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230904143643.259916-1-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Sep 2023 11:13:20 -0400
Message-ID: <CAJSP0QV+aADrdBGJD1LyWxeKtFAprK8=mMeDCt-F5_1qx0KYVg@mail.gmail.com>
Subject: Re: [PULL 00/14] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x336.google.com
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

test-bdrv-drain is failing. I think my coroutine wrapper patch might
be necessary:
https://gitlab.com/qemu-project/qemu/-/jobs/5029372308#L4907

I have dropped this patch series for the time being. Feel free to
remove my patches and send a new revision.

I will debug the test-bdrv-drain issue.

Stefan

On Mon, 4 Sept 2023 at 10:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2=
fc:
>
>   Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu in=
to staging (2023-08-31 10:06:29 -0400)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to bb86eb45297840c31dbc4df6bac02e50596f2376:
>
>   block: Remove unnecessary variable in bdrv_block_device_info (2023-09-0=
4 11:03:28 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Process I/O in the current AioContext (instead of the BB AioContext)
> - Optimise reqs_lock to make multiqueue actually scale
> - iotests: Fix reference output for some tests after recent changes
> - vpc: Avoid dynamic stack allocation
> - Code cleanup, improved documentation
>
> ----------------------------------------------------------------
> Dmitry Frolov (1):
>       vmdk: Clean up bdrv_open_child() return value check
>
> Fabiano Rosas (2):
>       block: Remove bdrv_query_block_node_info
>       block: Remove unnecessary variable in bdrv_block_device_info
>
> Fiona Ebner (1):
>       iotests: adapt test output for new qemu_cleanup() behavior
>
> Hanna Czenczek (1):
>       block: Be more verbose in create fallback
>
> Kevin Wolf (1):
>       qemu-img: Update documentation for compressed images
>
> Michael Tokarev (1):
>       qemu-img: omit errno value in error message
>
> Peter Maydell (1):
>       block/iscsi: Document why we use raw malloc()
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       block/vpc: Avoid dynamic stack allocation
>
> Stefan Hajnoczi (5):
>       block: minimize bs->reqs_lock section in tracked_request_end()
>       block: change reqs_lock to QemuMutex
>       block: remove AIOCBInfo->get_aio_context()
>       block-backend: process I/O in the current AioContext
>       block-backend: process zoned requests in the current AioContext
>
>  docs/tools/qemu-img.rst            | 19 ++++++++++++--
>  include/block/aio.h                |  1 -
>  include/block/block-global-state.h |  2 ++
>  include/block/block-io.h           |  1 -
>  include/block/block_int-common.h   |  2 +-
>  include/block/qapi.h               |  3 ---
>  block.c                            | 10 ++++---
>  block/block-backend.c              | 35 +++++++------------------
>  block/io.c                         | 53 +++++++++++++++++++-------------=
------
>  block/iscsi.c                      |  1 +
>  block/qapi.c                       | 32 ++---------------------
>  block/vmdk.c                       |  2 +-
>  block/vpc.c                        |  4 +--
>  hw/nvme/ctrl.c                     |  7 -----
>  qemu-img.c                         |  4 +--
>  softmmu/dma-helpers.c              |  8 ------
>  util/thread-pool.c                 |  8 ------
>  tests/qemu-iotests/080.out         |  6 ++---
>  tests/qemu-iotests/109.out         | 24 +++++++++++++++++
>  tests/qemu-iotests/112.out         |  6 ++---
>  tests/qemu-iotests/185             |  2 ++
>  tests/qemu-iotests/185.out         |  4 +++
>  tests/qemu-iotests/244.out         |  2 +-
>  23 files changed, 107 insertions(+), 129 deletions(-)
>
>

