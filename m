Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793777D665F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZuQ-00005b-J8; Wed, 25 Oct 2023 05:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvZuE-0008Ht-Uh
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvZu9-0006ZI-3R
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225019;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6DCwq5A2XFI0L9B2ko4D9fHuDvQ7eNoejGPsJbi5kw=;
 b=g9gYH//4urxtNjRclAH+B2HRKFxe+2B4B0qwGSUQIlURip19thFKmp+gj50w61viLUM0CG
 u5N8fAS39y0MiMERPhrOeHQRm1nOqtSsWTDJCk1GKXXd0fFokDwzymARSV574sfmm1LdPg
 ss/gs9rd2Slcd2NCgLgvmwjw9+HHIK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-Yw6g07enPG2ndBb5cZqoVA-1; Wed, 25 Oct 2023 05:10:02 -0400
X-MC-Unique: Yw6g07enPG2ndBb5cZqoVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05C3D101A529;
 Wed, 25 Oct 2023 09:10:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E84BB1C060AE;
 Wed, 25 Oct 2023 09:10:00 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:09:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 24/29] migration/ram: Ignore multifd flush when doing
 fixed-ram migration
Message-ID: <ZTjbZgIfzadO8iuz@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-25-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023203608.26370-25-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:36:03PM -0300, Fabiano Rosas wrote:
> Some functionalities of multifd are incompatible with the 'fixed-ram'
> migration format.
> 
> The MULTIFD_FLUSH flag in particular is not used because in fixed-ram
> there is no sinchronicity between migration source and destination so
> there is not need for a sync packet. In fact, fixed-ram disables
> packets in multifd as a whole.
> 
> Make sure RAM_SAVE_FLAG_MULTIFD_FLUSH is never emitted when fixed-ram
> is enabled.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 8e34c1b597..3497ed186a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1386,7 +1386,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (migrate_multifd() &&
> +            if (!migrate_fixed_ram() && migrate_multifd() &&

If I'm nitpicking I would put migrate_multifd() first in the
conditional, because fixed-ram is a sub-feature of multifd.

Either way though

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


>                  !migrate_multifd_flush_after_each_section()) {
>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_send_sync_main(f);
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


