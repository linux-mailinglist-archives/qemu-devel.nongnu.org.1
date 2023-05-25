Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB3710F02
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CUX-0003xB-Rw; Thu, 25 May 2023 11:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CUB-0003uj-6x
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CU8-0002QV-BQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685026953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ewTYYdd1rzcWFjD/hbJsmOUYVfN20Y2GdGOT2pV1cC0=;
 b=DFwedwRC3y+JhHfOSZpDlzgAtyPIQkipt4rdAWGNY9RLbCmsEYmiuFOoufCw2rTEOnS5pe
 3+HI+j6YWGKXR7UFCJIAaEVCQiGnAUjpX67bCM1dBeSRddK8UhNzoXGU3nHmOLnxF9CgNi
 EKDtzkqbNYV2pJIfbmykvQ/FDd8sYpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-bYh74MRdPUiOYWuzHmXEpw-1; Thu, 25 May 2023 11:02:29 -0400
X-MC-Unique: bYh74MRdPUiOYWuzHmXEpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A4518039C2;
 Thu, 25 May 2023 15:02:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29E12C154D1;
 Thu, 25 May 2023 15:02:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EB0721E692E; Thu, 25 May 2023 17:02:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  elena.ufimtseva@oracle.com
Subject: Re: [PATCH v1 2/2] docs: fix multi-process QEMU documentation
References: <cover.1684338236.git.jag.raman@oracle.com>
 <863b725089a7ee6b65adffacfc896b6ef795e86f.1684338236.git.jag.raman@oracle.com>
Date: Thu, 25 May 2023 17:02:28 +0200
In-Reply-To: <863b725089a7ee6b65adffacfc896b6ef795e86f.1684338236.git.jag.raman@oracle.com>
 (Jagannathan Raman's message of "Wed, 17 May 2023 16:43:57 +0000")
Message-ID: <87bki8o3nf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> Fix a typo in the system documentation for multi-process QEMU.
>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  docs/system/multi-process.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/multi-process.rst b/docs/system/multi-process.rst
> index 16f0352416..2008a67809 100644
> --- a/docs/system/multi-process.rst
> +++ b/docs/system/multi-process.rst
> @@ -4,7 +4,7 @@ Multi-process QEMU
>  ==================
>  
>  This document describes how to configure and use multi-process qemu.
> -For the design document refer to docs/devel/qemu-multiprocess.
> +For the design document refer to docs/devel/multi-process.rst.
>  
>  1) Configuration
>  ----------------

Reviewed-by: Markus Armbruster <armbru@redhat.com>


