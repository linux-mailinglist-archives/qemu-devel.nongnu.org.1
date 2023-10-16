Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048797CAF5B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQVS-00051S-Px; Mon, 16 Oct 2023 12:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsQVR-000515-Mk; Mon, 16 Oct 2023 12:31:49 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsQVP-0001Y8-R6; Mon, 16 Oct 2023 12:31:49 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c7b3adbeb6so3401420a34.0; 
 Mon, 16 Oct 2023 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697473906; x=1698078706; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pFDq/kScjanGyd7ZatiffKPAtm7Iym8SWFenqeaQAo=;
 b=bLwLfkeGcRxQQ37K0xepp7nc+cygUeabpzVa67E3coXhhRrfY6CFfPYJsSHUPUs0PM
 nTh/pIKiDycpwNTqd0jj6gLwV+pDTNBbufN1epzn6ZS49kqjYtFx4z+SQQi/XXvns2DO
 df8Kwj6inzBLFZZx5EcpUsi7BjJjOJY+5E+kwn9ESRPhO6ZDYYBmBexUGBOmBUYeq5NN
 AXLODRX8LDtqGqplRNI2iy0olF3Zsb5OeNuWWU22tuWPQPgi7sN2t6Uxd8t+8h3Q+ir9
 qjp8GYqfFeen63slPDYp6eNtBVU05L3co3wK5H0oBoH8tr0YtUWf9oGcndKuyuNdZB2B
 LHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473906; x=1698078706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pFDq/kScjanGyd7ZatiffKPAtm7Iym8SWFenqeaQAo=;
 b=mfo5ICEicSTx0pVI/IQknOnCHEh6hYgY052V270xHpMk2lO4MI+0okyJma9u0BjxZB
 y7l9+5yKElIB7ZO6bTHntU1w6w3h7aPKJr1ICnBmgd9DQ8MkL2Rd1ZDxCWqYSibmYdbY
 mjHLf4fsBPIj/xRyaHMi5GlT9Yn+ksDa3zOdMovzTuZQ3Wp+7v0hA60uhF/uwM1LLPNH
 nd4E0o/RWWnh/BCPV82RH9TBxjZOJu8Pvniobg3STg+BrxnQDy6rZB0J9blvMLHFInq1
 X/KyR+g0tkfyohVweAZiAsWYuRKDSpuwfWhkJYyPqF/tWzCcd2Xy+zodc/Ph276Kc5a3
 ZPEg==
X-Gm-Message-State: AOJu0YwmOHejIEXAzhyYUCdb0lNO/VNLxbAmbHIKJ/o2ZLOXDAHKAoHA
 Ayau0P/wVGDikxxB6A7xp0lIWuXKyGjC5poMBvs=
X-Google-Smtp-Source: AGHT+IEFyHmtmz3dPd5QbQOyQL85l9+VMkWYIiDAHDF3WUOjaKBGL7Qu8ieJ7eyL+drFOiFUbT2r2XwQYSKXJ9JAyMk=
X-Received: by 2002:a9d:63da:0:b0:6b9:a6ef:2709 with SMTP id
 e26-20020a9d63da000000b006b9a6ef2709mr38825775otl.8.1697473905942; Mon, 16
 Oct 2023 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231016100706.2551-1-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Oct 2023 12:31:33 -0400
Message-ID: <CAJSP0QXkTvJnioak5X1Ya3CC6LmiriFqYhyUV+AJ4=JS4SK97w@mail.gmail.com>
Subject: Re: [PULL 00/38] Migration 20231016 patches
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, 
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, 
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32b.google.com
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

On Mon, 16 Oct 2023 at 06:11, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 63011373ad22c794a013da69663c03f1297a5c=
56:
>
>   Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alista=
ir23/qemu into staging (2023-10-12 10:24:44 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/juan.quintela/qemu.git tags/migration-20231016-pull-=
request
>
> for you to fetch changes up to f39b0f42753635b0f2d8b00a26d11bb197bf51e2:
>
>   migration/multifd: Clarify Error usage in multifd_channel_connect (2023=
-10-16 11:01:33 +0200)
>
> ----------------------------------------------------------------
> Migration Pull request (20231016)
>
> In this pull request:
> - rdma cleanups
> - removal of QEMUFileHook
> - test for analyze-migration.py
> - test for multifd file
> - multifd cleanups
> - available switchover bandwidth
> - lots of cleanups.
>
> CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1037878829
>
> Please, apply.

This CI failure looks migration-related:

MALLOC_PERTURB_=3D96
PYTHON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/pyve=
nv/bin/python3
QTEST_QEMU_BINARY=3D./qemu-system-i386
G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qem=
u/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_IMG=3D./qemu-img
QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/m=
igration-test
--tap -k
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
**
ERROR:../tests/qtest/migration-test.c:1969:file_offset_finish_hook:
assertion failed (cpu_to_be32(*p) =3D=3D QEMU_VM_FILE_MAGIC): (3 =3D=3D
1363498573)

https://gitlab.com/qemu-project/qemu/-/jobs/5301793548

Stefan

>
> ----------------------------------------------------------------
>
> Dmitry Frolov (1):
>   migration: fix RAMBlock add NULL check
>
> Elena Ufimtseva (3):
>   migration: check for rate_limit_max for RATE_LIMIT_DISABLED
>   multifd: fix counters in multifd_send_thread
>   multifd: reset next_packet_len after sending pages
>
> Fabiano Rosas (13):
>   migration: Fix analyze-migration.py 'configuration' parsing
>   migration: Add capability parsing to analyze-migration.py
>   migration: Fix analyze-migration.py when ignore-shared is used
>   migration: Fix analyze-migration read operation signedness
>   tests/qtest/migration: Add a test for the analyze-migration script
>   tests/qtest: migration-test: Add tests for file-based migration
>   migration/ram: Remove RAMState from xbzrle_cache_zero_page
>   migration/ram: Stop passing QEMUFile around in save_zero_page
>   migration/ram: Move xbzrle zero page handling into save_zero_page
>   migration/ram: Merge save_zero_page functions
>   migration/multifd: Remove direct "socket" references
>   migration/multifd: Unify multifd_send_thread error paths
>   migration/multifd: Clarify Error usage in multifd_channel_connect
>
> Fiona Ebner (1):
>   migration: hold the BQL during setup
>
> Juan Quintela (15):
>   migration: Non multifd migration don't care about multifd flushes
>   migration: Create migrate_rdma()
>   migration/rdma: Unfold ram_control_before_iterate()
>   migration/rdma: Unfold ram_control_after_iterate()
>   migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>   migration/rdma: Unfold hook_ram_load()
>   migration/rdma: Create rdma_control_save_page()
>   qemu-file: Remove QEMUFileHooks
>   migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>   migration/rdma: Remove qemu_ prefix from exported functions
>   migration/rdma: Check sooner if we are in postcopy for save_page()
>   migration/rdma: Use i as for index instead of idx
>   migration/rdma: Declare for index variables local
>   migration/rdma: Remove all "ret" variables that are used only once
>   migration: Improve json and formatting
>
> Nikolay Borisov (2):
>   migration: Add the configuration vmstate to the json writer
>   migration/ram: Refactor precopy ram loading code
>
> Peter Xu (1):
>   migration: Allow user to specify available switchover bandwidth
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   migration: Use g_autofree to simplify ram_dirty_bitmap_reload()
>
> Wei Wang (1):
>   migration: refactor migration_completion
>
>  qapi/migration.json            |  41 ++++-
>  include/migration/register.h   |   2 +-
>  migration/migration.h          |   4 +-
>  migration/options.h            |   2 +
>  migration/qemu-file.h          |  49 ------
>  migration/rdma.h               |  42 +++++
>  migration/block-dirty-bitmap.c |   3 -
>  migration/block.c              |   5 -
>  migration/migration-hmp-cmds.c |  14 ++
>  migration/migration-stats.c    |   9 +-
>  migration/migration.c          | 199 +++++++++++++--------
>  migration/multifd.c            | 101 +++++------
>  migration/options.c            |  35 ++++
>  migration/qemu-file.c          |  61 +------
>  migration/ram.c                | 306 ++++++++++++++++++---------------
>  migration/rdma.c               | 259 ++++++++++++----------------
>  migration/savevm.c             |  22 ++-
>  tests/qtest/migration-test.c   | 207 ++++++++++++++++++++++
>  migration/trace-events         |  33 ++--
>  scripts/analyze-migration.py   |  67 +++++++-
>  tests/qtest/meson.build        |   2 +
>  21 files changed, 895 insertions(+), 568 deletions(-)
>
> --
> 2.41.0
>
>

