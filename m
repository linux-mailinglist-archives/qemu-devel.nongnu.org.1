Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B6B0AE5A
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Jul 2025 09:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ud1ix-0004C5-Lw; Sat, 19 Jul 2025 03:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ud155-0006WQ-Fv
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 02:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ud152-0001zc-Q0
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 02:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752906595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XUhy6ltm6KEtgup6YC8U4RDBvTxSHiWk6iP7IRVKTE8=;
 b=c/Gy+8A7TSuhY3Rb7Ke/oQr1KYAAViBPh3I4FG60BQ5dZaRUT7pgAV34cy9EGlHJFVWr9g
 O2H27AtENU8YZwtDJTY84nvHtki7djB9woI7KGiTCpJjTLE9Xy0hP/RDnGWtmhm1zEq5qM
 Qemb/+5wVb9nNX8NGNYG6hs+1G4SzJY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-yAFA6Eb0PBmitL9nJPFXSQ-1; Sat,
 19 Jul 2025 02:27:46 -0400
X-MC-Unique: yAFA6Eb0PBmitL9nJPFXSQ-1
X-Mimecast-MFC-AGG-ID: yAFA6Eb0PBmitL9nJPFXSQ_1752906466
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0912F1956088
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 06:27:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5025180045B
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 06:27:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F059E21E6A27; Sat, 19 Jul 2025 08:27:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,  Yan Vugenfirer <yvugenfi@redhat.com>,  Daniel
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
In-Reply-To: <20250717145948.77870-1-kkostiuk@redhat.com> (Kostiantyn
 Kostiuk's message of "Thu, 17 Jul 2025 17:59:48 +0300")
References: <20250717145948.77870-1-kkostiuk@redhat.com>
Date: Sat, 19 Jul 2025 08:27:42 +0200
Message-ID: <87pldwbspt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:

> g_win32_error_message - translate a Win32 error code
> (as returned by GetLastError()) into the corresponding message.
>
> In the same time, we call error_setg_win32_internal with
> error codes from different Windows componets like VSS or
> Performance monitor that provides different codes and
> can't be converted with g_win32_error_message.

Are these error codes from GetLastError()?

>                                                In this
> case, the empty suffix will be returned so error will be
> masked.
>
> QGA error example:
>  - before changes:
>   {"error": {"class": "GenericError", "desc": "failed to add D:\\ to snapshot set: "}}
>  - after changes:
>   {"error": {"class": "GenericError", "desc": "failed to add D:\\ to snapshot set: unknown Windows error 0x8004230e"}}

Exact reproducer?

> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  util/error.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/util/error.c b/util/error.c
> index daea2142f3..b1342558ae 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -188,6 +188,11 @@ void error_setg_win32_internal(Error **errp,
>  
>      if (win32_err != 0) {
>          suffix = g_win32_error_message(win32_err);
> +        // g_win32_error_message() failed
> +        if (!suffix[0]) {
> +            g_free(suffix);
> +            suffix = g_strdup_printf("unknown Windows error 0x%x", win32_err);
> +        }
>      }
>  
>      va_start(ap, fmt);


