Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01A7C86C4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIBe-0001oX-Gh; Fri, 13 Oct 2023 09:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrIBc-0001nt-1l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrIBZ-0001JY-Gw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697203596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0w3ytkdZmr87N9x1ztoKGvPH8ipAILALFzj5DZsCr+0=;
 b=BJj7E0yelvF7RFwYTgmttwAaBlyTjG3p6dp9+u/hajJQXqdeNl+pIxX2jW6sLsJtT+s1zB
 8YgY2inIYyUpy6miGQVV4AwY+2OatOsxupwnwtVP6n78LqEgS67AUiHlwl7SJVqNUCLfWW
 f8BrkjsOsTe4/5LTgkhWySAWIwHbROQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-GtbsJ412Po-XyCJx5fA2qQ-1; Fri, 13 Oct 2023 09:26:33 -0400
X-MC-Unique: GtbsJ412Po-XyCJx5fA2qQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CB8A3857B74;
 Fri, 13 Oct 2023 13:26:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A3C492BFA;
 Fri, 13 Oct 2023 13:26:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D167E21E6A21; Fri, 13 Oct 2023 15:26:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: michael.roth@amd.com,  kkostiuk@redhat.com,  berrange@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] qapi: qga: Clarify when out-data and err-data are
 populated
References: <cover.1696185261.git.dxu@dxuuu.xyz>
 <935735389830bbe8407d95ebf89632792bf11a30.1696185261.git.dxu@dxuuu.xyz>
Date: Fri, 13 Oct 2023 15:26:31 +0200
In-Reply-To: <935735389830bbe8407d95ebf89632792bf11a30.1696185261.git.dxu@dxuuu.xyz>
 (Daniel Xu's message of "Sun, 1 Oct 2023 12:38:26 -0600")
Message-ID: <87fs2efybc.fsf@pond.sub.org>
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

Daniel Xu <dxu@dxuuu.xyz> writes:

> If output is being captured for a guest-exec invocation, the out-data
> and err-data fields of guest-exec-status are only populated after the
> process is reaped. This is somewhat counter intuitive and too late to
> change. Thus, it would be good to document the behavior.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  qga/qapi-schema.json | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b720dd4379..876e2a8ea8 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1220,11 +1220,13 @@
>  # @signal: signal number (linux) or unhandled exception code (windows)
>  #     if the process was abnormally terminated.
>  #
> -# @out-data: base64-encoded stdout of the process
> +# @out-data: base64-encoded stdout of the process. This field will only
> +#     be populated after the process exits.
>  #
> -# @err-data: base64-encoded stderr of the process Note: @out-data and
> +# @err-data: base64-encoded stderr of the process. Note: @out-data and
>  #     @err-data are present only if 'capture-output' was specified for
> -#     'guest-exec'
> +#     'guest-exec'. This field will only be populated after the process
> +#     exits.
>  #
>  # @out-truncated: true if stdout was not fully captured due to size
>  #     limitation.

Two spaces between sentences for consistency, please.

With that:
Acked-by: Markus Armbruster <armbru@redhat.com>


