Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67227AD4008
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 19:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2QX-0007a1-CN; Tue, 10 Jun 2025 13:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP2QO-0007R8-7k
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP2QM-0004zv-IN
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749575167;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SjzsZmC3fCn150B3hwMh5JWwz1oxCXshyj5qDRiKeb0=;
 b=STlExGkFQZnsBXx0X2CqThFuFVkl1zzrY5B84FcWk6/g7bwKCEU6cBqOXlEVxqt6+5JmrZ
 OYl/PKkJX5981yydkqNSbCpu+0gIVtnFn+M17fntkm1wgYITRfbyhzlwTYBpQd2tYkp6ZG
 FI0dbPUe0r92fDdFxzHFKyNkAblpKzI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-EkhQG4ldPJqCXUpOLvJJrQ-1; Tue,
 10 Jun 2025 13:06:05 -0400
X-MC-Unique: EkhQG4ldPJqCXUpOLvJJrQ-1
X-Mimecast-MFC-AGG-ID: EkhQG4ldPJqCXUpOLvJJrQ_1749575164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ADD5180029E; Tue, 10 Jun 2025 17:06:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41D7F19560B2; Tue, 10 Jun 2025 17:06:00 +0000 (UTC)
Date: Tue, 10 Jun 2025 18:05:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 peterx@redhat.com, farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
Message-ID: <aEhl9S6Xf09VRnkK@redhat.com>
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610150849.326194-1-jhkim@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 10, 2025 at 10:08:49AM -0500, Jaehoon Kim wrote:
> When the source VM attempts to connect to the destination VM's Unix
> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
> occur if the socket file isn't ready. This can lead to connection
> failures when running tests.
> 
> This patch creates and listens on the socket in advance, and passes the
> pre-listened FD directly. This avoids timing issues and improves the
> reliability of CPR tests.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> 
> ---
> Changes since v1:
> - In v1, the patch added a wait loop to poll the existence of the socket
>   file (cpr_validate_socket_path()).
> 
> - This version instead creates the socket beforehand and passes its FD
>   to the destination QEMU, eliminating the race condition entirely.
> 
> - Commit title and message changed accordingly.
> ---
>  migration/cpr-transfer.c          |  3 +-
>  tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f140359c..7c9de70bad 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>      MigrationAddress *addr = channel->addr;
>  
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> -        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
> +        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
>  
>          g_autoptr(QIOChannelSocket) sioc = NULL;
>          SocketAddress *saddr = &addr->u.socket;

This will likely cause a crash in tracing code that is below this diff:

        trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);

q_unix.path is NOT valid to access with TYPE_FD.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


