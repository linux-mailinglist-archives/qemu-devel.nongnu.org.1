Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4C728FAB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 08:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7VJc-00072F-4W; Fri, 09 Jun 2023 02:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1q7VJM-00071i-9T
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 02:09:27 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1q7VJK-0001se-9X
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 02:09:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6CC8A65190;
 Fri,  9 Jun 2023 06:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD7C433D2;
 Fri,  9 Jun 2023 06:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1686290959;
 bh=VymAURH6DqwhMHojBPt5ZuPQYK69zpD8+HmhzERJHQs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BUcm9vafTjmhcgggePjJmaz/CH0W+mbeHr5qrrQwiB0h1f0JVSlBxyQKzOgMopEnY
 lFRs6FwN6lXiIizorV33KI6IMNKLqQPxpXoK4tRUII5GGb3Z08TYo2zB8FwXnZmiP8
 Hwt8ucnJj7jNCiplSapmsMgpbeFiRHshdQZliN6g=
Date: Fri, 9 Jun 2023 08:09:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 kirill.shutemov@linux.intel.com, mhocko@suse.com,
 jmarchan@redhat.com, muchun.song@linux.dev,
 James Houghton <jthoughton@google.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
Message-ID: <2023060908-pretender-boastful-cbb9@gregkh>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608204927.88711-1-mike.kravetz@oracle.com>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=gregkh@linuxfoundation.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 08, 2023 at 01:49:27PM -0700, Mike Kravetz wrote:
> This effectively reverts commit 16c243e99d33 ("udmabuf: Add support
> for mapping hugepages (v4)").  Recently, Junxiao Chang found a BUG
> with page map counting as described here [1].  This issue pointed out
> that the udmabuf driver was making direct use of subpages of hugetlb
> pages.  This is not a good idea, and no other mm code attempts such use.
> In addition to the mapcount issue, this also causes issues with hugetlb
> vmemmap optimization and page poisoning.
> 
> For now, remove hugetlb support.
> 
> If udmabuf wants to be used on hugetlb mappings, it should be changed to
> only use complete hugetlb pages.  This will require different alignment
> and size requirements on the UDMABUF_CREATE API.
> 
> [1] https://lore.kernel.org/linux-mm/20230512072036.1027784-1-junxiao.chang@intel.com/
> 
> Fixes: 16c243e99d33 ("udmabuf: Add support for mapping hugepages (v4)")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

