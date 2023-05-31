Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8402717DB5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Jgz-0002Y8-E4; Wed, 31 May 2023 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q4Jgt-0002UA-Fl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:08:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q4Jgq-0003N3-HM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:08:31 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWRK36KCsz67NbR;
 Wed, 31 May 2023 19:06:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 12:08:24 +0100
Date: Wed, 31 May 2023 12:08:23 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Li Zhijian <lizhijian@cn.fujitsu.com>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] hw/cxl: Fix CFMW config memory leak
Message-ID: <20230531120823.00001a6c@Huawei.com>
In-Reply-To: <5ac2e71e-7bc0-ee84-fce2-8d0b6e137a3e@linaro.org>
References: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
 <5ac2e71e-7bc0-ee84-fce2-8d0b6e137a3e@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 May 2023 09:51:43 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 31/5/23 08:07, Li Zhijian wrote:
> > Allocate targets and targets[n] resources when all sanity checks are
> > passed to avoid memory leaks.
> >=20
> > Suggested-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > ---
> > V3: allocte further resource when we can't fail # Philippe =20
>=20
> Thanks for the v3!
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>

Thanks.  I've added this near the top of my queue so will send
it out along with other similar fixes as a series for Michael
to consider picking up.

Jonathan

>=20
> > V2: Delete unnecesarry check
> > ---
> >   hw/cxl/cxl-host.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-) =20
>=20


