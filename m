Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DB7FFB09
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 20:18:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8mWy-0003Rq-Mi; Thu, 30 Nov 2023 14:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8mWu-0003Qw-La
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:16:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8mWt-00023a-1D
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701371809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eKlWRv7yzylB+1maPtzg8B2uyJpfWIeA+vQfTEx7+c=;
 b=IynqAdWHj61AtFaizIuzQbN1ku8ip6muEEp/XttHDkuUrx8PPW/MwAV6GLgwezKamPVuln
 oBBSDc7jeei/SeMYcVqu5q4CpH2txkYLVXQinSwaQ+IRnZTRK4guWCQWQL4Q3KVCjxKaEY
 X3NBHkckzd9Jp0R6iGtPY+8bbZWYMr4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-sHoipnd7NZKvONtTGL4JXw-1; Thu, 30 Nov 2023 14:16:47 -0500
X-MC-Unique: sHoipnd7NZKvONtTGL4JXw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-423c28eababso3320241cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 11:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701371807; x=1701976607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eKlWRv7yzylB+1maPtzg8B2uyJpfWIeA+vQfTEx7+c=;
 b=US//XORaVopI9mVzJmmd2xGaB/xDbMKxiA72ZDfMFJXZClZO1kYk3jVHR/k8ImR5d0
 M1JMeI5HGVRUSKf5ObLOgvM0YNhsGgbC6Z/0m5vjlgmiez+QxJWMlRzDR+aLSZxttVDw
 UAENPgpBI4ZA2JupxOhi3oRPn0KMYEHxik5LisZFnNUv3mtkOchaq1T/wxOmST8X1/G1
 iGq/yZrA0pfSQt7QgNri6PeI8AvcjN6GsiT9OCEpORoR8qG3Y/lMbAQgoaVG91Mzpqy1
 SAsaF1lb/N0T93jKYzKpD4qpx0jPnseNdtqCPCzra5vWDRQQnzUFHZYonUeuTDw2Ydvk
 WWlw==
X-Gm-Message-State: AOJu0YwrEcQkosZ9r5Bgia1KTMFUNE40WbhROIRuUf/uFwcC21Rz+OrW
 qt1Q5n0G7JAYYjIl0z6PVgO8DWelUJZoZYD6iZ802fiZ4cVnd5zL2rkGVkkmqKes+LkcM2GTwHD
 uM0XwyQUEuDh1Va4=
X-Received: by 2002:a05:622a:104a:b0:423:ccec:9c3b with SMTP id
 f10-20020a05622a104a00b00423ccec9c3bmr14884371qte.1.1701371807029; 
 Thu, 30 Nov 2023 11:16:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOi9NB13ybQsKnb0IJqSvw3s0v/UgTSocLfyyQ/uHGKqe0JTBigyK6oRXryLJt4trSkIdt8A==
X-Received: by 2002:a05:622a:104a:b0:423:ccec:9c3b with SMTP id
 f10-20020a05622a104a00b00423ccec9c3bmr14884343qte.1.1701371806679; 
 Thu, 30 Nov 2023 11:16:46 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h14-20020ac8568e000000b00423e6885152sm747535qta.75.2023.11.30.11.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 11:16:46 -0800 (PST)
Date: Thu, 30 Nov 2023 14:16:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de
Subject: Re: [PATCH v4] migration: Plug memory leak with migration URIs
Message-ID: <ZWjfnIjec3udUZZ-@x1n>
References: <20231129204301.131228-1-het.gala@nutanix.com>
 <ZWjGdg-gic-C1PA_@x1n> <87il5j2io0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il5j2io0.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 30, 2023 at 07:35:43PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Nov 29, 2023 at 08:43:01PM +0000, Het Gala wrote:
> >> migrate_uri_parse() allocates memory to 'channel' if the user
> >> opts for old syntax - uri, which is leaked because there is no
> >> code for freeing 'channel'.
> >> So, free channel to avoid memory leak in case where 'channels'
> >> is empty and uri parsing is required.
> >> 
> >> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
> >> Signed-off-by: Het Gala <het.gala@nutanix.com>
> >> Suggested-by: Markus Armbruster <armbru@redhat.com>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> >> @@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
> >>              error_setg(errp, "Channel list has more than one entries");
> >>              return;
> >>          }
> >> -        channel = channels->value;
> >> +        addr = channels->value->addr;
> >>      } else if (uri) {
> >>          /* caller uses the old URI syntax */
> >>          if (!migrate_uri_parse(uri, &channel, errp)) {
> >>              return;
> >>          }
> >> +        addr = channel->addr;
> >>      } else {
> >>          error_setg(errp, "neither 'uri' or 'channels' argument are "
> >>                     "specified in 'migrate-incoming' qmp command ");
> >>          return;
> >>      }
> >> -    addr = channel->addr;
> >
> > Why these "addr" lines need change?  Won't that behave the same as before?
> 
> In the first case, @channel is now null.  If we left the assignment to
> @addr alone, it would crash.  Clearer now?

Is it this one?

    if (uri && has_channels) {
        error_setg(errp, "'uri' and 'channels' arguments are mutually "
                   "exclusive; exactly one of the two should be present in "
                   "'migrate-incoming' qmp command ");
        return;
    }

It returns already?

Thanks,

-- 
Peter Xu


