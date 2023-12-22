Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89481C837
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:35:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcsK-0006wY-1j; Fri, 22 Dec 2023 05:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcsH-0006sU-63
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcsE-0008Ot-QH
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703241322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+RyOiNs3asN+pE+TkFX9nkoPC2RJZJOHanIeDOWTQ8=;
 b=AAD1e+Bg4dKzbj5Gc1ADOWUSGPRWMR1Vpqa5i9KQTw56Zqww5KCsWSUTiM+s47kYTUACjV
 K/vTa3eD66AHd499wkDih/AWNn4oNvPGzmC/hBYGoxC43DU3N8uVAH2KOlfLHYztzpKHIo
 5256lhCvV7KsmGfoNlu6a1iXncxEYLc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-FggTxAj1OZSSodALHRuu0w-1; Fri,
 22 Dec 2023 05:35:20 -0500
X-MC-Unique: FggTxAj1OZSSodALHRuu0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F081A1C04B75;
 Fri, 22 Dec 2023 10:35:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF5F03C25;
 Fri, 22 Dec 2023 10:35:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBFF621E6920; Fri, 22 Dec 2023 11:35:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH v3 06/30] migration/ram: Introduce 'fixed-ram'
 migration capability
In-Reply-To: <20231127202612.23012-7-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 27 Nov 2023 17:25:48 -0300")
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-7-farosas@suse.de>
Date: Fri, 22 Dec 2023 11:35:18 +0100
Message-ID: <871qbev82h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Fabiano Rosas <farosas@suse.de> writes:

> Add a new migration capability 'fixed-ram'.
>
> The core of the feature is to ensure that each RAM page has a specific
> offset in the resulting migration stream. The reasons why we'd want
> such behavior are:
>
>  - The resulting file will have a bounded size, since pages which are
>    dirtied multiple times will always go to a fixed location in the
>    file, rather than constantly being added to a sequential
>    stream. This eliminates cases where a VM with, say, 1G of RAM can
>    result in a migration file that's 10s of GBs, provided that the
>    workload constantly redirties memory.
>
>  - It paves the way to implement O_DIRECT-enabled save/restore of the
>    migration stream as the pages are ensured to be written at aligned
>    offsets.
>
>  - It allows the usage of multifd so we can write RAM pages to the
>    migration file in parallel.
>
> For now, enabling the capability has no effect. The next couple of
> patches implement the core functionality.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - mentioned seeking on docs
> ---
>  docs/devel/migration.rst | 21 +++++++++++++++++++++
>  migration/options.c      | 34 ++++++++++++++++++++++++++++++++++
>  migration/options.h      |  1 +
>  migration/savevm.c       |  1 +
>  qapi/migration.json      |  6 +++++-
>  5 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index ec55089b25..eeb4fec31f 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -572,6 +572,27 @@ Others (especially either older devices or system devices which for
>  some reason don't have a bus concept) make use of the ``instance id``
>  for otherwise identically named devices.
>  
> +Fixed-ram format
> +----------------
> +
> +When the ``fixed-ram`` capability is enabled, a slightly different
> +stream format is used for the RAM section. Instead of having a
> +sequential stream of pages that follow the RAMBlock headers, the dirty
> +pages for a RAMBlock follow its header. This ensures that each RAM
> +page has a fixed offset in the resulting migration file.
> +
> +The ``fixed-ram`` capability must be enabled in both source and
> +destination with:
> +
> +    ``migrate_set_capability fixed-ram on``
> +
> +Since pages are written to their relative offsets and out of order
> +(due to the memory dirtying patterns), streaming channels such as
> +sockets are not supported. A seekable channel such as a file is
> +required. This can be verified in the QIOChannel by the presence of
> +the QIO_CHANNEL_FEATURE_SEEKABLE. In more practical terms, this
> +migration format requires the ``file:`` URI when migrating.
> +
>  Return path
>  -----------
>  

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index eb2f883513..3b93e13743 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,6 +531,10 @@
>  #     and can result in more stable read performance.  Requires KVM
>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
> +# @fixed-ram: Migrate using fixed offsets for each RAM page.  Requires

Offsets in what?

Clear enough from commit message and doc update, but the doc comment
needs to make sense on its own.

> +#     a migration URI that supports seeking, such as a file.  (since
> +#     8.2)

9.0

> +#
>  # Features:
>  #
>  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> @@ -555,7 +559,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit'] }
> +           'dirty-limit', 'fixed-ram'] }
>  
>  ##
>  # @MigrationCapabilityStatus:


