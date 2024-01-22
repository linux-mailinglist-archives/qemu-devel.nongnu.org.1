Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5AB8365D7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:49:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvb5-0004oD-Mc; Mon, 22 Jan 2024 09:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRvb2-0004nv-Tp
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRvb0-0006Gk-Sq
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705934897;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SblM7Mt1hyPZECR7xDdjtVuE9lfYyGaKn9sbtGIruYc=;
 b=WHFwfR3W1atQ0rh4tmXvLydEnJbeEuhrnicY9VI7Oo4YBRhz1QFIJ5T/DvK21DAAk+FLVK
 EgNVGqX3c+97z+QFEGE5dbhE6agEfnrDIjgc1WhSnd+7pnnxCPp0a+tqppAXrLwTGQ1Rvn
 ayH+7hWXySzmRAelQspgJZNvQJ4Zew8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-YqHdSprFPVCKZt6jPUy1gA-1; Mon, 22 Jan 2024 09:48:15 -0500
X-MC-Unique: YqHdSprFPVCKZt6jPUy1gA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FBF210A5CC6;
 Mon, 22 Jan 2024 14:48:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90BBBC2E1E6;
 Mon, 22 Jan 2024 14:48:14 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:48:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cristian =?utf-8?Q?Rodr=C3=ADguez?= <cristian@rodriguez.im>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] crypto/gcrypt: prefer kernel as direct source of entropy
Message-ID: <Za6ALDkMyW9Pdspd@redhat.com>
References: <20240119203950.6434-1-cristian@rodriguez.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119203950.6434-1-cristian@rodriguez.im>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jan 19, 2024 at 05:39:40PM -0300, Cristian Rodríguez wrote:
> gcrypt by default uses an userspace RNG, which cannot know
> when it is time to discard/invalidate its buffer
> (suspend, resume, vm forks, other corner cases)
> as a "when to discard" event is unavailable to userspace.

So in this scenario QEMU is impacted when QEMU is running inside
another VM. ie the L0 QEMU "forks" the guest, and the L1 QEMU
needs to re-init its RNG.

> Set GCRYCTL_SET_PREFERRED_RNG_TYPE to GCRY_RNG_TYPE_SYSTEM
> which must be done before the first call to gcry_check_version()

QEMU is just one out of many applications that use libgcrypt and
I see no reason why QEMU should be special cased in this respect.

Updating each application to hardcode use of GCRY_RNG_TYPE_SYSTEM
does not feel like a good solution. If this was a good default
to use everywhere, then gcrypt should have set this default
already, rather than requiring every app to solve the forking
problem itself.

Updating every app that uses gcrypt is not really practical
in terms of time investment anyway.

If gcrypt doesn't want to make this its global default, then
I would suggest that gcrypt should make its default be
configurable. I see from its docs:

https://gnupg.org/documentation/manuals/gcrypt/Configuration.html#Configuration

that it already supports a /etc/gcrypt/random.conf file.
Perhaps they would extend that to allow selection of the
default RNG backend, system-wide.

> 
> Signed-off-by: Cristian Rodríguez <cristian@rodriguez.im>
> ---
>  crypto/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/init.c b/crypto/init.c
> index fb7f1bff10..0c3fe6a841 100644
> --- a/crypto/init.c
> +++ b/crypto/init.c
> @@ -60,6 +60,7 @@ int qcrypto_init(Error **errp)
>  #endif
>  
>  #ifdef CONFIG_GCRYPT
> +    gcry_control(GCRYCTL_SET_PREFERRED_RNG_TYPE, GCRY_RNG_TYPE_SYSTEM);
>      if (!gcry_check_version(NULL)) {
>          error_setg(errp, "Unable to initialize gcrypt");
>          return -1;
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


