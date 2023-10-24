Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4ED7D46FE
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 07:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAAT-0004Sg-Dm; Tue, 24 Oct 2023 01:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvAAR-0004RX-1i
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvAAP-0002iR-Fs
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698126084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5DQ+NMoxi5b1s7fhqQ2jpKc/hBEEr4hjOtri/WtV/U=;
 b=UbcRoY7WTrO5lpwuNuUzIIa3WqC87R0iVjWrZTt5vF40EagFQe/n9h8dLOexek/18rd3k0
 cBaL04fVaGZ/XBzQbfMIoN0xTl9FADMeCy+fsPPob4ZZfdc8EVrihKNGhcUUBsv89zUU+q
 WaDw60Gk9DDFn+WrVvhJJD7kuis7ZaA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-UY_2TTDMOzO_TAwSZx0aCw-1; Tue,
 24 Oct 2023 01:41:20 -0400
X-MC-Unique: UY_2TTDMOzO_TAwSZx0aCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 364A538062A7;
 Tue, 24 Oct 2023 05:41:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 139E41121318;
 Tue, 24 Oct 2023 05:41:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E778021E6A1F; Tue, 24 Oct 2023 07:41:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de>
Date: Tue, 24 Oct 2023 07:41:18 +0200
In-Reply-To: <20231023203608.26370-29-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 23 Oct 2023 17:36:07 -0300")
Message-ID: <878r7svapt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Fabiano Rosas <farosas@suse.de> writes:

> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
>
> This is currently only used for the secondary channels of fixed-ram
> migration, which can guarantee that writes are page aligned.
>
> However the parameter could be made to affect other types of
> file-based migrations in the future.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

When would you want to enable @direct-io, and when would you want to
leave it disabled?

What happens when you enable @direct-io with a migration that cannot use
O_DIRECT?


[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 1317dd32ab..3eb9e2c9b5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -840,6 +840,9 @@
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>  #     Defaults to 1.  (Since 8.1)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. Not
> +#             all migration transports support this. (since 8.1)
> +#

Please format like

   # @direct-io: Open migration files with O_DIRECT when possible.  Not
   #     all migration transports support this.  (since 8.1)

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -864,7 +867,7 @@
>             'multifd-zlib-level', 'multifd-zstd-level',
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
> -           'vcpu-dirty-limit'] }
> +           'vcpu-dirty-limit', 'direct-io'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1016,6 +1019,9 @@
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>  #     Defaults to 1.  (Since 8.1)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. Not
> +#             all migration transports support this. (since 8.1)
> +#

Likewise.

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1058,7 +1064,8 @@
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
> -            '*vcpu-dirty-limit': 'uint64'} }
> +            '*vcpu-dirty-limit': 'uint64',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1230,6 +1237,9 @@
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>  #     Defaults to 1.  (Since 8.1)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. Not
> +#             all migration transports support this. (since 8.1)
> +#

Likewise.

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1269,7 +1279,8 @@
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
> -            '*vcpu-dirty-limit': 'uint64'} }
> +            '*vcpu-dirty-limit': 'uint64',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:

This one is for the migration maintainers: we have MigrationCapability,
set with migrate-set-capabilities, and MigrationParameters, set with
migrate-set-parameters.  For a boolean configuration setting, either
works.  Which one should we use when?

[...]


