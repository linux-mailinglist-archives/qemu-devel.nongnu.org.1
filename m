Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B347D5873
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:33:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKKQ-0006IS-TL; Tue, 24 Oct 2023 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvKKH-0006En-VK
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvKKG-0003IO-3k
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698165135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+tdu1ICjyxv8/ztxRWEvZT9wTGL+LH4NMuH2aUFw8w=;
 b=S6CwYR4bf5+5OZqYbfanMYrFWKD2QNF8yFYp0PvcRx2RKvPVZBqFRtKoAWC3Q/GL/1FdKP
 bgYYJEo3eIL6NMoZNpg/nMKd5FJAp8xsdaP8JffHRTX6Ebs6nXyl0UBZgTE0WcC6SkMJoo
 Cr53mAH9qdq4JfQhkpXQLJkNMDaWYr4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-gBInAFVtPXqiqVH2ykNl9A-1; Tue, 24 Oct 2023 12:31:58 -0400
X-MC-Unique: gBInAFVtPXqiqVH2ykNl9A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-637948b24bdso14196186d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165118; x=1698769918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+tdu1ICjyxv8/ztxRWEvZT9wTGL+LH4NMuH2aUFw8w=;
 b=m4dIJ2GS7Zb8kIhpvZJ/3UdwFJOok0JMej3oy+lE9yZd+W8Zjpl4jme7hSc3zzfJ1y
 /LLWc4PJtB2/MhVoOaV7OKHbpwMOKq0TB8nWyTkjbS96RGOG9jEBWlb7Zv/QrrZYGkxi
 JBTOzyDA4Ch/RfA7XwpmmTeR1AVywQAQntIUQrMp0oYzmMiEvqSldc9XQdmrtOhI3uC5
 VZsBTsP9+6+mdxvH9EhjnKXgK13izlmFlILg/9JSk+7P/UZVB6t3UvzxV4P23wZ1Fy07
 ez71WLeMB4yLdd6pbIVg3rc86Vv1SFBgmnE7gZuXMpAXbBGv/yy+G8C20hqITkgJT9MA
 qIlA==
X-Gm-Message-State: AOJu0YxBS5pkVzmgFFvaLbSL75mM4/EjFayYyAE0KxZ5B7IzENQtgS8H
 vEp7GB+ENOTJvTPiKO/4ropCq/i5wR0R1onxE1FPTtACK5641M6/Ddy9AJL07xxdUnsJPcpIxa9
 fAjW9R3VmR8TrXYI=
X-Received: by 2002:a05:6214:4404:b0:66d:4994:b79a with SMTP id
 oj4-20020a056214440400b0066d4994b79amr12881966qvb.5.1698165117999; 
 Tue, 24 Oct 2023 09:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9sPHlX3WZ2HuZ5J6sOZntbCtYVD7v97LQo77XFwsrb9nBES71Mt4DSDHkzc7K9T6tKLtHEg==
X-Received: by 2002:a05:6214:4404:b0:66d:4994:b79a with SMTP id
 oj4-20020a056214440400b0066d4994b79amr12881944qvb.5.1698165117742; 
 Tue, 24 Oct 2023 09:31:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u13-20020a0ced2d000000b0065b2167fd63sm3679807qvq.65.2023.10.24.09.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:31:57 -0700 (PDT)
Date: Tue, 24 Oct 2023 12:31:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Zhijian Li <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] migration: Stop migration immediately in RDMA error
 paths
Message-ID: <ZTfxe0zLL8cP2AT3@x1n>
References: <20231024154008.512222-1-peterx@redhat.com>
 <878r7sknc4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r7sknc4.fsf@secure.mitica>
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

On Tue, Oct 24, 2023 at 06:16:27PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > In multiple places, RDMA errors are handled in a strange way, where it only
> > sets qemu_file_set_error() but not stop the migration immediately.
> >
> > It's not obvious what will happen later if there is already an error.  Make
> > all such failures stop migration immediately.
> >
> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >
> > v2:
> > - One more line squashed into to fix the build error...  Please ignore v1,
> >   sorry for the noise.
> >
> > This patch is based on Thomas's patch:
> >
> > [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
> > https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com
> >
> > Above patch should have been queued by both Markus and Juan.
> > ---
> >  migration/ram.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 212add4481..1473bb593a 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3034,11 +3034,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >      ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
> >      if (ret < 0) {
> >          qemu_file_set_error(f, ret);
> > +        return ret;
> 
> I agree
> 
> >      }
> >  
> >      ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
> >      if (ret < 0) {
> >          qemu_file_set_error(f, ret);
> > +        return ret;
> 
> I agree
> 
> >      }
> >  
> >      migration_ops = g_malloc0(sizeof(MigrationOps));
> > @@ -3104,6 +3106,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> >          ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
> >          if (ret < 0) {
> >              qemu_file_set_error(f, ret);
> > +            goto out;
> 
> Seems sensible
> 
> >          }
> >  
> >          t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> > @@ -3208,8 +3211,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >      rs->last_stage = !migration_in_colo_state();
> >  
> >      WITH_RCU_READ_LOCK_GUARD() {
> > -        int rdma_reg_ret;
> > -
> >          if (!migration_in_postcopy()) {
> >              migration_bitmap_sync_precopy(rs, true);
> >          }
> > @@ -3217,6 +3218,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >          ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
> >          if (ret < 0) {
> >              qemu_file_set_error(f, ret);
> > +            break;
> 
> Please
>               return ret;
> 
> 
> We can do exactly the same with pages < 0.
> 
> >          }
> >  
> >          /* try transferring iterative blocks of memory */
> > @@ -3240,9 +3242,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >  
> >          ram_flush_compressed_data(rs);
> >  
> > -        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> > -        if (rdma_reg_ret < 0) {
> > -            qemu_file_set_error(f, rdma_reg_ret);
> > +        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> > +        if (ret < 0) {
> > +            qemu_file_set_error(f, ret);
> > +            break;
> >          }
> >      }
> 
> And if we return here, we can just drop the:
> 
>     if (ret < 0) {
>         return ret;
>     }
> 
> 
> At the ext of the loop.

IIUC that'll be the same as this patch, but sure thing I'll prepare a v3.

Thanks,

-- 
Peter Xu


