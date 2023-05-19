Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE67095FB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 13:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzxyH-0005xZ-Hd; Fri, 19 May 2023 07:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzxyE-0005wx-IN
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:08:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzxy7-0001eG-Uw
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:08:22 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN3tB2dD1z6D94r;
 Fri, 19 May 2023 19:05:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 12:07:45 +0100
Date: Fri, 19 May 2023 12:07:44 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira Weiny
 <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Michael
 Roth <michael.roth@amd.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud?=
 =?ISO-8859-1?Q?=E9?= <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Markus Armbruster <armbru@redhat.com>, "Daniel P .
 =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v5 0/6] hw/cxl: Poison get, inject, clear
Message-ID: <20230519120744.00005063@Huawei.com>
In-Reply-To: <20230519030942-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
 <20230519030942-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 19 May 2023 04:49:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Apr 23, 2023 at 05:20:07PM +0100, Jonathan Cameron wrote:
> > v5: More details in each patch.
> >  - Simpler algorithm to find entry when clearing.
> >  - Improvements to debugability and docs for 24 bit endian functions.
> >  - Use of ROUND_DOWN() to simplify the various alignment questions.
> >  - Use CXL_CACHELINE_SIZE define to explain the mysterious 64 byte
> >    granularity
> >  - Use memory_region_size() instead of direct accesses. =20
>=20
>=20
> picked first 3 but dropped the rest for now due to build errors.
Drop the bswap one as well for now.
s390 is trying to call __builtin_bswap24 which clearly doesn't exist
- though you won't see that without the rest of this patch set.

Might be a case of crossing with a patch set reworking this stuff
to use the compiler more, but I'm not quite sure.

I'll see if I can figure out a fix or indeed exactly how this is
being triggered.

Hindsight says we should have kept definition local to CXL and
done the 'generic' version afterwards.=20

For reference

/builds/jic23/qemu/include/qemu/bswap.h:42:32: error: implicit declaration =
of function =E2=80=98__builtin_bswap24=E2=80=99; did you mean =E2=80=98__bu=
iltin_bswap64=E2=80=99? [-Werror=3Dimplicit-function-declaration]
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                                ^~~~~~~~~~~~~~~
/builds/jic23/qemu/include/qemu/compiler.h:34:21: note: in definition of ma=
cro =E2=80=98xglue=E2=80=99
   34 | #define xglue(x, y) x ## y
      |                     ^
/builds/jic23/qemu/include/qemu/bswap.h:42:27: note: in expansion of macro =
=E2=80=98glue=E2=80=99
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                           ^~~~
/builds/jic23/qemu/include/qemu/bswap.h:322:20: note: in expansion of macro=
 =E2=80=98le_bswap=E2=80=99
  322 |     st24_he_p(ptr, le_bswap(v, 24));
      |                    ^~~~~~~~
/builds/jic23/qemu/include/qemu/bswap.h:42:32: error: nested extern declara=
tion of =E2=80=98__builtin_bswap24=E2=80=99 [-Werror=3Dnested-externs]
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                                ^~~~~~~~~~~~~~~
/builds/jic23/qemu/include/qemu/compiler.h:34:21: note: in definition of ma=
cro =E2=80=98xglue=E2=80=99
   34 | #define xglue(x, y) x ## y
      |                     ^
/builds/jic23/qemu/include/qemu/bswap.h:42:27: note: in expansion of macro =
=E2=80=98glue=E2=80=99
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                           ^~~~
/builds/jic23/qemu/include/qemu/bswap.h:322:20: note: in expansion of macro=
 =E2=80=98le_bswap=E2=80=99
  322 |     st24_he_p(ptr, le_bswap(v, 24));
      |                    ^~~~~~~~

Jonathan
=20
>=20
> > Many of the precursors listed for v4 have now been applied, but
> > a few minor fixes have come up in the meantime so there are still
> > a few precursors including the volatile support left from v4
> > precursors.
> >=20
> > Depends on=20
> > [PATCH 0/2] hw/cxl: CDAT file handling fixes.
> > [PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
> > [PATCH 0/3] docs/cxl: Gathering of fixes for 8.0 CXL docs.
> > [PATCH v5 0/3] hw/mem: CXL Type-3 Volatile Memory Support
> > =20
> > Based on: Message-ID: 20230421132020.7408-1-Jonathan.Cameron@huawei.com
> > Based on: Message-ID: 20230421135906.3515-1-Jonathan.Cameron@huawei.com
> > Based on: Message-ID: 20230421134507.26842-1-Jonathan.Cameron@huawei.com
> > Based on: Message-ID: 20230421160827.2227-1-Jonathan.Cameron@huawei.com
> >=20
> > The kernel support for Poison handling is currently in the cxl/pending
> > branch and hopefully should be in the CXL pull request next week.
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=3Dpe=
nding
> >=20
> > This code has been very useful for testing and helped identify various
> > corner cases.
> >=20
> > Updated cover letter.
> >=20
> > The series supports:
> > 1) Injection of variable length poison regions via QMP (to fake real
> >    memory corruption and ensure we deal with odd overflow corner cases
> >    such as clearing the middle of a large region making the list overfl=
ow
> >    as we go from one long entry to two smaller entries.
> > 2) Read of poison list via the CXL mailbox.
> > 3) Injection via the poison injection mailbox command (limited to 64 by=
te
> >    entries - spec constraint)
> > 4) Clearing of poison injected via either method.
> >=20
> > The implementation is meant to be a valid combination of impdef choices
> > based on what the spec allowed. There are a number of places where it c=
ould
> > be made more sophisticated that we might consider in future:
> > * Fusing adjacent poison entries if the types match.
> > * Separate injection list and main poison list, to test out limits on
> >   injected poison list being smaller than the main list.
> > * Poison list overflow event (needs event log support in general)
> > * Connecting up to the poison list error record generation (rather comp=
lex
> >   and not needed for currently kernel handling testing).
> > * Triggering the synchronous and asynchronous errors that occur on reads
> >   and writes of the memory when the host receives poison.
> >=20
> > As the kernel code is currently fairly simple, it is likely that the ab=
ove
> > does not yet matter but who knows what will turn up in future!
> >=20
> >=20
> > Ira Weiny (2):
> >   hw/cxl: Introduce cxl_device_get_timestamp() utility function
> >   bswap: Add the ability to store to an unaligned 24 bit field
> >=20
> > Jonathan Cameron (4):
> >   hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
> >   hw/cxl: QMP based poison injection support
> >   hw/cxl: Add poison injection via the mailbox.
> >   hw/cxl: Add clear poison mailbox command support.
> >=20
> >  docs/devel/loads-stores.rst |   1 +
> >  hw/cxl/cxl-device-utils.c   |  15 ++
> >  hw/cxl/cxl-mailbox-utils.c  | 289 ++++++++++++++++++++++++++++++------
> >  hw/mem/cxl_type3.c          |  93 ++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |   6 +
> >  include/hw/cxl/cxl.h        |   1 +
> >  include/hw/cxl/cxl_device.h |  23 +++
> >  include/qemu/bswap.h        |  25 ++++
> >  qapi/cxl.json               |  18 +++
> >  9 files changed, 429 insertions(+), 42 deletions(-)
> >=20
> > --=20
> > 2.37.2 =20
>=20


