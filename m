Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A4C1C8AD
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 18:45:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEAAP-0001Ue-Fe; Wed, 29 Oct 2025 13:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEA9w-00017Q-PE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEA9o-0004Rv-2U
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761759615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OcNUmC7upxxIyk0/z4M4iVFHtq1JgHRGKEpzGJa4iU=;
 b=XnhcnhYI71umynLotreu2l6aTir8q7/fM7fJF+rNQg/bEDXGbHqUGbVHlkWZTZYr/ugJrT
 rilBSfaEc1UDXU30jcRGQZyRdw6iDm1+iV4kO3bTumlRtPuEE0INdHUVckoXuAmnkDDWZB
 dLuCY/gl1iL8VwkkjCiji8lRrpmqT0g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-p9Uiz0hLPsqTOEPEJn9ARA-1; Wed,
 29 Oct 2025 13:40:11 -0400
X-MC-Unique: p9Uiz0hLPsqTOEPEJn9ARA-1
X-Mimecast-MFC-AGG-ID: p9Uiz0hLPsqTOEPEJn9ARA_1761759607
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E6901800673; Wed, 29 Oct 2025 17:40:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 097AB19540E9; Wed, 29 Oct 2025 17:40:01 +0000 (UTC)
Date: Wed, 29 Oct 2025 18:39:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 07/16] nvme: Kick and check completions in BDS context
Message-ID: <aQJRb3OnQSa7dRbV@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-8-hreitz@redhat.com>
 <aQJNdeSL9Sh_UMuf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQJNdeSL9Sh_UMuf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 29.10.2025 um 18:23 hat Kevin Wolf geschrieben:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
> > nvme_process_completion() must run in the main BDS context, so schedule
> > a BH for requests that aren’t there.
> > 
> > The context in which we kick does not matter, but let’s just keep kick
> > and process_completion together for simplicity’s sake.
> 
> Ok, fair, move the main BDS context for calling these functions. But
> doesn't that mean that we need to move back to the request context for
> calling the callback?
> 
> In particular, I see this:
> 
>     static void nvme_rw_cb_bh(void *opaque)
>     {
>         NVMeCoData *data = opaque;
>         qemu_coroutine_enter(data->co);
>     }
> 
> The next patch changes some things about coroutine wakeup, but it
> doesn't touch this qemu_coroutine_enter(). So I think the coroutine is
> now running in the wrong thread.

It actually isn't because the patch changes in which AioContext the BH
is called. Quite confusing with all the indirections. Let's get rid of
the BH with qemu_coroutine_enter() and just call aio_co_wake() directly.

Kevin

> I also feel that it gets a bit confusing what is running in which
> context, so maybe we can add comments to each of the callbacks telling
> that they are running in main BDS context or request coroutine context.
> 
> > (For what it’s worth, a quick fio bandwidth test indicates that on my
> > test hardware, if anything, this may be a bit better than kicking
> > immediately before scheduling a pure nvme_process_completion() BH.  But
> > I wouldn’t take more from those results than that it doesn’t really seem
> > to matter either way.)
> > 
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> 
> Kevin


