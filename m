Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB738D81C5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 13:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6KH-0002pN-9M; Mon, 03 Jun 2024 07:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE6KD-0002p4-SM
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE6KB-00075h-RT
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717415882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WlmUAlHGosEIpwll4yW/dypoKgrXT7D6koa4wWvyO/E=;
 b=BblmdsxnER+ik2yne7GrujrUgVmh99F8WqiSGPdGlETMwWENx2Z3g6RMXXweGMfTWsOn9j
 oXDetaj6ppi5Ehpnh1QwGVzADMsnJHkJUwXZzvSIrb6fuYSAzZjKXmAS4Rjmjc6p7NZW7K
 268wJ9Luo39QwX1mNhxZEOq7qVE51dU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-77oZJ-SjO563gVbg7UQKng-1; Mon,
 03 Jun 2024 07:58:00 -0400
X-MC-Unique: 77oZJ-SjO563gVbg7UQKng-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C03D4191DB61; Mon,  3 Jun 2024 11:57:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B58230000C3; Mon,  3 Jun 2024 11:57:54 +0000 (UTC)
Date: Mon, 3 Jun 2024 12:57:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com,
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com,
 pbonzini@redhat.com, thomas.lendacky@amd.com,
 isaku.yamahata@intel.com, kvm@vger.kernel.org, anisinha@redhat.com
Subject: Re: [PATCH v4 01/31] i386/sev: Replace error_report with error_setg
Message-ID: <Zl2vvp2Wztpm4yu-@redhat.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-2-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530111643.1091816-2-pankaj.gupta@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 30, 2024 at 06:16:13AM -0500, Pankaj Gupta wrote:
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>  target/i386/sev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index d30b68c11e..67ed32e5ea 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -952,13 +952,13 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  
>      if (sev_es_enabled()) {
>          if (!kvm_kernel_irqchip_allowed()) {
> -            error_report("%s: SEV-ES guests require in-kernel irqchip support",
> -                         __func__);
> +            error_setg(errp, "%s: SEV-ES guests require in-kernel irqchip"
> +                       "support", __func__);
>              goto err;
>          }
>  
>          if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> -            error_report("%s: guest policy requires SEV-ES, but "
> +            error_setg(errp, "%s: guest policy requires SEV-ES, but "
>                           "host SEV-ES support unavailable",
>                           __func__);
>              goto err;

While changing this, I'd suggest removing '__func__' frmo this - including
internal function names in an error message is not useful to the end user,
as this is a private impl detail, and the text message is sufficiently
clear of the problem already.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


