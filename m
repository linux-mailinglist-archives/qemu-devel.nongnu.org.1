Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769679E2D3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLhS-0001UH-RO; Wed, 13 Sep 2023 04:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgLhQ-0001U1-BU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:58:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgLhN-0000Ro-QK
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:58:16 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlvV85Tj0z6H7HS;
 Wed, 13 Sep 2023 16:57:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 09:58:09 +0100
Date: Wed, 13 Sep 2023 09:58:08 +0100
To: Fan Ni <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 2/4] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Message-ID: <20230913095808.00000df4@Huawei.com>
In-Reply-To: <20230912172005.GB319114@bgt-140510-bm03>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
 <20230911114313.6144-3-Jonathan.Cameron@huawei.com>
 <CGME20230912172006uscas1p1f48a880aeaf7fad3400929d4bc919ae5@uscas1p1.samsung.com>
 <20230912172005.GB319114@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
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

On Tue, 12 Sep 2023 17:20:05 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Sep 11, 2023 at 12:43:11PM +0100, Jonathan Cameron wrote:
>=20
> > As an encoded version of these key configuration parameters is available
> > in a register, provide functions to extract it again so as to avoid
> > the need for duplicating the storage.
> >=20
> > Whilst here update the _enc() function to include additional values
> > as defined in the CXL 3.0 specification. Whilst they are not
> > currently used in the emulation, they may be in future and it is
> > easier to compare with the specification if all values are covered.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > --- =20
>=20
> LGTM. Only one minor comment inline.
>=20
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
Thanks!

> > +
> > +int cxl_decoder_count_dec(int enc_cnt)
> > +{
> > +    switch (enc_cnt) {
> > +    case 0x0: return 1;
> > +    case 0x1: return 2;
> > +    case 0x2: return 4;
> > +    case 0x3: return 6;
> > +    case 0x4: return 8;
> > +    case 0x5: return 10;
> > +    /* Switches and Host Bridges may have more than 10 decoders */
> > +    case 0x6: return 12;
> > +    case 0x7: return 14;
> > +    case 0x8: return 16;
> > +    case 0x9: return 20;
> > +    case 0xa: return 24;
> > +    case 0xb: return 28;
> > +    case 0xc: return 32;
> >      }
> >      return 0;
> >  }
> > @@ -410,6 +440,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **er=
rp)
> >      }
> >  }
> >   =20
>=20
> Similar as decoder count dec/enc, maybe we want to add a line of comment =
below.
> /* CXL r3.0 Section 8.2.4.19.7 CXL HDM Decoder n Control Register */

I'll do it before cxl_interleave_ways_enc() - one function up in the file
as applies equally well there.
>=20
> Fan
> > +int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
> > +{
> > +    switch (iw_enc) {
> > +    case 0x0: return 1;
> > +    case 0x1: return 2;
> > +    case 0x2: return 4;
> > +    case 0x3: return 8;
> > +    case 0x4: return 16;
> > +    case 0x8: return 3;
> > +    case 0x9: return 6;
> > +    case 0xa: return 12;
> > +    default:
> > +        error_setg(errp, "Encoded interleave ways: %d not supported", =
iw_enc);
> > +        return 0;
> > +    }
> > +}
> > +
> >  uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
> >  {
> >      switch (gran) {
> > --=20
> > 2.39.2
> >=20
> > =20


