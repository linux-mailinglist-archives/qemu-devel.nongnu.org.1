Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEFE828B5F
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNG5i-0004xv-CG; Tue, 09 Jan 2024 12:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNG5a-0004tq-Du
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:40:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNG5X-00076S-Sn
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:40:34 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8dSw407sz6K6DL;
 Wed, 10 Jan 2024 01:38:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 7B4E5140736;
 Wed, 10 Jan 2024 01:40:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 17:40:27 +0000
Date: Tue, 9 Jan 2024 17:40:26 +0000
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/4] hw/cxl: fix build error in cxl_type3_stubs.c
Message-ID: <20240109174026.00000760@Huawei.com>
In-Reply-To: <20231222090051.3265307-2-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-2-42.hyeyoo@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 22 Dec 2023 18:00:48 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> Fix build errors in cxl_type3_stubs.c due to a the incorrect definition
> of the qmp_cxl_{add,release}_dynamic_capacity functions.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Fan, this one needs squashing into your
hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
patch in the DCD series. I'll do that in my tree, but just wanted to
make sure you noticed this so we don't end up reintroducing it again by
accident!

Thanks Hyeonggon,

Jonathan

> ---
>  hw/mem/cxl_type3_stubs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 1b54ec028c..d913b11b4d 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -68,14 +68,14 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      error_setg(errp, "CXL Type 3 support is not compiled in");
>  }
>  
> -void qmp_cxl_add_dynamic_capacity(const char *path,
> +void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
>                                    CXLDCExtentRecordList  *records,
>                                    Error **errp)
>  {
>      error_setg(errp, "CXL Type 3 support is not compiled in");
>  }
>  
> -void qmp_cxl_release_dynamic_capacity(const char *path,
> +void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
>                                        CXLDCExtentRecordList  *records,
>                                        Error **errp)
>  {


