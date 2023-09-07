Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E19797EA9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeNHg-00027m-LS; Thu, 07 Sep 2023 18:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeNHY-00025K-29
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 18:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeNHQ-0003M4-To
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 18:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694124913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ewz41QGnf5r17tGA6heTggsSbrW+4Q7rBV60rBy0clM=;
 b=JBAzdnzoeIRvIcrr1p9UX+Ipf7IC6xRxZ5UQsdyTq2AXBavNEja2s4ZfQwkCRRfBbT4OES
 iy2Nms0LFWeblARmgnBouyv5r8y+S6DwIfj/qNQk/Kfw1ycuVN6dPV+AYYYTMrNkItNi7W
 CT4Vydh6ryej0vas+gqmJ2vuTPIT4IE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-tm6JRJdfNJ6VqJxSrS8T0A-1; Thu, 07 Sep 2023 18:15:11 -0400
X-MC-Unique: tm6JRJdfNJ6VqJxSrS8T0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 795631817929;
 Thu,  7 Sep 2023 22:15:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70A4C412F2D4;
 Thu,  7 Sep 2023 22:15:10 +0000 (UTC)
Date: Thu, 7 Sep 2023 17:15:08 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 8/8] qemu-nbd: fix formatting in main()
Message-ID: <ta6mmemj4hcg6rre5k6hunymh2hihhtmlbqa56jf4fz5h6pau3@e2ialxuwurae>
References: <20230906093210.339585-1-den@openvz.org>
 <20230906093210.339585-9-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906093210.339585-9-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 06, 2023 at 11:32:10AM +0200, Denis V. Lunev wrote:
> Just a formatting, no functional changes.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> Do not really sure that this patch is mandatory, just stabs my eye. Feel free
> to drop if this is too useless.
> 
>  qemu-nbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index b9c74ce77c..8eb1d1f40b 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -581,7 +581,8 @@ int main(int argc, char **argv)
>      pthread_t client_thread;
>      const char *fmt = NULL;
>      Error *local_err = NULL;
> -    BlockdevDetectZeroesOptions detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
> +    BlockdevDetectZeroesOptions detect_zeroes =
> +                                            BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;

check-patch allows code up to 90 columngs although it does advise
staying under 80.  You fixed the long line by keeping the wrapped
portion right-flushed to 80 columns; I think more typical tree-wide is
to just indent by four spaces (at least, that's what emacs suggests I
do).  But me changing what you wrote would a complete rewrite, so I'm
reluctant to include it in my upcoming pull request, although I'm not
ruling out a later cleanup (perhaps if it touches more than one
stylistic thing at once).

I'm queuing 1-7 through my NBD tree, and running another round of
iotests before sending the pull request this week.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


