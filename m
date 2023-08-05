Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DF770E16
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 08:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSAkR-0008Bv-PX; Sat, 05 Aug 2023 02:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSAkP-0008Bl-2w
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 02:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSAkM-0007MU-Bv
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 02:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691216801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAxpwTDIux+bUAnDpBd41Cum+iFfx61ZxZgyoogbfaY=;
 b=FEgOckWnwJvdoBhn+b5LntHtuEmu8aIUt8WZ8ev22Pd8weoYPXI6qzDh8I/Nn0Ta5bwYP/
 ifN/6lczmYDVCfetJfhPJgLEXPR+SZU665kGsj8xkc7UBnCzlFMNVbhhFd2hrfYdBtwylr
 8c2AA5QgfK372k2JX0XMYWVEgXCN0Fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-8_l0rB5uPiSMrRijhOffgg-1; Sat, 05 Aug 2023 02:26:37 -0400
X-MC-Unique: 8_l0rB5uPiSMrRijhOffgg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F271A858F1E;
 Sat,  5 Aug 2023 06:26:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC872492B02;
 Sat,  5 Aug 2023 06:26:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B12021E692A; Sat,  5 Aug 2023 08:26:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] print memory in MB units in initrd-too-large errmsg
References: <20230804190101.759753-1-jim.cromie@gmail.com>
Date: Sat, 05 Aug 2023 08:26:35 +0200
In-Reply-To: <20230804190101.759753-1-jim.cromie@gmail.com> (Jim Cromie's
 message of "Fri, 4 Aug 2023 13:01:01 -0600")
Message-ID: <87r0oiypgk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Jim Cromie <jim.cromie@gmail.com> writes:

> Change 2 error messages to display sizes in MB, not bytes.
>
> qemu: initrd is too large, cannot support this. (max: 2047 MB, need 5833 MB)
>
> Also, distinguish 2 sites by adding "it" and "this" respectively.
> This tells a careful reader that the error above is from the 2nd size
> check.

I don't like this part.

> With MB displayed, I have to ask: is it coincidence that max == 2048-1 ?

I don't know.

> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  hw/i386/x86.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index a88a126123..0677fe2fd1 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -878,9 +878,9 @@ void x86_load_linux(X86MachineState *x86ms,
>                  initrd_size = g_mapped_file_get_length(mapped_file);
>                  initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
>                  if (initrd_size >= initrd_max) {

Not this patch's problem, but here goes anyway: why reject initrd_size
== initrd_max?

> -                    fprintf(stderr, "qemu: initrd is too large, cannot support."
> -                            "(max: %"PRIu32", need %"PRId64")\n",
> -                            initrd_max, (uint64_t)initrd_size);
> +                    fprintf(stderr, "qemu: initrd is too large, cannot support it. "
> +                            "(max: %"PRIu32" MB, need %"PRId64" MB)\n",
> +                            initrd_max>>20, (uint64_t)initrd_size>>20);
>                      exit(1);
>                  }
>  
> @@ -1023,9 +1023,9 @@ void x86_load_linux(X86MachineState *x86ms,
>          initrd_data = g_mapped_file_get_contents(mapped_file);
>          initrd_size = g_mapped_file_get_length(mapped_file);
>          if (initrd_size >= initrd_max) {
> -            fprintf(stderr, "qemu: initrd is too large, cannot support."
> -                    "(max: %"PRIu32", need %"PRId64")\n",
> -                    initrd_max, (uint64_t)initrd_size);
> +            fprintf(stderr, "qemu: initrd is too large, cannot support this. "
> +                    "(max: %"PRIu32" MB, need %"PRId64" MB)\n",
> +                    initrd_max>>20, (uint64_t)initrd_size>>20);
>              exit(1);
>          }

You're rounding both values down.  Consider

    initrd_max = 1000.5MiB - 1 exactly
    initrd_size = 1000.5MiB + 4096

Before the patch, we report

    (max: 1049100287, need 1049104384)

Unfriendly, but at least it's correct.  Afterwards

    (max: 1000 MB, need 1000 MB)

Wat?  Long-suffering users may guess the rounding issue.  But let's not
make users guess.

Better would be something like

    size of initrd exceeds the limit of X MiB by Y Bytes

*if* X is actually a multiple of 1 MiB.  Else, we need to consider
showing a suitably rounded fractional part, or stick to Bytes after all.


