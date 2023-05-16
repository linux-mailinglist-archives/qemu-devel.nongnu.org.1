Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F757050F1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvm8-00018F-29; Tue, 16 May 2023 10:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyvlu-00015r-AF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyvlr-0004MJ-QB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684247722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcWh6eEaOcK7hsKVe7FAiyk66YsKlNoAiaSKpTUzehI=;
 b=TuQBqmAUqOC/pSHq1fW+3SefuX2NuPeYRhdOLb6eowEAj2kn8Xm62lOx21VVf2JXluygRJ
 UkK8lc+OmH6OfiTkBtuE81EmwVp5+ngwtrUGD+qKZD8sk6TpnHp5/cypU6sV1/oeefeduY
 wHgMPLK+8mR8uSLw6KunUFeMDR4wjQI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-dopYeuxmPqSnM7U_MuFULA-1; Tue, 16 May 2023 10:35:19 -0400
X-MC-Unique: dopYeuxmPqSnM7U_MuFULA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD40D3C0BE21;
 Tue, 16 May 2023 14:35:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 509702026D16;
 Tue, 16 May 2023 14:35:14 +0000 (UTC)
Date: Tue, 16 May 2023 15:35:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v2 5/6] qmp: Added new command to retrieve eBPF blob.
Message-ID: <ZGOUmRu0/Ckca6J6@redhat.com>
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-6-andrew@daynix.com>
 <ZGIAUxfLmI6hm3VT@redhat.com> <87zg64u0g7.fsf@pond.sub.org>
 <ZGNE0bk2zCDpUkYS@redhat.com> <87ilcsshgf.fsf@pond.sub.org>
 <ZGNbHcbeN0klbBjU@redhat.com> <87ilcspe2w.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilcspe2w.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 16, 2023 at 04:04:39PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, May 16, 2023 at 12:23:28PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Tue, May 16, 2023 at 10:47:52AM +0200, Markus Armbruster wrote:
> >> 
> >> [...]
> >> 
> >> >> So, this is basically a way to retrieve an eBPF program by some
> >> >> well-known name.
> >> >> 
> >> >> Ignorant question: how are these programs desposited?
> >> >
> >> > The eBPF code blob is linked into QEMU at build time. THis API lets
> >> > libvirt fetch it from QEMU, in base64 format. When libvirt later
> >> > creates NICs, it can attach the eBPF code blob to the TAP device (which
> >> > requires elevated privilleges that QEMU lacks). NB, libvirt would fetch
> >> > the eBPF code from QEMU when probing capabilities, as once a VM is
> >> > running it is untrusted.
> >> 
> >> Okay, I can see how that helps.  I trust the blob is in a read-only
> >> segment.  Ideally, libvirt fetches it before the guest runs.
> >
> > Whether the blob is in a read-only segment or not isn't important,
> > because it transits writable memory in the QMP command marshalling.
> 
> True.  We could bypass marshalling.  Unclean hack.  Or we could sign the
> bits cryptograhically.  Key management headaches.  Not worth it, because
> fetching it before QEMU becomes untrusted is easier.
> 
> However, I now wonder why we fetch it from QEMU.  Why not ship it with
> QEMU?

Fetching it from QEMU gives us a strong guarantee that the eBPF
code actually matches the QEMU binary we're talking to, which is
useful if you're dealing with RPMs which can be upgraded behind
your back, or have multiple parallel installs of QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


