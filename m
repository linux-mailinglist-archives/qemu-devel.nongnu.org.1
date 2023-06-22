Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B595173A8E7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCPqm-0001A0-Fs; Thu, 22 Jun 2023 15:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCPqk-00019Y-S5
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCPqi-0002De-O5
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687461607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14VtsKnVKF5TAMhjCO0cyadi9qMUeUj380kknWD4vQc=;
 b=ElBo914E61da6Xtt0+s4fCyyEFvoTyO4fzZTlHqtlH/tP5ns4gmJ+AWLkhg07+xUCIBbZ+
 S3JTWLIH3XLaYtBlwla8sBUb7h586/ezogGT4Kmc5hbkuvACHMeLpjaHOD2Cpx2vZ+qqGK
 Yp8iBzWBBzxvZQp+46S1ZNstDK92FZ4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-CmWb4MFDOVSLXQDxLKZ58Q-1; Thu, 22 Jun 2023 15:20:05 -0400
X-MC-Unique: CmWb4MFDOVSLXQDxLKZ58Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4007918c09aso3034021cf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 12:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687461604; x=1690053604;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=14VtsKnVKF5TAMhjCO0cyadi9qMUeUj380kknWD4vQc=;
 b=OgRqhpShXlBrJBPQmMmT8oORXuKz5tjyXxm0+ATq3FG3Iu+gf+tNc8P08glitr5mWz
 3nED4uzyRFHcDM/1M2s4hG7JLfYJP7dDiy+KtcXfsphQRgRt2Ca5NkYYGj7y/bmz5BnB
 6sEZIjqMpebElU+q7GccsxxmrSxM0FWwQyytgQ7QykLtfo2qOthAxs3T98a+28C7/3Le
 +OOOHNQlNlJftVRahgq7w7PvtD9i2kAErxe97Nz1e81fY+WM9GeE6kfviemHawJLm0aw
 UUm0vTCzp8enEy38D1Z7sK8kIfDn9UFTX6nqiYQxWCfRBNrJ63TLyu2E3pG8cwAEHaka
 egqw==
X-Gm-Message-State: AC+VfDzAAljIU81g4PzSjVq27CPgtC8G6f2PpHPoQxopl2JT1JfJWetM
 q6BeuerNZyoJOd7RuV2UdleNqxuejDTOeHbFtzY2nFSwNbZK8Ldua4irXRrymPa+9LtJHlRNHVb
 zZCK9wxgwz51sQM4=
X-Received: by 2002:a05:620a:28ca:b0:763:c764:577c with SMTP id
 l10-20020a05620a28ca00b00763c764577cmr7280210qkp.5.1687461604401; 
 Thu, 22 Jun 2023 12:20:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ744S8XK7S8j2WyT91O/4bpIR6xyQUmlsOsTYD5txNDxawTok7Nc84zh23/8guuD/gRmondZw==
X-Received: by 2002:a05:620a:28ca:b0:763:c764:577c with SMTP id
 l10-20020a05620a28ca00b00763c764577cmr7280178qkp.5.1687461604070; 
 Thu, 22 Jun 2023 12:20:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o25-20020a05620a131900b007621b795ffdsm3679403qkj.116.2023.06.22.12.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:20:03 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:20:01 -0400
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
Message-ID: <ZJSe4TunhU47yIJ/@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
 <ZJRuw19Rc1LlPQId@x1n> <ZJR32Vsw+bAyca8/@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJR32Vsw+bAyca8/@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 05:33:29PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 22, 2023 at 11:54:43AM -0400, Peter Xu wrote:
> > I can try to move the todo even higher.  Trying to list the initial goals
> > here:
> > 
> > - One extra phase of handshake between src/dst (maybe the time to boost
> >   QEMU_VM_FILE_VERSION) before anything else happens.
> > 
> > - Dest shouldn't need to apply any cap/param, it should get all from src.
> >   Dest still need to be setup with an URI and that should be all it needs.
> > 
> > - Src shouldn't need to worry on the binary version of dst anymore as long
> >   as dest qemu supports handshake, because src can fetch it from dest.
> 
> I'm not sure that works in general. Even if we have a handshake and
> bi-directional comms for live migration, we still haave the save/restore
> to file codepath to deal with. The dst QEMU doesn't exist at the time
> the save process is done, so we can't add logic to VMSate handling that
> assumes knowledge of the dst version at time of serialization.

My current thought was still based on a new cap or anything the user would
need to specify first on both sides (but hopefully the last cap to set on
dest).

E.g. if with a new handshake cap we shouldn't set it on a exec: or file:
protocol migration, and it should just fail on qmp_migrate() telling that
the URI is not supported if the cap is set.  Return path is definitely
required here.

> 
> > - Handshake can always fail gracefully if anything wrong happened, it
> >   normally should mean dest qemu is not compatible with src's setup (either
> >   machine, device, or migration configs) for whatever reason.  Src should
> >   be able to get a solid error from dest if so.
> > 
> > - Handshake protocol should always be self-bootstrap-able, it means when we
> >   change the handshake protocol it should always works with old binaries.
> > 
> >   - When src is newer it should be able to know what's missing on dest and
> >     skip the new bits.
> > 
> >   - When dst is newer it should all rely on src (which is older) and it
> >     should always understand src's language.
> 
> I'm not convinced it can reliably self-bootstrap in a backwards
> compatible manner, precisely because the current migration stream
> has no handshake and only requires a unidirectional channel.

Yes, please see above.  I meant when we grow the handshake protocol we
should make sure we don't need anything new to be setup either on src/dst
of qemu.  It won't apply to before-handshake binaries.

> I don't think its possible for QEMU to validate that it has a fully
> bi-directional channel, without adding timeouts to its detection which I
> think we should strive to avoid.
> 
> I don't think we actually need self-bootstrapping anyway.
> 
> I think the mgmt app can just indicate the new v2 bi-directional
> protocol when issuing the 'migrate' and 'migrate-incoming'
> commands.  This becomes trivial when Het's refactoring of the
> migrate address QAPI is accepted:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04851.html
> 
> eg:
> 
>     { "execute": "migrate",
>       "arguments": {
>           "channels": [ { "channeltype": "main",
>                           "addr": { "transport": "socket", "type": "inet",
>                                    "host": "10.12.34.9",
>                                     "port": "1050" } } ] } }
> 
> note the 'channeltype' parameter here. If we declare the 'main'
> refers to the existing migration protocol, then we merely need
> to define a new 'channeltype' to use as an indicator for the
> v2 migration handshake protocol.

Using a new channeltype would also work at least on src qemu, but I'm not
sure on how dest qemu would know that it needs a handshake in that case,
because it knows nothing until the connection is established.

Maybe we still need QEMU_VM_FILE_VERSION to be boosted at least in this
case, so dest can read this at the very beginning, old binaries will fail
immediately, new binaries will start to talk with v2 language.

> 
> > - All !main channels need to be established later than the handshake - if
> >   we're going to do this anyway we probably should do it altogether to make
> >   channels named, so each channel used in migration needs to have a common
> >   header.  Prepare to deprecate the old tricks of channel orderings.
> 
> Once the primary channel involves a bi-directional handshake,
> we'll trivially ensure ordering - similar to how the existing
> code worked fnie in TLS mode which had a bi-directional TLS
> handshake.

I'm not sure I fully get it here.

IIUC tls handshake was mostly transparent to QEMU in this case while we're
relying on gnutls_handshake().  Here IIUC we need to design the roundtrip
messages to sync up two qemus well.

The round trip messages can contain a lot of things that can be useful to
us, besides knowing what features dest supports, what caps src use, we can
e.g. also provide a device tree dump from dest and try to match it on src,
failing the migration very early if we see any mismatch.  Right now we fail
too late, only until the device load (which is the last stage).

For channel orders, I'd expect the v2 protocol contains a phase to talk on
the channels and creation of named channels should be part of setup phase
before anything will happen next.

Thanks,

-- 
Peter Xu


