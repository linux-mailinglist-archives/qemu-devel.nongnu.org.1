Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 843097082D4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdmd-0001vc-20; Thu, 18 May 2023 09:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzdma-0001v4-94
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzdmX-0006kv-E1
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684416898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xC/cH2NLdykz1Ceu4/a2a7b944agvY6KewPv7ZYtWZM=;
 b=OXyjy3eYUdXV7TTL75R0E3CXVBxFYde7vabbzb/M1qIkeYfKUHipHEbin4+lM9c0ci0Izt
 6cDCz94h2JQx/qpiy8hdrSieGYIb3vVj9dJL+Vmmflyx/28O9gKZzDAU/YiyisMWRaGBdt
 nAA1H9cxNaFkbMLnEWDB35hAB1MyaSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-Py1knuqeNfWiXVpsFywvAw-1; Thu, 18 May 2023 09:34:56 -0400
X-MC-Unique: Py1knuqeNfWiXVpsFywvAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA32871CA1;
 Thu, 18 May 2023 13:34:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98D52492B01;
 Thu, 18 May 2023 13:34:53 +0000 (UTC)
Date: Thu, 18 May 2023 08:34:51 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: hreitz@redhat.com, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 05/19] cutils: Fix wraparound parsing in qemu_strtoui
Message-ID: <qj4ug7oiuaf4dmpmfudmmfvpa7tktkwzfp3devx5yu7d2eilzc@c6yoog5akiv4>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512021033.1378730-6-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, May 11, 2023 at 09:10:19PM -0500, Eric Blake wrote:
> 
> While we were matching 32-bit strtol in qemu_strtoi, our use of a
> 64-bit parse was leaking through for some inaccurate answers in
> qemu_strtoui in comparison to a 32-bit strtoul.  Fix those, and update
> the testsuite now that our bounds checks are correct.
> 
> Our int wrappers would be a lot easier to write if libc had a
> guaranteed 32-bit parser even on platforms with 64-bit long.
> 
> Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/unit/test-cutils.c | 11 +++++------
>  util/cutils.c            | 14 ++++++++++----
>  2 files changed, 15 insertions(+), 10 deletions(-)

cc'ing qemu-stable as this is a bug fix, but given its age, it's not a
recent regression and therefore probably not essential for backport

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


