Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56619F6C5F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 18:33:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxuO-0006qO-Vs; Wed, 18 Dec 2024 12:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNxuK-0006pF-Qu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNxuI-0002Ub-Hp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734543133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xr/TAEC/kCY1GdHt3m9cZEp9v9fEfpLXyxsE9WSsSOM=;
 b=A33Q9Dds2kxBzf8OJCsv+SPmoo4pS2muBMV/zPCEbKJozcJ7RRyR9bC9NgTtnfzuFkgBe/
 pPwGbUzJmaWkyXZTWt1a+uoZt6dq0l5Sqlse+bYQimM4LJjYSEbP7tcuYxYuRswefK/YpP
 47+DxJRR0YoIU9dxGbTdDMMWpWpBAJ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-KaqHN6kIP7W0b4iMcoApBQ-1; Wed,
 18 Dec 2024 12:32:10 -0500
X-MC-Unique: KaqHN6kIP7W0b4iMcoApBQ-1
X-Mimecast-MFC-AGG-ID: KaqHN6kIP7W0b4iMcoApBQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 021F61955DD2; Wed, 18 Dec 2024 17:32:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48D7F1955F41; Wed, 18 Dec 2024 17:32:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F65E21E6682; Wed, 18 Dec 2024 18:32:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <pbonzini@redhat.com>,  <berrange@redhat.com>,
 <eduardo@habkost.net>,  <pankaj.gupta@amd.com>,  <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
In-Reply-To: <20241218154939.1114831-4-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 18 Dec 2024 09:49:39 -0600")
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
Date: Wed, 18 Dec 2024 18:32:05 +0100
Message-ID: <878qscrj6y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Michael Roth <michael.roth@amd.com> writes:

> The GHCB specification[1] defines a VMGEXIT-based Guest Request
> hypercall to allow an SNP guest to issue encrypted requests directly to
> SNP firmware to do things like query the attestation report for the
> guest. These are generally handled purely in the kernel.
>
> In some some cases, it's useful for the host to be able to additionally
> supply the certificate chain for the signing key that SNP firmware uses
> to sign these attestation reports. To allow for this, the GHCB
> specification defines an Extended Guest Request where this certificate
> data can be provided in a special format described in the GHCB spec.
> This certificate data may be global or guest-specific depending on how
> the guest was configured. Rather than providing interfaces to manage
> these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> to request the certificate contents from userspace. Implement support
> for that here.
>
> To synchronize delivery of the certificates to the guest in a way where
> they will not be rendered invalid by updates to SNP firmware or
> attestation singing/endorsement keys by management tools outside the
> purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> obtain a shared/read lock on the certificate file prior to delivering
> them back to KVM. Only after this will the attestation report be
> retrieved from firmware and bundled with the certificate data, so QEMU
> must continue to hold the file lock until KVM confirms that the
> attestation report has been retrieved/bundled. This confirmation is done
> by way of the kvm_immediate_exit callback infrastructure that was
> introduced in a previous patch.

The "management tools outside the purview of QEMU" will all obtain the
same kind of file lock?

> [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
>     https://www.amd.com/en/developer/sev.html
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/qom.json                 |  23 +++-
>  target/i386/kvm/kvm.c         |  10 ++
>  target/i386/sev-sysemu-stub.c |   5 +
>  target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
>  target/i386/sev.h             |   2 +
>  5 files changed, 288 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 28ce24cd8d..6eaf0e7721 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1034,6 +1034,25 @@
>  #     firmware.  Set this to true to disable the use of VCEK.
>  #     (default: false) (since: 9.1)
>  #
> +# @certs-path: Path to certificate data that can be passed to guests via
> +#              SNP Extended Guest Requests. File should be in the format
> +#              described in the GHCB specification. (default: none)
> +#              (since: 10.0)

I prefer "filename" to "path".  We have many kinds of paths: pathnames
(denoting files), QOM paths (denoting objects), qdev paths, search
paths, ...  With "filename", your readers immediately know what you're
talking about.

SevGuestProperties has a member 'dh-cert-file'.  Whether that's related
to your file I can't tell from its documentation.

> +#
> +# @certs-timeout: Max time in milliseconds to wait to obtain a read lock

Please don't abbreviate "Maximum" here.

Confident millisecond granularity will suffice forever?

> +#                 on the certificate file specified by @certs-path. This
> +#                 is not a cumulative value and only affects how long
> +#                 QEMU waits before returning execution to the vCPU and
> +#                 informing the guest of the timeout, so the guest can
> +#                 still continuing retrying for as long as it likes
> +#                 (which will be about 60 seconds for linux guests at
> +#                 the time of this writing). If the guest-side timeout
> +#                 is insufficient, set this higher to allow more time to
> +#                 fetch the certificate. If the guest-side timeout is
> +#                 sufficient, set this lower to reduce the likelihood of
> +#                 soft lockups in the guest.
> +#                 (default: 100) (since: 10.0)
> +#
>  # Since: 9.1
>  ##

Please format like

   # @certs-path: Path to certificate data that can be passed to guests
   #     via SNP Extended Guest Requests.  File should be in the format
   #     described in the GHCB specification.
   #     (default: none) (since: 10.0)
   #
   # @certs-timeout: Max time in milliseconds to wait to obtain a read
   #     lock on the certificate file specified by @certs-path.  This is
   #     not a cumulative value and only affects how long QEMU waits
   #     before returning execution to the vCPU and informing the guest
   #     of the timeout, so the guest can still continuing retrying for
   #     as long as it likes (which will be about 60 seconds for linux
   #     guests at the time of this writing).  If the guest-side timeout
   #     is insufficient, set this higher to allow more time to fetch the
   #     certificate.  If the guest-side timeout is sufficient, set this
   #     lower to reduce the likelihood of soft lockups in the guest.
   #     (default: 100) (since: 10.0)

to blend in with commit a937b6aa739 (qapi: Reformat doc comments to
conform to current conventions).

>  { 'struct': 'SevSnpGuestProperties',
> @@ -1045,7 +1064,9 @@
>              '*id-auth': 'str',
>              '*author-key-enabled': 'bool',
>              '*host-data': 'str',
> -            '*vcek-disabled': 'bool' } }
> +            '*vcek-disabled': 'bool',
> +            '*certs-path': 'str',
> +            '*certs-timeout': 'uint32' } }
>  
>  ##
>  # @ThreadContextProperties:

[...]


