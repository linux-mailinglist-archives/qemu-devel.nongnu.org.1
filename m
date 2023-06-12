Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F972CFE7
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ndp-0006w5-DF; Mon, 12 Jun 2023 15:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8ndZ-0006s9-AD
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8ndV-0002aB-Ub
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686599732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n4j0wyWg13B9F3SP2Ggfa4RVJQXhooE2MVh+v70BjFo=;
 b=D4iF8w5DwxugkAb7zYqOHiPjeDhcWL1QVEHzdfOf7PMsZgoDHMxRA4mz6CBTOYz86BZt8H
 jffLo1jfHpCfA6mr7BybJ5ucmRUt7W7X2jXODLXtTwGlV1oQuVnYN3lbDW+Acgf7b0vDUz
 hdMtlZkgWbnTMMBFMXY2Xm1Y+SxYLtI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-Ae9mSUeAONO4pBbI1LCpVQ-1; Mon, 12 Jun 2023 15:55:29 -0400
X-MC-Unique: Ae9mSUeAONO4pBbI1LCpVQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f9e7a1caf2so6443151cf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 12:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686599729; x=1689191729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4j0wyWg13B9F3SP2Ggfa4RVJQXhooE2MVh+v70BjFo=;
 b=fnRRoi5Fz8Ndk2KHvViBfRcOg/aWpQbgFnKHyyTLQLRq13KkcQPjrSESEp0nqgi3qv
 B0WnKEi0MKd5F5fLRTLuikltfcYmXb58LKZez/pcoTsSbQMaGuGaEzZQoecNTGx/uruz
 JgKpfGpnneWdFS0WUudSu6MC5NsedGB0iBrHGdlcvHjMY8XwlUDZPpp3KeAskNjMjNdQ
 R9nBOfIchUDPAtdI9J/bUfnWLKr8tm8/T9MZbkfTO5kydkZ3WD/mH5yGBeHOBEToI0+x
 BemzjkuETudHO5YIPgHAshuDqIk+PmdzFjFK7/80cITAP4CQyzXLRQLFry+X+ZekQ6iy
 GeTw==
X-Gm-Message-State: AC+VfDwHPUQ6eSBnJ+PUIDg60Gv86EVUU1ll0vzhyIG0TiqOtILpmx4O
 dZIbSShqPTzEK8uE4hXNs/8ceeRUwKtDhnTFY8Om1DlnWB7LYgQehEU2/tv5qA7aTbk0yDyP8dK
 rx1fP8eMNs/vIYYU=
X-Received: by 2002:a05:622a:1a25:b0:3f6:b493:8ee4 with SMTP id
 f37-20020a05622a1a2500b003f6b4938ee4mr13421405qtb.0.1686599728999; 
 Mon, 12 Jun 2023 12:55:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SFFfwpKVLwLZzEFCA0MQ9QFkP6IaGlgtFVmEzNCkHc7BSpRkhaKYp4LDf38z5YtDUpXaoRA==
X-Received: by 2002:a05:622a:1a25:b0:3f6:b493:8ee4 with SMTP id
 f37-20020a05622a1a2500b003f6b4938ee4mr13421398qtb.0.1686599728749; 
 Mon, 12 Jun 2023 12:55:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z16-20020ac87cb0000000b003e69c51cf53sm3643970qtv.72.2023.06.12.12.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 12:55:28 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:55:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZId4LggDVgxbtGTn@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n>
 <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
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

On Mon, Jun 12, 2023 at 03:39:34PM -0400, Steven Sistare wrote:
> On 6/12/2023 2:44 PM, Peter Xu wrote:
> > Hi, Steve,
> > 
> > On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
> >> Extend the migration URI to support file:<filename>.  This can be used for
> >> any migration scenario that does not require a reverse path.  It can be used
> >> as an alternative to 'exec:cat > file' in minimized containers that do not
> >> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
> >> be used in HMP commands, and as a qemu command-line parameter.
> > 
> > I have similar question on the fixed-ram work,
> 
> Sorry, what is the "fixed-ram work"?

https://lore.kernel.org/all/20230330180336.2791-1-farosas@suse.de

It has similar requirement to migrate to a file, though slightly different
use case.

> 
> > on whether we should assume
> > the vm stopped before doing so.  Again, it leaves us space for
> > optimizations on top without breaking anyone.
> 
> I do not assume the vm is stopped.  The migration code will stop the vm
> in migration_iteration_finish.
> 
> > The other thing is considering a very busy guest, migration may not even
> > converge for "file:" URI (the same to other URIs) but I think that doesn't
> > make much sense to not converge for a "file:" URI.  The user might be very
> > confused too.
> 
> The file URI is mainly intended for the case where guest ram is backed by shared memory 
> and preserved in place, in which case writes are not tracked and convergence is not an
> issue.  If not shared memory, the user should be advised to stop the machine first.
> I should document these notes in qemu-options and/or migration.json.

My question was whether we should treat "file:" differently from most of
other URIs.  It makes the URI slightly tricky for sure, but it also does
make sense to me because "file:" implies more than the rest URIs, where
we're sure about the consequence of the migration (vm stops), in that case
keeping vm live makes it less performant, and also weird.

It doesn't need to be special in memory type being shared, e.g. what if
there's a device that contains a lot of data to migrate in the future?
Assuming "shared memory will always migrate very fast" may not hold true.

Do you think it makes more sense to just always stop VM when migrating to
file URI?  Then if someone tries to restart the VM or cancel the migration,
we always do both (cancel migration, then start VM).

-- 
Peter Xu


