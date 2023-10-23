Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E107D3AB2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwoQ-00053J-GX; Mon, 23 Oct 2023 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quwoL-000530-S7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quwoI-0001ER-Gn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698074741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vI2k3c1u0+zMs4l/cI3+MwHr/zZSVs/IeWlIZCdij48=;
 b=dx9zzUqsXPx8Z5KA8JJN1y9arfSEehYSiQqhNO10OwSaA/rBNI9euo6pUySNhECS5vovxB
 IswMn+zTi3LZns66ckSLgeeg/PgkAlMFeQzYbjXqe6WQkBazAXM4oFF4V2s5q+3pKnABpW
 +B2XLZZtUo3TtGn734l/vUcDU5gNBR0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-FN3impx2NjCMBCae6SvsWg-1; Mon, 23 Oct 2023 11:25:32 -0400
X-MC-Unique: FN3impx2NjCMBCae6SvsWg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-45a62748716so25516137.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698074732; x=1698679532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vI2k3c1u0+zMs4l/cI3+MwHr/zZSVs/IeWlIZCdij48=;
 b=etL3muA3r47fJJDKe9/P54LSDekUP7FqGfadcwaxShmpR/X4j2y9xnXevuLIs4CqkL
 Png4t9ujPlKvlflEhHxNHYj6ImDdu6H4A/54zdD/6kaLXFBnPYE2aXJGIf3h7k/82PPR
 OKGRIj8iqtOO1QL5j3Yubk2ZLGgS8aJNIjdfZY3ws7mvlbPaXQ7gtTmABEYme9oR+jOG
 tT7Y57fpCDQHBZvvIJNopY8pb9rtk6zfZmT5m5ypOQOJke1OwZ8PzEDIzMI7vM9NSKlV
 NqgX+ntG07DyUWpRTwnUg4A8TdisY+1UKIJDYu5/PDiZBnX26iXCsFbiPHSjKZZ/frIi
 uqhw==
X-Gm-Message-State: AOJu0YzWKYoL2t680MYS2HUB5kop8/IPkX4H6BZzIwnxLcRnNBmxTbSj
 u2dQk2oHJPxDL11IBvi4SegTkpehfJcAPTb+e8XdN/AwKgj8G6x0J405KggUmn3Ow6g7FEpYSg4
 z6Y8jVemKIk+7dho=
X-Received: by 2002:a67:fe89:0:b0:457:c159:9675 with SMTP id
 b9-20020a67fe89000000b00457c1599675mr4407561vsr.1.1698074732492; 
 Mon, 23 Oct 2023 08:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVbh6h5A1KWM/xt+rIKIl5Zlwwnk3Bf+8dLMo0AeMap13Mvm++5An2+nNVNTDx4hNh2Qq3NQ==
X-Received: by 2002:a67:fe89:0:b0:457:c159:9675 with SMTP id
 b9-20020a67fe89000000b00457c1599675mr4407544vsr.1.1698074732213; 
 Mon, 23 Oct 2023 08:25:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e6-20020a05620a208600b007742218dc42sm2759569qka.119.2023.10.23.08.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:25:31 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:25:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V1 3/4] cpr: relax some blockers
Message-ID: <ZTaQaT8N4lMF6+3p@x1n>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-4-git-send-email-steven.sistare@oracle.com>
 <87r0lpzl8w.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0lpzl8w.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 20, 2023 at 11:38:55AM +0200, Juan Quintela wrote:
> Steve Sistare <steven.sistare@oracle.com> wrote:
> > Some devices block migration because they rely on local state that
> > is not migrated to the target host, such as for local filesystems.
> > These need not block cpr, which will restart qemu on the same host.
> > Narrow the scope of these blockers so they only apply to normal mode.
> > They will not block cpr modes when they are added in subsequent patches.
> >
> > No functional change until a new mode is added.
> >
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> They are all basically block devices support, would be great to have a
> comment from someone from the block layer.

There're also non-block ones like vhost/9pfs/..

I agree with Daniel that we should split and allow module maintainers to
review.  Maybe we can unify changes of the same module into one patch.
Even if so, some comments for each site on explaining why local migration
can skip the blocker would be greatly helpful.

Thanks,

-- 
Peter Xu


