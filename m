Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172677CBC2C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qseRj-0003as-7L; Tue, 17 Oct 2023 03:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qseRg-0003aP-QO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qseRa-0001E3-TJ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697527484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIZIdED5swPiCZl/uMiQiWNQ4XUZ54clhkSPOBEH2wI=;
 b=LYBBE9Qjg8NNrX1JpHa8pqTXOna1qpOWqwypkEz3SdF6OX69QX7mx89nudjcTjWJ+7jA4m
 EaLjMzz//GkKMY8KfadLEpH0m9hyiJUcy+5bYqG3/x2fgKjQCB9ssh1flKeGlCw2LX3aZ4
 l1a4NZWdPhuAR6glT4OkSxCisURfSKA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-qTvANZKBM3iJet4K3KJMeQ-1; Tue, 17 Oct 2023 03:24:28 -0400
X-MC-Unique: qTvANZKBM3iJet4K3KJMeQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c5161838d8so23761561fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697527467; x=1698132267;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XIZIdED5swPiCZl/uMiQiWNQ4XUZ54clhkSPOBEH2wI=;
 b=m5UVVGSNUk/CJXG+51KkRQLJleT/E7LMT5sPVzskWTDeJC+uAs4ld8pcCWpnJn0wxa
 ggqT9UG9OvMQyeNHyMh5H3FVNADoTyJki+QOq5ZRzipBo+cbhkgCjdGRpK4ho8t+C3sC
 m5C+CzldXe/XOr7Rgez2wvmaVijWngpyqIINVJjfuvotNt/dYTYEZF61Mlg1N71RxoXm
 Gmw3vtYA+hk9zcw3ReyO+Eiuzuc3hZGv15PMAY1UVHMk8dwr7EIJi+VfooHbRr6Eir75
 ZCblZsDVaXD7oUl5g/aK9TmL9vZgF7+7O9T6aW+Krc8w2bpKFAnXQFiea4yaYSmvQgWE
 P2YQ==
X-Gm-Message-State: AOJu0Yxbw+/4C1KNmdLUDRpaw0wV0l5A0/o11UxuLZ2lJ2sYmf3xDtj6
 a5VjbznnYu9SPmilj2SwI2kymzi/gOhFaFukgxkEpNAl+uRT4RDYdGLjFRgGQsmPvnDxe3/WiNt
 dPf7+fuPt7UspOvQ=
X-Received: by 2002:a2e:908d:0:b0:2bd:1804:29fa with SMTP id
 l13-20020a2e908d000000b002bd180429famr1074220ljg.39.1697527466748; 
 Tue, 17 Oct 2023 00:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE/AJV1F83DWPLW9m4ADeshkBZ4VEH3QbUT9u5WV4BFxJf3Akt2hiq++/juM5XHuKnQJFkkw==
X-Received: by 2002:a2e:908d:0:b0:2bd:1804:29fa with SMTP id
 l13-20020a2e908d000000b002bd180429famr1074191ljg.39.1697527466333; 
 Tue, 17 Oct 2023 00:24:26 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bg24-20020a05600c3c9800b004053e9276easm9219537wmb.32.2023.10.17.00.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 00:24:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Fam Zheng <fam@euphon.net>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>,  Peter Xu <peterx@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  John Snow <jsnow@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PULL 00/38] Migration 20231016 patches
In-Reply-To: <CAJSP0QXkTvJnioak5X1Ya3CC6LmiriFqYhyUV+AJ4=JS4SK97w@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 16 Oct 2023 12:31:33 -0400")
References: <20231016100706.2551-1-quintela@redhat.com>
 <CAJSP0QXkTvJnioak5X1Ya3CC6LmiriFqYhyUV+AJ4=JS4SK97w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 09:24:25 +0200
Message-ID: <877cnl3e52.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, 16 Oct 2023 at 06:11, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit 63011373ad22c794a013da69663c03f1297a5=
c56:
>>
>>   Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alist=
air23/qemu into staging (2023-10-12 10:24:44 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/juan.quintela/qemu.git tags/migration-20231016-pull=
-request
>>
>> for you to fetch changes up to f39b0f42753635b0f2d8b00a26d11bb197bf51e2:
>>
>>   migration/multifd: Clarify Error usage in multifd_channel_connect (202=
3-10-16 11:01:33 +0200)
>>
>> ----------------------------------------------------------------
>> Migration Pull request (20231016)
>>
>> In this pull request:
>> - rdma cleanups
>> - removal of QEMUFileHook
>> - test for analyze-migration.py
>> - test for multifd file
>> - multifd cleanups
>> - available switchover bandwidth
>> - lots of cleanups.
>>
>> CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1037878829
>>
>> Please, apply.
>
> This CI failure looks migration-related:

It is.

> MALLOC_PERTURB_=3D96
> PYTHON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/py=
venv/bin/python3
> QTEST_QEMU_BINARY=3D./qemu-system-i386
> G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/q=
emu/tests/dbus-vmstate-daemon.sh
> QTEST_QEMU_IMG=3D./qemu-img
> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
> /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest=
/migration-test
> --tap -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> **
> ERROR:../tests/qtest/migration-test.c:1969:file_offset_finish_hook:
> assertion failed (cpu_to_be32(*p) =3D=3D QEMU_VM_FILE_MAGIC): (3 =3D=3D
> 1363498573)
>
> https://gitlab.com/qemu-project/qemu/-/jobs/5301793548

But what I am doing wrong here?
This time I even posnted the CI link that I passed O:-)

I thought that if I pass the:

$ git push -o ci.variable=3DQEMU_CI=3D2

on my branch, I was doing all the testing that you are doing.  Clearly
not.

Thanks, Juan.


> Stefan
>
>>
>> ----------------------------------------------------------------
>>
>> Dmitry Frolov (1):
>>   migration: fix RAMBlock add NULL check
>>
>> Elena Ufimtseva (3):
>>   migration: check for rate_limit_max for RATE_LIMIT_DISABLED
>>   multifd: fix counters in multifd_send_thread
>>   multifd: reset next_packet_len after sending pages
>>
>> Fabiano Rosas (13):
>>   migration: Fix analyze-migration.py 'configuration' parsing
>>   migration: Add capability parsing to analyze-migration.py
>>   migration: Fix analyze-migration.py when ignore-shared is used
>>   migration: Fix analyze-migration read operation signedness
>>   tests/qtest/migration: Add a test for the analyze-migration script
>>   tests/qtest: migration-test: Add tests for file-based migration
>>   migration/ram: Remove RAMState from xbzrle_cache_zero_page
>>   migration/ram: Stop passing QEMUFile around in save_zero_page
>>   migration/ram: Move xbzrle zero page handling into save_zero_page
>>   migration/ram: Merge save_zero_page functions
>>   migration/multifd: Remove direct "socket" references
>>   migration/multifd: Unify multifd_send_thread error paths
>>   migration/multifd: Clarify Error usage in multifd_channel_connect
>>
>> Fiona Ebner (1):
>>   migration: hold the BQL during setup
>>
>> Juan Quintela (15):
>>   migration: Non multifd migration don't care about multifd flushes
>>   migration: Create migrate_rdma()
>>   migration/rdma: Unfold ram_control_before_iterate()
>>   migration/rdma: Unfold ram_control_after_iterate()
>>   migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>>   migration/rdma: Unfold hook_ram_load()
>>   migration/rdma: Create rdma_control_save_page()
>>   qemu-file: Remove QEMUFileHooks
>>   migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>>   migration/rdma: Remove qemu_ prefix from exported functions
>>   migration/rdma: Check sooner if we are in postcopy for save_page()
>>   migration/rdma: Use i as for index instead of idx
>>   migration/rdma: Declare for index variables local
>>   migration/rdma: Remove all "ret" variables that are used only once
>>   migration: Improve json and formatting
>>
>> Nikolay Borisov (2):
>>   migration: Add the configuration vmstate to the json writer
>>   migration/ram: Refactor precopy ram loading code
>>
>> Peter Xu (1):
>>   migration: Allow user to specify available switchover bandwidth
>>
>> Philippe Mathieu-Daud=C3=A9 (1):
>>   migration: Use g_autofree to simplify ram_dirty_bitmap_reload()
>>
>> Wei Wang (1):
>>   migration: refactor migration_completion
>>
>>  qapi/migration.json            |  41 ++++-
>>  include/migration/register.h   |   2 +-
>>  migration/migration.h          |   4 +-
>>  migration/options.h            |   2 +
>>  migration/qemu-file.h          |  49 ------
>>  migration/rdma.h               |  42 +++++
>>  migration/block-dirty-bitmap.c |   3 -
>>  migration/block.c              |   5 -
>>  migration/migration-hmp-cmds.c |  14 ++
>>  migration/migration-stats.c    |   9 +-
>>  migration/migration.c          | 199 +++++++++++++--------
>>  migration/multifd.c            | 101 +++++------
>>  migration/options.c            |  35 ++++
>>  migration/qemu-file.c          |  61 +------
>>  migration/ram.c                | 306 ++++++++++++++++++---------------
>>  migration/rdma.c               | 259 ++++++++++++----------------
>>  migration/savevm.c             |  22 ++-
>>  tests/qtest/migration-test.c   | 207 ++++++++++++++++++++++
>>  migration/trace-events         |  33 ++--
>>  scripts/analyze-migration.py   |  67 +++++++-
>>  tests/qtest/meson.build        |   2 +
>>  21 files changed, 895 insertions(+), 568 deletions(-)
>>
>> --
>> 2.41.0
>>
>>


