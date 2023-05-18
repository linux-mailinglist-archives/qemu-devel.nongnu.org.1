Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 256197082F9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdtz-0006Ip-IM; Thu, 18 May 2023 09:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzdtw-0006IU-63
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzdtu-000088-3z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684417357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PR3PA4vHYXKjR7dnbsDamNJ5tumlMjvTauIaqLfsziE=;
 b=JoWWAXdGl4999jLQkHiM9p+RHDI49qDrN0kNBNEPi/baom3ISVF+gd8Dm1ZlPKCrIOAUD7
 S4X9npP0Ec90moolXPCEJyyJkr3ug5o3jzj9maYIWa36KoVQCJ50t9zSQkulTW9Im2wSJd
 tCur1ON2TU+AMvvYc2WL/ARaOeyFQ6Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-SOIp_I3nMDe3HjkzHEV-rg-1; Thu, 18 May 2023 09:42:36 -0400
X-MC-Unique: SOIp_I3nMDe3HjkzHEV-rg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f393bf5546so4198061cf.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684417354; x=1687009354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PR3PA4vHYXKjR7dnbsDamNJ5tumlMjvTauIaqLfsziE=;
 b=MNAQ4I9aCWB6aA8uZifGIg3Oqdm/vTB/WDY1ZrLgICGU+bSoU17lWal0xI7/fRr7TT
 OWRIpyIMrBrBzAQeqhiUdMfzdhSvOiOPkijcKL3PgTRfqf2nv4RxxeSIYUD6bwSlYICe
 +HhKl5WD+K/mzUtemHKVqy+F1xPl0mQd1PST/wCyERy4zDuK5T5lFClEfWPJFzCLpl+D
 uG1qGZ0RBcn7lbc9fSwxSsjXXEuYAgWPc5R7rp5uv4KYPNI9t7auIsyrrl936DkDT1sX
 u/DMmMde6o3mDAl3gFQQdA9BEBVdRe0N/ffVg9h9qqMeDyisqwVCBuieUIgY+gc4+aBg
 gjSg==
X-Gm-Message-State: AC+VfDzf2FjeR15YzeYcY2rkH9eEawjg4G/A779LXYPUKXgwba4ne+4P
 YTTzXh13hEdDjwniYDNHIsymY1amp8tBcVGz6yN3/wEp1FffjwhDtYh3qXcitPy1lZYl6G8Q6f8
 1Qzc5MrTOpgIPLLU=
X-Received: by 2002:ac8:7d06:0:b0:3f5:29b9:59e3 with SMTP id
 g6-20020ac87d06000000b003f529b959e3mr11852574qtb.3.1684417354545; 
 Thu, 18 May 2023 06:42:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4eIPtuJ8oOuVacqGr32j3lIHN9nyQ8yfA+xeQ/A8v2V4v8rUliMvdx8qu/Z72dQSOCtFeb9Q==
X-Received: by 2002:ac8:7d06:0:b0:3f5:29b9:59e3 with SMTP id
 g6-20020ac87d06000000b003f529b959e3mr11852536qtb.3.1684417354263; 
 Thu, 18 May 2023 06:42:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 fc12-20020a05622a488c00b003f38f55e71asm507651qtb.47.2023.05.18.06.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 06:42:33 -0700 (PDT)
Date: Thu, 18 May 2023 09:42:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 3/7] migration: Enable precopy initial data capability
Message-ID: <ZGYrR6tn0VxNZ/h2@x1n>
References: <20230517155219.10691-1-avihaih@nvidia.com>
 <20230517155219.10691-4-avihaih@nvidia.com> <ZGT72DLNTevauf9N@x1n>
 <bd2bf4eb-2f3d-83ce-609a-9b48a592d88e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd2bf4eb-2f3d-83ce-609a-9b48a592d88e@nvidia.com>
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

On Thu, May 18, 2023 at 10:26:04AM +0300, Avihai Horon wrote:
> 
> On 17/05/2023 19:07, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, May 17, 2023 at 06:52:15PM +0300, Avihai Horon wrote:
> > > Now that precopy initial data logic has been implemented, enable the
> > > capability.
> > > 
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > ---
> > >   migration/options.c | 4 ----
> > >   1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/migration/options.c b/migration/options.c
> > > index 0a31921a7a..3449ce4f14 100644
> > > --- a/migration/options.c
> > > +++ b/migration/options.c
> > > @@ -561,10 +561,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
> > >                                "capability 'return-path'");
> > >               return false;
> > >           }
> > > -
> > > -        /* Disable this capability until it's implemented */
> > > -        error_setg(errp, "'precopy-initial-data' is not implemented yet");
> > > -        return false;
> > >       }
> > I'm always confused why we need this and not having this squashed into
> > patch 1 (or say, never have these lines).
> > 
> > The only thing it matters is when someone backports patch 1 but not
> > backport the rest of the patches.  But that's really, really weird already
> > as a backporter doing that, and I doubt its happening.
> > 
> > Neither should we merge patch 1 without merging follow up patches to
> > master, as we should just always merge the whole feature or just keep
> > reworking on the list.
> > 
> > I'd like to know if I missed something else..
> 
> There are also git bisect considerations.
> This practice is useful for git bisect for features that are enabled by
> default, so you won't mistakenly run "half a feature" if you do bisect.
> But here the capability must be manually enabled, so maybe it's not that
> useful in this case.
> 
> I like it for the sake of good order, so this capability can't be enabled
> before it's fully implemented (even if it's unlikely that someone would do
> that).

Right.  I was kind of thinking someone bisecting such feature will always
make sure to start from the last commit got merged, but I see your point as
a general concept.

One slightly better way to not add something and remove again is, we can
introduce migrate_precopy_initial_data() in patch 2, returning constantly
false, then we can put patch 1 (qapi interface) to be after current patch
2, where you allow migrate_precopy_initial_data() to start return true.  It
saves a few lines to remove, and also one specific patch explicitly
removing it.  But I think fundamentally it's similar indeed.

In case you'd like to keep this as is, feel free to add:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


