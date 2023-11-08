Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00D7E4EBA
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 02:45:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Xcs-0005qg-Ro; Tue, 07 Nov 2023 20:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0Xcq-0005qS-2A
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:45:00 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0Xcn-00069e-Mw
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:44:59 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d2efe8c43eso168188a34.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 17:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699407895; x=1700012695; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EGtTPwlxOWLSZYJp83mt5x3plgd7q7w9jGIwoLIITp8=;
 b=K7Z//E6sOShyT3jW2ArPtlgI79h5pu7X36H172+D9Nv0V3Kt/KQENSL8G3GQVzwgUN
 UfVytm/AN6kigipaCeMi9YVRihoHmZOzsff6BCTg7+iCZSTrbTIe65CtQzaI/3GKoSxs
 uoR14vlTswQFR1df9kmmmWofkYR4bpTrrZcCq4qtnyo9wBX0jaffAWgLP+zg59TFEKlU
 2hCR1rumNAn95J2edJW7nNQ2c5x/sN/+ruxKmvlScJnlGzUBYtiaOiMiw8JbAyxXei6R
 uU+wT3nkc22tl1nDrXCzdTcOWNDrPFj+UaEOofRPh4tnI/OsoGq466aRhbMT47FcW/u3
 dyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699407895; x=1700012695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGtTPwlxOWLSZYJp83mt5x3plgd7q7w9jGIwoLIITp8=;
 b=M0ej6MZWpRgkF149O4B8Dj9UqPdg34YR1Ue42YAZEIekIdRfL5b2EdjcAVPdN9llxP
 wcEe9Xj/BJNnDS8RQ3U1oDbHi/0gKAiDOgSQM36j2RAKy34h/ZFRsOQOW8FvPzBB2iSO
 XooE8BmVG20zD06Eq6MtZL4af7DxCu/LQDaC/NeZTrwj16Nc8lcGxy/nLKL/MgxYd7P3
 3NDGt0q1ZDitUsa2BmW7nRHkuSCn1PimaVw8vJp/WSY8r04QVs/evORebHas704NEVpO
 QCVqIdJ8lmhP9qKbru7NfNMJV9zWgi2e3WcUZyCXrL8bf82YIky0TJiZJtw+B8tya7cJ
 WaEQ==
X-Gm-Message-State: AOJu0YzKjVM0MZndy5F/xUFBAbrEoeLFcxAKekumAP+KqUtdBb1jxrKJ
 OjuSLvn/MI13W56YnyFdyt/lT0G1BuK8NdBX41Y=
X-Google-Smtp-Source: AGHT+IEaSVdWaODPJbB39fGaPQS33lMPx9DoYyt8jz/qMd7Ks0l2YUIones2LS4agQKdkrJy2DObnTRxFx95c4n+W6s=
X-Received: by 2002:a05:6830:e12:b0:6c4:56b4:e91c with SMTP id
 do18-20020a0568300e1200b006c456b4e91cmr2482748otb.7.1699407895038; Tue, 07
 Nov 2023 17:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20231107184605.236540-1-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Nov 2023 09:44:42 +0800
Message-ID: <CAJSP0QVF-+qDoT8L_+f4vEci0Tjta4L_BNDfAqLwXu=0AFh7EA@mail.gmail.com>
Subject: Re: [PULL 00/25] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x335.google.com
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

On Wed, 8 Nov 2023 at 02:47, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:
>
>   Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 5d4a5080e43681b753f922c5c2a7682bc1d67497:
>
>   hw/ide/ahci: trigger either error IRQ or regular IRQ, not both (2023-11-07 19:14:20 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Graph locking part 6 (bs->file/backing)
> - ahci: trigger either error IRQ or regular IRQ, not both
>
> ----------------------------------------------------------------
> Kevin Wolf (24):
>       block: Mark bdrv_probe_blocksizes() and callers GRAPH_RDLOCK
>       block: Mark bdrv_has_zero_init() and callers GRAPH_RDLOCK
>       block: Mark bdrv_filter_bs() and callers GRAPH_RDLOCK
>       block: Mark bdrv_root_attach_child() GRAPH_WRLOCK
>       block: Mark block_job_add_bdrv() GRAPH_WRLOCK
>       block: Mark bdrv_filter_or_cow_bs() and callers GRAPH_RDLOCK
>       block: Mark bdrv_skip_implicit_filters() and callers GRAPH_RDLOCK
>       block: Mark bdrv_skip_filters() and callers GRAPH_RDLOCK
>       block: Mark bdrv_(un)freeze_backing_chain() and callers GRAPH_RDLOCK
>       block: Mark bdrv_chain_contains() and callers GRAPH_RDLOCK
>       block: Mark bdrv_filter_child() and callers GRAPH_RDLOCK
>       block: Mark bdrv_cow_child() and callers GRAPH_RDLOCK
>       block: Mark bdrv_set_backing_hd_drained() GRAPH_WRLOCK
>       block: Inline bdrv_set_backing_noperm()
>       block: Mark bdrv_replace_node_common() GRAPH_WRLOCK
>       block: Mark bdrv_replace_node() GRAPH_WRLOCK
>       block: Protect bs->backing with graph_lock

Hi Kevin,
This patch series fails CI:

commit ecdd779f1332d0625cbb6195e30db8e3c179cc76
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Fri Oct 27 17:53:26 2023 +0200

    block: Protect bs->backing with graph_lock

../block/mirror.c: In function 'mirror_run':
../block/mirror.c:1173:9: error: 'bs' may be used uninitialized in
this function [-Werror=maybe-uninitialized]
 1173 |         bdrv_drained_begin(bs);
      |         ^~~~~~~~~~~~~~~~~~~~~~

https://gitlab.com/qemu-project/qemu/-/jobs/5483228890

Please take a look. Thanks!

Stefan

>       blkverify: Add locking for request_fn
>       block: Introduce bdrv_co_change_backing_file()
>       block: Add missing GRAPH_RDLOCK annotations
>       qcow2: Take locks for accessing bs->file
>       vhdx: Take locks for accessing bs->file
>       block: Take graph lock for most of .bdrv_open
>       block: Protect bs->file with graph_lock
>
> Niklas Cassel (1):
>       hw/ide/ahci: trigger either error IRQ or regular IRQ, not both
>
>  block/copy-on-read.h                   |   3 +-
>  block/parallels.h                      |   5 +-
>  block/qcow2.h                          |  59 +++++-----
>  block/qed.h                            |   2 +-
>  block/vhdx.h                           |   9 +-
>  include/block/block-global-state.h     |  43 ++++----
>  include/block/block-io.h               |  10 +-
>  include/block/block_int-common.h       |  31 +++---
>  include/block/block_int-global-state.h |  16 +--
>  include/block/block_int-io.h           |  19 ++--
>  include/block/blockjob.h               |   5 +-
>  include/block/blockjob_int.h           |   9 +-
>  block.c                                | 192 +++++++++++++++++++--------------
>  block/backup.c                         |  21 ++--
>  block/blkdebug.c                       |  29 ++---
>  block/blkreplay.c                      |   8 +-
>  block/blkverify.c                      |  18 ++--
>  block/block-backend.c                  |   5 +
>  block/block-copy.c                     |  11 +-
>  block/bochs.c                          |   4 +
>  block/cloop.c                          |   4 +
>  block/commit.c                         |  32 +++++-
>  block/copy-before-write.c              |   6 +-
>  block/copy-on-read.c                   |  19 +++-
>  block/crypto.c                         |  10 ++
>  block/dmg.c                            |  21 ++--
>  block/filter-compress.c                |   5 +-
>  block/io.c                             |   2 +
>  block/mirror.c                         |  85 ++++++++++-----
>  block/monitor/block-hmp-cmds.c         |   3 +
>  block/parallels-ext.c                  |  21 ++--
>  block/parallels.c                      |  22 ++--
>  block/preallocate.c                    |  27 +++--
>  block/qcow.c                           |  13 ++-
>  block/qcow2-bitmap.c                   |  14 +--
>  block/qcow2-cluster.c                  |  25 ++---
>  block/qcow2.c                          | 148 +++++++++++++------------
>  block/qed.c                            |  88 ++++++++-------
>  block/raw-format.c                     |  36 ++++---
>  block/replication.c                    |  12 ++-
>  block/snapshot-access.c                |   5 +-
>  block/stream.c                         |  48 ++++++---
>  block/throttle.c                       |   3 +
>  block/vdi.c                            |  15 ++-
>  block/vhdx-log.c                       |  40 +++----
>  block/vhdx.c                           |  37 ++++---
>  block/vmdk.c                           |  23 ++--
>  block/vpc.c                            |   6 +-
>  blockdev.c                             |  72 ++++++++-----
>  blockjob.c                             |   6 +-
>  hw/ide/ahci.c                          |   5 +-
>  migration/block-dirty-bitmap.c         |   4 +
>  nbd/server.c                           |   6 ++
>  qemu-img.c                             |  31 ++++--
>  tests/unit/test-bdrv-drain.c           |  39 +++++--
>  tests/unit/test-bdrv-graph-mod.c       |  18 +++-
>  56 files changed, 923 insertions(+), 527 deletions(-)
>
>

