Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05D77993B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZPP-0006kd-5J; Fri, 11 Aug 2023 17:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.sneddon@linux.intel.com>)
 id 1qUWGp-0000eO-78
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:49:55 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.sneddon@linux.intel.com>)
 id 1qUWGm-00053C-U1
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691776192; x=1723312192;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5aE3MkXmMiLyEY3goYWQJLuH5N5xIMj4F1XRm0A7SMI=;
 b=AQhsF/p12sqIqV/eia4qL+OgwCR89lPt28t2gkO1SvqArS52uPNjIHBf
 G+D4yZtB7jUiMvarNNnCrmDnvQzIYrT+9TY0CBdwIKBod1whF9PWop1rV
 SUXc8Ie2p5/c0oV0x+MTjgmZzInGQvWwo/SGbYF3b9iVjmAKGZJbnsffd
 AOSWPYZPO0slt+6MfsN+Rm8x/W7Y5KK+wIdUsoZ//tD2gyBVsxl9YylL/
 cFNadBESTZbSX2hfXXbl4cORf8ZneNxx3kEWqoDewzZ8e7DsgEZCddp97
 mS1F9FQgKff9AhUBEdk82IOAl5Xcp+u3f/3XeH1o+DDTKgNkBdWjJIvkw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="458101540"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="458101540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2023 10:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="846863219"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="846863219"
Received: from spenceke-mobl1.amr.corp.intel.com (HELO [10.209.183.12])
 ([10.209.183.12])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2023 10:49:47 -0700
Message-ID: <75a0aff8-2cb0-1c6c-0f4d-b108bc2d1099@linux.intel.com>
Date: Fri, 11 Aug 2023 10:49:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] target/i386: Export GDS_NO bit to guests
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tao1.su@linux.intel.com,
 xiaoyao.li@intel.com, Yu Zhang <yu.zhang@ionos.com>,
 antonio.gomez.iglesias@intel.com, Chao Gao <chao.gao@intel.com>
References: <CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com>
 <c373f3f92b542b738f296d44bb6a916a1cded7bd.1691774049.git.pawan.kumar.gupta@linux.intel.com>
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <c373f3f92b542b738f296d44bb6a916a1cded7bd.1691774049.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=daniel.sneddon@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 11 Aug 2023 17:10:53 -0400
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

On 8/11/23 10:18, Pawan Gupta wrote:
> This is just compile tested.

I used this patch when testing the GDS Linux patches, so you can add a T-B from me.

