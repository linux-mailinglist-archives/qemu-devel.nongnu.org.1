Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989977DCD4C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 13:52:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoCn-0006P7-O2; Tue, 31 Oct 2023 08:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxoCk-0006Ni-TC
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxoCj-00035a-03
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698756642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHfQKndaUPw5IfOY0pZL/2dnUqY0LA19ATkhCaVZf1w=;
 b=OrvudpVgAk28TXwTq2wcfZxUDX4sDsQcNwGaSRHO/vK/QGnCyOl+W2B05xU1/c3iLn3WAv
 IILoqEuDbtQcwjJoZSLWVemREe3l6MhFJHXpuJWFl28lzAw2m4FL8D3zbMBpvmbVj/bsDK
 FFS8WykNOcSy5MB7PFoCeaSkW4NiWC8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-IfAKxWh0MAyy8OWVvsKmDw-1; Tue,
 31 Oct 2023 08:50:34 -0400
X-MC-Unique: IfAKxWh0MAyy8OWVvsKmDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E7F32824766;
 Tue, 31 Oct 2023 12:50:34 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEA5010F4C;
 Tue, 31 Oct 2023 12:50:33 +0000 (UTC)
Date: Tue, 31 Oct 2023 13:50:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] block: Fix locking in media change monitor commands
Message-ID: <ZUD4GI7YfYpSe29m@redhat.com>
References: <20231013153302.39234-1-kwolf@redhat.com>
 <20231013153302.39234-2-kwolf@redhat.com>
 <7dd7cca5-6706-4ecd-9d5b-cc0133053d86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dd7cca5-6706-4ecd-9d5b-cc0133053d86@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 31.10.2023 um 12:54 hat Hanna Czenczek geschrieben:
> On 13.10.23 17:33, Kevin Wolf wrote:
> > blk_insert_bs() requires that the caller holds the AioContext lock for
> > the node to be inserted. Since commit c066e808e11, neglecting to do so
> > causes a crash when the child has to be moved to a different AioContext
> > to attach it to the BlockBackend.
> > 
> > This fixes qmp_blockdev_insert_anon_medium(), which is called for the
> > QMP commands 'blockdev-insert-medium' and 'blockdev-change-medium', to
> > correctly take the lock.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: https://issues.redhat.com/browse/RHEL-3922
> > Fixes: c066e808e11a5c181b625537b6c78e0de27a4801
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/qapi-sysemu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> 
> Do we need to take the lock for the dev_ops tray callbacks, too?  I suppose
> not, and it also wouldn’t really matter in light of the lock being supposed
> to go away anyway, but still thought I should ask.

Seems nobody ever bothered to define what the callbacks expects, and I
don't know either. Not taking the lock can obviously be a problem, but
taking it can also be a problem if the callback then locks a second time
and calls a synchronous function that polls.

What I do see is that callers disagree about this, so no matter what the
correct answer is, I'm almost sure there is a bug hiding somewhere.

Kevin


