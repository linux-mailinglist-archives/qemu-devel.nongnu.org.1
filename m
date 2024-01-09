Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B4828A4B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:46:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFF2-0002RW-Po; Tue, 09 Jan 2024 11:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rNFEu-0002OX-51
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rNFEr-0006xy-9g
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704818763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylfHKyOdCmZ68LebeoY0CC8FeX/BFIYNW3PTK6e8Hoc=;
 b=BE4HOO2xeO/FWUBaLepj+aFATqVETuwLoVKhCw4sOG1Hu8h0+TTTSryOse0zMShwouG4h1
 3ORwfJP08uSDbqDveVFaPbWfhZOj00H4GEeAogfddD3Z14/Y8Vup8uBSagccVHwqv79eC5
 GSoZjTvHWSpWA8H2rXQIJw2VJEDEK4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-eU2h-z0wPfCHT-WWfPwuGg-1; Tue, 09 Jan 2024 11:46:00 -0500
X-MC-Unique: eU2h-z0wPfCHT-WWfPwuGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29054832D61;
 Tue,  9 Jan 2024 16:46:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFA181121312;
 Tue,  9 Jan 2024 16:45:58 +0000 (UTC)
Date: Tue, 9 Jan 2024 10:45:57 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/2] meson: generate .stp files for tools too
Message-ID: <zi5xcqknktwnyiz66obasytr3alkljmb2a2usgjxwxrpgnig74@g2wgazvuh4rm>
References: <20240108171356.1037059-1-berrange@redhat.com>
 <20240108171356.1037059-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108171356.1037059-3-berrange@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 08, 2024 at 05:13:56PM +0000, Daniel P. Berrangé wrote:
> The qemu-img, qemu-io, qemu-nbd, qemu-storage-daemon tools all have
> support for systemtap tracing built-in, so should be given corresponding
> .stp files to define their probes.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  meson.build | 61 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 21 deletions(-)

I'm less familiar with writing meson rules, but I can follow how you
refactored the stap.found() logic to be shared among two different
groups of traceable binaries, with the obvious difference being the
generation of command:[] in a way that uses the correct prefixes per
tracable item.

And since I hit the problem of not being able to see trace output via
qemu-trace-stap on qemu-io, this makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


