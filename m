Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D4C07026
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 17:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJsL-0007ex-JM; Fri, 24 Oct 2025 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJsJ-0007eZ-Lz
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJsG-00032p-Ql
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761320319;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWBYrhm9ToG17SacckpYZOV2RFrw1D4RLHvI1ypL5WU=;
 b=DjfTlGplN72hPRGU805dmhJH+NLl5FUf1jBzEiUnpz3f/4vsouRfU01UQ1LrfPdf9TJsf3
 wLvxEMZxK5gOZdrSLaKqgahJnM65ZT+YEgdRJN+uioz/kARjNtYgfbDSqNBZfvldXOaMXK
 gsls29gFXJVXkUGIDpo5O6NTyhpQPs8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-dMkH9pwDNESASseRSJqSaw-1; Fri,
 24 Oct 2025 11:38:35 -0400
X-MC-Unique: dMkH9pwDNESASseRSJqSaw-1
X-Mimecast-MFC-AGG-ID: dMkH9pwDNESASseRSJqSaw_1761320315
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDA2B1809A0E; Fri, 24 Oct 2025 15:38:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72BC230002DB; Fri, 24 Oct 2025 15:38:32 +0000 (UTC)
Date: Fri, 24 Oct 2025 16:38:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/13] Next crypto & I/O patches
Message-ID: <aPuddawJ9Zug9g4D@redhat.com>
References: <20251024131937.56673-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024131937.56673-1-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Self-NACK

I've discovered this fails on CFI enabled builds, because
gnutls_malloc/gnutls_free are incompatible with CFI due
to requiring bad function pointer casts. Fortunately
gnutls 3.3.0 dropped support for replacing the system
allocators, so we can assume C library malloc/free are
acceptable, just as with glib.

I'll post a v2 PULL shortly.


On Fri, Oct 24, 2025 at 02:19:24PM +0100, Daniel P. Berrangé wrote:
> The following changes since commit e8779f3d1509cd07620c6166a9a280376e01ff2f:
> 
>   Merge tag 'pull-riscv-to-apply-20251024' of https://github.com/alistair23/qemu into staging (2025-10-24 10:53:02 +0200)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/berrange/qemu tags/next-pr-pull-request
> 
> for you to fetch changes up to 608be310a9c0a8501480a8ba76de3df8feaaf0d8:
> 
>   crypto: switch to newer gnutls API for distinguished name (2025-10-24 13:06:05 +0100)
> 
> ----------------------------------------------------------------
> Merge misc, crypto and I/O subsystems changes
> 
>  * Fix use after free in websocket handshake (CVE-2025-11234)
>  * Improved stack traces fatal errors/aborts raised for
>    user creatable objects
>  * Stop requiring 'key encipherment' usage in x509 certs
>  * Only sanity check CA certs needed in the chain of trust
>  * Allow intermediate CA certs to be present in client/server
>    cert file
>  * Fix regression propagating errors in premature shutdown
>    of TLS connections
> 
> ----------------------------------------------------------------
> 
> Daniel P. Berrangé (11):
>   crypto: propagate Error object on premature termination
>   qom: use ERRP_GUARD in user_creatable_complete
>   tests: use macros for registering char tests for sockets
>   io: release active GSource in TLS channel finalizer
>   io: move websock resource release to close method
>   io: fix use after free in websocket handshake code
>   crypto: remove extraneous pointer usage in gnutls certs
>   crypto: validate an error is reported in test expected fails
>   crypto: fix error reporting in cert chain checks
>   crypto: stop requiring "key encipherment" usage in x509 certs
>   crypto: switch to newer gnutls API for distinguished name
> 
> Henry Kleynhans (1):
>   crypto: only verify CA certs in chain of trust
> 
> matoro (1):
>   crypto: allow client/server cert chains
> 
>  crypto/tlscredsx509.c                 | 223 +++++++++++++++-----------
>  crypto/tlssession.c                   |  20 +--
>  docs/system/tls.rst                   |  13 +-
>  include/io/channel-websock.h          |   3 +-
>  io/channel-tls.c                      |  23 ++-
>  io/channel-websock.c                  |  33 +++-
>  qom/object_interfaces.c               |   7 +-
>  tests/unit/crypto-tls-x509-helpers.h  |   6 +-
>  tests/unit/test-char.c                |   8 +-
>  tests/unit/test-crypto-tlscredsx509.c | 155 +++++++++++++++---
>  tests/unit/test-crypto-tlssession.c   |  14 +-
>  tests/unit/test-io-channel-tls.c      |   4 +-
>  12 files changed, 336 insertions(+), 173 deletions(-)
> 
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


