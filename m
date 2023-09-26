Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E634F7AF005
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlANd-00042R-Tf; Tue, 26 Sep 2023 11:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qlANE-00041v-HW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:53:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qlAN9-0006EA-Q7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:53:20 -0400
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rw42j1fmgz15NQL;
 Tue, 26 Sep 2023 23:50:37 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 23:52:50 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 16:52:48 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: xianglai li <lixianglai@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao
 <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "wangyanan
 (Y)" <wangyanan55@huawei.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Bibo Mao <maobibo@loongson.cn>
Subject: RE: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Thread-Topic: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Thread-Index: AQHZ8F98Fz18osKCj0u+l4OH//GmcbAs7Gww///2vACAABh10P//8ysAgAARtGD///H6AAAJV4+w
Date: Tue, 26 Sep 2023 15:52:48 +0000
Message-ID: <726b4f44a38e4ee8b476ab6130e29b13@huawei.com>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
 <54482e7486564d68926ded075ebe8c6f@huawei.com>
 <20230926080436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926080436-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=salil.mehta@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, September 26, 2023 1:07 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
> Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaoju=
an
> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> Bonzini <pbonzini@redhat.com>; Richard Henderson
> <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> Berrang=E9 <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
>=20
> On Tue, Sep 26, 2023 at 12:03:46PM +0000, Salil Mehta wrote:
> > Sure, ARM patch-set follows exactly above rules.
> >
>=20
>=20
> Almost.
>=20
> 	Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> 	Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> 	Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> 	Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> 	Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>=20
> You should drop your own Co-developed-by as well as multiple Signed-off-b=
y.


https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-b=
y-cc-and-co-developed-by

Reference: Co-developed-by: Pasting excerpt from above link:

"1. Standard sign-off procedure applies, i.e. the ordering of
   Signed-off-by: tags should reflect the chronological history
   of the patch insofar as possible, regardless of whether the
  author is attributed via From: or Co-developed-by:.
2.Notably, the last Signed-off-by: must always be that of the
  developer submitting the patch."

To be able to achieve 1. I have to put Co-developed-by: of
mine at the top as I am the main author of the patch-set
historically and have been continually driving the work.
(It is a common rule even within the kernel to keep first
 SOB that of the main author)

Reference: Signed-off-by: Excerpt from above link:

" Any further SoBs (Signed-off-by:'s) following the author's
 SoB are from people handling and transporting the patch, but
 were not involved in its development. SoB chains should
 reflect the real route a patch took as it was propagated to
 the maintainers and ultimately to Linus, with the first SoB
 entry signalling primary authorship of a single author."


And since I am the person who is submitting the patches
(which might or not be the same in future) I need to put
my SOB in any case to be able to achieve 2.

This is to ensure primary author remains the first SOD/CDY.


Thanks
Salil.



