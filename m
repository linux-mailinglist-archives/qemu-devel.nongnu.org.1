Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A67D5918
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKZ5-00070d-WE; Tue, 24 Oct 2023 12:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvKZ4-00070C-6n
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvKZ2-00089C-Ha
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698166050;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=x9XPlIxUKcaWQHXhnZStQ4hsubiNOL3/mPjWRUDrzlg=;
 b=ilMylcNfzqjcc5Q40g8Denn4OkSZyvuyIkpD9xPRmBNKwdstWc1XsRYQbFLdCrFeixb3JN
 fGnp3rOPNbMaZmACrS43Nct7/ecVEYLeQ5dJZVYeARF4l+T4n5gmCaTkpvv9tCGOJwTk1g
 h7PyRolECZf91FPu/40Rjud+sL5wMwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-KZEILO-bNiyhbXc727zyMw-1; Tue, 24 Oct 2023 12:47:29 -0400
X-MC-Unique: KZEILO-bNiyhbXc727zyMw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so28867635e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166048; x=1698770848;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9XPlIxUKcaWQHXhnZStQ4hsubiNOL3/mPjWRUDrzlg=;
 b=XnoxgOn3+Sc34wOs0PJvJZ/iqp2ykOJ8qwZMM1ZM2yxi+pAHNhthzcUDA48bqOy18L
 qDovU0Dtj5IaRY9P4w6MBOzpAU2YshZLhP5s/Yz8UmBivmdqZIRKB8mmOxW0GR2i0VlV
 Hdb5UuZHBNspYKoUce8EMAToEjm/2M0MREK40y+Ga20ianR3MHXC+pHQmdTqLtk8lWvR
 icwe3OfGBufVZJczlHJZII8cPBVNUBhZQEo9Y3uh2oe0AfM6p9ffLn3GXEvBowJg6xkV
 E5FkF3Vf352G3eYhpBas5Af9nK7HE6Rv9kh84oei0QROMLxhfHrAGOLUt0Cb9ETXMdIP
 b35A==
X-Gm-Message-State: AOJu0Yz6863/EUXt8YdvUc2o/tD97/A/qIHF2FdeFoyLo+UgR6Xoe3kM
 UZu+N5GGMbYa+eNRdH0WS7vlccdyirtQg6tHiYsl9o7lJjJPB47RcFx/AXMuzLbe4YDzLuH1/G+
 WoxZSnH7wdA0u7Ww=
X-Received: by 2002:a5d:5352:0:b0:32d:b051:9a27 with SMTP id
 t18-20020a5d5352000000b0032db0519a27mr9578711wrv.20.1698166048464; 
 Tue, 24 Oct 2023 09:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERTSOMAEVPlwGZ8bc3M/Jmkvac+ATJ+qj1TJEuVRc4DQltRVi49mGIKODPYEqX3AVJsa94CA==
X-Received: by 2002:a5d:5352:0:b0:32d:b051:9a27 with SMTP id
 t18-20020a5d5352000000b0032db0519a27mr9578696wrv.20.1698166048101; 
 Tue, 24 Oct 2023 09:47:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6687000000b00327bf4f2f14sm10177698wru.88.2023.10.24.09.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:47:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhijian Li <lizhijian@fujitsu.com>,  Markus
 Armbruster <armbru@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] migration: Stop migration immediately in RDMA error
 paths
In-Reply-To: <ZTfxe0zLL8cP2AT3@x1n> (Peter Xu's message of "Tue, 24 Oct 2023
 12:31:55 -0400")
References: <20231024154008.512222-1-peterx@redhat.com>
 <878r7sknc4.fsf@secure.mitica> <ZTfxe0zLL8cP2AT3@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 18:47:27 +0200
Message-ID: <87zg08j7c0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Oct 24, 2023 at 06:16:27PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > In multiple places, RDMA errors are handled in a strange way, where it only
>> > sets qemu_file_set_error() but not stop the migration immediately.
>> >
>> > It's not obvious what will happen later if there is already an error.  Make
>> > all such failures stop migration immediately.
>> >
>> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
>> > Cc: Markus Armbruster <armbru@redhat.com>
>> > Cc: Juan Quintela <quintela@redhat.com>
>> > Cc: Fabiano Rosas <farosas@suse.de>
>> > Reported-by: Thomas Huth <thuth@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >
>> > v2:
>> > - One more line squashed into to fix the build error...  Please ignore v1,
>> >   sorry for the noise.
>> >
>> > This patch is based on Thomas's patch:
>> >
>> > [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
>> > https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com
>> >
>> > Above patch should have been queued by both Markus and Juan.
>> > ---
>> >  migration/ram.c | 13 ++++++++-----
>> >  1 file changed, 8 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index 212add4481..1473bb593a 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -3034,11 +3034,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>> >      ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
>> >      if (ret < 0) {
>> >          qemu_file_set_error(f, ret);
>> > +        return ret;
>> 
>> I agree
>> 
>> >      }
>> >  
>> >      ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
>> >      if (ret < 0) {
>> >          qemu_file_set_error(f, ret);
>> > +        return ret;
>> 
>> I agree
>> 
>> >      }
>> >  
>> >      migration_ops = g_malloc0(sizeof(MigrationOps));
>> > @@ -3104,6 +3106,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>> >          ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
>> >          if (ret < 0) {
>> >              qemu_file_set_error(f, ret);
>> > +            goto out;
>> 
>> Seems sensible
>> 
>> >          }
>> >  
>> >          t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> > @@ -3208,8 +3211,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>> >      rs->last_stage = !migration_in_colo_state();
>> >  
>> >      WITH_RCU_READ_LOCK_GUARD() {
>> > -        int rdma_reg_ret;
>> > -
>> >          if (!migration_in_postcopy()) {
>> >              migration_bitmap_sync_precopy(rs, true);
>> >          }
>> > @@ -3217,6 +3218,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>> >          ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>> >          if (ret < 0) {
>> >              qemu_file_set_error(f, ret);
>> > +            break;
>> 
>> Please
>>               return ret;
>> 
>> 
>> We can do exactly the same with pages < 0.
>> 
>> >          }
>> >  
>> >          /* try transferring iterative blocks of memory */
>> > @@ -3240,9 +3242,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>> >  
>> >          ram_flush_compressed_data(rs);
>> >  
>> > -        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
>> > -        if (rdma_reg_ret < 0) {
>> > -            qemu_file_set_error(f, rdma_reg_ret);
>> > +        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
>> > +        if (ret < 0) {
>> > +            qemu_file_set_error(f, ret);
>> > +            break;
>> >          }
>> >      }
>> 
>> And if we return here, we can just drop the:
>> 
>>     if (ret < 0) {
>>         return ret;
>>     }
>> 
>> 
>> At the ext of the loop.
>
> IIUC that'll be the same as this patch,

No.

if you see a break, you need to search for the loop, and go to the end
and see what happens.

  return ret;

It is completely obvious what we do in case of error.

> but sure thing I'll prepare a v3.

Thanks.


