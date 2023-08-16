Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FE77E9C8
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 21:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWML1-0004AL-DV; Wed, 16 Aug 2023 15:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWMKx-0004A4-Vw
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 15:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWMKu-0004SC-Pu
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 15:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692214663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KNyjfTb8s2WYM8s9txrCJp2mgtCYm3w0JTsFUCqUxHQ=;
 b=ND5chRoU7egq3fuCdQCnOUCOJppiBWTxBK/Oi9B4OOSuN5JY8fRQsJuLDCjAk+12+MYXzE
 IblXgnv//EClzRkqzmsQkc2eGzcrfZQNd5z3qKumEHGHEs0XObmk+99/s6ECHTUOcgppLZ
 rQc4vWKOJlgXrj6RnJ43msv20nbLFCU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-fGtW8lciPrWa30UHpdKZOg-1; Wed, 16 Aug 2023 15:37:39 -0400
X-MC-Unique: fGtW8lciPrWa30UHpdKZOg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76cb9958d60so181937585a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 12:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692214659; x=1692819459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNyjfTb8s2WYM8s9txrCJp2mgtCYm3w0JTsFUCqUxHQ=;
 b=WplU9R7dvgaxgc9IFH0tz2/wX7ysP2+P/qg9N48O255zFR4FyZdMgscza3/UCdcS8V
 bqRYQF60hd4SVe16Cd6y/I2OJjdu2awWyYvvz2HWQPaPchWbo71zhnK0ttFC2CdaqMtE
 AKEB5oJ2JSk1A+ZZtlzkw2Q6Y00lDKGy6BFm4VLfC4f0dU7K58TahyZ7wVzVcSXdmd+T
 aHwGdpiz9s9hVIfN2Qy9dpI61QMY0H71wpLoG3IXiXmsGiU2DaZQLHpTZkLXYfhTnJag
 S9VJhlahsSIQ6UQ0dOjDfC8hzj+KiZUzVCYafgGsFe/5h0+VXR/PDD464sw6Lx23SLWk
 22Kg==
X-Gm-Message-State: AOJu0YwjuW/yxTBeeBAtT70AwQnSVFgXIUmBi9X2/0URZlMv4Af7BKWn
 Oy2nQ21GGlc+IKCktBvoBifJYOWvy976mVG5ihJovIJxbzzQCvJGekiY0hIps0BqQ9F+NwjPASL
 290FYBDqrKMzS088=
X-Received: by 2002:a05:620a:4093:b0:76c:ed4e:ac10 with SMTP id
 f19-20020a05620a409300b0076ced4eac10mr3638992qko.6.1692214658739; 
 Wed, 16 Aug 2023 12:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4WlssNwryI+Eqm+D+4JlbXUKWiHYVV6u5S7ySwqBdyEk2tgaUy/eI6tbUUgCcGiNHWxh8Jg==
X-Received: by 2002:a05:620a:4093:b0:76c:ed4e:ac10 with SMTP id
 f19-20020a05620a409300b0076ced4eac10mr3638981qko.6.1692214658449; 
 Wed, 16 Aug 2023 12:37:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i10-20020a37c20a000000b0076768dfe53esm4625236qkm.105.2023.08.16.12.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 12:37:38 -0700 (PDT)
Date: Wed, 16 Aug 2023 15:37:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 8/8] migration: Add a wrapper to cleanup migration files
Message-ID: <ZN0lgcI3Ieksdbv/@x1n>
References: <20230816142510.5637-1-farosas@suse.de>
 <20230816142510.5637-9-farosas@suse.de> <ZNzot6bDD15S3U7u@x1n>
 <87leealt8h.fsf@suse.de> <ZN0k/DFQQIeEpgjl@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZN0k/DFQQIeEpgjl@x1n>
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


On Wed, Aug 16, 2023 at 03:35:24PM -0400, Peter Xu wrote:
> On Wed, Aug 16, 2023 at 03:47:26PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Wed, Aug 16, 2023 at 11:25:10AM -0300, Fabiano Rosas wrote:
> > >> @@ -2003,6 +1980,8 @@ static int open_return_path_on_source(MigrationState *ms)
> > >>          return -1;
> > >>      }
> > >>  
> > >> +    migration_ioc_register_yank(qemu_file_get_ioc(ms->rp_state.from_dst_file));
> > >
> > > I think I didn't really get why it wasn't paired before yesterday.  My
> > > fault.
> > >
> > > Registering from_dst_file, afaict, will register two identical yank objects
> > > because the ioc is the same.
> > >
> > 
> > Why do we have two QEMUFiles for the same fd again?
> 
> Because qemufile has a "direction" (either read / write)?
> 
> > 
> > We're bound to crash at some point by trying to qemu_fclose() the two
> > QEMUFiles at the same time.
> 
> Even with each qemufile holding a reference on the ioc object?  I thought
> it won't crash, but if it will please point that out; or fix it would be
> even better.
> 
> > 
> > > Should we make migration_file_release() not handle the unregister of
> > > yank(), but leave that to callers?  Then we keep the rule of only register
> > > yank for each ioc once.
> > >
> > 
> > We need the unregister to be at migration_file_release() so that it
> > takes benefit of the locking while checking the file for NULL. If it
> > moves out then the caller will have to do locking as well. Which
> > defeats the purpose of the patch.
> > 
> > I don't understand why you moved the unregister out of channel_close in
> > commit 39675ffffb ("migration: Move the yank unregister of channel_close
> > out"). You called it a "hack" at the time, but looking at the current
> > situation, it seems like a reasonable thing to do: unregister the yank
> > when the ioc refcount drops to 1.
> > 
> > I would go even further and say that qemu_fclose should also avoid
> > calling qio_channel_close if the ioc refcnt is elevated.
> 
> I'd rather not; I still think it's a hack, always open to be corrected.
> 
> I think the problem is yank can register anything so it's separate from
> iochannels.  If one would like to have ioc close() automatically
> unregister, then one should also register yank transparently without the
> ioc user even aware of yank's existance.
> 
> Now the condition is the caller register yank itself, then I think the
> caller should unreg it.. not iochannel itself, silently.

I just noticed this is not really copying the list.. let me add the cc list
back, assuming it was just forgotten.

One more thing to mention is, now I kind of agree probably we should
register yank over each qemufile, as you raised the concern in the other
thread that otherwise qmp_yank() won't set error for the qemufile, which
seems to be unexpected.

-- 
Peter Xu


