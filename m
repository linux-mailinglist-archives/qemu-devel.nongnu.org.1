Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F3973A62B
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNHe-00012i-Jw; Thu, 22 Jun 2023 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCNHV-0000wH-6S
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCNHL-0005hZ-UX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687451724;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Hu07p0IjksqJYGUqzP7woCxSC1Ust1O9AhWMDaXeQnw=;
 b=FlDGUX0R0fA7xEsXGAR4GYnAa83T3X61GxA0EWDmJNHKjQ+hmPwZisDQxIv+0SVr1RNd7h
 +YE7cxVFww0/NdILrx3XXWzeWoaodMED089Obd1Rqm0ERb/IIoi3O+n2wIvFW6hmPBFLJM
 4mfOuOpftkmBZm3/pHzgdQm0WDWSEVc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306--OD_z-4gMvOAXP9SfM3dUw-1; Thu, 22 Jun 2023 12:35:14 -0400
X-MC-Unique: -OD_z-4gMvOAXP9SfM3dUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEFC12800171;
 Thu, 22 Jun 2023 16:33:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A6DF41C8;
 Thu, 22 Jun 2023 16:33:34 +0000 (UTC)
Date: Thu, 22 Jun 2023 17:33:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJR32Vsw+bAyca8/@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
 <ZJRuw19Rc1LlPQId@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJRuw19Rc1LlPQId@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 11:54:43AM -0400, Peter Xu wrote:
> I can try to move the todo even higher.  Trying to list the initial goals
> here:
> 
> - One extra phase of handshake between src/dst (maybe the time to boost
>   QEMU_VM_FILE_VERSION) before anything else happens.
> 
> - Dest shouldn't need to apply any cap/param, it should get all from src.
>   Dest still need to be setup with an URI and that should be all it needs.
> 
> - Src shouldn't need to worry on the binary version of dst anymore as long
>   as dest qemu supports handshake, because src can fetch it from dest.

I'm not sure that works in general. Even if we have a handshake and
bi-directional comms for live migration, we still haave the save/restore
to file codepath to deal with. The dst QEMU doesn't exist at the time
the save process is done, so we can't add logic to VMSate handling that
assumes knowledge of the dst version at time of serialization.

> - Handshake can always fail gracefully if anything wrong happened, it
>   normally should mean dest qemu is not compatible with src's setup (either
>   machine, device, or migration configs) for whatever reason.  Src should
>   be able to get a solid error from dest if so.
> 
> - Handshake protocol should always be self-bootstrap-able, it means when we
>   change the handshake protocol it should always works with old binaries.
> 
>   - When src is newer it should be able to know what's missing on dest and
>     skip the new bits.
> 
>   - When dst is newer it should all rely on src (which is older) and it
>     should always understand src's language.

I'm not convinced it can reliably self-bootstrap in a backwards
compatible manner, precisely because the current migration stream
has no handshake and only requires a unidirectional channel. I
don't think its possible for QEMU to validate that it has a fully
bi-directional channel, without adding timeouts to its detection
which I think we should strive to avoid.

I don't think we actually need self-bootstrapping anyway.

I think the mgmt app can just indicate the new v2 bi-directional
protocol when issuing the 'migrate' and 'migrate-incoming'
commands.  This becomes trivial when Het's refactoring of the
migrate address QAPI is accepted:

  https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04851.html

eg:

    { "execute": "migrate",
      "arguments": {
          "channels": [ { "channeltype": "main",
                          "addr": { "transport": "socket", "type": "inet",
                                   "host": "10.12.34.9",
                                    "port": "1050" } } ] } }

note the 'channeltype' parameter here. If we declare the 'main'
refers to the existing migration protocol, then we merely need
to define a new 'channeltype' to use as an indicator for the
v2 migration handshake protocol.

> - All !main channels need to be established later than the handshake - if
>   we're going to do this anyway we probably should do it altogether to make
>   channels named, so each channel used in migration needs to have a common
>   header.  Prepare to deprecate the old tricks of channel orderings.

Once the primary channel involves a bi-directional handshake,
we'll trivially ensure ordering - similar to how the existing
code worked fnie in TLS mode which had a bi-directional TLS
handshake.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


