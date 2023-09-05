Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6379238A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdX60-0005kQ-Oj; Tue, 05 Sep 2023 10:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdX5v-0005iM-4h
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdX5p-0001HJ-6h
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693924307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bip5YEc1P2/+ZHUeDzG4ergCBQMS1zTT8JbALsnt93o=;
 b=Iba6T+XmLmcge1/8+n8650mXfwiX4YT84f2hfmkHVCIMZramxe3mgt3jQIjekSVJwcnf1c
 hh2uA1uGJm1Uon/AGvX6j2t45xF8PdG9MHVDx6+1/SaOE1yfmYNd+CeN82MaTe+jwXn3ig
 ZHmHVnlR3tknCd6/BXst5H+3wMkpYy0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-dXxWRSTDPVCNYW2kVDbHUA-1; Tue, 05 Sep 2023 10:31:46 -0400
X-MC-Unique: dXxWRSTDPVCNYW2kVDbHUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A164382254B;
 Tue,  5 Sep 2023 14:31:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0768140F2D26;
 Tue,  5 Sep 2023 14:31:45 +0000 (UTC)
Date: Tue, 5 Sep 2023 09:31:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/devel/loads-stores: Fix git grep regexes
Message-ID: <63liuowfkrgvmwipyhb5mpjerjs5nef7ztla5obbh3wsxrna72@ugii6rhgrhb4>
References: <20230904161703.3996734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904161703.3996734-1-peter.maydell@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 04, 2023 at 05:17:03PM +0100, Peter Maydell wrote:
> The loads-and-stores documentation includes git grep regexes to find
> occurrences of the various functions.  Some of these regexes have
> errors, typically failing to escape the '?', '(' and ')' when they
> should be metacharacters (since these are POSIX basic REs). We also
> weren't consistent about whether to have a ':' on the end of the
> line introducing the list of regexes in each section.
> 
> Fix the errors.
> 
> The following shell rune will complain about any REs in the
> file which don't have any matches in the codebase:
>  for re in $(sed -ne 's/ - ``\(\\<.*\)``/\1/p' docs/devel/loads-stores.rst); do git grep -q "$re" || echo "no matches for re $re"; done
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/loads-stores.rst | 40 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index dab6dfa0acc..ec627aa9c06 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -63,12 +63,12 @@ which stores ``val`` to ``ptr`` as an ``{endian}`` order value
>  of size ``sz`` bytes.
>  
>  
> -Regexes for git grep
> +Regexes for git grep:
>   - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``

This claims that ldul_be_p() is a valid function name (which I would
expect to take a pointer to a 32-bit integer and produce an unsigned
result suitable for assigning into a 64-bit value).  But it does not
exist, and the fact that ldl_be_p() returns 'int' means I had to add a
cast to avoid unintended sign-extension:

https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05234.html

cast added in relation to v5 patch at
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04923.html

>   - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
>   - ``\<st24\(_[hbl]e\)\?_p\>``
> - - ``\<ldn_\([hbl]e\)?_p\>``
> - - ``\<stn_\([hbl]e\)?_p\>``
> + - ``\<ldn_\([hbl]e\)\?_p\>``
> + - ``\<stn_\([hbl]e\)\?_p\>``

So as long as we are touching the docs, is it worth considering the
larger task of auditing whether it is appropriate to have all of the
ld*_ functions return unsigned values, and/or implement ldu/lds
variants that guarantee zero or sign extension for widening 32-bit
values when assigning to 64-bit destinations?

>  
>  ``cpu_{ld,st}*_mmu``
>  ~~~~~~~~~~~~~~~~~~~~
> @@ -121,8 +121,8 @@ store: ``cpu_st{size}{end}_mmu(env, ptr, val, oi, retaddr)``
>   - ``_le`` : little endian
>  
>  Regexes for git grep:
> - - ``\<cpu_ld[bwlq](_[bl]e)\?_mmu\>``

As a counterpoint, the cpu_ldl_* functions already return uint32_t.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


