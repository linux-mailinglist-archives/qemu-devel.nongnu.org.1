Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB397D46EE
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 07:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvA30-0001IX-GY; Tue, 24 Oct 2023 01:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvA2x-0001Hv-Pg
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvA2w-0001GP-4v
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698125620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2S/cPEjx0Mu1ahqSAWxy0Q5ppS1XGigbe0/WSd4mSk=;
 b=XeqIBtUHzv5xaeIcgLXsPah6/lkEgnXhElgVBGEtroTYLkPPZ2/EZO6YG7QrMSWT9jsazX
 ag+tChSFZuAgQlZuTRLlWtUTTmXwOK1BG7QfYHNihuj28ah2m94BpfrPqr02TUrjLWuViC
 9NyBusBUdUoIFyRytkVT4vwjCB1RsXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-QhDH6B5mOUa7RrMazww_gw-1; Tue, 24 Oct 2023 01:33:37 -0400
X-MC-Unique: QhDH6B5mOUa7RrMazww_gw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAD10101A594;
 Tue, 24 Oct 2023 05:33:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 896BB492BFB;
 Tue, 24 Oct 2023 05:33:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3845621E6A1F; Tue, 24 Oct 2023 07:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 14/29] migration/ram: Introduce 'fixed-ram' migration
 capability
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-15-farosas@suse.de>
Date: Tue, 24 Oct 2023 07:33:34 +0200
In-Reply-To: <20231023203608.26370-15-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 23 Oct 2023 17:35:53 -0300")
Message-ID: <87fs20vb2p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

> Add a new migration capability 'fixed-ram'.
>
> The core of the feature is to ensure that each ram page has a specific
> offset in the resulting migration stream. The reason why we'd want
> such behavior are two fold:
>
>  - When doing a 'fixed-ram' migration the resulting file will have a
>    bounded size, since pages which are dirtied multiple times will
>    always go to a fixed location in the file, rather than constantly
>    being added to a sequential stream. This eliminates cases where a vm
>    with, say, 1G of ram can result in a migration file that's 10s of
>    GBs, provided that the workload constantly redirties memory.
>
>  - It paves the way to implement DIRECT_IO-enabled save/restore of the
>    migration stream as the pages are ensured to be written at aligned
>    offsets.
>
> For now, enabling the capability has no effect. The next couple of
> patches implement the core funcionality.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/devel/migration.rst | 14 ++++++++++++++
>  migration/options.c      | 37 +++++++++++++++++++++++++++++++++++++
>  migration/options.h      |  1 +
>  migration/savevm.c       |  1 +
>  qapi/migration.json      |  5 ++++-
>  5 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index c3e1400c0c..6f898b5dbd 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -566,6 +566,20 @@ Others (especially either older devices or system devices which for
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
> +page has a fixed offset in the resulting migration stream.

This requires the migration stream to be seekable, as documented in the
QAPI schema below.  I think it's worth documenting here, as well.

> +
> +The ``fixed-ram`` capaility can be enabled in both source and
> +destination with:
> +
> +    ``migrate_set_capability fixed-ram on``

Effect of enabling on the destination?

What happens when we enable it only on one end?

> +
>  Return path
>  -----------
>  

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 74f12adc0e..1317dd32ab 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -527,6 +527,9 @@
>  #     VM before migration for an optimal migration performance.
>  #     Enabled by default. (since 8.1)
>  #
> +# @fixed-ram: Migrate using fixed offsets for each RAM page. Requires

Two spaces between sentences for consistency, please.

> +#             a seekable transport such as a file.  (since 8.1)

What is a migration transport?  migration.json doesn't define the term.

Which transports are seekable?

Out of curiosity: what happens if the transport isn't seekable?

> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -543,7 +546,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'auto-pause'] }
> +           'dirty-limit', 'auto-pause', 'fixed-ram'] }
>  
>  ##
>  # @MigrationCapabilityStatus:


