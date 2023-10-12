Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD787C6D90
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtWj-0003De-6l; Thu, 12 Oct 2023 07:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqtWg-0003Cv-Mq
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqtWe-0000dH-NI
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697108803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lID0uzad8aLdFk9HF4k0VVWM7tqDQOgIasuKpwq0Phg=;
 b=AN/7GQ3CpsawZlGgtaowBr2kJw+UuCPBf2imLW4LwSw5TrP5XuV9mJj/nxxCGO1wKSXSGv
 4tLEVkDNwY7wmZ9H7p1gcO7Wsw84FPPdMMDvd/xQVnUeq3asKU9ZTDVhAUG9wUxu64d9+x
 +chogsKhC8ZhdWQocRgP6/qdgO23PNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-6xaJyUisP6uRUOpOm49ylQ-1; Thu, 12 Oct 2023 07:06:38 -0400
X-MC-Unique: 6xaJyUisP6uRUOpOm49ylQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6AD8663E6;
 Thu, 12 Oct 2023 11:06:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22281111CD23;
 Thu, 12 Oct 2023 11:06:36 +0000 (UTC)
Date: Thu, 12 Oct 2023 13:06:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Leonardo Bras <leobras@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v3 3/4] migration: Deprecate block migration
Message-ID: <ZSfTOqKhTGJqoAkh@redhat.com>
References: <20231011204711.9744-1-quintela@redhat.com>
 <20231011204711.9744-4-quintela@redhat.com>
 <87r0m0yxb2.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0m0yxb2.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.10.2023 um 12:01 hat Markus Armbruster geschrieben:
> Juan Quintela <quintela@redhat.com> writes:
> 
> > It is obsolete.  It is better to use driver-mirror with NBD instead.
> 
> drive-mirror
> 
> Several more below.

Actually, blockdev-mirror, please. We don't want to move people from the
oldest way to the next oldest one. Pointing them to the modern way makes
more sense.

> >
> > CC: Kevin Wolf <kwolf@redhat.com>
> > CC: Eric Blake <eblake@redhat.com>
> > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > CC: Hanna Czenczek <hreitz@redhat.com>
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>

Kevin


