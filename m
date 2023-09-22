Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20F7AB595
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjijG-0007hs-Pu; Fri, 22 Sep 2023 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjijE-0007hU-9P
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjijC-0000DQ-Lm
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695399002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F87Nb9X6Lhkwvgwvir8s2AM9YSPzRzwXHLczZlEMidA=;
 b=feqKFQWj8TP4nY8V2nizNb7ZAEa3rCPAPMMhmNmS8bjrSLrHXMFPFrqDKkQF6n0VOlgI8h
 /Lomdz2Frt9ZcFzjcxZwWTDUwMDqiVBMt7+48crmf2NTvG6E7xnr+NL3nYluzcJgOzxnaj
 greGogoLnR/+jjqvg7eOxcGqhngH2tY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-zCgj75XVNFGb4Pqzdxbc4g-1; Fri, 22 Sep 2023 12:10:00 -0400
X-MC-Unique: zCgj75XVNFGb4Pqzdxbc4g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-637948b24bdso5150316d6.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 09:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695399000; x=1696003800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F87Nb9X6Lhkwvgwvir8s2AM9YSPzRzwXHLczZlEMidA=;
 b=OXR0N5LDpaI7hR5VP5E7baqGAj+LR0+7v46ixCM1rT50uc/Y5xHIK2CgjEZT4DISzY
 xq64xF/vbnp4vsddzbwETTlaYchO0MXEgdQmrrEX63KtUmvi3AOfNmT+dfxKoWjc58B2
 y39CiiQrJzynGB68ln88hKBMFh+X5D2fTlYkGTv2BExFIYPzShgHu6XWCB4rmbe+QYj3
 q7FiGC6w5pZ/K419sTUCKbqDcBwNUU2q806oHnwEQ3mCcwykPvrrC9AO68cpe05oY1rw
 0NOOUW+dnGJvP+A4aZ0nfrw+vcT0+Mcu0lHbog4nZx0Xs/51+APLrvgBcWl+xT5dtSSo
 RD5A==
X-Gm-Message-State: AOJu0Yzdl3ukrjc1frubXjro9Bmk8cmb841DxZZNJDX7b4sdCODZNESL
 G6fVUXBdNXCZNVy9HlyINKBx0lEASq8ZxmpUoMr3tQ6U3GUylLpwmF4xEidJWocPFdi67DPRZym
 Gw2IXY2rBMIiOJOY=
X-Received: by 2002:a05:6214:411b:b0:656:308b:98bc with SMTP id
 kc27-20020a056214411b00b00656308b98bcmr8872766qvb.4.1695398999886; 
 Fri, 22 Sep 2023 09:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx2qx3ISz7kmSXsSYTT0DgzTZuQVkiLgMYyT0PhMZpoB8xUD9SL22LkWIaFUgc/pJRRHVy8A==
X-Received: by 2002:a05:6214:411b:b0:656:308b:98bc with SMTP id
 kc27-20020a056214411b00b00656308b98bcmr8872752qvb.4.1695398999571; 
 Fri, 22 Sep 2023 09:09:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l19-20020a0ce093000000b0064f77d37798sm1536408qvk.5.2023.09.22.09.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 09:09:59 -0700 (PDT)
Date: Fri, 22 Sep 2023 12:09:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Li Zhijian <lizhijian@fujitsu.com>, quintela@redhat.com,
 leobras@redhat.com, qemu-devel@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
Message-ID: <ZQ28VIHZGjhdwQCV@x1n>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <ZQ210LoAWDIJ5l9J@x1n> <87ediqmc5y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ediqmc5y.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 22, 2023 at 12:59:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Sep 20, 2023 at 05:04:11PM +0800, Li Zhijian wrote:
> >> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> >> 
> >> Destination will fail with:
> >> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
> >> 
> >> migrate with RDMA is different from tcp. RDMA has its own control
> >> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
> >> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.
> >> 
> >> find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
> >> and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic to
> >> destination and cause migration to fail.
> >> 
> >> Since there's no existing subroutine to indicate whether it's migrated
> >> by RDMA or not, and RDMA is not compatible with multifd, we use
> >> migrate_multifd() here.
> >> 
> >> Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
> >> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >> ---
> >>  migration/ram.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 9040d66e61..89ae28e21a 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -1399,7 +1399,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
> >>          pss->page = 0;
> >>          pss->block = QLIST_NEXT_RCU(pss->block, next);
> >>          if (!pss->block) {
> >> -            if (!migrate_multifd_flush_after_each_section()) {
> >> +            if (migrate_multifd() &&
> >> +                !migrate_multifd_flush_after_each_section()) {
> >>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
> >>                  int ret = multifd_send_sync_main(f);
> >>                  if (ret < 0) {
> >> -- 
> >> 2.31.1
> >> 
> >
> > Maybe better to put that check at the entry of
> > migrate_multifd_flush_after_each_section()?
> >
> > I also hope that some day there's no multifd function called in generic
> > migration code paths..
> 
> I wonder what happened with that MigrationOps idea. We added the
> ram_save_target_page pointer and nothing else. It seems like it could be
> something in the direction of allowing different parts of the migration
> code to provide different behavior without having to put these explicit
> checks all over the place.

Yeah..

https://lore.kernel.org/qemu-devel/20230130080956.3047-12-quintela@redhat.com/

Juan should know better.

Personally I think it'll be good we only introduce hook when there's a 2nd
user already.  I assume Juan merged it planning that'll land soon but it
didn't.

-- 
Peter Xu


