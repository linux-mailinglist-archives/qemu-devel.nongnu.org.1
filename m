Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4747741715
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 19:18:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYnj-0006t1-Be; Wed, 28 Jun 2023 13:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEYnf-0006sj-Ih
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEYnd-0007VX-Rp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687972667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OACJSAknmKv+7w+jh54nTGVVGTGMJ04BZ95eq0HhI1c=;
 b=ZQmEa885BjAnh/aomzbzdpIWxoBC1FHbChBCD38I7V4UVDPybu4317rSeUeGWJMKXCjUaF
 JR8S34ErCmAL4elUBTwJIg1rFPL68GBAAvdLna3cwWr6UMR5hROCpahxPh3mpjZlyJ4VLb
 u3GJ+rU+NLwL1J+/GdbKQ+1+VRznJeM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-TYtKlZ72Ope7beXnp1cbag-1; Wed, 28 Jun 2023 13:17:45 -0400
X-MC-Unique: TYtKlZ72Ope7beXnp1cbag-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7655fffd637so128416185a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 10:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687972665; x=1690564665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OACJSAknmKv+7w+jh54nTGVVGTGMJ04BZ95eq0HhI1c=;
 b=da8wcPtAV9VXQUcgJWbpLo3QFAHkfK/xIthnX1jXlfNc7c9SUuMQZOFqb7WmvDXG0l
 QLVNcUUbNWDTbVhcSmX3Ou2idF/t9GimjcWq3R9F0eFhM1C03S2lJRmwN8cnh8bJfBI0
 4cGc5ghOaUBNlBOgOLW8e6kL2z23RWbjeowpTqwrqaWBLrerpqNtHkhxu26NFLDiRKvF
 hQIcKcBdkqU+V8DD/HYq109MExDtF/Gi5oc8MQxmnC9VpzbqluJ+NQB9OFDztY39sFGc
 VgZyWBEWEtEmmWJmGDG3wnrAkxT8zsPdtW/o113WKYB0qqy0wa5a60iNqhAo9+UE3ZF3
 OT8w==
X-Gm-Message-State: AC+VfDydUnIq8z2oFkT0wnmfltl81SNioUpBDY30HGUDHHzaGeURDrnE
 H/0LzjgMIAkRANaV0+7sxI+par/efYUmycjBSXEEAvxoTy748cxDiosJwDNVxOQweXRjjOl7ue2
 o0FWKgOTZ3VcLiGPMIgJWcs8=
X-Received: by 2002:a05:620a:4729:b0:765:5b3d:8195 with SMTP id
 bs41-20020a05620a472900b007655b3d8195mr16603029qkb.6.1687972664916; 
 Wed, 28 Jun 2023 10:17:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66aMToPMZuBRvQsCv5+P52ZaC8b3iJlCrq0e5+l+SAY49l03ix7gbMYtFptY8ZpmGjvm9Uqg==
X-Received: by 2002:a05:620a:4729:b0:765:5b3d:8195 with SMTP id
 bs41-20020a05620a472900b007655b3d8195mr16603016qkb.6.1687972664653; 
 Wed, 28 Jun 2023 10:17:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y26-20020a37e31a000000b00765a7843382sm3658752qki.74.2023.06.28.10.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 10:17:44 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:17:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 1/2] migration: file URI
Message-ID: <ZJxrNzAai8yJkDwc@x1n>
References: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
 <1687466251-310524-2-git-send-email-steven.sistare@oracle.com>
 <ZJxozLt2gfqmnjSa@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJxozLt2gfqmnjSa@x1n>
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

On Wed, Jun 28, 2023 at 01:07:24PM -0400, Peter Xu wrote:
> On Thu, Jun 22, 2023 at 01:37:30PM -0700, Steve Sistare wrote:
> > Extend the migration URI to support file:<filename>.  This can be used for
> > any migration scenario that does not require a reverse path.  It can be
> > used as an alternative to 'exec:cat > file' in minimized containers that
> > do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
> > It can be used in HMP commands, and as a qemu command-line parameter.
> > 
> > For best performance, guest ram should be shared and x-ignore-shared
> > should be true, so guest pages are not written to the file, in which case
> > the guest may remain running.  If ram is not so configured, then the user
> > is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
> > the same page, causing it to be appended to the file multiple times,
> > and the file may grow unboundedly.  That issue is being addressed in the
> > "fixed-ram" patch series.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  migration/file.h       | 14 ++++++++++++
> >  migration/meson.build  |  1 +
> >  migration/migration.c  |  5 ++++
> >  migration/trace-events |  4 ++++
> >  qemu-options.hx        |  6 ++++-
> >  6 files changed, 91 insertions(+), 1 deletion(-)
> >  create mode 100644 migration/file.c
> >  create mode 100644 migration/file.h
> > 
> > diff --git a/migration/file.c b/migration/file.c
> > new file mode 100644
> > index 0000000..8e35827
> > --- /dev/null
> > +++ b/migration/file.c
> > @@ -0,0 +1,62 @@
> > +/*
> > + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "channel.h"
> > +#include "file.h"
> > +#include "migration.h"
> > +#include "io/channel-file.h"
> > +#include "io/channel-util.h"
> > +#include "trace.h"
> > +
> > +void file_start_outgoing_migration(MigrationState *s, const char *filename,
> > +                                   Error **errp)
> > +{
> > +    g_autoptr(QIOChannelFile) fioc = NULL;
> > +    QIOChannel *ioc;
> > +
> > +    trace_migration_file_outgoing(filename);
> > +
> > +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> > +                                     0600, errp);
> > +    if (!fioc) {
> > +        return;
> > +    }
> > +
> > +    ioc = QIO_CHANNEL(fioc);
> > +    qio_channel_set_name(ioc, "migration-file-outgoing");
> > +    migration_channel_connect(s, ioc, NULL, NULL);
> 
> Miss one object_unref(ioc)?

Never mind, I overlooked the g_autoptr.. all fine:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


