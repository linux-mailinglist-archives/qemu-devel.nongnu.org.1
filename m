Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5131B04740
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 20:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNde-000551-Vh; Mon, 14 Jul 2025 14:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubMZc-0004yM-AG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:02:50 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubMZY-0002QB-G4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:02:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgpSP15X9z6L5Nj;
 Tue, 15 Jul 2025 00:59:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 993BC140142;
 Tue, 15 Jul 2025 01:02:28 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Jul
 2025 19:02:28 +0200
Date: Mon, 14 Jul 2025 18:02:26 +0100
To: Fan Ni <nifan.cxl@gmail.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Anisa Su
 <anisa.su@samsung.com>
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <20250714180226.0000562d@huawei.com>
In-Reply-To: <aHU0K4bXbPLsed5t@lg>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
 <20250714052757-mutt-send-email-mst@kernel.org>
 <20250714150218.00006c95@huawei.com>
 <20250714151512.00000a2a@huawei.com>
 <20250714151638.000038ac@huawei.com> <aHU0K4bXbPLsed5t@lg>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 14 Jul 2025 09:45:31 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Mon, Jul 14, 2025 at 03:16:38PM +0100, Jonathan Cameron wrote:
> > On Mon, 14 Jul 2025 15:15:12 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >  =20
> > > On Mon, 14 Jul 2025 15:02:18 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >  =20
> > > > On Mon, 14 Jul 2025 05:32:19 -0400
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >    =20
> > > > > On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:=
     =20
> > > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > > >=20
> > > > > > FM DCD Management command 0x5602 implemented per CXL r3.2 Spec =
Section 7.6.7.6.3
> > > > > >=20
> > > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  =
   =20
> > > >=20
> > > >    =20
> > > > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-ut=
ils.c
> > > > > > index bf1710b251..1fc453f70d 100644
> > > > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > > > +++ b/hw/cxl/cxl-mailbox-utils.c     =20
> > > >    =20
> > > > > > +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuratio=
n (Opcode 5602) */
> > > > > > +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl=
_cmd *cmd,
> > > > > > +                                              uint8_t *payload=
_in,
> > > > > > +                                              size_t len_in,
> > > > > > +                                              uint8_t *payload=
_out,
> > > > > > +                                              size_t *len_out,
> > > > > > +                                              CXLCCI *cci)
> > > > > > +{
> > > > > > +    struct {
> > > > > > +        uint8_t reg_id;
> > > > > > +        uint8_t rsvd[3];
> > > > > > +        uint64_t block_sz;
> > > > > > +        uint8_t flags;
> > > > > > +        uint8_t rsvd2[3];
> > > > > > +    } QEMU_PACKED *in =3D (void *)payload_in;
> > > > > > +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> > > > > > +    CXLEventDynamicCapacity dcEvent =3D {};
> > > > > > +    CXLDCRegion *region =3D &ct3d->dc.regions[in->reg_id];
> > > > > > +
> > > > > > +    /*
> > > > > > +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> > > > > > +     * This command shall fail with Unsupported when the Sanit=
ize on Release
> > > > > > +     * field does not match the region=E2=80=99s configuration=
... and the device
> > > > > > +     * does not support reconfiguration of the Sanitize on Rel=
ease setting.
> > > > > > +     *
> > > > > > +     * Currently not reconfigurable, so always fail if sanitiz=
e bit (bit 0)
> > > > > > +     * doesn't match.
> > > > > > +     */
> > > > > > +    if ((in->flags & 0x1) !=3D (region->flags & 0x1)) {
> > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (in->reg_id >=3D DCD_MAX_NUM_REGION) {
> > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > +    }
> > > > > > +
> > > > > > +    /* Check that no extents are in the region being reconfigu=
red */
> > > > > > +    if (!bitmap_empty(region->blk_bitmap, region->len / region=
->block_size)) {
> > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > +    }
> > > > > > +
> > > > > > +    /* Check that new block size is supported */
> > > > > > +    if (!test_bit(BIT((int) log2(in->block_sz)),
> > > > > > +                  &region->supported_blk_size_bitmask)) {
> > > > > > +        return CXL_MBOX_INVALID_INPUT;
> > > > > > +    }       =20
> > > > >=20
> > > > > This does not work: test_bit works on unsigned long, while
> > > > > supported_blk_size_bitmask is uint64_t.
> > > > >=20
> > > > > Why so funky? what is wrong with:
> > > > >=20
> > > > > if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bi=
tmask))
> > > > >=20
> > > > > And BTW why cast to int here?     =20
> > > This became obvious when your suggestion didn't build :(
> > >=20
> > > ./../hw/cxl/cxl-mailbox-utils.c: In function =E2=80=98cmd_fm_set_dc_r=
egion_config=E2=80=99:
> > > /home/jic23/src/qemu/include/qemu/bitops.h:25:39: error: invalid oper=
ands to binary << (have =E2=80=98long long unsigned int=E2=80=99 and =E2=80=
=98double=E2=80=99)
> > >    25 | #define BIT_ULL(nr)             (1ULL << (nr))
> > >       |                                       ^~ ~~~~
> > > ../../hw/cxl/cxl-mailbox-utils.c:3436:11: note: in expansion of macro=
 =E2=80=98BIT_ULL=E2=80=99
> > >  3436 |     if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk=
_size_bitmask)) {
> > >       |           ^~~~~~~
> > >=20
> > > Now I look again, this is effectively 2**(log_2(x)) or x. So
> > > if (in->block_sz & region->supporte_blk_size_bitmask) =20
> >=20
> > it (!(in->block_sz & region->supports_blk_size_bitmask))
> >=20
> > I mean. =20
>=20
> Make sense to me.=20
>=20
> The only thing is how to detect the violation if the passed in block_sz
> is not power of 2.
> Or who will do the check if not in qemu?
Hi Fan,

I checked the spec on this.  There isn't an explicit statement that the dev=
ice
should return an error on this. Looks to be impdef. I'd happily see such
a check as a usability improvement though!

I'm just not set up to test this right now so decided to be
risk averse and not trying adding one.=20

If you want to send a patch on top I'd be happy to add it.

Jonathan



>=20
> Fan
>=20
> >=20
> >  =20
> > > Should work as long as we know block_size is a power of 2 (which the =
specification
> > > says it must be).
> > >=20
> > > Anisa?
> > >  =20
> > > >=20
> > > > Change looks fine to me, so I'll prepare an updated set with this
> > > > and the missing semi colon.  Anisa if you can have a look at this
> > > > that would be great.=20
> > > >=20
> > > > Sorry I seem to have missed Anisa off the cc for this!
> > > >=20
> > > > Jonathan
> > > >    =20
> > >  =20
> >  =20
>=20


