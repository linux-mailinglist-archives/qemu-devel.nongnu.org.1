Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153CA8A47E
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 18:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4jRp-0002gM-H0; Tue, 15 Apr 2025 12:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u4jRa-0002ed-FN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:47:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u4jRW-0001XA-0J
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:47:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcVMs6yZjz6M4Mm;
 Wed, 16 Apr 2025 00:43:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B6450140144;
 Wed, 16 Apr 2025 00:47:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 18:47:19 +0200
Date: Tue, 15 Apr 2025 17:47:17 +0100
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Message-ID: <20250415174717.00001509@huawei.com>
In-Reply-To: <e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
References: <20250323080420.935930-1-lizhijian@fujitsu.com>
 <e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 7 Apr 2025 02:59:20 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> Ping

Sorry, I wrote half a reply but then lost it before sending
- was still in my drafts :(

> 
> Only if (dsp_count==1 && hdm_for_passthrough==true), the QEMU shouldn't implement
> the HDM decodder for the Host-bridge.

HDM for pass through means that we do have decoders even for pass through
not that we do not.  The name could be better and the code flow
perhaps simpler.

> 
> But previous code didn't follow this.

> Thanks
> Zhijian
> 
> On 23/03/2025 16:04, Li Zhijian wrote:
> > Reverse the logical condition for HDM passthrough support in
> > pci_expander_bridge. This patch ensures the HDM passthrough condition
> > is evaluated only when hdm_for_passthrough is set to true, aligning
> > behavior with intended semantics and comments.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> > 
> > This change corrects what appears to be a previous mistake in logic
> > regarding HDM passthrough conditions.
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index 3396ab4bdd..25f8922d76 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -307,7 +307,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
> >        * The CXL specification allows for host bridges with no HDM decoders
> >        * if they only have a single root port.
> >        */
> > -    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {

This makes us only check the number of ports if we are not
providing hdm decoders for passthrough ports.

If we are providing HDM Decoders anyway we don't care how many
ports there are so the 0 value is fine.

> > +    if (PXB_CXL_DEV(dev)->hdm_for_passthrough) {
> >           dsp_count = pcie_count_ds_ports(hb->bus);
> >       }
> >       /* Initial reset will have 0 dsp so wait until > 0 *  


