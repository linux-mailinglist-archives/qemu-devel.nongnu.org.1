Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B66AB8BDF
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 18:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb5X-0001bn-6l; Thu, 15 May 2025 12:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFb5I-0001SW-Hn
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFb5F-0000Ji-Eu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747325118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOlTAH3rMVGYJqAnA/l5nzZvyw5olRnQFswqfFBqIoo=;
 b=PJlLhZ6mPK12uUuwQjrkAVzk7/lNKUxB4InkfOfnH1lbIKhr97BJrs1AlCb+pMEec9ToCs
 BaWTLWLlBrDWaLjot94J5296F7rlNwKXE0euEZ8sTy8/qfQzCU4WsIcZuWBQmk6JlxvaFU
 Inl9awKE1ePE7zUMh3EgpyGxhlPZTCE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-4Tgj0C5nPTqiOWBybBI0Iw-1; Thu,
 15 May 2025 12:05:14 -0400
X-MC-Unique: 4Tgj0C5nPTqiOWBybBI0Iw-1
X-Mimecast-MFC-AGG-ID: 4Tgj0C5nPTqiOWBybBI0Iw_1747325113
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 859A51800360; Thu, 15 May 2025 16:05:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC87D1956066; Thu, 15 May 2025 16:05:11 +0000 (UTC)
Date: Thu, 15 May 2025 17:05:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 9/9] scripts/checkpatch: reject license boilerplate on
 new files
Message-ID: <aCYQtA4cU2xPyvPo@redhat.com>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515135936.86760-10-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, May 15, 2025 at 02:59:36PM +0100, Daniel P. Berrangé wrote:
> The previous commit mandates use of SPDX-License-Identifier on common
> source files, and encourages it on all other files.
> 
> Some contributors are none the less still also including the license
> boilerplate text. This is redundant and will potentially cause
> trouble if inconsistent with the SPDX declaration.
> 
> Match common boilerplate text blurbs and report them as invalid,
> for newly added files.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 87050e6677..cb1942c021 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1496,6 +1496,13 @@ sub process_end_of_file {
>  			     "' need 'SPDX-License-Identifier'?");
>  		}
>  	}
> +	if ($fileinfo->{action} eq "new" &&
> +	    !exists $fileinfo->{facts}->{sawboilerplate}) {

/face-palm  - I forgot to remove the '!' here so the check is
inverted and my test patch had two very similarly named files
so didn't notice it :-(

> +		ERROR("New file '" . $fileinfo->{filenew} . "' must " .
> +		      "not have license boilerplate header text unless " .
> +		      "this file is copied from existing code with such " .
> +		      "text already present.");
> +	}
>  }
>  
>  sub process {
> @@ -1798,6 +1805,15 @@ sub process {
>  			&checkspdx($realfile, $1);
>  		}
>  
> +		if ($rawline =~ /licensed under the terms of the GNU GPL/ ||
> +		    $rawline =~ /under the terms of the GNU General Public License/ ||
> +		    $rawline =~ /under the terms of the GNU Lesser General Public/ ||
> +		    $rawline =~ /Permission is hereby granted, free of charge/ ||
> +		    $rawline =~ /GNU GPL, version 2 or later/ ||
> +		    $rawline =~ /See the COPYING file/) {
> +			$fileinfo->{facts}->{sawboilerplate} = 1;
> +		}
> +
>  		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
>  			my $tag = $1;
>  			my @permitted = qw(
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


