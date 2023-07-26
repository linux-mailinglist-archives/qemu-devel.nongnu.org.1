Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A179763F4D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOi2G-0007Mp-R3; Wed, 26 Jul 2023 13:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOi1k-0007E1-8H
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOi1c-0003OF-VV
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690391411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4tDHEaIhGpFJhgy8GnmlLz77VVNVtCsJLVNkTkUnKk=;
 b=S0e9xafod5wFmRNZ3JBZQ462pIDdCjcA4hEuchwsjYOn9eovjHUvNxlG+xF/mG95jvEiU2
 BQ3yQs5X8+nf6ATAZWrRZyt67rLE5n4EteMLVpBCOho7IRI0AmHo78Zpp9HJuO4KRl+0xX
 ZwO1U9Z6Tp6HMrn0nChikJElUAfNQhg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-U8zBVpcGP-acG-MrkUBzjg-1; Wed, 26 Jul 2023 13:10:09 -0400
X-MC-Unique: U8zBVpcGP-acG-MrkUBzjg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-767b80384a3so892085a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 10:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690391409; x=1690996209;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C4tDHEaIhGpFJhgy8GnmlLz77VVNVtCsJLVNkTkUnKk=;
 b=HaEXXqv2Rb+dd81lTgku1ua9Zw5edt1bgBeit9RkzAWPKNHDoC1W/Sr0/EvUtXewrs
 VMyrcg9e6EdrVrOnblI1E/K6dih930HHuqN++cYaiCGMeGpn0WoUImY5U6FTOEcjhbjl
 X47mUOn2Z4B4dwK3R+9U3DYeOcwXz942XIK0SODmDrR1fPS9Oss9txjQQsp75mnxWJMR
 d2LSoScHSXfre3OtsmNJSAdzrVeNz4asuT/4UoJ1aBcY0tUlPXXPCCDBpFqI4pg/hQY1
 42gXx4aHxdZuoM6Sn1vQQDGf8aGit0HxKR53WumLPVwkoBSOKGmcPk1xhlIWDh/4eteQ
 zcyw==
X-Gm-Message-State: ABy/qLYdQjz7PeFfdhjjeo4JpamflUbZBwKOMFuhXYJJVXY5L43JaysQ
 pDbNXT44VtNDVS/37V2Aw2IVLOzeV1vsvPcO8XBKPtuVuV2fNKwq99w7udLWIWVoH2MYR7te2b8
 TiUQeYB6LCaWyreY=
X-Received: by 2002:a05:620a:4491:b0:767:f178:b517 with SMTP id
 x17-20020a05620a449100b00767f178b517mr3781296qkp.0.1690391409200; 
 Wed, 26 Jul 2023 10:10:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH33QOQcBPHDrf1TJdk/ToTkV6YQM8oDFxKlytL3W0dzVeBGTZHOR49fr1SZSLhSzyWRpM1yA==
X-Received: by 2002:a05:620a:4491:b0:767:f178:b517 with SMTP id
 x17-20020a05620a449100b00767f178b517mr3781280qkp.0.1690391408939; 
 Wed, 26 Jul 2023 10:10:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d10-20020a05620a166a00b007671678e325sm4491843qko.88.2023.07.26.10.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 10:10:08 -0700 (PDT)
Date: Wed, 26 Jul 2023 13:10:06 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: refactor migration_completion
Message-ID: <ZMFTbqL30O/Fw6iH@x1n>
References: <20230714124823.25142-1-wei.w.wang@intel.com>
 <20230718054425.GA1807130@ls.amr.corp.intel.com>
 <DS0PR11MB6373E417A60B2DEF9EFE3697DC38A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZLmbKSqrDvg7Tx4A@x1n>
 <DS0PR11MB6373FA83BFCF6706F671B36ADC3FA@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB6373FA83BFCF6706F671B36ADC3FA@DS0PR11MB6373.namprd11.prod.outlook.com>
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

On Fri, Jul 21, 2023 at 11:14:55AM +0000, Wang, Wei W wrote:
> On Friday, July 21, 2023 4:38 AM, Peter Xu wrote:
> > Looks good to me, after addressing Isaku's comments.
> > 
> > The current_active_state is very unfortunate, along with most of the calls to
> > migrate_set_state() - I bet most of the code will definitely go wrong if that
> > cmpxchg didn't succeed inside of migrate_set_state(), IOW in most cases we
> > simply always want:
> 
> Can you share examples where it could be wrong?
> (If it has bugs, we need to fix)

Nop.  What I meant is most of the cases we want to set the state without
caring much about the old state, so at least we can have a helper like
below and simply call migrate_set_state(s, STATE) where we don't care old
state.

> 
> > 
> >   migrate_set_state(&s->state, s->state, XXX);
> > 
> > Not sure whether one pre-requisite patch is good to have so we can rename
> > migrate_set_state() to something like __migrate_set_state(), then:
> > 
> >   migrate_set_state(s, XXX) {
> >     __migrate_set_state(&s->state, s->state, XXX);
> >   }
> > 
> > I don't even know whether there's any call site that will need
> > __migrate_set_state() for real..
> > 
> 
> Seems this would break the use of "MIGRATION_STATUS_CANCELLING".
> For example, 
> - In migration_maybe_pause:
> migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
>                                     new_state);
> If the current s->state isn't MIGRATION_STATUS_PRE_SWITCHOVER (could
> be MIGRATION_STATUS_CANCELLING),  then s->state won’t be updated to
> new_state.
> - Then, in migration_completion, the following update to s->state won't succeed:
>    migrate_set_state(&s->state, current_active_state,
>                           MIGRATION_STATUS_COMPLETED);
> 
> - Finally, when reaching migration_iteration_finish(), s->state is
> MIGRATION_STATUS_CANCELLING, instead of MIGRATION_STATUS_COMPLETED.

The whole state changes are just flaky to me in general, even with the help
of old_state cmpxchg.

E.g., I'm wondering whether below race can happen, assuming we're starting
with ACTIVE state and just about to complete migration:

          main thread                            migration thread
          -----------                            ----------------
                                           migration_maybe_pause(current_active_state==ACTIVE)
                                             if (s->state != MIGRATION_STATUS_CANCELLING)
                                               --> true, keep setting state
                                               qemu_mutex_unlock_iothread();
    qemu_mutex_lock_iothread();
    migrate_fd_cancel()
      if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER)
        --> false, not posting to pause_sem
      set state to MIGRATION_STATUS_CANCELLING
                                              migrate_set_state(&s->state, *current_active_state,
                                                                MIGRATION_STATUS_PRE_SWITCHOVER);
                                                --> false, cmpxchg fail
                                              qemu_sem_wait(&s->pause_sem);
                                                --> hang death?

Thanks,

-- 
Peter Xu


