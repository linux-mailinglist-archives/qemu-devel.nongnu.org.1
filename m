Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAD710F00
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CTv-0003rx-HV; Thu, 25 May 2023 11:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CTn-0003rB-Sc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CTk-0002Oz-O8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685026930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xRZQz0yqt9SVNDjpnH8+8VC2X8usGz2QWoiQlekvPXM=;
 b=A8ZrIfOOSPKyZP2FsBSd+zMOyRE4iLbfhHrPl1RkDAx57AlopGIE5S52jDy+3DAYy2XIij
 2xgM+K37wyLXB1j9AZ4yddBBxmL1ts+l1pdkNVuRLMGmMPHerqkuTrHpnNFWYsSPZYL1oH
 CuIghrHvvUQCRRvzd+JUbr8ExTvJXns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-93D7lpwYPbeg-hgFKgjEzA-1; Thu, 25 May 2023 11:02:05 -0400
X-MC-Unique: 93D7lpwYPbeg-hgFKgjEzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3361A8039AF;
 Thu, 25 May 2023 15:02:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F84A2023450;
 Thu, 25 May 2023 15:02:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 057D921E692E; Thu, 25 May 2023 17:02:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  elena.ufimtseva@oracle.com
Subject: Re: [PATCH v1 1/2] vfio-user: update comments
References: <cover.1684338236.git.jag.raman@oracle.com>
 <7340a298bcda0268b3decdd772ebce84bfcedcd5.1684338236.git.jag.raman@oracle.com>
Date: Thu, 25 May 2023 17:02:03 +0200
In-Reply-To: <7340a298bcda0268b3decdd772ebce84bfcedcd5.1684338236.git.jag.raman@oracle.com>
 (Jagannathan Raman's message of "Wed, 17 May 2023 16:43:56 +0000")
Message-ID: <87fs7ko3o4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Jagannathan Raman <jag.raman@oracle.com> writes:

> Clarify the behavior of TYPE_VFU_OBJECT when TYPE_REMOTE_MACHINE enables
> the auto-shutdown property. Also, add notes to VFU_OBJECT_ERROR.
>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/remote/vfio-user-obj.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 88ffafc73e..8b10c32a3c 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -30,6 +30,11 @@
>   *
>   * notes - x-vfio-user-server could block IO and monitor during the
>   *         initialization phase.
> + *
> + *         When x-remote machine has the auto-shutdown property
> + *         enabled (default), x-vfio-user-server terminates after the last
> + *         client disconnects. Otherwise, it will continue running until
> + *         explicitly killed.
>   */
>  
>  #include "qemu/osdep.h"
> @@ -61,9 +66,12 @@
>  OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
>  
>  /**
> - * VFU_OBJECT_ERROR - reports an error message. If auto_shutdown
> - * is set, it aborts the machine on error. Otherwise, it logs an
> - * error message without aborting.
> + * VFU_OBJECT_ERROR - reports an error message.
> + *
> + * If auto_shutdown is set, it aborts the machine on error. Otherwise,
> + * it logs an error message without aborting. auto_shutdown is disabled
> + * when the server serves clients from multiple VMs; as such, an error
> + * from one VM shouldn't be able to disrupt other VM's services.
>   */
>  #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
>      {                                                                     \

I still very much doubt an error can be severe enough to justify abort()
in one configuration, yet harmless enough to permit carrying on in
another configuration.  But this patch merely documents what the code
does, so

Reviewed-by: Markus Armbruster <armbru@redhat.com>


