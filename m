Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F873BA46
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qChsF-0005RO-Gc; Fri, 23 Jun 2023 10:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qChs9-0005R5-SR
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qChs7-0006Nf-F2
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687530877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZxxeumrnLe9sLRw1Dj3jcCSoc8q5OSfx7U1y/ytHL4=;
 b=D1I5GgEcGkXKmlQlfLbjqqo2lUe0Jt0k3l/1tCN1rLZBj74/9yJhbk0haFJ0nqOWcQXGHG
 PQxe0X0B15hB5o6eFjpc0ypZsDlRMOVW9s64t5o9VhFq+Ju44E3Aro4GgWwBwz6kl/kcgD
 dk7ck4+o4EGZa9eq9Eht+ny9Nk4ggHQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-QW0LwlvSPoegmsJXdsuQwg-1; Fri, 23 Jun 2023 10:34:35 -0400
X-MC-Unique: QW0LwlvSPoegmsJXdsuQwg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76077669a5aso17825585a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687530875; x=1690122875;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZxxeumrnLe9sLRw1Dj3jcCSoc8q5OSfx7U1y/ytHL4=;
 b=NUaAdV8PG2uthxsGhREVj5WxUFjVvnf0vDEx0mEV43TClPuFoPSvWUiBwCwdaROrG4
 Fm6ocS5nN55J2wgltssgc5ov8cSnvf8/CI8dpKPP6ggqjLQaqao/+DZV7w296gWU0a9d
 +O+i/Jswce0gmEbE3cMQAdvc+sgYuorkOUcgnK/g9r37i98iKtfgZst5/c0pgZeNJ5L9
 oV7fcNF+RxxZHgGEhpLm6hQMXqnjUE9v35Y7ggahIeIW56ZTJnNhtH61h0uII5wdqktI
 0PLLpQsmR0ukcobeWjQGQXi5N9q/alJ68b/zlTg7OV/RPvTokgHRxhe7SB4LB5GJL2fk
 YZsA==
X-Gm-Message-State: AC+VfDyNDZXeO/KJqHfctCdF/uKMzqJv/5ejbGIR8kSgwA9xPzt6OOoL
 QgEByj/Duvqaab391vXJQgqApQtJoUlvuZYP3uDV8VltTf2Gyp1GlyczpMwnts0+dkGiPyL9Eav
 Kgp1uOB+gdHt1iHo=
X-Received: by 2002:a05:622a:1a0c:b0:3fd:e410:7398 with SMTP id
 f12-20020a05622a1a0c00b003fde4107398mr21423789qtb.1.1687530875125; 
 Fri, 23 Jun 2023 07:34:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QCw4laKlNRjcEm3WMyA2c3Pi+j2OTeMNfzsAoGCLG08+W2PXggd98MLwWYnou9ioOdPSTuA==
X-Received: by 2002:a05:622a:1a0c:b0:3fd:e410:7398 with SMTP id
 f12-20020a05622a1a0c00b003fde4107398mr21423769qtb.1.1687530874755; 
 Fri, 23 Jun 2023 07:34:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b13-20020ac8540d000000b003f364778b2bsm4925618qtq.4.2023.06.23.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 07:34:34 -0700 (PDT)
Date: Fri, 23 Jun 2023 10:34:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJWteYyWlT+pmyVi@x1n>
References: <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
 <ZJRuw19Rc1LlPQId@x1n> <ZJR32Vsw+bAyca8/@redhat.com>
 <ZJSe4TunhU47yIJ/@x1n> <ZJVHGtK38JwNJW9Z@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJVHGtK38JwNJW9Z@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 23, 2023 at 08:17:46AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 22, 2023 at 03:20:01PM -0400, Peter Xu wrote:
> > On Thu, Jun 22, 2023 at 05:33:29PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Jun 22, 2023 at 11:54:43AM -0400, Peter Xu wrote:
> > > > I can try to move the todo even higher.  Trying to list the initial goals
> > > > here:
> > > > 
> > > > - One extra phase of handshake between src/dst (maybe the time to boost
> > > >   QEMU_VM_FILE_VERSION) before anything else happens.
> > > > 
> > > > - Dest shouldn't need to apply any cap/param, it should get all from src.
> > > >   Dest still need to be setup with an URI and that should be all it needs.
> > > > 
> > > > - Src shouldn't need to worry on the binary version of dst anymore as long
> > > >   as dest qemu supports handshake, because src can fetch it from dest.
> > > 
> > > I'm not sure that works in general. Even if we have a handshake and
> > > bi-directional comms for live migration, we still haave the save/restore
> > > to file codepath to deal with. The dst QEMU doesn't exist at the time
> > > the save process is done, so we can't add logic to VMSate handling that
> > > assumes knowledge of the dst version at time of serialization.
> > 
> > My current thought was still based on a new cap or anything the user would
> > need to specify first on both sides (but hopefully the last cap to set on
> > dest).
> > 
> > E.g. if with a new handshake cap we shouldn't set it on a exec: or file:
> > protocol migration, and it should just fail on qmp_migrate() telling that
> > the URI is not supported if the cap is set.  Return path is definitely
> > required here.
> 
> exec can support bi-directional migration - we have both stdin + stdout
> for the command. For exec it is mostly a documentation problem - you
> can't merely use 'cat' for example, but if you used 'socat' that could
> be made to work bi-directionally.

Okay.  Just an example that the handshake just cannot work for all the
cases, and it should always be able to fail.

So when exec doesn't properly provide return path, I think with
handshake=on we should get a timeout of not getting response properly and
fail the migration after the timeout, then.

There're a bunch of implications and details that need to be investigated
around such a handshake if it'll be proposed for real, so I'm not yet sure
whether there's something that may be surprising.  For channeltypes it
seems all fine for now.  Hopefully nothing obvious overlooked.

> 
> > > I don't think its possible for QEMU to validate that it has a fully
> > > bi-directional channel, without adding timeouts to its detection which I
> > > think we should strive to avoid.
> > > 
> > > I don't think we actually need self-bootstrapping anyway.
> > > 
> > > I think the mgmt app can just indicate the new v2 bi-directional
> > > protocol when issuing the 'migrate' and 'migrate-incoming'
> > > commands.  This becomes trivial when Het's refactoring of the
> > > migrate address QAPI is accepted:
> > > 
> > >   https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04851.html
> > > 
> > > eg:
> > > 
> > >     { "execute": "migrate",
> > >       "arguments": {
> > >           "channels": [ { "channeltype": "main",
> > >                           "addr": { "transport": "socket", "type": "inet",
> > >                                    "host": "10.12.34.9",
> > >                                     "port": "1050" } } ] } }
> > > 
> > > note the 'channeltype' parameter here. If we declare the 'main'
> > > refers to the existing migration protocol, then we merely need
> > > to define a new 'channeltype' to use as an indicator for the
> > > v2 migration handshake protocol.
> > 
> > Using a new channeltype would also work at least on src qemu, but I'm not
> > sure on how dest qemu would know that it needs a handshake in that case,
> > because it knows nothing until the connection is established.
> 
> In Het's series the 'migrate_incoming' command similarly has a chaneltype
> parameter.

Oh, yeah then that'll just work.  Thanks.

-- 
Peter Xu


