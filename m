Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB570B8A7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 11:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q11Zp-0003Hb-Rx; Mon, 22 May 2023 05:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.zhong@linux.intel.com>)
 id 1q11Za-000386-6N
 for qemu-devel@nongnu.org; Mon, 22 May 2023 05:11:25 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.zhong@linux.intel.com>)
 id 1q11ZW-0005sv-BY
 for qemu-devel@nongnu.org; Mon, 22 May 2023 05:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684746678; x=1716282678;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=c19cHFg3Vnfl8t8WKcBpQQ1VuUtxaC8awxEA8D7gcMs=;
 b=Cd1dgmyg0SUJQOTPttuucMoBF/OoMN2/GMzLEzY9RydSW0U8i5Zk4RoB
 Lhy2WHzfalDF3jK73iPwemquMOXOCv+xK4hq2/uQxyOitQpDp6khW1tjo
 C88XaMqrxhz7eCtsLV0JYNWpc0nFCILAGFsvucdPh87YmuNYqTEFGRSK5
 kyvtgDZz+wYYTJZDP8bQrRgXKscxkNaBlji+ykC8lLCjQ3UxsVDoyuYVb
 sQyhged/5Xl1VrOAEsyIgobB7YwtpHhb2b5vf4NWt7byHfdPJei/wZYOM
 LVF34NIYRLuH2nkQYNolSYAye3DNbk6B4Ey53H/TUHiPORyK2SzRu9y2i A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="381093732"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; d="scan'208";a="381093732"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 02:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="949991911"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; d="scan'208";a="949991911"
Received: from yangzhon.bj.intel.com (HELO yangzhon) ([10.238.157.60])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 02:11:13 -0700
Date: Mon, 22 May 2023 05:11:02 -0400
From: Yang Zhong <yang.zhong@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
Message-ID: <ZGsxpr2X64LPjkWf@yangzhon>
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <ZGbnrwKTTO1PsDhT@yangzhon>
 <7e2b211f-8da8-3345-528d-bc6f3b35484d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e2b211f-8da8-3345-528d-bc6f3b35484d@redhat.com>
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=yang.zhong@linux.intel.com; helo=mga01.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, May 19, 2023 at 10:29:47AM +0200, Paolo Bonzini wrote:
> On 5/19/23 05:06, Yang Zhong wrote:
> > 
> > Paolo, please help add below queued sgx fix into this PULL request, which was
> > missed from last time, thanks a lot!
> > https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg00841.html
> > https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg00896.html
> 
> Isn't this commit 72497cff896fecf74306ed33626c30e43633cdd6?
> 
> Author: Yang Zhong <yang.zhong@linux.intel.com>
> Date:   Thu Apr 6 02:40:41 2023 -0400
> 
>     target/i386: Change wrong XFRM value in SGX CPUID leaf
>     The previous patch wrongly replaced FEAT_XSAVE_XCR0_{LO|HI} with
>     FEAT_XSAVE_XSS_{LO|HI} in CPUID(EAX=12,ECX=1):{ECX,EDX}.  As a result,
>     SGX enclaves only supported SSE and x87 feature (xfrm=0x3).
>     Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
>     Signed-off-by: Yang Zhong <yang.zhong@linux.intel.com>
>     Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>
>     Reviewed-by: Kai Huang <kai.huang@intel.com>
>     Message-Id: <20230406064041.420039-1-yang.zhong@linux.intel.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

  Oh, So sorry for this,,, it's my fault.
  
  I missed PULL email information for this patch,
  Apr 21 Paolo Bonzini   (1.4K) [PULL 16/25] target/i386: Change wrong XFRM value in SGX CPUID leaf

  Regards,
  Yang

> Paolo
> 
> 

