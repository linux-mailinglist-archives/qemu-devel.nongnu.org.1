Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F70E86CBD4
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 15:43:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhc4-00024c-Qh; Thu, 29 Feb 2024 09:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfhbx-00021N-Nf
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfhbw-0001HJ-2G
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709217729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1QgDldSsCJtxeJ0IjtTCPbiOKSp6fBTys1FmNx1zCs=;
 b=E5f7sYYcwHrMFg9UStO08oK47M07Qm8v4i2QxvD+AaJIbwBkq5qHmT1hWpqXaiJlLtU1fB
 Q8QHAkmzfxq7DgO3xrfYz4gBovEOMGjUTSd5D/zuZjNwZWTEk1xK5gPfHmG1eu1aZHxLss
 f3r03Xysip+gJQoQhcVfSAxWiyge4fI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-MbFVY4TEMDu_Od64SNMAlQ-1; Thu, 29 Feb 2024 09:42:07 -0500
X-MC-Unique: MbFVY4TEMDu_Od64SNMAlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB1DE85A588;
 Thu, 29 Feb 2024 14:42:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7314820229A4;
 Thu, 29 Feb 2024 14:42:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C95C21E6767; Thu, 29 Feb 2024 15:42:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Michael Roth <michael.roth@amd.com>,  Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 01/16] error: Add error_vprepend() in comment of
 ERRP_GUARD() rules
In-Reply-To: <20240228163723.1775791-2-zhao1.liu@linux.intel.com> (Zhao Liu's
 message of "Thu, 29 Feb 2024 00:37:08 +0800")
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-2-zhao1.liu@linux.intel.com>
Date: Thu, 29 Feb 2024 15:42:05 +0100
Message-ID: <87jzmnuybm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@linux.intel.com> writes:

> From: Zhao Liu <zhao1.liu@intel.com>
>
> The error_vprepend() should use ERRP_GUARD() just as the documentation
> of ERRP_GUARD() says:
>
>> It must be used when the function dereferences @errp or passes
>> @errp to error_prepend(), error_vprepend(), or error_append_hint().
>
> Considering that error_vprepend() is also an API provided in error.h,
> it is necessary to add it to the description of the rules for using
> ERRP_GUARD().
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/qapi/error.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index f21a231bb1a6..b1b389967f92 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -207,7 +207,7 @@
>   *
>   * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>   * - It must not be dereferenced, because it may be null.
> - * - It should not be passed to error_prepend() or
> + * - It should not be passed to error_prepend(), error_vprepend() or
>   *   error_append_hint(), because that doesn't work with &error_fatal.
>   * ERRP_GUARD() lifts these restrictions.
>   *

Good catch!

I'd like a comma after error_vprepend().

Reviewed-by: Markus Armbruster <armbru@redhat.com>


