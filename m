Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC673BAC6
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCi8q-0003lp-Bs; Fri, 23 Jun 2023 10:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCi8n-0003iS-Bu
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCi8l-0007Mi-Ii
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687531918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOlWmEmQdV3rKq8KDvAjHzqfY2QTqMt8l5WxCdIGOx8=;
 b=KlvW6asCWFQWwwslFdrbG6k8TWU3QbNN+4HqRW6duSYbJpE8h1Hc2xWsoyRLsCj5QU+CAz
 pWmDjHLAQN8IpQEs4z9iuf/UxF2BuIybnWHIjBgLYc6pZcjOF+P4j5/d9GW/ksMFMtBsRY
 P3C0wZJsKTdg0546Eff2ujM5tsm5984=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xzPG0aCkNiOJsc3jPQyPZg-1; Fri, 23 Jun 2023 10:51:56 -0400
X-MC-Unique: xzPG0aCkNiOJsc3jPQyPZg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76248f3057bso14041985a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687531916; x=1690123916;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOlWmEmQdV3rKq8KDvAjHzqfY2QTqMt8l5WxCdIGOx8=;
 b=EQT/5iP7jJk4Cn2Owg8MKZpQoocklk0tLdfRo6gCN/KlTG4jT80W8y0vxRvC3Qqq0S
 Lx9SfiRGbDOzwswTxbcbxUIp05aEx3suze4IvXbFaAWOsWQexAWVG6/kTdaIHdAdagyW
 I3R5dU1aTf/NFw9SU42ax8NY8CJv968Xfnt+A2rGpY6zP8ur69fON2zLzDUfyTdgMF9D
 zqd+lQS0OnNT4NyUfl4MyyQUnlZ7mDOCCJaoRL37U+/S1DtPxH+hYOm47S5haYGVfQKo
 NsMlPEQ/2j8KRKiZ5T7+Yva8aJ90ozicue1EoeVABkifxFPSDjt9Lr8Fm4DbYYji+CwW
 SCRg==
X-Gm-Message-State: AC+VfDxoR3ogXhOLqDDrkwEcmM7zInS9skeu6uApPfumwvPulV4ZtC1y
 TyQHqmQ69e0p96oeNBhwsm9jSn6J6vv5QdKJXf5jBxwBfsB+2DPKkjdTiddF05W5O+j6X4uUsvH
 klHKSpIZ5MLuJfR0=
X-Received: by 2002:ac8:5842:0:b0:3f9:cb97:f15a with SMTP id
 h2-20020ac85842000000b003f9cb97f15amr28104556qth.0.1687531915804; 
 Fri, 23 Jun 2023 07:51:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ456rFIHzXRztFqYg5Md8Gfd5bNvRzqyoUeDVwcSUN7YJ7I2Q/CEz8v7Fp4jxz4wuEQyo5YNA==
X-Received: by 2002:ac8:5842:0:b0:3f9:cb97:f15a with SMTP id
 h2-20020ac85842000000b003f9cb97f15amr28104526qth.0.1687531915422; 
 Fri, 23 Jun 2023 07:51:55 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w38-20020a05622a192600b003fde72a93e0sm4834488qtc.97.2023.06.23.07.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 07:51:55 -0700 (PDT)
Date: Fri, 23 Jun 2023 10:51:53 -0400
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
Message-ID: <ZJWxiTZf9zNGDeky@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
 <ZJRuw19Rc1LlPQId@x1n> <ZJVWdgXWad2w+za3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJVWdgXWad2w+za3@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 23, 2023 at 09:23:18AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 22, 2023 at 11:54:43AM -0400, Peter Xu wrote:
> > On Thu, Jun 22, 2023 at 10:59:58AM +0100, Daniel P. Berrangé wrote:
> > > I've mentioned several times before that the user should never need to
> > > set this multifd-channels parameter (nor many other parameters) on the
> > > destination in the first place.
> > > 
> > > The QEMU migration stream should be changed to add a full
> > > bi-directional handshake, with negotiation of most parameters.
> > > IOW, the src QEMU should be configured with 16 channels, and
> > > it should connect the primary control channel, and then directly
> > > tell the dest that it wants to use 16 multifd channels.
> > > 
> > > If we're expecting the user to pass this info across to the dest
> > > manually we've already spectacularly failed wrt user friendliness.
> > 
> > I can try to move the todo even higher.  Trying to list the initial goals
> > here:
> > 
> > - One extra phase of handshake between src/dst (maybe the time to boost
> >   QEMU_VM_FILE_VERSION) before anything else happens.
> > 
> > - Dest shouldn't need to apply any cap/param, it should get all from src.
> >   Dest still need to be setup with an URI and that should be all it needs.
> 
> There are a few that the dest will still need set explicitly. Specifically
> the TLS parameters - tls-authz and tls-creds, because those are both
> related to --object parameters configured on the dst QEMU. Potentially
> there's an argument to be made for the TLS parameters to be part fo the
> initial 'migrate' and 'migrate-incoming' command data, as they're
> specifically related to the connection establishment, while (most) of
> the other params are related to the migration protocol running inside
> the connection.

Ideally we can even make tls options to be after the main connection is
established, IOW the gnutls handshake can be part of the generic handshake.
But yeah I agree that may contain much more work, so we may start with
assuming the v2 handshake just happen on the tls channel built for now.

I think the new protocol should allow extension so when we want to move the
tls handshake into it v2 protocol should be able to first detect src/dst
binary support of that, and switch to that if we want - then we can even
got a src qemu migration failure which tells "dest qemu forget to setup tls
credentials in cmdlines", or anything wrong on dest during tls setup.

> 
> A few other parameters are also related to the connection establishment,
> most notably the enablement multifd, postcopy and postcopy-pre-empt.

As I mentioned in the list, I plan to make this part of the default v2
where v2 handshake will take care of managing the connections rather than
relying on the old code.  I'm not sure how complicated it'll be, but the v2
protocol just sounds a good fit for having such a major change on how we
setup the channels, and chance we get all things alright from the start.

> 
> I think with those ones we don't need to set them on the src either.
> With the new migration handshake we should probably use multifd
> codepaths unconditionally, with a single channel.

The v2 handshake will be beneficial to !multifd as well.  Right now I tend
to make it also work for !multifd, e.g., it always makes sense to do a
device tree comparision before migration, even if someone used special
tunneling so multifd may not be able to be enabled for whatever reason, but
as long as a return path is available so they can talk.

> By matching with the introduction of new protocol, we have a nice point
> against which to deprecate the old non-multifd codepaths. We'll need to
> keep the non-multifd code around *alot* longer than the normal
> deprecation cycle though, as we need mig to/from very old QEMUs.

I actually had a feeling that we should always keep it..  I'm not sure
whether we must combine a new handshake to "making multifd the default".  I
do think we can make the !multifd path very simple though, e.g., I'd think
we should start considering deprecate things like !multifd+compressions etc
earlier than that.

> 
> The enablement of postcopy could be automatic too - src & dst can
> both detect if their host OS supports it. That would make all
> migrations post-copy capable. The mgmt app just needs to trigger
> the switch to post-copy mode *if* they want to use it.

Sounds doable.

> 
> Likewise we can just always assume postcopy-pre-empt is available.
> 
> I think 'return-path' becomes another one we can just assume too.

Right, handshake cap (or with the new QAPI of URI replacement) should imply
return path already.

Thanks,

-- 
Peter Xu


