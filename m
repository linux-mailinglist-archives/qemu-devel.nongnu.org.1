Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D87C690C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqrhs-0002cL-5w; Thu, 12 Oct 2023 05:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qqrhk-0002c0-9F
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:10:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qqrhg-0001tE-UV
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:10:02 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5kKN4jHsz67CtD;
 Thu, 12 Oct 2023 17:06:48 +0800 (CST)
Received: from localhost (10.48.155.47) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 12 Oct
 2023 10:09:53 +0100
Date: Thu, 12 Oct 2023 10:09:52 +0100
To: Ani Sinha <anisinha@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/i386/cxl: ensure maxram is greater than ram size for
 calculating cxl range
Message-ID: <20231012100952.000064e2@Huawei.com>
In-Reply-To: <8E01874E-9B9D-41C5-9D88-29D9B4071BC6@redhat.com>
References: <20231011105335.42296-1-anisinha@redhat.com>
 <20231011173104.000016f5@Huawei.com>
 <8E01874E-9B9D-41C5-9D88-29D9B4071BC6@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.48.155.47]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 12 Oct 2023 10:10:36 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 11-Oct-2023, at 10:01 PM, Jonathan Cameron <Jonathan.Cameron@huawei.=
com> wrote:
> >=20
> > On Wed, 11 Oct 2023 16:23:35 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> >  =20
> >> pc_get_device_memory_range() finds the device memory size by calculati=
ng the
> >> difference between maxram and ram sizes. This calculation makes sense =
only when
> >> maxram is greater than the ram size. Make sure we check for that befor=
e calling
> >> pc_get_device_memory_range().
> >>=20
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com> =20
> >=20
> > Whilst this is similar to other cases, I can't remember or quickly work
> > out if the 'else' path here is appropriate.  Can we add something to the
> > patch description to talk about that?
> >=20
> > For reference it's:
> >=20
> > cxl_base =3D pc_above_4g_end(pcms); =20
>=20
> Leaving the alignment adjustments aside, the hotplugged memory devices ar=
e mapped starting from where the =E2=80=9Cabove_4g=E2=80=9D memory ends.
> The cxl memory starts after the region reserved for hot plugged memory de=
vices. If there is no hot plugged memory device region (maxmem =3D=3D mem),=
 the cxl memory can start right after where =E2=80=9Cabove_4g=E2=80=9D memo=
ry ends.
> See also pc_pci_hole64_start() and pc_max_used_gpa().
> I did not want to add any alignment adjustments because I was not sure if=
 it would add regression and incompatibility with older machine types.=20
>=20

Thanks for explanation.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>=20
> >  =20
> >> ---
> >> hw/i386/pc.c | 4 +++-
> >> 1 file changed, 3 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index f72e2c3b35..948c58171c 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -820,10 +820,12 @@ static void pc_get_device_memory_range(PCMachine=
State *pcms,
> >> static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
> >> {
> >>     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> >> +    MachineState *ms =3D MACHINE(pcms);
> >>     hwaddr cxl_base;
> >>     ram_addr_t size;
> >>=20
> >> -    if (pcmc->has_reserved_memory) {
> >> +    if (pcmc->has_reserved_memory &&
> >> +        (ms->ram_size < ms->maxram_size)) {
> >>         pc_get_device_memory_range(pcms, &cxl_base, &size);
> >>         cxl_base +=3D size;
> >>     } else { =20
> >  =20
>=20


