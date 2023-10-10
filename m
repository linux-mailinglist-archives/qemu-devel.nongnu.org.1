Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF07BEF90
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 02:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq0Nd-0000WX-4r; Mon, 09 Oct 2023 20:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0Nb-0000WP-Lx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:13:43 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0Na-0002qy-6i
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:13:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E89416145D;
 Tue, 10 Oct 2023 00:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F5FC433C8;
 Tue, 10 Oct 2023 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696896820;
 bh=pFShj7E3teMu9hJW8EV5RvbTmKj4bVtl8O/wRY3ZG7M=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=rSWwqSmBwJb5Dl2qzyJsJ8Nv5st7powAi+gOwKy3X3EFBNT1MufUYMEYMsjc8Ali7
 h7QWSqCRLEeihNelze6EJ45RLodm8f2u+LVJ3O257jpaiTkMCQQlWEUW9mhTzwRvEJ
 ipmcQ2GAmESz9/6ElOfCoirfCi4BImsb0ByLXE27SP60xxf9RT0mYvvHnz0URxjquv
 nvHOAZwld4ZL0iU6W6b/fHxWKMTk5DKGFs5gac1eJyrZN869NXhMcUsbZvrMwPWPF8
 C5IusCS3xZgKk48eKXyIRuaHMWB/WZtpl/0dqh0bX/eYp+cqXhTIsOIiVpQUQ3JbQI
 jtgeEJdMWGejQ==
Date: Mon, 9 Oct 2023 17:13:37 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Juergen Gross <jgross@suse.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v1 4/7] xen: let xen_ram_addr_from_mapcache() return
 -1 in case of not found entry
In-Reply-To: <20231005181629.4046-5-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310091713200.3431292@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-5-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, 5 Oct 2023, Vikram Garhwal wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
> case it can't find a matching entry for a pointer value. Both cases
> are bad, so change that to return an invalid address instead.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 8115c44c00..8a61c7dde6 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -404,13 +404,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          }
>      }
>      if (!found) {
> -        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
> -        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> -            DPRINTF("   "HWADDR_FMT_plx" -> %p is present\n", reventry->paddr_index,
> -                    reventry->vaddr_req);
> -        }
> -        abort();
> -        return 0;
> +        mapcache_unlock();
> +        return RAM_ADDR_INVALID;
>      }
>  
>      entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
> @@ -418,8 +413,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          entry = entry->next;
>      }
>      if (!entry) {
> -        DPRINTF("Trying to find address %p that is not in the mapcache!\n", ptr);
> -        raddr = 0;
> +        raddr = RAM_ADDR_INVALID;
>      } else {
>          raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
>               ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
> -- 
> 2.17.1
> 

