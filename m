Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B18322FF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 02:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQdlG-0001r7-51; Thu, 18 Jan 2024 20:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQdlD-0001qg-RY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 20:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQdlC-0001Bt-79
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 20:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705628009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9gLQFJ2rXGHD53e2/0wegQRH+iKPbk+pOGpcvu5oxvI=;
 b=G/it/uECO2q+zAatcFwePvJA95BoQLdC55FrTeiUdkfBJLaM45RGkfVwBbjm7xHV66XCGf
 PLg19NH2XlHnaVcFmZQQFKlMHJnRS3C2oJb4Q67a1ntLdmI+4PPBk3VCe3VrcXhq//vjXO
 T9FGlfybTIU+i8/yVn6hezGwfhiSvFo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Hk8XWcJEPp6Kovt2yfBSjw-1; Thu, 18 Jan 2024 20:33:22 -0500
X-MC-Unique: Hk8XWcJEPp6Kovt2yfBSjw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29028fd04c9so84359a91.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 17:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705628001; x=1706232801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gLQFJ2rXGHD53e2/0wegQRH+iKPbk+pOGpcvu5oxvI=;
 b=CTn4dHEwE9mszWN9nGjfmaGobeq5NMTKTrbDHsJ25LPLLfWjRMi+ERr9nMHRzGls2v
 jXlRkNI/aLUwuU5BQGdzNUnEHsK9PhH7DF0fFrSlLE+xAeEU/PndQ67MCzyxlhh/n6gS
 dZgYSOkQRuAyq7QoNxa3nhVXX5hbzOyVO0ruTddIrFJa7SbmSy+kE5k+GjNmVq7IKsgk
 0FOumsr8Pxm87kM0WrMPR+pg27RNHvyFzElrLPHy374fNTt7C7mTjUdFjSjtB03p0qVg
 6OUbkL6x05qRnaTeAJLC/Ngwf+7YZ44AD1kVX0mX4E7JS+jjNGHP6JV5vlVux/LFFb3Q
 HUGw==
X-Gm-Message-State: AOJu0Yw3AKMDiI6SG+vPq0vLRkz6GZpSHlABKeY4w358VTXUjSabEOhd
 QIQGr79ZOud0S2tM5oQupB+LGcXJw0d4nW+NVmzyN0T3Bk8QgkWUVAx1gmRv6R4b8aPmuCF55S+
 H35bNWc54TFxBOmg6H/ltznTyll2ow0TRt5saRVp2VbVABYyBwokA
X-Received: by 2002:a17:90b:238d:b0:290:172f:3b1a with SMTP id
 mr13-20020a17090b238d00b00290172f3b1amr853006pjb.3.1705628001590; 
 Thu, 18 Jan 2024 17:33:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPx8Cs6IMKV1DUHSdH6sx5uvfj6cKVEuoNxtS6CYQ+u/G7KX8j3bnrjxjHYzXcp7A2NZaO7g==
X-Received: by 2002:a17:90b:238d:b0:290:172f:3b1a with SMTP id
 mr13-20020a17090b238d00b00290172f3b1amr852991pjb.3.1705628001254; 
 Thu, 18 Jan 2024 17:33:21 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 px7-20020a17090b270700b0028ffc524086sm2614919pjb.24.2024.01.18.17.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 17:33:20 -0800 (PST)
Date: Fri, 19 Jan 2024 09:33:12 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 19/30] migration/ram: Ignore multifd flush when
 doing fixed-ram migration
Message-ID: <ZanRWFw1kvm051rB@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-20-farosas@suse.de> <ZaY9Bl4GOD9BbumD@x1n>
 <87a5p3de0v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5p3de0v.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 17, 2024 at 03:13:20PM -0300, Fabiano Rosas wrote:
> >> @@ -3242,8 +3243,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> >>  out:
> >>      if (ret >= 0
> >>          && migration_is_setup_or_active(migrate_get_current()->state)) {
> >> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
> >> -            ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
> >> +        if (migrate_multifd() &&
> >> +            (migrate_multifd_flush_after_each_section() ||
> >> +             migrate_fixed_ram())) {
> >> +            ret = multifd_send_sync_main(
> >> +                rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
> >
> > Why you want this one?  ram_save_iterate() can be called tens for each
> > second iiuc.
> >
> 
> AIUI, this is a requirement for live migration, so that we're not
> sending the new version of the page while the old version is still in
> transit.
> 
> > There's one more?  ram_save_complete():
> >
> >     if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> >         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> >     }
> >
> > IIUC that's the one you referred to at [1] above, not sure why you modified
> > the code in ram_save_iterate() instead.
> >
> 
> I mentioned it in the commit message as well:
> 
> " - between iterations, to avoid a slow channel being overrun by a fast
>  channel in the subsequent iteration;"

IMHO you only need to flush all threads in find_dirty_block(). That's when
the "real iteration" happens (IOW, when the "real iteration" is defined to
be a full walk across all guest memories, rather than one single call to
ram_save_iterate()).

Multifd used to do too many flushes, and that's why we had the new
migrate_multifd_flush_after_each_section() and it's a bit of a mess if you
see..

To be super safe, you can also flush at ram_save_complete(), but I doubt
its necessity, and this same question applies to generic multifd: the
multifd_send_sync_main() in the ram_save_complete() can be redundant,
afaiu.  However we can leave that for later to not add even more dependency
to fixed-ram.  If that is justified, we can remove the sync_main for both
socket / file then.

-- 
Peter Xu


