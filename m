Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0EAD29F7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 00:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOlNL-0001AS-H3; Mon, 09 Jun 2025 18:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1uOlNJ-0001AH-8X
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:53:53 -0400
Received: from out-174.mta1.migadu.com ([95.215.58.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1uOlNG-0000hA-F6
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:53:53 -0400
Date: Tue, 10 Jun 2025 07:53:31 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1749509621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxOE58UHkmyNaPXHD2BEAW9G/zuBXBYxX7HObtol/Pk=;
 b=o2JUa19nU6VI9eHrFmLm25tJTWCrylx3+QZroe5AtZqrqHSWWwAc2MzoKO83N+hbDd8hjx
 HyQqaHCfTW8t5FzjBfT+L9eV6o0jHQyK/vdZp/MiRy1DmVuO5ZjFU+En4Khm3f1BbCz5oa
 4LZuymeS5mnmDQOre3uoa5uWqZUUvPA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows devices.
Message-ID: <aEdl6xvqyOsU+Z2S@vm4>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
 <20250528110726.226389-3-Jonathan.Cameron@huawei.com>
 <20250529160801.00003ade@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529160801.00003ade@huawei.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.174;
 envelope-from=itaru.kitayama@linux.dev; helo=out-174.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, May 29, 2025 at 04:08:01PM +0100, Jonathan Cameron wrote:
> On Wed, 28 May 2025 12:07:23 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Previously these somewhat device like structures were tracked using a list
> > in the CXLState in each machine.  This is proving restrictive in a few
> > cases where we need to iterate through these without being aware of the
> > machine type. Just make them sysbus devices.
> > 
> > Restrict them to not user created as they need to be visible to early
> > stages of machine init given effects on the memory map.
> > 
> > This change both simplifies state tracking and enables features needed
> > for performance optimization and hotness tracking by making it possible
> > to retrieve the fixed memory window on actions elsewhere in the topology.
> > 
> > In some cases the ordering of the Fixed Memory Windows matters.
> > For those utility functions provide a GSList sorted by the window index.
> > This ensures that we get consistency across:
> > - ordering in the command line
> > - ordering of the host PA ranges
> > - ordering of ACPI CEDT structures describing the CFMWS.
> > 
> > Other aspects don't have this constraint. For those direct iteration
> > of the underlying hash structures is fine.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I'll not post v15 for a while to give time for review, but I just realized
> this snippet was in a patch I was carrying on top of this and should have
> been in this patch.
> 
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index a610795c87..de66ab8c35 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -46,7 +46,6 @@ typedef struct CXLState {
>      bool is_enabled;
>      MemoryRegion host_mr;
>      unsigned int next_mr_idx;
> -    GList *fixed_windows;
>      CXLFixedMemoryWindowOptionsList *cfmw_list;
>  } CXLState;

With this one line removed on top of v14, today's Dave's cxl/next kernel makes
cxl test suite ran through without a single failure.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Jonathan, Zhi jian of Fujitsu gave you feedback on the QEMU core CXL emulation code, 
are you still waiting on any other reviewers to take a look at the series v14 (or
v14-ish)?

Thanks,
Itaru.

> 

