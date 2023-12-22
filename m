Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C068A81C843
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:38:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcv6-0000EP-Ka; Fri, 22 Dec 2023 05:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcv4-0000EC-GS
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcv2-0002yL-Pu
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703241495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0BSyKkgp4Ck20HWn4xpEfLbAblV38ipvHBs2yMK1ss=;
 b=GTYFHhAxbp1NmNARURLKZipRDqSLAoAzRRvPC1toMjH+GvYtcLx6EvpvGu2G8jCAcwrdTN
 wt51wEvCNv3ZBkHcpQgNuA7Zfxm+CwNf1+xoEC0D1pf7P8vQ2pZYIb0fGB66D8h0Wlwu1R
 Scy2SAJ5jTRe51AsxSLU4ldHJ0Ro/0Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-JeS3pqRrM8aa6HUjW_Zb3A-1; Fri,
 22 Dec 2023 05:38:12 -0500
X-MC-Unique: JeS3pqRrM8aa6HUjW_Zb3A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D43433C02750;
 Fri, 22 Dec 2023 10:38:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B39F9492BFA;
 Fri, 22 Dec 2023 10:38:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE2A821E6920; Fri, 22 Dec 2023 11:38:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH v3 23/30] migration: Add direct-io parameter
In-Reply-To: <20231127202612.23012-24-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 27 Nov 2023 17:26:05 -0300")
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-24-farosas@suse.de>
Date: Fri, 22 Dec 2023 11:38:10 +0100
Message-ID: <87v88qttd9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.

Why is that useful?

> This is currently only used with fixed-ram migration for the multifd
> channels that transfer the RAM pages. Those channels only transfer the
> pages and are guaranteed to perform aligned writes.
>
> However the parameter could be made to affect other types of
> file-based migrations in the future.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3b93e13743..1d38619842 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -878,6 +878,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the 'fixed-ram' capability is enabled. (since 9.0)

Two spaces between sentences for consistency, please.

> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -911,7 +914,8 @@
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
> -           'mode'] }
> +           'mode',
> +           'direct-io'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1066,6 +1070,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1119,7 +1126,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1294,6 +1302,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1344,7 +1355,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:

[...]


