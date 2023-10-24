Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19BB7D46E3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 07:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv9vc-00075R-O3; Tue, 24 Oct 2023 01:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qv9va-00074G-GA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qv9vY-0008Pu-Mi
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698125163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HEoOnph3bWceyM0BA5dpdgHNmGyrz9LsyrNCMJxMws=;
 b=KZp9QmN25H+lz88oQ9E25+YVnW2Qkbn7tetu3bhoI348NIamC8ZT6ujvRuE84ksHBo43Of
 CQhP/6R5JE8LTMLV2KcI9JAZGjzKRodX1g6UXk1MnmwlsCJdW6850jrnINvOFlbvRsEOs/
 /1HEc6yagY+Qo57aScGwJ12lp1o4hlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Rxwe5XHCNZi2XtFmJ_HNRg-1; Tue, 24 Oct 2023 01:25:59 -0400
X-MC-Unique: Rxwe5XHCNZi2XtFmJ_HNRg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62DB384AEA1;
 Tue, 24 Oct 2023 05:25:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40B57492BD9;
 Tue, 24 Oct 2023 05:25:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 332DF21E6A1F; Tue, 24 Oct 2023 07:25:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
Date: Tue, 24 Oct 2023 07:25:58 +0200
In-Reply-To: <20231023203608.26370-7-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 17:35:45 -0300")
Message-ID: <87r0lkvbfd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

> Add a capability that allows the management layer to delegate to QEMU
> the decision of whether to pause a VM and perform a non-live
> migration. Depending on the type of migration being performed, this
> could bring performance benefits.
>
> Note that the capability is enabled by default but at this moment no
> migration scheme is making use of it.

This sounds as if the capability has no effect unless the "migration
scheme" (whatever that may be) opts into using it.  Am I confused?

> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index db3df12d6c..74f12adc0e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -523,6 +523,10 @@
>  #     and can result in more stable read performance.  Requires KVM
>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
> +# @auto-pause: If enabled, allows QEMU to decide whether to pause the
> +#     VM before migration for an optimal migration performance.
> +#     Enabled by default. (since 8.1)

If this needs an opt-in to take effect, it should be documented.

> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -539,7 +543,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit'] }
> +           'dirty-limit', 'auto-pause'] }
>  
>  ##
>  # @MigrationCapabilityStatus:


