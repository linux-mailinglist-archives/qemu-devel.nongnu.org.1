Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D07988AB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:28:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecTI-00070l-Vn; Fri, 08 Sep 2023 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qecTA-0006s8-HW
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qecT3-0003m8-3X
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTYzSqr0mxQict/WIQcKZfztEsXGvr/1XKwA9lEYcRE=;
 b=O0Z8H7czpNA8rcjMoJGEuZedJqU9i11i6VDr1+wm3zkd8+t/r+qQV4zwHOnOGGpywvmUEL
 WSuQ4kk8JX1fO9c3+vmrbbAybaO5itlBGHfOhXO0tAAS7xn9pilH/GJYroPAODt+CTYmyd
 YMKFSgmHYpmuGvsSz+GzPvPuXMa6pUU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-3akXuvXtOtunz4KeWmY_WA-1; Fri, 08 Sep 2023 10:28:12 -0400
X-MC-Unique: 3akXuvXtOtunz4KeWmY_WA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57576280D584;
 Fri,  8 Sep 2023 14:28:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 790B721EE566;
 Fri,  8 Sep 2023 14:28:11 +0000 (UTC)
Date: Fri, 8 Sep 2023 15:28:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH V5 1/2] migration: file URI
Message-ID: <ZPsveSauup24WXtK@redhat.com>
References: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
 <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 08, 2023 at 07:22:10AM -0700, Steve Sistare wrote:
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be
> used as an alternative to 'exec:cat > file' in minimized containers that
> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
> It can be used in HMP commands, and as a qemu command-line parameter.
> 
> For best performance, guest ram should be shared and x-ignore-shared
> should be true, so guest pages are not written to the file, in which case
> the guest may remain running.  If ram is not so configured, then the user
> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
> the same page, causing it to be appended to the file multiple times,
> and the file may grow unboundedly.  That issue is being addressed in the
> "fixed-ram" patch series.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/file.h       | 14 ++++++++++++
>  migration/meson.build  |  1 +
>  migration/migration.c  |  5 ++++
>  migration/trace-events |  4 ++++
>  qemu-options.hx        |  6 ++++-
>  6 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 migration/file.c
>  create mode 100644 migration/file.h

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


