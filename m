Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14E7BBD8A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qooQb-0005cT-RE; Fri, 06 Oct 2023 13:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qooQV-0005c7-Vu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qooQU-0002FQ-ET
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696612545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrRpT6B1V2JmCBNTJdv4w/8KID9qTEJCNsX3inx6ySo=;
 b=RJFZk2cGQSgvEGrWLkYW1AMcH7IL2n2g0SvpStm1ZUvjpwHiAMHrjK0kaH08j98hr0z18i
 RJ9IdvJFT4MXFdQOv8NX0apN+srYA2CTq+XOMZsdZx7kNCHn4C/RdPV5j7qTEpwqiMel3I
 zkfETgUmKGHfHbAYAYFbwCUnvIk2VT0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-UmewHghqPPCDPv0br0XGnw-1; Fri, 06 Oct 2023 13:15:43 -0400
X-MC-Unique: UmewHghqPPCDPv0br0XGnw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7742bd869e4so43428785a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 10:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696612543; x=1697217343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrRpT6B1V2JmCBNTJdv4w/8KID9qTEJCNsX3inx6ySo=;
 b=GzJnUjvEF9imBzwAS1iuGBSrCKObbpwfoIIQz4jxNLYcJpV/8qXMUmxvDGUgMF0yEO
 Bn//DS8ghOk4F9hWpiNv8kFERieRYatQxETb7o54S7iqS/8OqOZmZAR6efPn0iYigCa1
 ieSHWwEPN5J+DFaw8A9uMZMKKIUMZFRhBE/q/Pa9xNBCeqTUFm9BOoiZv7jAVIp03G2U
 m/7VZVisstW1KFe722HsOl4lJ89iuuGChGcTTu7SXLmbEuxtJIJkoQ3ZZoH7y1Yl2Jjp
 qLUO7296DaF4Y1dR3oB/VU5fSSoMt7hjASyb0wszzHGcYtfLwPz197MhDLs9Iys4uX6Y
 UFbg==
X-Gm-Message-State: AOJu0YzzwhVr6WG+IEMJqvxw6rTa6AQjVMgBVlGoWo/hXN11gb4kI7nQ
 DlJuzMBcICUaY3L0X/RDEWevmpcVI9KDruzCeTOgoFwOUCYi6CDS8j4vLrAtsdkOKxz9vwGLaBO
 18bh9wywB3XKzfyg=
X-Received: by 2002:a05:620a:19a0:b0:76e:f686:cacb with SMTP id
 bm32-20020a05620a19a000b0076ef686cacbmr9439781qkb.3.1696612543274; 
 Fri, 06 Oct 2023 10:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfdXRGF8i9v2Pi9YOcA9+bVfj20b6ZIsiijO1vemNu8mXHuFxK+FO0nH2zY/clKAO2wh3C6w==
X-Received: by 2002:a05:620a:19a0:b0:76e:f686:cacb with SMTP id
 bm32-20020a05620a19a000b0076ef686cacbmr9439758qkb.3.1696612542902; 
 Fri, 06 Oct 2023 10:15:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i16-20020a05620a145000b00767dc4c539bsm1451364qkl.44.2023.10.06.10.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 10:15:42 -0700 (PDT)
Date: Fri, 6 Oct 2023 13:15:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>, leobras@redhat.com,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
Message-ID: <ZSBAvU2PHST7/Tte@x1n>
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
 <87edib5ybg.fsf@secure.mitica> <ZSAtKmOFkomgXyJ7@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSAtKmOFkomgXyJ7@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Oct 06, 2023 at 11:52:10AM -0400, Peter Xu wrote:
> On Tue, Oct 03, 2023 at 08:57:07PM +0200, Juan Quintela wrote:
> > commit c638f66121ce30063fbf68c3eab4d7429cf2b209
> > Author: Juan Quintela <quintela@redhat.com>
> > Date:   Tue Oct 3 20:53:38 2023 +0200
> > 
> >     migration: Non multifd migration don't care about multifd flushes
> >     
> >     RDMA was having trouble because
> >     migrate_multifd_flush_after_each_section() can only be true or false,
> >     but we don't want to send any flush when we are not in multifd
> >     migration.
> >     
> >     CC: Fabiano Rosas <farosas@suse.de
> >     Reported-by: Li Zhijian <lizhijian@fujitsu.com>
> >     Signed-off-by: Juan Quintela <quintela@redhat.com>
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e4bfd39f08..716cef6425 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1387,7 +1387,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
> >          pss->page = 0;
> >          pss->block = QLIST_NEXT_RCU(pss->block, next);
> >          if (!pss->block) {
> > -            if (!migrate_multifd_flush_after_each_section()) {
> > +            if (migrate_multifd() &&
> > +                !migrate_multifd_flush_after_each_section()) {
> >                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
> >                  int ret = multifd_send_sync_main(f);
> >                  if (ret < 0) {
> > @@ -3064,7 +3065,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >          return ret;
> >      }
> >  
> > -    if (!migrate_multifd_flush_after_each_section()) {
> > +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> >          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> >      }
> >  
> > @@ -3176,7 +3177,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> >  out:
> >      if (ret >= 0
> >          && migration_is_setup_or_active(migrate_get_current()->state)) {
> > -        if (migrate_multifd_flush_after_each_section()) {
> > +        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
> >              ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
> >              if (ret < 0) {
> >                  return ret;
> > @@ -3253,7 +3254,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >          return ret;
> >      }
> >  
> > -    if (!migrate_multifd_flush_after_each_section()) {
> > +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> >          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> >      }
> >      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> > @@ -3760,7 +3761,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
> >              break;
> >          case RAM_SAVE_FLAG_EOS:
> >              /* normal exit */
> > -            if (migrate_multifd_flush_after_each_section()) {
> > +            if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
> >                  multifd_recv_sync_main();
> >              }
> >              break;
> > @@ -4038,7 +4039,8 @@ static int ram_load_precopy(QEMUFile *f)
> >              break;
> >          case RAM_SAVE_FLAG_EOS:
> >              /* normal exit */
> > -            if (migrate_multifd_flush_after_each_section()) {
> > +            if (migrate_multifd() &&
> > +                migrate_multifd_flush_after_each_section()) {
> >                  multifd_recv_sync_main();
> >              }
> >              break;
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Did you forget to send this out formally?  Even if f1de309792d6656e landed
> (which, IMHO, shouldn't..), but IIUC rdma is still broken..

Two more things to mention..

$ git tag --contains 294e5a4034e81b

It tells me v8.1 is also affected.. so we may want to copy stable too for
8.1, for whichever patch we want to merge (either yours or Zhijian's)..

Meanwhile, it also breaks migration as long as user specifies the new
behavior.. for example: v8.1->v8.0 will break with this:

$ (echo "migrate exec:cat>out"; echo "quit") | ./qemu-v8.1.1 -M pc-q35-8.0 -global migration.multifd-flush-after-each-section=false -monitor stdio
QEMU 8.1.1 monitor - type 'help' for more information
VNC server running on ::1:5900
(qemu) migrate exec:cat>out
(qemu) quit

$ ./qemu-v8.0.5 -M pc-q35-8.0 -incoming "exec:cat<out"
VNC server running on ::1:5900
qemu-v8.0.5: Unknown combination of migration flags: 0x200
qemu-v8.0.5: error while loading state for instance 0x0 of device 'ram'
qemu-v8.0.5: load of migration failed: Invalid argument

IOW, besides rdma and the script, it can also break in other ways.

-- 
Peter Xu


