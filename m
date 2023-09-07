Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0067971BE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:28:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDAl-0004y5-Jw; Thu, 07 Sep 2023 07:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qeDAi-0004qx-Q7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:27:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qeDAa-00068P-Sh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:27:40 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RhH5c2scjz6FBlH;
 Thu,  7 Sep 2023 19:27:16 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 7 Sep
 2023 12:27:29 +0100
Date: Thu, 7 Sep 2023 12:27:28 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Message-ID: <20230907122728.00006968@huawei.com>
In-Reply-To: <d3e6506a-b553-d292-9428-25e784be0d4f@linaro.org>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
 <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
 <20230905155639.00000b3a@huawei.com>
 <20230905160607.0000366f@huawei.com>
 <d3e6506a-b553-d292-9428-25e784be0d4f@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 5 Sep 2023 18:55:23 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 5/9/23 17:06, Jonathan Cameron wrote:
> > On Tue, 5 Sep 2023 15:56:39 +0100
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >  =20
> >> On Mon, 4 Sep 2023 20:26:59 +0200
> >> Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:
> >> =20
> >>> On 4/9/23 18:47, Jonathan Cameron wrote: =20
> >>>> As an encoded version of these key configuration parameters is
> >>>> a register, provide functions to extract it again so as to avoid
> >>>> the need for duplicating the storage.
> >>>>
> >>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>> ---
> >>>>    include/hw/cxl/cxl_component.h | 14 ++++++++++++++
> >>>>    hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
> >>>>    2 files changed, 31 insertions(+)
> >>>>
> >>>> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_com=
ponent.h
> >>>> index 42c7e581a7..f0ad9cf7de 100644
> >>>> --- a/include/hw/cxl/cxl_component.h
> >>>> +++ b/include/hw/cxl/cxl_component.h
> >>>> @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int cou=
nt)
> >>>>        return 0;
> >>>>    }
> >>>>   =20
> >>>> +static inline int cxl_decoder_count_dec(int enc_cnt)
> >>>> +{
> >>>> +    switch (enc_cnt) {
> >>>> +    case 0: return 1;
> >>>> +    case 1: return 2;
> >>>> +    case 2: return 4;
> >>>> +    case 3: return 6;
> >>>> +    case 4: return 8;
> >>>> +    case 5: return 10;
> >>>> +    }
> >>>> +    return 0;
> >>>> +} =20
> >>>
> >>> Why inline?
> >>>     =20
> >>
> >> Bad habit. =20
> > Nope. I'm being slow.  This is in a header so if I don't
> > mark it inline I get a bunch of defined but not used warnings.
> >=20
> > Obviously I could move the implementation of this and the matching
> > encoding routines out of the header. I haven't done so for now. =20
>=20
> Inlined function in hw/ are hardly justifiable. They make the headers
> and debugging sessions harder to read in my experience. Compilers are
> becoming clever and clever, and we have LTO, so I rather privilege
> code maintainability. My 2 cents :)
>=20
> >>> Alternatively:
> >>>
> >>>     unsigned cxl_decoder_count_dec(unsigned enc_cnt)
> >>>     {
> >>>         return enc_cnt <=3D 5 ? 2 * enc_cnt : 0; =20
> >>
> >> It gets a little more fiddly than the code I'm proposing implies.
> >> For Switches and Host Bridges larger values are defined
> >> (we just don't emulate them yet and may never do so) and those
> >> don't have a sensible mapping.
> >>
> >> I guess there is no harm in adding the full decode however
> >> which will make it more obvious why it was a switch statement. =20
>=20
> Right, no problem.
>=20
> Preferably having this tiny function not inlined

I'll push this and the enc() version down into the cxl-component-utils.c
as a precursor patch.

>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20
>=20
Thanks, but the changes to do make these non inline, and include
the larger decode and encode values are big enough I won't pick up
the RB - too much changing (that I might mess up ;)


Jonathan



