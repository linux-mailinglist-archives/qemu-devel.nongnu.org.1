Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CC79D0D0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2HH-00064Q-Qw; Tue, 12 Sep 2023 08:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qg2HG-00061A-DT
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:13:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qg2HD-0004g3-Vr
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:13:58 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlMnk39zTz67QKJ;
 Tue, 12 Sep 2023 20:09:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 13:13:52 +0100
Date: Tue, 12 Sep 2023 13:13:51 +0100
To: Gregory Price <gourry.memverge@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, 
 <kwangjin.ko@sk.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v3 2/6] cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Message-ID: <20230912131351.00007e5e@Huawei.com>
In-Reply-To: <20230906001517.324380-3-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
 <20230906001517.324380-3-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Tue,  5 Sep 2023 20:15:13 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Call CXL_TYPE3 once at top of function to avoid multiple invocations.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

This one is queued up in a set I posted for Michael to hopefully pick up.
So no need to keep it in this series (I'll post tree short etc)

Jonathan

> ---
>  hw/mem/cxl_type3.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index fd9d134d46..80d596ee10 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1248,17 +1248,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>                             unsigned size, MemTxAttrs attrs)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);
>      uint64_t dpa_offset = 0;
>      AddressSpace *as = NULL;
>      int res;
>  
> -    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
> +    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
>                                        &as, &dpa_offset);
>      if (res) {
>          return MEMTX_ERROR;
>      }
>  
> -    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
> +    if (sanitize_running(&ct3d->cci)) {
>          qemu_guest_getrandom_nofail(data, size);
>          return MEMTX_OK;
>      }
> @@ -1268,16 +1269,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>                              unsigned size, MemTxAttrs attrs)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);
>      uint64_t dpa_offset = 0;
>      AddressSpace *as = NULL;
>      int res;
>  
> -    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
> +    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
>                                        &as, &dpa_offset);
>      if (res) {
>          return MEMTX_ERROR;
>      }
> -    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
> +    if (sanitize_running(&ct3d->cci)) {
>          return MEMTX_OK;
>      }
>      return address_space_write(as, dpa_offset, attrs, &data, size);


