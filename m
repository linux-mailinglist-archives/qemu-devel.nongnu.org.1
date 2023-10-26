Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFBB7D8394
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 15:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw0OL-0007IB-6y; Thu, 26 Oct 2023 09:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qw0OJ-0007HS-DI
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 09:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qw0OD-0008O3-VR
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 09:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698326827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dbYP/1YoZlgw4VErFzBf95J8CejPvJr73os9cC+MaY=;
 b=FQaCrqykkpWciKUXg38R82jb3isNqXAyg2czHvCLimybD/UODCDx4z37+gm3qu8NqQ+H5r
 +eZ4pevqs8Cmw6kzHsEgbNA/t0LFfEZKxyqmwlAxoMh158yZTNSX8nmniknA58EwdCrBMh
 aD/zCWE+z5OPiUHWc3VNdVz9wuu921A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Te0GfZ6OMQaiw7YqfytQRA-1; Thu, 26 Oct 2023 09:27:05 -0400
X-MC-Unique: Te0GfZ6OMQaiw7YqfytQRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD5F0101B04A;
 Thu, 26 Oct 2023 13:27:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D3D1C060AE;
 Thu, 26 Oct 2023 13:27:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6563521E6A1F; Thu, 26 Oct 2023 15:27:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,  clg@redhat.com,
 jgg@nvidia.com,  nicolinc@nvidia.com,  joao.m.martins@oracle.com,
 eric.auger@redhat.com,  peterx@redhat.com,  jasowang@redhat.com,
 kevin.tian@intel.com,  yi.l.liu@intel.com,  yi.y.sun@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 00/37] vfio: Adopt iommufd
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
Date: Thu, 26 Oct 2023 15:27:03 +0200
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com> (Zhenzhong
 Duan's message of "Thu, 26 Oct 2023 18:30:27 +0800")
Message-ID: <87o7gla508.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Zhenzhong Duan <zhenzhong.duan@intel.com> writes:

> Hi,
>
> Thanks all for giving guides and comments on previous series, here is
> the v3 of pure iommufd support part.
>
> Based on C=C3=A9dric's suggestion, this series includes an effort to remo=
ve
> spapr code from container.c, now all spapr functions are moved to spapr.c
> or spapr_pci_vfio.c, but there are still a few trival check on
> VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce many
> callbacks and duplicate code just to remove them. Some functions are moved
> to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
> spapr_pci_vfio.c is arch specific, or else we need to introduce stub
> functions to those spapr functions moved.

[...]

> qemu code: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cd=
ev_v3
> Based on vfio-next, commit id: fd0e1c8bc1

I fetched this, and get several compile errors with Clang (but not with
GCC):

    FAILED: libqemu-x86_64-softmmu.fa.p/hw_vfio_common.c.o=20
    clang -m64 -mcx16 -Ilibqemu-x86_64-softmmu.fa.p -I. -I.. -Itarget/i386 =
-I../target/i386 -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I=
/usr/include/capstone -I/usr/include/spice-server -I/usr/include/spice-1 -I=
/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -=
I/usr/include/sysprof-4 -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/inc=
lude/PCSC -fcolor-diagnostics -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 =
-g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes -W=
strict-prototypes -Wredundant-decls -Wold-style-definition -Wtype-limits -W=
format-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body =
-Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wmissing-format-att=
ribute -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-nega=
tive-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-tautological=
-type-limit-compare -Wno-psabi -Wno-gnu-variable-sized-type-not-at-end -Wth=
read-safety -isystem /work/armbru/qemu/linux-headers -isystem linux-headers=
 -iquote . -iquote /work/armbru/qemu -iquote /work/armbru/qemu/include -iqu=
ote /work/armbru/qemu/host/include/x86_64 -iquote /work/armbru/qemu/host/in=
clude/generic -iquote /work/armbru/qemu/tcg/i386 -pthread -D_GNU_SOURCE -D_=
FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common =
-fwrapv -fsanitize-coverage-allowlist=3Dinstrumentation-filter -fsanitize=
=3Dfuzzer-no-link -fPIE -isystem../linux-headers -isystemlinux-headers -DNE=
ED_CPU_H '-DCONFIG_TARGET=3D"x86_64-softmmu-config-target.h"' '-DCONFIG_DEV=
ICES=3D"x86_64-softmmu-config-devices.h"' -MD -MQ libqemu-x86_64-softmmu.fa=
.p/hw_vfio_common.c.o -MF libqemu-x86_64-softmmu.fa.p/hw_vfio_common.c.o.d =
-o libqemu-x86_64-softmmu.fa.p/hw_vfio_common.c.o -c ../hw/vfio/common.c
    ../hw/vfio/common.c:682:40: error: variable 'hostwin' is uninitialized =
when used here [-Werror,-Wuninitialized]
            hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
                                           ^~~~~~~
    ../hw/vfio/common.c:578:31: note: initialize the variable 'hostwin' to =
silence this warning
        VFIOHostDMAWindow *hostwin;
                                  ^
                                   =3D NULL
    ../hw/vfio/common.c:785:33: error: variable 'hostwin' is uninitialized =
when used here [-Werror,-Wuninitialized]
            pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
                                    ^~~~~~~
    ../hw/vfio/common.c:783:35: note: initialize the variable 'hostwin' to =
silence this warning
            VFIOHostDMAWindow *hostwin;
                                      ^
                                       =3D NULL
    2 errors generated.
    FAILED: tests/unit/test-resv-mem.p/test-resv-mem.c.o=20
    clang -m64 -mcx16 -Itests/unit/test-resv-mem.p -Itests/unit -I../tests/=
unit -I. -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib=
64/glib-2.0/include -I/usr/include/sysprof-4 -fcolor-diagnostics -Wall -Win=
valid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wundef -Wwr=
ite-strings -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wol=
d-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self=
 -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpans=
ion-to-defined -Wmissing-format-attribute -Wno-initializer-overrides -Wno-m=
issing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typ=
edef-redefinition -Wno-tautological-type-limit-compare -Wno-psabi -Wno-gnu-=
variable-sized-type-not-at-end -Wthread-safety -isystem /work/armbru/qemu/l=
inux-headers -isystem linux-headers -iquote . -iquote /work/armbru/qemu -iq=
uote /work/armbru/qemu/include -iquote /work/armbru/qemu/host/include/x86_6=
4 -iquote /work/armbru/qemu/host/include/generic -iquote /work/armbru/qemu/=
tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURC=
E -fno-strict-aliasing -fno-common -fwrapv -fsanitize-coverage-allowlist=3D=
instrumentation-filter -fsanitize=3Dfuzzer-no-link -fPIE -MD -MQ tests/unit=
/test-resv-mem.p/test-resv-mem.c.o -MF tests/unit/test-resv-mem.p/test-resv=
-mem.c.o.d -o tests/unit/test-resv-mem.p/test-resv-mem.c.o -c ../tests/unit=
/test-resv-mem.c
    ../tests/unit/test-resv-mem.c:42:9: error: variable 'i' set but not use=
d [-Werror,-Wunused-but-set-variable]
        int i =3D 0;
            ^
    1 error generated.

Delete @i, please.


