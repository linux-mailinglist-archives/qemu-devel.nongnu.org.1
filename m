Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7238D70831E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdkP-0005Hq-Fe; Thu, 18 May 2023 09:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzdkN-0005H2-S7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzdkM-0006P6-AT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684416765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KV0ZLxSuW5t5tqUkF6NOlfKzMGv527wZcGWEtMuTRZs=;
 b=MjG+CxSLKRZZULGuyCXIeF9YVugb2vakD8WBUiwfiqdKNyA+Xg7d8va36VK4hoY31IbevD
 8czk5r4aCENnVQn3geoPn4caAjy2FlvWLryBFpPGcGBKsyzY8Av34h98eqvvoCVi6SberU
 fkY2EjnvUbttC+cJAXIK1+ODHBkvngc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-ptGQ77n9MEurb2l2Hrb46A-1; Thu, 18 May 2023 09:32:39 -0400
X-MC-Unique: ptGQ77n9MEurb2l2Hrb46A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C6E785A588;
 Thu, 18 May 2023 13:32:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D703740C6EC4;
 Thu, 18 May 2023 13:32:38 +0000 (UTC)
Date: Thu, 18 May 2023 08:32:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v8.0.1 00/36] Patch Round-up for stable 8.0.1, freeze on
 2023-05-27
Message-ID: <jwgbzdtl72ewm2nzsil3fp2ie7f3gysqsfgsw5kr5g7fst2qgb@hc7v7yxk6mci>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Wed, May 17, 2023 at 11:00:20AM +0300, Michael Tokarev wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v8.0.1:
> 
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0
> 
> Patch freeze is 2023-05-27, and the release is planned for 2023-06-29:
> 
>   https://wiki.qemu.org/Planning/8.0
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> I'd like to include a few more changes in 8.0.1 release, for example
> https://lore.kernel.org/all/20230301142926.18686-1-yuval.shaia.ml@gmail.com/
> "hw/pvrdma: Protect against buggy or malicious guest driver", and especially
> https://lore.kernel.org/all/20230503002701.854329-1-leobras@redhat.com/
> "hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < 8.0"
> and a few others, but we can wait forever.  I pinged patches which seems
> like should be in -stable.

Here's a trio probably worth including:

403d18ae384 migration: Handle block device inactivation fa
5d39f44d7ac migration: Minor control flow simplification
6dab4c93ecf migration: Attempt disk reactivation in more f

(the middle one is pointless on its own, but reduces conflict
resolution in the third)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


