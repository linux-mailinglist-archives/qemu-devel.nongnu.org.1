Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06EB80C50
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyoPF-0006tI-Tb; Wed, 17 Sep 2025 05:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyoPD-0006t6-PB
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyoPB-0003vH-VF
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758101086;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z5MhU3co+svOBhmwxAJZjbXyelYHdzlId7kYNUDHg/k=;
 b=PDe+YWGxRqRJw9rDCH+fVqayLnZOyaweH42mTrJByYSji13qt7VT3QEp8OjsBpUQOiKIj1
 rbHKCfwOAYmKSj0sboDeiotNZR0vSrz8SE+G1IFlMxV52aka2PqXt5qd4fvXoP0jzk9nNm
 XOXYvGDSZZuyMxdJJilSZ63GYmVYTI4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-tsSTHdC3PrOZGk-ZH78h_g-1; Wed,
 17 Sep 2025 05:24:36 -0400
X-MC-Unique: tsSTHdC3PrOZGk-ZH78h_g-1
X-Mimecast-MFC-AGG-ID: tsSTHdC3PrOZGk-ZH78h_g_1758101075
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EEA2195608E; Wed, 17 Sep 2025 09:24:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2B17300018D; Wed, 17 Sep 2025 09:24:31 +0000 (UTC)
Date: Wed, 17 Sep 2025 10:24:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH] checkpatch: Ignore removed lines in license check
Message-ID: <aMp-MzBE19NORy4Y@redhat.com>
References: <20250916165928.10048-1-nabihestefan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916165928.10048-1-nabihestefan@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 16, 2025 at 04:59:28PM +0000, Nabih Estefan wrote:
> When running the license check, if we are updating a license it is
> possible for the checkpatch script to test against old license lines
> instead of newer ones, since the removal lines appear before the
> addition lines in a .patch file.

While we match the "SPDX-License-Identifier" text in any context,
the "file must have SDPX" validation is only performed against
files that are entirely new: 

  # Called at the end of processing a diff hunk for a file
  sub process_end_of_file {
        my $fileinfo = shift;

        if ($fileinfo->{action} eq "new" &&
            !exists $fileinfo->{facts}->{sawspdx}) {
             ...raise error ....

> Fix this by skipping over lines that start with "-" in the checkpatch
> script.

A new file cannot have any "-" lines present, so there isn't any
bug that needs fixing AFAICT.  Can you show any patch or commit
where this would have made a difference to what checkpatch.pl
reports ?

> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 833f20f555..c57a423f9f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1813,7 +1813,8 @@ sub process {
>  		}
>  
>  # Check SPDX-License-Identifier references a permitted license
> -		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
> +		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
> +			$rawline !~ /^-/) {
>  			$fileinfo->{facts}->{sawspdx} = 1;
>  			&checkspdx($realfile, $1);
>  		}
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


