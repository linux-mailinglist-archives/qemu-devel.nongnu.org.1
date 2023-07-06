Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB074A047
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 17:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQS7-0003HN-Lp; Thu, 06 Jul 2023 10:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQS1-0003H6-LL
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQRy-0003Bl-Fm
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688655557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jr15GtauzOZy4UNNTLDRlqgzGqok5Y017suwWAGDhnA=;
 b=WnsGeVIv70guII8mZlo4AJyvWDeMHuaJbhjksZ6LcmujwBNSAVvbCTFUyTgIpabz4E2ypl
 GSuhzaD8JvQM5rj0UK5g8/pLFodOuRhh8S/DU5tDjFuqV9oCMSciVOAYojVy6tQNJavtE8
 5YH6v6GhGnB29RVU7BFo75pl1CWockU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-8KlKpdTGNTiA3O2g1LgQow-1; Thu, 06 Jul 2023 10:59:13 -0400
X-MC-Unique: 8KlKpdTGNTiA3O2g1LgQow-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3C0A185A794;
 Thu,  6 Jul 2023 14:59:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91B57492B02;
 Thu,  6 Jul 2023 14:59:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8588F21E6A1F; Thu,  6 Jul 2023 16:59:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v7 4/9] migration: Introduce dirty-limit capability
References: <168853615963.17240.15832775267134683267-4@git.sr.ht>
Date: Thu, 06 Jul 2023 16:59:11 +0200
In-Reply-To: <168853615963.17240.15832775267134683267-4@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 23:30:50 +0800")
Message-ID: <877crdozls.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

~hyman <hyman@git.sr.ht> writes:

> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce migration dirty-limit capability, which can
> be turned on before live migration and limit dirty
> page rate durty live migration.
>
> Introduce migrate_dirty_limit function to help check
> if dirty-limit capability enabled during live migration.
>
> Meanwhile, refactor vcpu_dirty_rate_stat_collect
> so that period can be configured instead of hardcoded.
>
> dirty-limit capability is kind of like auto-converge
> but using dirty limit instead of traditional cpu-throttle
> to throttle guest down. To enable this feature, turn on
> the dirty-limit capability before live migration using
> migrate-set-capabilities, and set the parameters
> "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
> to speed up convergence.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

[...]

> diff --git a/migration/options.h b/migration/options.h
> index 9aaf363322..b5a950d4e4 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -24,6 +24,7 @@ extern Property migration_properties[];
>  /* capabilities */
>=20=20
>  bool migrate_auto_converge(void);
> +bool migrate_dirty_limit(void);
>  bool migrate_background_snapshot(void);
>  bool migrate_block(void);
>  bool migrate_colo(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index aa590dbf0e..cc51835cdd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -497,6 +497,16 @@
>  #     are present.  'return-path' capability must be enabled to use
>  #     it.  (since 8.1)
>  #
> +# @dirty-limit: If enabled, migration will use the dirty-limit algo to
> +#               throttle down guest instead of auto-converge algo.
> +#               Throttle algo only works when vCPU's dirtyrate greater
> +#               than 'vcpu-dirty-limit', read processes in guest os
> +#               aren't penalized any more, so this algo can improve
> +#               performance of vCPU during live migration. This is an
> +#               optional performance feature and should not affect the
> +#               correctness of the existing auto-converge algo.
> +#               (since 8.1)
> +#

Please format like

   # @dirty-limit: If enabled, migration will use the dirty-limit algo to
   #     throttle down guest instead of auto-converge algo.  Throttle
   #     algo only works when vCPU's dirtyrate greater than
   #     'vcpu-dirty-limit', read processes in guest os aren't penalized
   #     any more, so this algo can improve performance of vCPU during
   #     live migration.  This is an optional performance feature and
   #     should not affect the correctness of the existing auto-converge
   #     algo.  (since 8.1)

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

"Dirty rate" with a space, because that's how we spell it elsewhere.

Moreover, "algo" is not a word, "algorithm" is :)

Is "the dirty-limit algorithm" defined anywhere?=20=20

More word-smithing is needed, but I'd like to get the reference to "the
dirty-limit algorithm" clarified first.

>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -512,7 +522,8 @@
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
> -           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
> +           'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> +           'dirty-limit'] }
>=20=20
>  ##
>  # @MigrationCapabilityStatus:

[...]


