Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF5829278
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 03:38:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNOT6-0003rZ-Nr; Tue, 09 Jan 2024 21:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNOT4-0003rR-VL
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNOT3-0002bu-1g
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704854239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVqZ/21nh+G/2hdutxQ7/ykcyTClGz0BUHcHya4id+c=;
 b=InYHkzg4vYZfvvB/zTHd3O8e+0PnwAgnjzNQ08dT52LC1v9jC2TbnaaX4UupmJwo/8c6iB
 Ba+53jladBOooSqeqzhUaAEdKWc8efuuB7b6UBtxoMyJ5XGEU7BkWVug7eBIbkYMQ/gOUp
 ug/vmRZzD1A4yet96Ssd7acdYsjL4yU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-eB0fGsd6Plqvmk5oGrbkAA-1; Tue, 09 Jan 2024 21:37:16 -0500
X-MC-Unique: eB0fGsd6Plqvmk5oGrbkAA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d9bf77a474so1164162b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 18:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704854235; x=1705459035;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LVqZ/21nh+G/2hdutxQ7/ykcyTClGz0BUHcHya4id+c=;
 b=OD42W8l8Hh6S93rZV87j0fE0gjBMayETICuCranz/hkpggSdls01FsIM65/PshkF/a
 afbydgb3VF85bU4di9wwM96+25SV90z814OMXJ24vHHnMG7RztnhfSP5xhk6Dki3SVdi
 DbAgIfSTlQ/HUS8+SxDMCd3JEJyZPckAzI6WmO13ocyPFUj9R2U9WfWeuUeydleFk+nu
 faWCzO6LBdxX5V2EwBaRct1bfq+1eCCtaOO9H/X2qIwed5u7MLw8oG+Pe+CgvJEGB43U
 apb7dsMu1NFyI3RKm2YlMipJgI5r7tAWggoDYwSuWq7rnhq5yLMQsVORSkdZCEAEv54h
 ngtQ==
X-Gm-Message-State: AOJu0YwxSsProVrhEcWWmlSc9tK0mHI188AVuRtlFtzJfIp0TX77Hrl7
 cjnrb+WB+kuwHvNn/62RiS5urwECahS5r4kc5Ns/4ofhuVWr82hs3K/hxTI99dO6lOdxbT7A0BN
 odmF1mwHJRH2i2JUPbfLrtGU=
X-Received: by 2002:a05:6a00:887:b0:6da:83a2:1d9a with SMTP id
 q7-20020a056a00088700b006da83a21d9amr936425pfj.1.1704854235281; 
 Tue, 09 Jan 2024 18:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt/Y4xSNY+5UCLfQ0G4cV2CtaAg0Zuru8rZ0TuMmGgn967CVnevrj+62CvgkUxixl3/qdyhQ==
X-Received: by 2002:a05:6a00:887:b0:6da:83a2:1d9a with SMTP id
 q7-20020a056a00088700b006da83a21d9amr936409pfj.1.1704854234954; 
 Tue, 09 Jan 2024 18:37:14 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e8-20020a056a0000c800b006d9ecb8e956sm2407713pfj.173.2024.01.09.18.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 18:37:14 -0800 (PST)
Date: Wed, 10 Jan 2024 10:37:07 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/10] docs/migration: Reorganize migration documentations
Message-ID: <ZZ4C08Jrb-76WHW9@x1n>
References: <20240109064628.595453-1-peterx@redhat.com> <ZZ0kpnT741chs1np@x1n>
 <1644d352-7ced-4ddc-90a8-8190fe863e87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644d352-7ced-4ddc-90a8-8190fe863e87@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 09, 2024 at 02:21:26PM +0100, Cédric Le Goater wrote:
> 
> > A few things I'd like to mention alongside, because it's documentation
> > relevant too, and I'd like to collect if there's any comment.
> > 
> > I just mostly rewrote two wiki pages completely:
> > 
> >    https://wiki.qemu.org/ToDo/LiveMigration
> >    https://wiki.qemu.org/Features/Migration>
> > I merged all the TODO items from Features/Migration into the ToDo page,
> > while kept the 2nd page mostly clean, just to route to other places.
> > 
> > I had a plan to make:
> > 
> >    https://qemu.org/docs/master
> > 
> > The solo place for migration documentations (aka, QEMU repo the source of
> > truth for migration docs, as it's peroidically built there), making all the
> > rest places pointing to that, as I already did in the wiki page.  While I
> > kept all the TODOs on the wiki page (not Features/Migration, but
> > ToDo/LiveMigration).> Fabiano / anyone: feel free to add / update /
> > correct any entries there
> > where applicable.  Also if there's any thoughts on above feel free to let
> > me know too.
> 
> The Wiki has some limited value, the changelog for instance, but the rest
> is a bag of orphan and obsolete pages doomed to bit-rot since it is slowly
> being replaced by the in-tree documentation.
> 
> The info in the Features/Migration page is redundant with what we have
> in-tree, a part from the CREDITS. The TODO list could be some file under :
> 
> 	https://qemu.org/docs/master/devel/migration
> 
> It would be easier to find and it would keep the Wiki to a strict minimum.

Thanks for the suggestions.  I agree that we should minimize the wiki use,
especially on docs.  It'll be nice we use a solo source of truth for the
docs, always accessable via qemu.org/docs, and also makes it easier for us
to ask for docs altogether as patches when new features are merged.

I see that most of the ToDos for the other part of qemus still use the wiki
page, even though they're indeed mostly outdated just like the migration
ToDo before I updated it.

IMHO one thing that the wiki services well for ToDo is that it allows easy
& frequent updates on the projects, without the need to require a review
process like most of the patches being posted on the list.  The wiki page
still maintains a diff, and IMHO that may not even be required, as a
history record of a ToDo list may not help much in most cases.

The other issue regarding ToDo is that, some of the ToDo idea (or when
someone frequently updates with details on a project of an ongoing item)
may not be mature enough to be mentioned in an official documents. So even
if some can be considered to be put together with the qemu repo, there may
always be some that may not be suitable, then we will still need some place
for those.  I still don't know what's the ideal way to do this.

Thanks,

-- 
Peter Xu


