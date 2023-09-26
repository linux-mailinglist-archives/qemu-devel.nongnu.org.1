Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F327AEE0C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8Ir-0007nb-C2; Tue, 26 Sep 2023 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ql8IY-0007mO-GD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ql8IW-0006Rd-J4
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695735617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BIZXBLzpv4jFYzMXE9Q+4TP3S9qfS6+Tw+iFNkCk2aQ=;
 b=VFYii/qe/ymHhMIalJVtv8QfRLMJyc/zhxX9kWykHfINNdnmBUXBy4mSAXoFPpqAyQ+WJR
 zlUFZM7JkBbLRMR+UVzxaxbjyw8NDRj1+8xEEvicind54+5n+mGKf39nlgtaW0xVihy1e3
 +FX+JiXnGG1Ts/i3g3IrFoPc6u1bJho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-KNQy6g5-PkaQVBQhBfpEpQ-1; Tue, 26 Sep 2023 09:40:11 -0400
X-MC-Unique: KNQy6g5-PkaQVBQhBfpEpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE751C0782D;
 Tue, 26 Sep 2023 13:40:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3B47C15BB8;
 Tue, 26 Sep 2023 13:40:09 +0000 (UTC)
Date: Tue, 26 Sep 2023 08:40:07 -0500
From: Eric Blake <eblake@redhat.com>
To: andrey.drobyshev@virtuozzo.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
Message-ID: <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 26, 2023 at 01:28:01PM +0300, andrey.drobyshev@virtuozzo.com wrote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> This fixes authorship of commits 2848289168, 52b10c9c0c as the mailing
> list rewrote the "From:" field in the corresponding patches.  See commit
> 3bd2608db7 ("maint: Add .mailmap entries for patches claiming list
> authorship") for explanation.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/.mailmap b/.mailmap
> index 64ef9f4de6..04a7feb005 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -46,6 +46,7 @@ Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu
>  Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
>  Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
>  Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
> +Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>
>  
>  # Next, replace old addresses by a more recent one.
>  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
> -- 
> 2.41.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


