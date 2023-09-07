Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD3797E0F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 23:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeMmP-0002Ne-16; Thu, 07 Sep 2023 17:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeMmM-0002N3-OG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 17:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeMmK-0000hy-HF
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 17:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694122987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szcbRwJa7anoBRI+DZFNInj/kiQrO27HA2krkLo0H+c=;
 b=Zzaq0xtW/8iCqdUCSGuyzLXl0LSLES6sVAEC0slAv7Cf5oXkLiK0cMZnbBwlMnQzws4rat
 BRf4fwBLcpKlpvcvJwgKmlFtrbdTst/xiwZN9oDNbWL6Y05CSMsTSskm58f4adxooLCZtx
 +9N0jB+n2mL2w0yqV87sh33ljrTRJB4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-5pUdwW4pMPOOKFqHRJU7Zg-1; Thu, 07 Sep 2023 17:43:04 -0400
X-MC-Unique: 5pUdwW4pMPOOKFqHRJU7Zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58E5B29ABA22;
 Thu,  7 Sep 2023 21:43:03 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA03E2012F37;
 Thu,  7 Sep 2023 21:43:02 +0000 (UTC)
Date: Thu, 7 Sep 2023 16:43:01 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 3/8] qemu-nbd: move srcpath into struct NbdClientOpts
Message-ID: <aldkq2zlyzdwu3li3gruinwr2442ygescmhmpmrheyucr6a65w@5u56epsqbe2p>
References: <20230906093210.339585-1-den@openvz.org>
 <20230906093210.339585-4-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906093210.339585-4-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Wed, Sep 06, 2023 at 11:32:05AM +0200, Denis V. Lunev wrote:
> We pass other parameters into nbd_client_thread() in this way. This patch
> makes the code more consistent.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

> @@ -1059,19 +1060,19 @@ int main(int argc, char **argv)
>      bdrv_init();
>      atexit(qemu_nbd_shutdown);
>  
> -    srcpath = argv[optind];
> +    opts.srcpath = argv[optind];
>      if (imageOpts) {
> -        QemuOpts *opts;
> +        QemuOpts *o;
>          if (fmt) {
>              error_report("--image-opts and -f are mutually exclusive");
>              exit(EXIT_FAILURE);
>          }
> -        opts = qemu_opts_parse_noisily(&file_opts, srcpath, true);
> -        if (!opts) {
> +        o = qemu_opts_parse_noisily(&file_opts, opts.srcpath, true);
> +        if (!o) {

Hmm - this would have been flagged by -Wshadow, and there are other
series working to clean up tree-wide issues that shadowing can cause.
Looking again, the shadowing was previously introduced before this
series, but only when HAVE_NBD_DEVICE was defined; then patch 2/8 made
the shadowing unconditional.  Reworking the series to clean up the
shadowing earlier in 2/8 is just churn, so I don't mind that it took
us to this point to notice it; however, I'm inclined to add a note to
the commit message that it is a (happy) side-effect.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


