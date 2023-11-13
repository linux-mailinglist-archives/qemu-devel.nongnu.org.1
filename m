Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215397EA185
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:52:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2a9u-0000ud-NP; Mon, 13 Nov 2023 11:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2a9n-0000uR-Uw
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2a9m-0001xk-E1
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699894285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HaxIHyavgn5AIhXqCyqDK2s92y2IcUeosCYtVUFcfZs=;
 b=FZg1ireq93hIYm0wghheF9j6zVeFPMdO47PdhBYd7DliV1FGiGvnFs5oCQ6gZgM95iYodP
 BSJN6FzHeR7v+CqyK4yzwQDdfuaFnmFzE5h+13UUK2RNW0C86iXNdjZRNvUWAQMt7IQMXd
 GRrYq5k00Cq21lj/oAhDWRk81E/rA7c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-QwQmX_pVNVGPIMvMR30zRQ-1; Mon, 13 Nov 2023 11:51:23 -0500
X-MC-Unique: QwQmX_pVNVGPIMvMR30zRQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778b5c628f4so32758985a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 08:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699894283; x=1700499083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaxIHyavgn5AIhXqCyqDK2s92y2IcUeosCYtVUFcfZs=;
 b=Y+hINrTYx/V3vPgDox1/DqRcRKN4zbYKcwJoiSM8j0CSRhAKRtz2TwrHq/Wnf+MMYx
 urkWDuBJV48OifuKkD98FHh1QxP1QhvawDAIopZhAZ3bcRu96HsIfViMxIDSNWJ1hYgH
 6kCLdNllgaAlKqUd2Mo32jHuGeOCjWpoJHRaO+5+Dl+QqcXeAYPNmb6v9mboBfjnF6dR
 W1j8CRO4uBtK/LnX41L1p4LpYkA9SfGV9d6LyryBIdhW9UtAXJhmOE5pl/rxKRxHZfM8
 xfQT8aB+YplHteygYkNkqDC+HRe5IcWfVyN+zmZLswEs+ALIrdQxdqBHYNK6uQViAxGJ
 2jDw==
X-Gm-Message-State: AOJu0YxTW81CZiiSfE+hSJ1oPROcKuUCZhUIwGK/Du13R7WVLJx39ze7
 S41lJikkeCkcTDFlNTezeqAhT+EFU8S0JPz4Sm0XRj6f5DRSQ57Vdqy0nAKwnf/heVY1StTSjXd
 EMpB3LAwkK+TYJdI=
X-Received: by 2002:a0c:c78f:0:b0:66d:b23:a62e with SMTP id
 k15-20020a0cc78f000000b0066d0b23a62emr7647191qvj.6.1699894283132; 
 Mon, 13 Nov 2023 08:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPgSxmnuFliazLWF/GX9bw2Xu3zZWf7GvpyW/N4lSm/+HsWpAyGjEUEgLL3pOd3QG5/l1NCg==
X-Received: by 2002:a0c:c78f:0:b0:66d:b23:a62e with SMTP id
 k15-20020a0cc78f000000b0066d0b23a62emr7647181qvj.6.1699894282851; 
 Mon, 13 Nov 2023 08:51:22 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y8-20020a0cff48000000b006562b70805bsm2176638qvt.84.2023.11.13.08.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 08:51:22 -0800 (PST)
Date: Mon, 13 Nov 2023 11:51:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 1/2] migration: Report error in incoming migration
Message-ID: <ZVJUCG9jQEjoMDWT@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-2-farosas@suse.de> <ZU0rqJv0IHzaY5aW@x1n>
 <87sf5dzxhj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf5dzxhj.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Nov 10, 2023 at 07:58:00AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Nov 09, 2023 at 01:58:55PM -0300, Fabiano Rosas wrote:
> >> We're not currently reporting the errors set with migrate_set_error()
> >> when incoming migration fails.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/migration.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 28a34c9068..cca32c553c 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -698,6 +698,13 @@ process_incoming_migration_co(void *opaque)
> >>      }
> >>  
> >>      if (ret < 0) {
> >> +        MigrationState *s = migrate_get_current();
> >> +
> >> +        if (migrate_has_error(s)) {
> >> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> >> +                error_report_err(s->error);
> >> +            }
> >> +        }
> >
> > What's the major benefit of dumping this explicitly?
> 
> This is incoming migration, so there's no centralized error reporting
> aside from the useless "load of migration failed: -5". If the code has
> not called error_report we just never see the error message.
> 
> > And this is not relevant to the multifd problem, correct?
> 
> Yes, I'm being sneaky.

Trying to sneak one patch into a 2 patch series is prone to be exposed and
lose the effect. :-)

I remember we had the verbose error before. Was that lost since some
commit?  In all cases, feel free to post that separately if you think we
should get it back.

The multifd fixes do not look like a regression either for this release. If
so, both of them may be better next release's material?

-- 
Peter Xu


