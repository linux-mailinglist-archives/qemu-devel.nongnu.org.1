Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6C77E395
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHTZ-0005yJ-E9; Wed, 16 Aug 2023 10:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWHTR-0005dI-Iv
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWHTO-0003vA-1P
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692195969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shk1bJrducpIHUkEIuUtewXVf0Ziav/EoTGMtZoZEU8=;
 b=Q031BTjMG0trl94dAzCjF4zU9urH8o/1zsSw4vUL/QAesJiCagex64hfbLuYUKq9n1LYfE
 /t8hE9WC2pv85Em39EatPad0KcW3p2/UL/+y6IV7VO/zwlvpbU9y6OflLL80BOliNmWdHA
 w5CJBJB3UTo0WcvTteGpl1DrAySK5K8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-FSnyPer2MIqQozab_mWS3Q-1; Wed, 16 Aug 2023 10:26:05 -0400
X-MC-Unique: FSnyPer2MIqQozab_mWS3Q-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6b9de434705so1185278a34.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692195965; x=1692800765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shk1bJrducpIHUkEIuUtewXVf0Ziav/EoTGMtZoZEU8=;
 b=gks3rPhM75AR+18Ls8kh3MlOuyIjnpx1eVI/9jYDPIOSPyw8zn92MTgtxacA16VhGL
 T4sHNi4JNmse622m12Df+oxvGoh92c9Nt91+70BiwNl0O+Ivf338VtrTd8BT+2BUhcTy
 WPMoWUMiLMHWEyWux+J54mKyjs7WDR/cKx0qgjEuLxAJu3uc8o9P90Ct1Vgt66nO5j7J
 ri7fanQxqwV2JdMxBH/TMa/sjnZq9SrgmCZ1UMwa2sJ4YGKkNNgw+diACrsMzzaaHh+W
 H88/HNgv/pqjzlgJMsjo4LsGHTgYICXMDtVQc3Ihu3N38OnyRRU75mkD4U1j90Sfzm46
 2sgA==
X-Gm-Message-State: AOJu0YygmcOQd61QL8LwDL6dvRMnk6fhEwCg9wK2CHD5mJPEmpvdfDF1
 qmif+QCV0g9oqD4243DKw1vm00I5tzuo5WmQM7Mc7fmkRnu1tFHYhCnw4A92Qeo9oRQwPvLx/yy
 b0l8vv0fUC0e/RGM=
X-Received: by 2002:a05:6830:2aa7:b0:6bd:6d51:e9e5 with SMTP id
 s39-20020a0568302aa700b006bd6d51e9e5mr1775603otu.0.1692195964769; 
 Wed, 16 Aug 2023 07:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEsvlklyrzh948bHRo2IeK1ZcKjnZUGM6jnaGaxE9Yg4m+/nqH/2rmWZ1AltgDgSFxEMkJbA==
X-Received: by 2002:a05:6830:2aa7:b0:6bd:6d51:e9e5 with SMTP id
 s39-20020a0568302aa700b006bd6d51e9e5mr1775584otu.0.1692195964508; 
 Wed, 16 Aug 2023 07:26:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t7-20020a0cb387000000b0061a68b5a8c4sm4975146qve.134.2023.08.16.07.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:26:04 -0700 (PDT)
Date: Wed, 16 Aug 2023 10:26:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 10/10] migration: Add a wrapper to cleanup migration
 files
Message-ID: <ZNzcek7oqn+ccoQ+@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-11-farosas@suse.de> <ZNv4/ndxGPpaIX9H@x1n>
 <875y5glyyn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y5glyyn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Aug 15, 2023 at 07:31:28PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Aug 11, 2023 at 12:08:36PM -0300, Fabiano Rosas wrote:
> >> We currently have a pattern for cleaning up a migration QEMUFile:
> >> 
> >>   qemu_mutex_lock(&s->qemu_file_lock);
> >>   file = s->file_name;
> >>   s->file_name = NULL;
> >>   qemu_mutex_unlock(&s->qemu_file_lock);
> >> 
> >>   migration_ioc_unregister_yank_from_file(file);
> >>   qemu_file_shutdown(file);
> >>   qemu_fclose(file);
> >> 
> >> There are some considerations for this sequence:
> >> 
> >> - we must clear the pointer under the lock, to avoid TOC/TOU bugs;
> >> - the shutdown() and close() expect be given a non-null parameter;
> >> - a close() in one thread should not race with a shutdown() in another;
> >> 
> >> Create a wrapper function to make sure everything works correctly.
> >> 
> >> Note: the return path did not used to call
> >>       migration_ioc_unregister_yank_from_file(), but I added it
> >>       nonetheless for uniformity.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > This definitely looks cleaner.  Probably can be squashed together with
> > previous patch?  If you could double check whether we can just drop the
> > shutdown() all over the places when close() altogether, it'll be even
> > nicer (I hope I didn't miss any real reasons to explicitly do that).
> >
> >> diff --git a/util/yank.c b/util/yank.c
> >> index abf47c346d..4b6afbf589 100644
> >> --- a/util/yank.c
> >> +++ b/util/yank.c
> >> @@ -146,8 +146,6 @@ void yank_unregister_function(const YankInstance *instance,
> >>              return;
> >>          }
> >>      }
> >> -
> >> -    abort();
> >
> > I think we can't silently do this.  This check is very strict and I guess
> > you removed it because you hit a crash.  What's the crash?  Can we just
> > pair the yank reg/unreg?
> >
> 
> Well, the abort() is the crash. It just means that we looped and didn't
> find the handler to unregister. It looks harmless to me. I should have
> mentioned this in the commit message.

Yeah, trust me I wanted to remove that for quite a few times. :) But then I
normally decided to try harder to find what's missing; and so far indeed I
found that the cleanest way is always pair the reg/unreg.

> 
> I could certainly add a yank handler to the rp_state.from_dst_file. But
> then I have no idea what will happen if we try to yank the return path
> at a random moment.

I think the idea was it should be registered always when the channel is
created, and then unregistered when the channel is destroyed.  They should
just pair, alongside with the channel's lifecycle?

> 
> Side note: I see that yank does a qio_channel_shutdown() without the
> controversial setting of -EIO. Which means it is probably succeptible to
> the same race described in the qemu_file_shutdown() code.

Are you looking outside migration code (I saw nbd_teardown_connection()
does have one)?

For migration IIUC it's always via migration_ioc_unregister_yank().

-- 
Peter Xu


