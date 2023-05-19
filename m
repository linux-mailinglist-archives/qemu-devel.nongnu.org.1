Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B9E709B01
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01oo-000882-Ni; Fri, 19 May 2023 11:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q01om-0007tI-1r
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:14:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q01oj-00042N-Gr
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:14:55 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN9MG06wJz67Q1L;
 Fri, 19 May 2023 23:12:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 16:14:49 +0100
Date: Fri, 19 May 2023 16:14:48 +0100
To: Ira Weiny <ira.weiny@intel.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
Message-ID: <20230519161448.00001983@Huawei.com>
In-Reply-To: <64668840a067b_114f6029416@iweiny-mobl.notmuch>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
 <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
 <20230518105416.000054c9@Huawei.com>
 <64668840a067b_114f6029416@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 18 May 2023 13:19:12 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 17 May 2023 19:45:54 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > Magic numbers can be confusing.
> > > 
> > > Use the range size define for CXL.cachemem rather than a magic number.
> > > Update/add spec references.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > I guess we should do a scrub to move all refs to 3.0 soon
> > given it's horrible having a mixture of spec versions for the references.
> > 
> > For future specs, we should only do this when sufficient X.Y references
> > have started to appear - I think that's true for r3.0 now.  
> 
> For the kernel side I think Dan is taking the 'if you are updating it then
> update the spec' but otherwise leave it be.  So since I'm touching the
> code I updated it.
> 
> I agree, it is a pain to have to look at the 2.0 spec but you can do it.

Only if you are either a member of the consortium, or happened to have
grabbed a copy in the past I think.  I've had people mentioning they can't
get it today.

Jonathan

> 
> Ira


