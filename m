Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F27CD860
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:39:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt30r-0006r6-Lx; Wed, 18 Oct 2023 05:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt30q-0006lh-5G
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt30o-0001mC-PL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697621926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hj9Vtm632v1qo+xzuQat19I8pwvHgkKbJTuHca24NPc=;
 b=I122vK86rud9V26M7UEpez3JqodUErAIwhUBcm/dPHJsh31/MaHnEtbc1lt9VhvfuxqYy+
 gMu3BKmxYv7phixCP/g827B7yWfv6TEs3ORnFlxizgyZDiMqVicwNgoILx/S9Eyvv1tQVF
 L53nzo8MDHZuUcaGHnhz0Fgd68dL4b0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-l7IELpikNo-iFIyzvBNZ2g-1; Wed, 18 Oct 2023 05:38:42 -0400
X-MC-Unique: l7IELpikNo-iFIyzvBNZ2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 531A31C2B66C;
 Wed, 18 Oct 2023 09:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 309DBC15BB8;
 Wed, 18 Oct 2023 09:38:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C7DD21E6A1F; Wed, 18 Oct 2023 11:38:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  den@virtuozzo.com,  t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 5/9] mirror: implement mirror_change method
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-6-f.ebner@proxmox.com>
Date: Wed, 18 Oct 2023 11:38:41 +0200
In-Reply-To: <20231013092143.365296-6-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 13 Oct 2023 11:21:39 +0200")
Message-ID: <87pm1cuv6m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fiona Ebner <f.ebner@proxmox.com> writes:

> which allows switching the @copy-mode from 'background' to
> 'write-blocking'.
>
> This is useful for management applications, so they can start out in
> background mode to avoid limiting guest write speed and switch to
> active mode when certain criteria are fulfilled.
>
> In presence of an iothread, the copy_mode member is now shared between
> the iothread and the main thread, so turn accesses to it atomic.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c6f31a9399..01427c259a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3044,6 +3044,17 @@
>  { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
>    'allow-preconfig': true }
>  
> +##
> +# @BlockJobChangeOptionsMirror:
> +#
> +# @copy-mode: Switch to this copy mode. Currenlty, only the switch

Typo: Currently

Also, two spaces between sentences for consistency, please.

> +#     from 'background' to 'write-blocking' is implemented.
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'BlockJobChangeOptionsMirror',
> +  'data': { 'copy-mode' : 'MirrorCopyMode' } }
> +
>  ##
>  # @BlockJobChangeOptions:
>  #
> @@ -3058,7 +3069,7 @@
>  { 'union': 'BlockJobChangeOptions',
>    'base': { 'id': 'str', 'type': 'JobType' },
>    'discriminator': 'type',
> -  'data': {} }
> +  'data': { 'mirror': 'BlockJobChangeOptionsMirror' } }
>  
>  ##
>  # @block-job-change:


