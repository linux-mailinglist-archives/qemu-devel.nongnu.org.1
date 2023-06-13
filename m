Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A895C72DDC2
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 11:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90Jv-0000pu-RP; Tue, 13 Jun 2023 05:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q90Jq-0000pW-Rf
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:28:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q90Iz-0003zu-J0
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:28:06 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgNRX0nhgz6J7f3;
 Tue, 13 Jun 2023 17:24:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:26:50 +0100
Date: Tue, 13 Jun 2023 10:26:49 +0100
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>
Subject: Re: [PULL 26/42] target/arm: Use tcg_gen_qemu_{ld, st}_i128 in
 gen_sve_{ld, st}r
Message-ID: <20230613102649.00000eec@Huawei.com>
In-Reply-To: <805feb0f-2511-65b8-80c9-8607bf6e57ab@ilande.co.uk>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-27-peter.maydell@linaro.org>
 <20230612162044.00002fdc@huawei.com>
 <805feb0f-2511-65b8-80c9-8607bf6e57ab@ilande.co.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 12 Jun 2023 19:40:29 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 12/06/2023 16:20, Jonathan Cameron via wrote:
> 
> > On Tue,  6 Jun 2023 10:47:58 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> >> From: Richard Henderson <richard.henderson@linaro.org>
> >>
> >> Round len_align to 16 instead of 8, handling an odd 8-byte as part
> >> of the tail.  Use MO_ATOM_NONE to indicate that all of these memory
> >> ops have only byte atomicity.
> >>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> Message-id: 20230530191438.411344-8-richard.henderson@linaro.org
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>  
> > 
> > Early in debugging but a git bisect pointed at this patch causing:
> > 
> > ERROR:../../tcg/tcg.c:4317:temp_load: code should not be reached
> > Bail out! ERROR:../../tcg/tcg.c:4317:temp_load: code should not be reached
> > Aborted
> > 
> > Just after Run /sbin/init arm64 / virt running on an x86 host.
> > cpu max.
> > 
> > Just reverting this patch results in length check failures.
> > I reverted as follows
> > 
> > 
> > revert: Revert "target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r"
> > revert: Revert "target/arm: Sink gen_mte_check1 into load/store_exclusive"
> > revert: Revert "target/arm: Load/store integer pair with one tcg operation"
> > revert: Revert "target/arm: Hoist finalize_memop out of do_gpr_{ld, st}"
> > revert: Revert "target/arm: Hoist finalize_memop out of do_fp_{ld, st}"
> > revert: Revert "target/arm: Pass memop to gen_mte_check1*"
> > revert: Revert "target/arm: Pass single_memop to gen_mte_checkN"
> > revert: Revert "target/arm: Check alignment in helper_mte_check"
> > revert: Revert "target/arm: Add SCTLR.nAA to TBFLAG_A64"
> > revert: Revert "target/arm: Relax ordered/atomic alignment checks for LSE2"
> > revert: Revert "target/arm: Move mte check for store-exclusive"
> > 
> > and all is good - obviously that's probably massive overkill.
> > 
> > Jonathan  
> 
> Could this possibly be the same as https://gitlab.com/qemu-project/qemu/-/issues/1704?

Seems likely.  I'll watch that issue for a resolution.

Thanks!

Jonathan

> 
> 
> ATB,
> 
> Mark.
> 


