Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801370597A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 23:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz2EY-0000CX-Fm; Tue, 16 May 2023 17:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pz2EW-0000CI-DQ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pz2EU-00034g-V0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684272562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HJ+Hcs9GVRA0rbVMaeJkPWmF8gcN3qMAGNbfh1BJXg=;
 b=WxkCXC1o8psgd2lIF7mDpO2PneOXlGb5Sa/zobuv80fflX0mzky+6Z5ReJla5/x03uDcuJ
 H+9V9xN8gVHVD6uwmwD2O1QjKrpugbpJui5WXcm55EVdQEBc9GDkU/qlgkg1uvYzK9WBuS
 cRRIbVGBxxGeBQfkJCybbjosOSnli4o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-ub32tCvEOmy2UGw3KcqSZA-1; Tue, 16 May 2023 17:29:20 -0400
X-MC-Unique: ub32tCvEOmy2UGw3KcqSZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B2913850543;
 Tue, 16 May 2023 21:29:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B375EC15BA0;
 Tue, 16 May 2023 21:29:19 +0000 (UTC)
Date: Tue, 16 May 2023 16:29:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com,
 yan@daynix.com
Subject: Re: [PATCH v2 6/6] ebpf: Updated eBPF program and skeleton.
Message-ID: <cpbx5qe2joehuvljvn5cuvazp66k3od2rgvw3vmuwlhjcwxvsr@pecplll2l5dg>
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-7-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122902.34345-7-andrew@daynix.com>
User-Agent: NeoMutt/20230512
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On Fri, May 12, 2023 at 03:29:02PM +0300, Andrew Melnychenko wrote:
> 
> Updated section name, so libbpf should init/gues proper
> program type without specifications during open/load.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/rss.bpf.skeleton.h | 1469 ++++++++++++++++++++-------------------
>  tools/ebpf/rss.bpf.c    |    2 +-
>  2 files changed, 741 insertions(+), 730 deletions(-)
> 
> diff --git a/ebpf/rss.bpf.skeleton.h b/ebpf/rss.bpf.skeleton.h
> index 18eb2adb12c..41b84aea44c 100644
> --- a/ebpf/rss.bpf.skeleton.h
> +++ b/ebpf/rss.bpf.skeleton.h
> @@ -176,162 +176,162 @@ err:
>  
>  static inline const void *rss_bpf__elf_bytes(size_t *sz)
>  {
> -	*sz = 20440;
> +	*sz = 20720;
>  	return (const void *)"\
>  \x7f\x45\x4c\x46\x02\x01\x01\0\0\0\0\0\0\0\0\0\x01\0\xf7\0\x01\0\0\0\0\0\0\0\0\
> -\0\0\0\0\0\0\0\0\0\0\0\x98\x4c\0\0\0\0\0\0\0\0\0\0\x40\0\0\0\0\0\x40\0\x0d\0\

Appears to be pre-existing, and looking at the broader context, I see
this comment earlier in the file:

/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */

/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */

but a suggestion to improve things: tweak the comment produced by the
generator to also output the name of the source file (not just the
bpftool generator), to make it easier to figure out how to map this
binary blob of data back to human-readable source and instructions on
how to regenerate it should I want to edit those sources.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


