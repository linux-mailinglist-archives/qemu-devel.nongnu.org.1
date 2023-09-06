Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6154B793D88
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdsQP-0006Z2-K1; Wed, 06 Sep 2023 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qdsQN-0006YS-LX; Wed, 06 Sep 2023 09:18:27 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qdsQL-00063E-5Q; Wed, 06 Sep 2023 09:18:27 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57325fcd970so2217038eaf.1; 
 Wed, 06 Sep 2023 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694006303; x=1694611103; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ln3jkPRfqjn/9IeLfH2kXlZgY4yfO9d/YJEDmoDxsY=;
 b=E49pX1knadMH5++JhCSujAv+RViFsz4QSXbgiPvCkyDriGvHil/A+kEvpc3s6X6yYZ
 zciMdgFa9MHtGPmnUiDS36nEc5+tQg8VNwBSZX/6UWTG2ZlCPaeRRrSNJOZBSPI4hxei
 2YK/iiZruD72YQtXO1m1mJDNhMmiOYnWohU/C6+5sqRW+fGiFv/rHWYw6EnY0Z7VXSSk
 t+zhussVa380MiQQBcitJtYGAr35d/O769wqCS2ZQJv2Adc4xHaLpoonMQVHOL1Hjiax
 MRvaFEIzTDOOnA6sEUqDNpVxGq5NfGmgv3f0xVcq9S6CvYWBHuzNaegTKphJN7xEwTVS
 zEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694006303; x=1694611103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ln3jkPRfqjn/9IeLfH2kXlZgY4yfO9d/YJEDmoDxsY=;
 b=J9xgX8FbogT3kt8ZJdiDhzOYJtALwr7B7OEv00ol/AG5ZUBrF873xK1o8tuQC/a7mW
 mDd+eCKRvD+/nZzgEOYOebMDBPIc/ZvoXhLRe8YWUVmaPI5IYgndggi//mKdwHqBGkqx
 tlOfD3OZR2jRhjL554LH58luokSMiD9tdST7MsIoFISEsfnJMbSB9f+VoKim1hC9+rg8
 FKfe5YpJOuiziyfRV1c2Ihzv9TmU/TcfC9mS7hhG1P+UcGWk4IYaHT9von450sPf+3VQ
 LkcmRlBRHgQiWlOKW5pGTsE5nhSYBBstT6nSu0rsF03kM3wYi64+B/i1og60uUcdEbTw
 JQ4w==
X-Gm-Message-State: AOJu0YxUYrRyHkaMlxdbkDvYFAXbo90C0CIom5w6GpOBgnruztCbQut6
 v1YvuGZudrdnDnwKEenxA9blrF9KnoyvUWxH7/E=
X-Google-Smtp-Source: AGHT+IFj5bScXJ3iw/AOL7dnYjohAn25D4lh04b26s6WI2QUCFiR3t1ARYZJdJMLWt2rsNOAk+cpcRqiqCi6A21g3o8=
X-Received: by 2002:a4a:6c11:0:b0:571:aceb:26d0 with SMTP id
 q17-20020a4a6c11000000b00571aceb26d0mr14383178ooc.2.1694006303318; Wed, 06
 Sep 2023 06:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230901081804.31377-1-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Sep 2023 09:18:10 -0400
Message-ID: <CAJSP0QV4-dR2-2r+4E0N+yWHdzNF0A+FkHGU7Q3uiEg3wxR5Fg@mail.gmail.com>
Subject: Re: [PULL 00/14] Block patches
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
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

On Fri, 1 Sept 2023 at 04:18, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> The following changes since commit f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81:
>
>   Merge tag 'pull-tcg-20230823-2' of https://gitlab.com/rth7680/qemu into staging (2023-08-28 16:07:04 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/hreitz/qemu.git tags/pull-block-2023-09-01

Hi Hanna,
Please push a signed tag (git tag -s). Thanks!

Stefan

>
> for you to fetch changes up to 380448464dd89291cf7fd7434be6c225482a334d:
>
>   tests/file-io-error: New test (2023-08-29 13:01:24 +0200)
>
> ----------------------------------------------------------------
> Block patches
>
> - Fix for file-posix's zoning code crashing on I/O errors
> - Throttling refactoring
>
> ----------------------------------------------------------------
> Hanna Czenczek (5):
>   file-posix: Clear bs->bl.zoned on error
>   file-posix: Check bs->bl.zoned for zone info
>   file-posix: Fix zone update in I/O error path
>   file-posix: Simplify raw_co_prw's 'out' zone code
>   tests/file-io-error: New test
>
> Zhenwei Pi (9):
>   throttle: introduce enum ThrottleDirection
>   test-throttle: use enum ThrottleDirection
>   throttle: support read-only and write-only
>   test-throttle: test read only and write only
>   cryptodev: use NULL throttle timer cb for read direction
>   throttle: use enum ThrottleDirection instead of bool is_write
>   throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
>   fsdev: Use ThrottleDirection instread of bool is_write
>   block/throttle-groups: Use ThrottleDirection instread of bool is_write
>
>  fsdev/qemu-fsdev-throttle.h                |   4 +-
>  include/block/throttle-groups.h            |   6 +-
>  include/qemu/throttle.h                    |  16 +-
>  backends/cryptodev.c                       |  12 +-
>  block/block-backend.c                      |   4 +-
>  block/file-posix.c                         |  42 +++---
>  block/throttle-groups.c                    | 163 +++++++++++----------
>  block/throttle.c                           |   8 +-
>  fsdev/qemu-fsdev-throttle.c                |  18 ++-
>  hw/9pfs/cofile.c                           |   4 +-
>  tests/unit/test-throttle.c                 |  76 +++++++++-
>  util/throttle.c                            |  84 +++++++----
>  tests/qemu-iotests/tests/file-io-error     | 119 +++++++++++++++
>  tests/qemu-iotests/tests/file-io-error.out |  33 +++++
>  14 files changed, 418 insertions(+), 171 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/file-io-error
>  create mode 100644 tests/qemu-iotests/tests/file-io-error.out
>
> --
> 2.41.0
>
>

