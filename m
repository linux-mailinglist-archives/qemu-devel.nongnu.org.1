Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407C7EB505
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:39:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wRg-0006wA-6U; Tue, 14 Nov 2023 11:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r2wRd-0006vX-Mp
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r2wRT-0008NU-6R
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699979948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ntwUqa+yZKEr3xlptMcWegZ363x3+nDLix3V4MTy+A=;
 b=YD/bwUPgrBBbVoEkFTWvObp9RzE5GDm1gy/G6iN7fsYECsCheQ0Lt+85OlA1iH/1/XQ64d
 LFEiuppSCQCstwREJ36hJNG9a8bFhCgnxYV949WFTSABohG+b/YLBCJqXleGOV/CVAYbdz
 x0/QzGy0u2x28+jFxusW5T9ggbMW0Qk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-zdFcaccZPj2fq6Xg2qsniQ-1; Tue,
 14 Nov 2023 11:39:05 -0500
X-MC-Unique: zdFcaccZPj2fq6Xg2qsniQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADB741C29EAD;
 Tue, 14 Nov 2023 16:39:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.137])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 456CE1121307;
 Tue, 14 Nov 2023 16:39:04 +0000 (UTC)
Date: Tue, 14 Nov 2023 10:39:02 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] qapi/pragma.json: Improve the comment about the lists of
 QAPI rule exceptions
Message-ID: <ph2xihgmr6abip3e4q4d2nvo7pglj2j43i7j733ikdoavj6bek@hwge4eifu2h6>
References: <20231113162928.54551-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113162928.54551-1-thuth@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Nov 13, 2023 at 05:29:28PM +0100, Thomas Huth wrote:
> Let's use more inclusive language here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qapi/pragma.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 7f810b0e97..0aa4eeddd3 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -3,8 +3,8 @@
>  
>  { 'pragma': { 'doc-required': true } }
>  
> -# Whitelists to permit QAPI rule violations; think twice before you
> -# add to them!
> +# Entries in these lists are allowed to violate the QAPI rules (for
> +# historical reasons); think twice before you add to them!
>  { 'pragma': {
>      # Command names containing '_'
>      'command-name-exceptions': [
> -- 
> 2.41.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


