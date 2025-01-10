Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D37A08F88
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 12:34:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDHE-00012k-Kn; Fri, 10 Jan 2025 06:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tWDHC-00012R-6P
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tWDHA-0006ov-Gn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736508841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyJyHQ4+/jFg8cBAgV34BO1sXA5pSbXUqccexv31Eg8=;
 b=bJLQ0A3R8gVBMzEU3gCd2SAEFRXHOHyQjsW0g8buNoaWliq3BdJDj0PFobS6cu7m1dJvG2
 MTMGvll/jnVTFXBorjN757oP9gbzfyNBaJeVKdMU/U/KB5tU102eGEw2oehzvMxB8WoUNJ
 Zy8N0pEL5zN5jgyhhRnVOKPefivStnM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-A_UJmH6KOLaef87HjPKMgQ-1; Fri,
 10 Jan 2025 06:33:57 -0500
X-MC-Unique: A_UJmH6KOLaef87HjPKMgQ-1
X-Mimecast-MFC-AGG-ID: A_UJmH6KOLaef87HjPKMgQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 251BB19560AB; Fri, 10 Jan 2025 11:33:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.82])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B00FB1955BE3; Fri, 10 Jan 2025 11:33:51 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:33:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/9] qapi: Make qapi_bool_parse() gracefully handle
 NULL value
Message-ID: <Z4EFnOMRUDsH6cpd@redhat.com>
References: <20250108202625.149869-1-iii@linux.ibm.com>
 <20250108202625.149869-2-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108202625.149869-2-iii@linux.ibm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jan 08, 2025 at 09:04:56PM +0100, Ilya Leoshkevich wrote:
> Use g_strcmp0(), so that NULL is considered an invalid parameter value.

Why are we calling qapi_bool_parse with a NULL value in the first
place ? IMHO this is a sign of a bug higher up the call chain
that ought to be fixed, as in general all our input parsing code
would expect non-NULL input values.

> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  qapi/qapi-util.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 65a7d184372..c6ae829f904 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -86,17 +86,17 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
>  
>  bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
>  {
> -    if (g_str_equal(value, "on") ||
> -        g_str_equal(value, "yes") ||
> -        g_str_equal(value, "true") ||
> -        g_str_equal(value, "y")) {
> +    if (!g_strcmp0(value, "on") ||
> +        !g_strcmp0(value, "yes") ||
> +        !g_strcmp0(value, "true") ||
> +        !g_strcmp0(value, "y")) {
>          *obj = true;
>          return true;
>      }
> -    if (g_str_equal(value, "off") ||
> -        g_str_equal(value, "no") ||
> -        g_str_equal(value, "false") ||
> -        g_str_equal(value, "n")) {
> +    if (!g_strcmp0(value, "off") ||
> +        !g_strcmp0(value, "no") ||
> +        !g_strcmp0(value, "false") ||
> +        !g_strcmp0(value, "n")) {
>          *obj = false;
>          return true;
>      }
> -- 
> 2.47.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


