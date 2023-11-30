Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370117FF61A
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:34:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jyT-0004rr-T0; Thu, 30 Nov 2023 11:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1r8jyP-0004pJ-MS
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:33:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1r8jyK-0007DK-22
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:33:08 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh1v36g4Vz6J9fy;
 Fri,  1 Dec 2023 00:32:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C0AAB1404F4;
 Fri,  1 Dec 2023 00:32:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 16:32:54 +0000
Date: Thu, 30 Nov 2023 16:32:53 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@lore.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/2] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <20231130163253.00002140@Huawei.com>
In-Reply-To: <20231127202702.zkqomoapz2iprpra@offworld>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-2-42.hyeyoo@gmail.com>
 <20231127202702.zkqomoapz2iprpra@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
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

On Mon, 27 Nov 2023 12:27:02 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:
> 
> >In the current mdev_reg_read() implementation, it consistently returns
> >that the Media Status is Ready (01b). This was fine until commit
> >25a52959f99d ("hw/cxl: Add support for device sanitation") because the
> >media was presumed to be ready.
> >
> >However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
> >during sanitation, the Media State should be set to Disabled (11b). The
> >mentioned commit correctly sets it to Disabled, but mdev_reg_read()
> >still returns Media Status as Ready.
> >
> >To address this, update mdev_reg_read() to read register values instead
> >of returning dummy values.
> >
> >Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> >Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>  
> 
> Looks good, thanks.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> In addition how about the following to further robustify?
>    - disallow certain incoming cci cmd when media is disabled
>    - deal with memory reads/writes when media is disabled
>    - make __toggle_media() a nop when passed value is already set
>    - play nice with arm64 uses little endian reads and writes (this
>      should be extended to all of mbox/cci of course).
This one you've lost me on.  Arm64 and x86 both little endian.

If you mean generally harden the code we haven't fixed up for
big endian systems then fair enough - that indeed needs doing.
Tricky to be sure we got it all right though unless we have a big
endian arch to test on...

Jonathan


