Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444D7A4B66
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFnU-0008NJ-41; Mon, 18 Sep 2023 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiFnD-00086F-AK; Mon, 18 Sep 2023 11:04:08 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiFn7-0007Ae-1Z; Mon, 18 Sep 2023 11:04:06 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5738949f62cso2780026eaf.0; 
 Mon, 18 Sep 2023 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695049439; x=1695654239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04VaeoBQpIsnH17ejD9KK+f7NXHWdc/i+7VBOY9mr6Y=;
 b=Ku4rOm0FZ/bSeQw48+wpqPSwqKD/jrCwKjUcYD+4VzHiqNkHtBcITXCqIZ9OyfmzIy
 b1Tqea0PFd7va/Xl49FrRqB93YUbzW6zXvu97d+DBBJYlumCJtylUzCI/USzCpBNO5eu
 ChM8ifJrXYONfxD6MsEFDs+2vd2LsghUXroi6v15zoiRksM3BPbYv7IyECjMxJ92XEZj
 8MlW3so5tm4rCoL5rC80aLVQMi6sl3nX0PnTU+sNhF3OF51ubPKrCaRYBWqVfyaVqQ37
 gP8iJy5SWciX6nSRJ3AIizLa6KpulfNMY+fNeFbbY3V4BrM0mXzXS93sO5t42+mw72/D
 1U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695049439; x=1695654239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04VaeoBQpIsnH17ejD9KK+f7NXHWdc/i+7VBOY9mr6Y=;
 b=FBL2j1WLtQEM6kSNCc/YJJ2qUg/C0qzBpntCEf0y8bloYVPZenaypodqihynUQuPoD
 lJjhCPT+QAAaJsfRPyQzLuXsmiQhz/REca2Oa2X3gi4vxyZE79Ne++1rCBrXQ7XQO5Kq
 j7ijR/MywTv7RgTBEtZg0LBJzTJBDhT+bgL3J+6vZ3FKvnyPoYulAqw7ewk7U4l3CQvE
 r3G/EIRw/P08uk4EfvqTXKoJSUnw9xPidKIDLVAM5KwFu0wfz0oYqOSl5HtgWrqwJPFe
 60OWuapTPbG4q8SNjxJsXYGS29p8CAqfobYlKMEplLNufPJSW3AlAL7BS40+IesWXRaJ
 uFmQ==
X-Gm-Message-State: AOJu0YygK2DW9PuFk+NSPG7BODPtZGrDQypbBpkS5HVwVx12uABAjtmM
 Jk0cwC2UdtVWTmWnPdV4QVXJ8NRl4sL9e2k1tdI=
X-Google-Smtp-Source: AGHT+IFgdX/ZBOr4AaMewJaI2RcJ8G+fToatgwbehx299BcawTjFpcccyy7stEocntw7GiWuwXcxc0ZMk7KG2xVPdaY=
X-Received: by 2002:a4a:6206:0:b0:576:8ae8:5dfc with SMTP id
 x6-20020a4a6206000000b005768ae85dfcmr9201981ooc.4.1695049435995; Mon, 18 Sep
 2023 08:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230915144344.238596-1-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 18 Sep 2023 11:03:43 -0400
Message-ID: <CAJSP0QUPOVq5v+7W8E-ruV-Wbg1HYZn2kFWaDzULxSO-3SdEZg@mail.gmail.com>
Subject: Re: [PULL 00/28] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Kevin,
The following CI failure looks like it is related to this pull
request. Please take a look:
https://gitlab.com/qemu-project/qemu/-/jobs/5112083994

=E2=96=B6 823/840 qcow2 iothreads-commit-active FAIL
823/840 qemu:block / io-qcow2-iothreads-commit-active ERROR 6.16s exit stat=
us 1
>>> MALLOC_PERTURB_=3D184 PYTHON=3D/home/gitlab-runner/builds/E8PpwMky/0/qe=
mu-project/qemu/build/pyvenv/bin/python3 /home/gitlab-runner/builds/E8PpwMk=
y/0/qemu-project/qemu/build/pyvenv/bin/python3 /home/gitlab-runner/builds/E=
8PpwMky/0/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 i=
othreads-commit-active --source-dir /home/gitlab-runner/builds/E8PpwMky/0/q=
emu-project/qemu/tests/qemu-iotests --build-dir /home/gitlab-runner/builds/=
E8PpwMky/0/qemu-project/qemu/build/tests/qemu-iotests
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
--- /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/qemu-iote=
sts/tests/iothreads-commit-active.out
+++ /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/scratch/q=
cow2-file-iothreads-commit-active/iothreads-commit-active.out.bad
@@ -18,6 +18,35 @@
{"execute": "job-complete", "arguments": {"id": "job1"}}
{"return": {}}
{"data": {"device": "job1", "len": 131072, "offset": 131072, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "job1", "len": 131072, "offset": 131072, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-{"execute": "job-dismiss", "arguments": {"id": "job1"}}
-{"return": {}}
+Traceback (most recent call last):
+ File "/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/python/qemu=
/qmp/events.py",
line 557, in get
+ return await self._queue.get()
+ File "/usr/lib/python3.10/asyncio/queues.py", line 159, in get
+ await getter
+asyncio.exceptions.CancelledError
+
+During handling of the above exception, another exception occurred:
+
+Traceback (most recent call last):
+ File "/usr/lib/python3.10/asyncio/tasks.py", line 456, in wait_for
+ return fut.result()
+asyncio.exceptions.CancelledError
+
+The above exception was the direct cause of the following exception:

On Fri, 15 Sept 2023 at 10:45, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39=
e5:
>
>   Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qe=
mu-tpm into staging (2023-09-13 13:41:57 -0400)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 5d96864b73225ee61b0dad7e928f0cddf14270fc:
>
>   block-coroutine-wrapper: use qemu_get_current_aio_context() (2023-09-15=
 15:49:14 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Graph locking part 4 (node management)
> - qemu-img map: report compressed data blocks
> - block-backend: process I/O in the current AioContext
>
> ----------------------------------------------------------------
> Andrey Drobyshev via (2):
>       block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
>       qemu-img: map: report compressed data blocks
>
> Kevin Wolf (21):
>       block: Remove unused BlockReopenQueueEntry.perms_checked
>       preallocate: Factor out preallocate_truncate_to_real_size()
>       preallocate: Don't poll during permission updates
>       block: Take AioContext lock for bdrv_append() more consistently
>       block: Introduce bdrv_schedule_unref()
>       block-coroutine-wrapper: Add no_co_wrapper_bdrv_wrlock functions
>       block-coroutine-wrapper: Allow arbitrary parameter names
>       block: Mark bdrv_replace_child_noperm() GRAPH_WRLOCK
>       block: Mark bdrv_replace_child_tran() GRAPH_WRLOCK
>       block: Mark bdrv_attach_child_common() GRAPH_WRLOCK
>       block: Call transaction callbacks with lock held
>       block: Mark bdrv_attach_child() GRAPH_WRLOCK
>       block: Mark bdrv_parent_perms_conflict() and callers GRAPH_RDLOCK
>       block: Mark bdrv_get_cumulative_perm() and callers GRAPH_RDLOCK
>       block: Mark bdrv_child_perm() GRAPH_RDLOCK
>       block: Mark bdrv_parent_cb_change_media() GRAPH_RDLOCK
>       block: Take graph rdlock in bdrv_drop_intermediate()
>       block: Take graph rdlock in bdrv_change_aio_context()
>       block: Mark bdrv_root_unref_child() GRAPH_WRLOCK
>       block: Mark bdrv_unref_child() GRAPH_WRLOCK
>       block: Mark bdrv_add/del_child() and caller GRAPH_WRLOCK
>
> Stefan Hajnoczi (5):
>       block: remove AIOCBInfo->get_aio_context()
>       test-bdrv-drain: avoid race with BH in IOThread drain test
>       block-backend: process I/O in the current AioContext
>       block-backend: process zoned requests in the current AioContext
>       block-coroutine-wrapper: use qemu_get_current_aio_context()
>
>  qapi/block-core.json                             |   6 +-
>  include/block/aio.h                              |   1 -
>  include/block/block-common.h                     |   7 +
>  include/block/block-global-state.h               |  32 +-
>  include/block/block-io.h                         |   1 -
>  include/block/block_int-common.h                 |  34 +-
>  include/block/block_int-global-state.h           |  14 +-
>  include/sysemu/block-backend-global-state.h      |   4 +-
>  block.c                                          | 348 +++++++---
>  block/blklogwrites.c                             |   4 +
>  block/blkverify.c                                |   2 +
>  block/block-backend.c                            |  64 +-
>  block/copy-before-write.c                        |  10 +-
>  block/crypto.c                                   |   6 +-
>  block/graph-lock.c                               |  26 +-
>  block/io.c                                       |  23 +-
>  block/mirror.c                                   |   8 +
>  block/preallocate.c                              | 133 ++--
>  block/qcow.c                                     |   5 +-
>  block/qcow2.c                                    |   7 +-
>  block/quorum.c                                   |  23 +-
>  block/replication.c                              |   9 +
>  block/snapshot.c                                 |   2 +
>  block/stream.c                                   |  20 +-
>  block/vmdk.c                                     |  15 +
>  blockdev.c                                       |  23 +-
>  blockjob.c                                       |   2 +
>  hw/nvme/ctrl.c                                   |   7 -
>  qemu-img.c                                       |   8 +-
>  softmmu/dma-helpers.c                            |   8 -
>  tests/unit/test-bdrv-drain.c                     |  31 +-
>  tests/unit/test-bdrv-graph-mod.c                 |  20 +
>  tests/unit/test-block-iothread.c                 |   3 +
>  util/thread-pool.c                               |   8 -
>  scripts/block-coroutine-wrapper.py               |  24 +-
>  tests/qemu-iotests/051.pc.out                    |   6 +-
>  tests/qemu-iotests/122.out                       |  84 +--
>  tests/qemu-iotests/146.out                       | 780 +++++++++++------=
------
>  tests/qemu-iotests/154.out                       | 194 +++---
>  tests/qemu-iotests/179.out                       | 178 +++---
>  tests/qemu-iotests/209.out                       |   4 +-
>  tests/qemu-iotests/221.out                       |  16 +-
>  tests/qemu-iotests/223.out                       |  60 +-
>  tests/qemu-iotests/241.out                       |  10 +-
>  tests/qemu-iotests/244.out                       |  24 +-
>  tests/qemu-iotests/252.out                       |  10 +-
>  tests/qemu-iotests/253.out                       |  20 +-
>  tests/qemu-iotests/274.out                       |  48 +-
>  tests/qemu-iotests/tests/nbd-qemu-allocation.out |  16 +-
>  tests/qemu-iotests/tests/qemu-img-bitmaps.out    |  24 +-
>  50 files changed, 1376 insertions(+), 1036 deletions(-)
>
>

