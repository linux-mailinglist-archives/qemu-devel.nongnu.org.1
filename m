Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC179984B7
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 13:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrAU-0008Gb-3z; Thu, 10 Oct 2024 07:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrAS-0008GC-Im
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrAP-0004hL-Eb
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728559030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0ItoMevl0mgIMAEGzznGsyPGdd04lN5yi44a/lagDI=;
 b=eVSThl4rGRLLIxbxj6SRGIS0Fh3ALtsk001I+PUn+cUw6b3EpTek52tk3qvL56O+l8WWun
 nae9W4WneNjJdPFTe6GbwJMWl5vnIIThJ4ETX3HtJ3pJhre+jTTU1oaZz86P0igQxIYfIF
 m/Cis3CZSEUGM8HFZRRqqA9pSyYrz04=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-AmG-VtsGP8OiVVIzFrnjYQ-1; Thu,
 10 Oct 2024 07:17:07 -0400
X-MC-Unique: AmG-VtsGP8OiVVIzFrnjYQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4406619560A2; Thu, 10 Oct 2024 11:17:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEFFC19560A2; Thu, 10 Oct 2024 11:17:02 +0000 (UTC)
Date: Thu, 10 Oct 2024 12:16:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com,
 peter.maydell@linaro.org, Alejandro Zeise <alejandro.zeise@seagate.com>
Subject: Re: [PATCH v5 07/16] crypto/hash-afalg: Implement new hash API
Message-ID: <Zwe3qpF0eGWMOqUR@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
 <20241008075724.2772149-8-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008075724.2772149-8-clg@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 08, 2024 at 09:57:14AM +0200, Cédric Le Goater wrote:
> From: Alejandro Zeise <alejandro.zeise@seagate.com>
> 
> Updates the afalg hash driver to support the new accumulative
> hashing changes as part of the patch series.
> 
> Implements opening/closing of contexts, updating hash data
> and finalizing the hash digest.
> 
> In order to support the update function, a flag needs to be passed
> to the kernel via the socket send call (MSG_MORE) to notify it that more
> data is to be expected to calculate the hash correctly.
> As a result, a new function was added to the iov helper utils to allow
> passing a flag to the socket send call.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Handled qcrypto_afalg_hash_ctx_new() errors in
>          qcrypto_afalg_hash_new()
>        - Freed alg_name in qcrypto_afalg_hash_new()
>        - Reworked qcrypto_afalg_recv_from_kernel()
>        - Split iov changes from original patch ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  crypto/hash-afalg.c | 127 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


