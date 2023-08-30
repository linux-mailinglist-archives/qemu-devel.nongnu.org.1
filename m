Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1117D78D594
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:36:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJUP-0003xw-Hd; Wed, 30 Aug 2023 07:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbJUO-0003xf-2k; Wed, 30 Aug 2023 07:36:00 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbJUL-00018e-9z; Wed, 30 Aug 2023 07:35:59 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-571194584e2so3372603eaf.3; 
 Wed, 30 Aug 2023 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693395355; x=1694000155; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zyvfr6+5lz4z4IhLqPbzE/UUu172eFJMIVuRt4uBNbc=;
 b=FHJ2LEsGdK7JvtC9gmnt6FyTxk5UyhdsiW9yqtf6QxbQiAj9LfEBpuBaHU1ZrIebCo
 OQ4JvG9Y20mvfZX9s/gUyPht618halz4Zc5466Ckdrgjp9UnI7YGNVlOlHTjEAs2KMAY
 OfHP/7krcc4GeUcj8cLe113KwAG83EoetG7yxy/gjaxz06PNOgEgYeb9uiuSX57masuv
 vFUUWzkq1j8LA4pVC2QXNAF1vrsYoXrC8RE+QdB/2/wlyNi6JLaT/iiXcA4XUDTAqAtL
 rQU81KQaSHhMg+mXgVd/4/Ewuuo6DNWdJDseRpkuETZU+GUqGJBdzsc+sDiupp6/3PAS
 I35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693395355; x=1694000155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zyvfr6+5lz4z4IhLqPbzE/UUu172eFJMIVuRt4uBNbc=;
 b=LrKUqozR/h2hQcyQnS1JmhFnmPJQlvLNz8A2LwWs+ol3zqhFgw0ElyZdgHzPlfPujD
 ElyhTPaTov93rpKVAjpeTxoVtVPQeuG4twqVF2lRw1PjaRUtzdXBVtB6AQ+KXpwjFpbV
 d61K+vynlioB7SMiNK5KcTPhXnrdG5eZ3JwVo34cenbf/gT0qCQMtr/5tsypm/6UDcit
 WacWqu8YOceLbIUGt7P+2jpz/d4OZ3kvGafxA1emccXJP9SSY3ZunScp20lgKbdy/7HP
 EHqrX1FboJ945g+kbaoHc9ianQQHb5nX2jgoW2Pq3zeEh+ym9+0D35NCDW2cKeCT7DVa
 wONg==
X-Gm-Message-State: AOJu0Ywlfid/xH5Nt0trW/z0/lJIhUMxuTYbyzrm+PYNL/LmTSU63rhC
 BiYJL9iJpjkezSLmyozjZgnt1HSOAPMi8XH/mpI=
X-Google-Smtp-Source: AGHT+IFYsZ2TBPOAuhp8uwDVgXDoMkd2rNmLOjEfkEOvIDZsFtXWXkPnPfpyaSsJ9vlQswRV4+r09cX6pBLbzi3ndXw=
X-Received: by 2002:a05:6820:53:b0:56c:7428:4a35 with SMTP id
 v19-20020a056820005300b0056c74284a35mr1473014oob.7.1693395355058; Wed, 30 Aug
 2023 04:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691062912.git.jeuk20.kim@samsung.com>
In-Reply-To: <cover.1691062912.git.jeuk20.kim@samsung.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Aug 2023 07:35:43 -0400
Message-ID: <CAJSP0QUrJTOKw-005Kz_uF3YhFmysHimq3gaxYY-1vLmO-HC5g@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com, 
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com, 
 qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, thuth@redhat.com, lvivier@redhat.com, 
 jeuk20.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
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

On Thu, 3 Aug 2023 at 07:49, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>
> Dear Stefan,
> I'm really sorry, but could you please put this patch series
> instead of v8, which was previously merged into block-next?
> The fixes from v8 are below.
> Please let me know if you have any comments or issues.

Hi,
This series fails to compile for win32. I have dropped it from my queue.

You can use "make docker-test-build@fedora-win32-cross" to run a win32
build locally on a Linux host. Please take a look and I'll merge it
again when the build issue is fixed.

Thanks!

https://gitlab.com/qemu-project/qemu/-/jobs/4977255992

In file included from /usr/i686-w64-mingw32/sys-root/mingw/include/windows.h:72,
from /usr/i686-w64-mingw32/sys-root/mingw/include/winsock2.h:23,
from /builds/qemu-project/qemu/include/sysemu/os-win32.h:29,
from /builds/qemu-project/qemu/include/qemu/osdep.h:160,
from ../hw/ufs/lu.c:11:
/builds/qemu-project/qemu/include/block/ufs.h:456:5: error: expected
identifier before numeric constant
456 | PWR_OK = 0x0,
| ^~~~~~
[1657/3707] Compiling C object libcommon.fa.p/hw_ufs_ufs.c.obj
FAILED: libcommon.fa.p/hw_ufs_ufs.c.obj
i686-w64-mingw32-gcc -m32 -Ilibcommon.fa.p -Isubprojects/dtc/libfdt
-I../subprojects/dtc/libfdt
-I/usr/i686-w64-mingw32/sys-root/mingw/include/pixman-1
-I/usr/i686-w64-mingw32/sys-root/mingw/include/libpng16
-I/usr/i686-w64-mingw32/sys-root/mingw/include/p11-kit-1
-I/usr/i686-w64-mingw32/sys-root/mingw/include/SDL2
-I/usr/i686-w64-mingw32/sys-root/mingw/include/glib-2.0
-I/usr/i686-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
-I/usr/i686-w64-mingw32/sys-root/mingw/include/gtk-3.0
-I/usr/i686-w64-mingw32/sys-root/mingw/include/pango-1.0
-I/usr/i686-w64-mingw32/sys-root/mingw/include/harfbuzz
-I/usr/i686-w64-mingw32/sys-root/mingw/include/freetype2
-I/usr/i686-w64-mingw32/sys-root/mingw/include/fribidi
-I/usr/i686-w64-mingw32/sys-root/mingw/include/cairo
-I/usr/i686-w64-mingw32/sys-root/mingw/include/gdk-pixbuf-2.0
-I/usr/i686-w64-mingw32/sys-root/mingw/include/atk-1.0
-I/usr/i686-w64-mingw32/sys-root/mingw/include/webp
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g
-fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
-Wstrict-prototypes -Wredundant-decls -Wold-style-declaration
-Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
-Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
-Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
-Wmissing-format-attribute -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-psabi -iquote . -iquote
/builds/qemu-project/qemu -iquote /builds/qemu-project/qemu/include
-iquote /builds/qemu-project/qemu/host/include/i386 -iquote
/builds/qemu-project/qemu/host/include/generic -iquote
/builds/qemu-project/qemu/tcg/i386 -mms-bitfields -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fno-pie -no-pie -mms-bitfields -mms-bitfields
-mms-bitfields -Dmain=SDL_main -MD -MQ libcommon.fa.p/hw_ufs_ufs.c.obj
-MF libcommon.fa.p/hw_ufs_ufs.c.obj.d -o
libcommon.fa.p/hw_ufs_ufs.c.obj -c ../hw/ufs/ufs.c
In file included from /usr/i686-w64-mingw32/sys-root/mingw/include/windows.h:72,
from /usr/i686-w64-mingw32/sys-root/mingw/include/winsock2.h:23,
from /builds/qemu-project/qemu/include/sysemu/os-win32.h:29,
from /builds/qemu-project/qemu/include/qemu/osdep.h:160,
from ../hw/ufs/ufs.c:24:
/builds/qemu-project/qemu/include/block/ufs.h:456:5: error: expected
identifier before numeric constant
456 | PWR_OK = 0x0,
| ^~~~~~
In file included from /builds/qemu-project/qemu/include/block/ufs.h:6,
from ../hw/ufs/ufs.h:16,
from ../hw/ufs/ufs.c:28:
../hw/ufs/ufs.c: In function 'ufs_process_uiccmd':
../hw/ufs/ufs.c:310:58: error: 'PWR_LOCAL' undeclared (first use in
this function)
310 | u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UPMCRS, PWR_LOCAL);
| ^~~~~~~~~
/builds/qemu-project/qemu/include/hw/registerfields.h:104:19: note: in
definition of macro 'FIELD_DP32'
104 | } _v = { .v = val }; \
| ^~~
../hw/ufs/ufs.c:310:58: note: each undeclared identifier is reported
only once for each function it appears in
310 | u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UPMCRS, PWR_LOCAL);
| ^~~~~~~~~
/builds/qemu-project/qemu/include/hw/registerfields.h:104:19: note: in
definition of macro 'FIELD_DP32'
104 | } _v = { .v = val }; \
| ^~~

