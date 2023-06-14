Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A573042B
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 17:51:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9SlX-0008A4-OQ; Wed, 14 Jun 2023 11:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9SlV-00087y-8G
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9SlS-0002SU-LN
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686757829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmHDpjjm7i5z0dzg2oojgdw58WvnrDn3yBdneR+LQR8=;
 b=Wfbp23FXkRg+ligw9+qFGtR1YXoR6fFGhE4nLQM0iFaU19MVHagwTPJ0iHW/NTns2zRA5E
 c5EAn3sFnUKwxwAbSD7ugX87DqYOpjaL+75taR4ANOeO+iIVbQjcbwyuOSiS127yIVKQxC
 RuaDlpTMrHCxTN/5Y23tWqlJphnNHW4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-W8AM586HNIyQpvviBMeZeg-1; Wed, 14 Jun 2023 11:50:25 -0400
X-MC-Unique: W8AM586HNIyQpvviBMeZeg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f9eb7d5202so6419691cf.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 08:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686757825; x=1689349825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmHDpjjm7i5z0dzg2oojgdw58WvnrDn3yBdneR+LQR8=;
 b=fAN445jdtel4M9mMbltR7LRnPd28MI3jbP4X6rln8naTKhnMB725lpVxdb9+OyNyzm
 5Hrb44sEfw+wk463KLT2ev0hj9kLX8QKrzQZ6RTRJqPTuMlSCLH8EmyGJpP2Ya//pS3u
 diSiGxYE7yZOtDei3lmhUZyaewRaRsgSHePHt6yxjqrNIF1RaXSCMI6/VvPULS7qy7jD
 k3PDvmnWxgFxrKVcdM+PZU24yZVGyQLs13B0+ZkNh2pdy8oj3vl0JHKl6UIRlyupy6pe
 r5SR+ZSzpLrzEnlWh3vecx8vYmc9SrLb7KJPAX0UZuVdeBh2GieZc18x4M6JZ2CzL27K
 L5fw==
X-Gm-Message-State: AC+VfDwoXKXFeQPaJX4l6sGVShXqWwkuQCtlKHJQx1h6uXdsW0ByJ85k
 DOC1gAPl7ia89TPODjkIVjLKOfZMe4ooC088e20ec+LjpnqvCj+B66n37VnhegI4pm9eChCa7jj
 syXKGyHalUNGe/vs=
X-Received: by 2002:a05:622a:1887:b0:3f9:ab2c:8895 with SMTP id
 v7-20020a05622a188700b003f9ab2c8895mr20923155qtc.3.1686757825192; 
 Wed, 14 Jun 2023 08:50:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Q2lo3uuUZoeN2jMzYmVVz97VO/JnKqISORWdjgYNoKSBu8Sy9KaH5qjRalcusHSU0X5h6rA==
X-Received: by 2002:a05:622a:1887:b0:3f9:ab2c:8895 with SMTP id
 v7-20020a05622a188700b003f9ab2c8895mr20923143qtc.3.1686757824907; 
 Wed, 14 Jun 2023 08:50:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f2-20020ac87f02000000b003e4d9c91106sm5112616qtk.57.2023.06.14.08.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:50:24 -0700 (PDT)
Date: Wed, 14 Jun 2023 11:50:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZInhvxq9YgoM9ykZ@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n>
 <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
 <ZId4LggDVgxbtGTn@x1n> <877cs6ujtu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cs6ujtu.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 14, 2023 at 12:47:41PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 12, 2023 at 03:39:34PM -0400, Steven Sistare wrote:
> >> On 6/12/2023 2:44 PM, Peter Xu wrote:
> >> > Hi, Steve,
> >> > 
> >> > On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
> >> >> Extend the migration URI to support file:<filename>.  This can be used for
> >> >> any migration scenario that does not require a reverse path.  It can be used
> >> >> as an alternative to 'exec:cat > file' in minimized containers that do not
> >> >> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
> >> >> be used in HMP commands, and as a qemu command-line parameter.
> >> > 
> >> > I have similar question on the fixed-ram work,
> >> 
> >> Sorry, what is the "fixed-ram work"?
> >
> > https://lore.kernel.org/all/20230330180336.2791-1-farosas@suse.de
> >
> > It has similar requirement to migrate to a file, though slightly different
> > use case.
> >
> >> 
> >> > on whether we should assume
> >> > the vm stopped before doing so.  Again, it leaves us space for
> >> > optimizations on top without breaking anyone.
> >> 
> >> I do not assume the vm is stopped.  The migration code will stop the vm
> >> in migration_iteration_finish.
> >> 
> >> > The other thing is considering a very busy guest, migration may not even
> >> > converge for "file:" URI (the same to other URIs) but I think that doesn't
> >> > make much sense to not converge for a "file:" URI.  The user might be very
> >> > confused too.
> >> 
> >> The file URI is mainly intended for the case where guest ram is backed by shared memory 
> >> and preserved in place, in which case writes are not tracked and convergence is not an
> >> issue.  If not shared memory, the user should be advised to stop the machine first.
> >> I should document these notes in qemu-options and/or migration.json.
> >
> > My question was whether we should treat "file:" differently from most of
> > other URIs.  It makes the URI slightly tricky for sure, but it also does
> > make sense to me because "file:" implies more than the rest URIs, where
> > we're sure about the consequence of the migration (vm stops), in that case
> > keeping vm live makes it less performant, and also weird.
> >
> > It doesn't need to be special in memory type being shared, e.g. what if
> > there's a device that contains a lot of data to migrate in the future?
> > Assuming "shared memory will always migrate very fast" may not hold true.
> >
> > Do you think it makes more sense to just always stop VM when migrating to
> > file URI?  Then if someone tries to restart the VM or cancel the migration,
> > we always do both (cancel migration, then start VM).
> 
> From our discussions in the other thread, I have implemented a
> MIGRATION_CAPABILITY_SUSPEND to allow the management layer to decide
> whether the guest should be stopped by QEMU before the migration.
> 
> I'm not opposed to coupling file URI with a stopped VM, although I
> think, at least for fixed-ram, libvirt would prefer to be able to decide
> when to stop.

IIUC the best timing is when migration starts, not earlier, not later.

If that's always the case, it's better qemu guarantee that?  Or am I wrong
that libvirt wants to not do it in some cases?

-- 
Peter Xu


