Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F767CCFE4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssIA-0000XU-QD; Tue, 17 Oct 2023 18:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qssI8-0000XC-Rt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qssI7-0002Bs-7b
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697580714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4XpVbJ8SPpdXJKO0HlFVL0QBCotqfPnhl3G0UO16DHA=;
 b=dYg5NOy0K3okq27hvz18+wj4oKpyllkC3GWip1fK9YI9tA+VPcOsicYF2m3rq4SLyNaa8I
 ylBLj+16vIw3vTwvp3GvsEngxNizfscuzpRm0zKgzYoZvgNKGbU71JRIVI3bTXAXlScMSk
 l9vpCHsv4YENd11z/iU/yQEohxvQVoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-GDgg8Qv7Nx2CwMT1gCSbtA-1; Tue, 17 Oct 2023 18:11:50 -0400
X-MC-Unique: GDgg8Qv7Nx2CwMT1gCSbtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B621855310;
 Tue, 17 Oct 2023 22:11:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09BEB1C060B0;
 Tue, 17 Oct 2023 22:11:49 +0000 (UTC)
Date: Tue, 17 Oct 2023 17:11:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Subject: Re: [RFC PATCH v2 04/78] qapi/opts-visitor: add fallthrough
 pseudo-keyword
Message-ID: <z44yrbxsvk4vqozjqikrmuubidpje5tusumrg5ittwz6zjaw6b@zm4b3lmcnqan>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <da9d0ba48a5be92f212e6bc04710803ca0ffa7b3.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9d0ba48a5be92f212e6bc04710803ca0ffa7b3.1697183699.git.manos.pitsidianakis@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 13, 2023 at 10:56:31AM +0300, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  qapi/opts-visitor.c         | 1 +
>  qapi/string-input-visitor.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


