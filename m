Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7367C75C9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 20:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr0Jo-0005hD-Ee; Thu, 12 Oct 2023 14:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qr0Jc-0005aL-N9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 14:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qr0Ja-00050I-Vn
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 14:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697134902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHnpoutRta9eN/Q+k6ekHzHSnkfw+xNtdAuIYrLEsMI=;
 b=ICd40d2jH0edIyRlnWs470kmvugGXPvLKvhGjn5aMCMAvWUfC7NtZ83f5BDvxsYFchoYJt
 RJZAgo/ERHHL7X2AM4OVkNbWA86VrNdYgcAuzpORwRoMbP/U5mBqrn4oIfsBO15D0ansY4
 2gXz9Ua0NiA5/Ll80St9r8rfrH/zkag=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-XCDNzBy2OZ6zxNUyTkccTg-1; Thu, 12 Oct 2023 14:21:35 -0400
X-MC-Unique: XCDNzBy2OZ6zxNUyTkccTg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5895d0eaf19so885277a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697134894; x=1697739694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHnpoutRta9eN/Q+k6ekHzHSnkfw+xNtdAuIYrLEsMI=;
 b=BDf08798SfSzI1Lt+xmck3irf1UxbTLk0s9NuvKdNvWH5RWDXtEYtfAs9cvWGFCdFo
 8ZthL+grqvKCvB60uvXPa40XEVM0Z4SpUVM3jGFsfjgg8zjsm4mLknOpl+j6VC40agD2
 U9N6P1UU9IMI/eBumy0CK144nN9RYSgZ+uSV8skXXX29SAd0BkeQZrXgGIDPEng+MFI3
 kqRH/98s4nkaLLEn1iG739uvsfV8fMwn+PW7zJMDrYRNEIvJdZBEggwOD7GicxWjoT6S
 tBqCf5IB//POiT69v11RzTQcuDH0NYM3u/KAIvibcW0E7yK6DxnQhtXmntiXTrcWE5Ky
 x8og==
X-Gm-Message-State: AOJu0Yz3bSgEMffqqZimoz0/E3D9RmzqeGOMr/u/2q5+1JsoyDC9/8fG
 va8O9XJefsmf3ileAlXxG1/JFi61L9NotSUk/iOftOMyQYLv7eg5wHbC29dFdn6BG9av4lKJmVE
 Ft/3YALvoB0gAOdS4GkKheEGnesKswVc=
X-Received: by 2002:a05:6a21:6d98:b0:138:92ef:78f9 with SMTP id
 wl24-20020a056a216d9800b0013892ef78f9mr27025101pzb.6.1697134894477; 
 Thu, 12 Oct 2023 11:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENxya1H7x8bftKahrKPYsQdMivJUymVKvzAqOtuqXxLFHAvQd7k/4xbwwTUoXYP5aChHxiWRXJlPS9B/ACxAY=
X-Received: by 2002:a05:6a21:6d98:b0:138:92ef:78f9 with SMTP id
 wl24-20020a056a216d9800b0013892ef78f9mr27025079pzb.6.1697134894156; Thu, 12
 Oct 2023 11:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
 <CAFn=p-bxLEo-wJNv+LZDL_pVTQYKyues+C1NiQgvCzHKeqAM3g@mail.gmail.com>
 <685cac82-f465-4a7e-968d-9570b256136f@yandex-team.ru>
In-Reply-To: <685cac82-f465-4a7e-968d-9570b256136f@yandex-team.ru>
From: John Snow <jsnow@redhat.com>
Date: Thu, 12 Oct 2023 14:21:22 -0400
Message-ID: <CAFn=p-ased0cjXJBKV4CUqhB3Gz4HCUMg3ew+PTWreXCDdFOAg@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] iotests: use vm.cmd()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, crosa@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 12, 2023 at 1:52=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 12.10.23 01:04, John Snow wrote:
> > On Fri, Oct 6, 2023 at 11:41=E2=80=AFAM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> Hi all!
> >>
> >> Let's get rid of pattern
> >>
> >>      result =3D self.vm.qmp(...)
> >>      self.assert_qmp(result, 'return', {})
> >>
> >> And switch to just
> >>
> >>      self.vm.cmd(...)
> >>
> >> v7: add r-bs and small wording/grammar fixes by Eric
> >>    05: handle missed tests/avocado/machine_aspeed.py, keep r-bs
> >>    10: patch renamed: s/occasional/extra/
> >>    14: new
> >>    15: rebuilt with the script: some hunks are added, old are unchange=
d
> >>        (look comparison with previous version in patchew or by
> >>         git check-rebase)
> >>
> >> Vladimir Sementsov-Ogievskiy (15):
> >>    python/qemu/qmp/legacy: cmd(): drop cmd_id unused argument
> >>    qmp_shell.py: _fill_completion() use .command() instead of .cmd()
> >>    scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()
> >>    python: rename QEMUMonitorProtocol.cmd() to cmd_raw()
> >>    python/qemu: rename command() to cmd()
> >>    python/machine.py: upgrade vm.cmd() method
> >>    iotests: QemuStorageDaemon: add cmd() method like in QEMUMachine.
> >>    iotests: add some missed checks of qmp result
> >>    iotests: refactor some common qmp result checks into generic patter=
n
> >>    iotests: drop some extra semicolons
> >>    iotests: drop some extra ** in qmp() call
> >>    iotests.py: pause_job(): drop return value
> >>    tests/vm/basevm.py: use cmd() instead of qmp()
> >>    scripts: add python_qmp_updater.py
> >>    python: use vm.cmd() instead of vm.qmp() where appropriate
> >>
> >>   docs/devel/testing.rst                        |  10 +-
> >>   python/qemu/machine/machine.py                |  20 +-
> >>   python/qemu/qmp/legacy.py                     |  10 +-
> >>   python/qemu/qmp/qmp_shell.py                  |  20 +-
> >>   python/qemu/utils/qemu_ga_client.py           |   2 +-
> >>   python/qemu/utils/qom.py                      |   8 +-
> >>   python/qemu/utils/qom_common.py               |   2 +-
> >>   python/qemu/utils/qom_fuse.py                 |   6 +-
> >>   scripts/cpu-x86-uarch-abi.py                  |   8 +-
> >>   scripts/device-crash-test                     |   8 +-
> >>   scripts/python_qmp_updater.py                 | 136 +++++
> >>   scripts/render_block_graph.py                 |   8 +-
> >>   tests/avocado/avocado_qemu/__init__.py        |   4 +-
> >>   tests/avocado/cpu_queries.py                  |   5 +-
> >>   tests/avocado/hotplug_cpu.py                  |  10 +-
> >>   tests/avocado/info_usernet.py                 |   4 +-
> >>   tests/avocado/machine_arm_integratorcp.py     |   6 +-
> >>   tests/avocado/machine_aspeed.py               |  12 +-
> >>   tests/avocado/machine_m68k_nextcube.py        |   4 +-
> >>   tests/avocado/machine_mips_malta.py           |   6 +-
> >>   tests/avocado/machine_s390_ccw_virtio.py      |  28 +-
> >>   tests/avocado/migration.py                    |  10 +-
> >>   tests/avocado/pc_cpu_hotplug_props.py         |   2 +-
> >>   tests/avocado/version.py                      |   4 +-
> >>   tests/avocado/virtio_check_params.py          |   6 +-
> >>   tests/avocado/virtio_version.py               |   5 +-
> >>   tests/avocado/vnc.py                          |  16 +-
> >>   tests/avocado/x86_cpu_model_versions.py       |  13 +-
> >>   tests/migration/guestperf/engine.py           | 150 +++---
> >>   tests/qemu-iotests/030                        | 168 +++---
> >>   tests/qemu-iotests/040                        | 171 +++----
> >>   tests/qemu-iotests/041                        | 482 ++++++++--------=
--
> >>   tests/qemu-iotests/045                        |  15 +-
> >>   tests/qemu-iotests/055                        |  62 +--
> >>   tests/qemu-iotests/056                        |  77 ++-
> >>   tests/qemu-iotests/093                        |  42 +-
> >>   tests/qemu-iotests/118                        | 225 ++++----
> >>   tests/qemu-iotests/124                        | 102 ++--
> >>   tests/qemu-iotests/129                        |  14 +-
> >>   tests/qemu-iotests/132                        |   5 +-
> >>   tests/qemu-iotests/139                        |  45 +-
> >>   tests/qemu-iotests/147                        |  30 +-
> >>   tests/qemu-iotests/151                        | 103 ++--
> >>   tests/qemu-iotests/152                        |   8 +-
> >>   tests/qemu-iotests/155                        |  55 +-
> >>   tests/qemu-iotests/165                        |   8 +-
> >>   tests/qemu-iotests/196                        |   3 +-
> >>   tests/qemu-iotests/205                        |   6 +-
> >>   tests/qemu-iotests/218                        | 105 ++--
> >>   tests/qemu-iotests/245                        | 245 ++++-----
> >>   tests/qemu-iotests/256                        |  34 +-
> >>   tests/qemu-iotests/257                        |  36 +-
> >>   tests/qemu-iotests/264                        |  31 +-
> >>   tests/qemu-iotests/281                        |  21 +-
> >>   tests/qemu-iotests/295                        |  16 +-
> >>   tests/qemu-iotests/296                        |  21 +-
> >>   tests/qemu-iotests/298                        |  13 +-
> >>   tests/qemu-iotests/300                        |  54 +-
> >>   tests/qemu-iotests/iotests.py                 |  21 +-
> >>   .../tests/backing-file-invalidation           |  11 +-
> >>   tests/qemu-iotests/tests/copy-before-write    |  15 +-
> >>   .../tests/export-incoming-iothread            |   6 +-
> >>   .../qemu-iotests/tests/graph-changes-while-io |  18 +-
> >>   tests/qemu-iotests/tests/image-fleecing       |   3 +-
> >>   .../tests/migrate-bitmaps-postcopy-test       |  31 +-
> >>   tests/qemu-iotests/tests/migrate-bitmaps-test |  45 +-
> >>   .../qemu-iotests/tests/migrate-during-backup  |  41 +-
> >>   .../qemu-iotests/tests/migration-permissions  |   9 +-
> >>   .../tests/mirror-ready-cancel-error           |  74 ++-
> >>   tests/qemu-iotests/tests/mirror-top-perms     |  16 +-
> >>   tests/qemu-iotests/tests/nbd-multiconn        |  12 +-
> >>   tests/qemu-iotests/tests/reopen-file          |   3 +-
> >>   .../qemu-iotests/tests/stream-error-on-reset  |   6 +-
> >>   .../qemu-iotests/tests/stream-under-throttle  |   7 +-
> >>   tests/vm/basevm.py                            |   4 +-
> >>   75 files changed, 1367 insertions(+), 1675 deletions(-)
> >>   create mode 100755 scripts/python_qmp_updater.py
> >>
> >> --
> >> 2.34.1
> >>
> >
> > I rebased this on top of my python branch today and confirmed all of
> > my python tests pass - I'm happy enough with it from the Python
> > perspective. I think it's the right thing to do, and I'm happy you did
> > it, but I can't begin to pretend I audited the rewrite script or the
> > actual output it produced - I did not.
> >
> > But:
> >
> > Reviewed-by: John Snow <jsnow@redhat.com> (Patches 1-6, Patch 13)
> > Tested-by: John Snow <jsnow@redhat.com> (All - I went patch by patch
> > and ran my Python tests and made sure nothing regressed.)
> > Acked-by: John Snow <jsnow@redhat.com> (All)
> >
>
> Thanks!
>
> Finally, is it queued, so will you send a PR?
>

Would you like me to queue this alongside my other Python changes? I
can definitely do that as long as it isn't inconvenient to
Kevin/Eric/Hannah et al, since this changes so much in iotests.
Well... Tell you what: I'll queue it up and I will send it tomorrow if
there's no objections.

--js


