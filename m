Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E17C8621
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHbP-00019r-U2; Fri, 13 Oct 2023 08:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHbE-0000xV-Jb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHbB-0000gc-4B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697201339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHvCOv/NcL1Stol9ZafkgoTC91c8c0SQkuo16+WgedI=;
 b=IjDjftdIZ/jGVSGFZjU8Qq+ikzzwOqJLwtYmOcBzk+ux4uQeOFWh9gWw5pfddhZLubEJCj
 KnXcMhDRKHqMgS2ZwxENBoG9v36bK1KSDxCyCPjt3x7lu1Pupeiqhko1CDINAPI2DfcBAX
 wsz2jJ6TPDrdnSJ7n4KYytJ1KT0bz1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-f8MjhHa6OqG0o1oLoUMW_A-1; Fri, 13 Oct 2023 08:48:55 -0400
X-MC-Unique: f8MjhHa6OqG0o1oLoUMW_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 597FD85A5BA;
 Fri, 13 Oct 2023 12:48:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2F8492BFA;
 Fri, 13 Oct 2023 12:48:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 034F321E6A21; Fri, 13 Oct 2023 14:48:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,  libvir-list@redhat.com,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 01/10] migration: Improve json and formatting
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-2-quintela@redhat.com>
Date: Fri, 13 Oct 2023 14:48:53 +0200
In-Reply-To: <20231013104736.31722-2-quintela@redhat.com> (Juan Quintela's
 message of "Fri, 13 Oct 2023 12:47:27 +0200")
Message-ID: <87bkd2hemi.fsf@pond.sub.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  qapi/migration.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d7dfaa5db9..6865fea3c5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -73,7 +73,7 @@
>  { 'struct': 'MigrationStats',
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int',
> -           'skipped': { 'type': 'int', 'features': ['deprecated'] },
> +           'skipped': { 'type': 'int', 'features': [ 'deprecated' ] },
>             'normal': 'int',
>             'normal-bytes': 'int', 'dirty-pages-rate': 'int',
>             'mbps': 'number', 'dirty-sync-count': 'int',
> @@ -440,10 +440,9 @@
>  #     compress and xbzrle are both on, compress only takes effect in
>  #     the ram bulk stage, after that, it will be disabled and only
>  #     xbzrle takes effect, this can help to minimize migration
> -#     traffic.  The feature is disabled by default.  (since 2.4 )
> +#     traffic.  The feature is disabled by default.  (since 2.4)
>  #
> -# @events: generate events for each migration state change (since 2.4
> -#     )
> +# @events: generate events for each migration state change (since 2.4)
>  #
>  # @auto-converge: If enabled, QEMU will automatically throttle down
>  #     the guest to speed up convergence of RAM migration.  (since 1.6)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


