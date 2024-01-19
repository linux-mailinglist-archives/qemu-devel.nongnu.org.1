Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665883229C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 01:23:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQcel-0001fE-MP; Thu, 18 Jan 2024 19:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQcek-0001f3-LK
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 19:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQcei-0005EV-SS
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 19:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705623764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3o+1/fEVAngLiAsxxT7AdlSBPLLkUoGvSq77Tg9yVkg=;
 b=jC0fQFGg56vyNDcEf2EZZHc+4iDmX5vopOUyiy/Tz3NpWlYWDgqfi4E9KnWnDeZ/uiPUPA
 TAl441ZFcT8XRzNf0AmZOJeiPfmUdbsW4PJXmkJm1856jYx2xeirtJUL6woyB6v1iGJgDt
 QFmDaMwUt8Ut0pqwjHZjeJs5ESnpfYk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358--JQ04hapOpy8ta8pfv1z5A-1; Thu, 18 Jan 2024 19:22:35 -0500
X-MC-Unique: -JQ04hapOpy8ta8pfv1z5A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2901a2437d3so82492a91.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 16:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705623754; x=1706228554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3o+1/fEVAngLiAsxxT7AdlSBPLLkUoGvSq77Tg9yVkg=;
 b=T1UN2eM/ZQGYb5JNwJc0UEa/sOs/ptgkcDfD/EocWRNuglB4bCY0BC+zZo9hab4Ofd
 EcH3JzYpf+3gqjm/lb3ZBaYwe5RrJnj5zhawDwPl4h8mRDtoi/rKVsJPHj2Am/mH9CNr
 11jpalF7jBNlbm/GBEppJtwgqdPLJLJnBHK6PRhpbmCCPyChv7yfbS4pGyIeNYb/ITxD
 5ptMb27wc73Oy1bt2MwqmFd4pkEXjTCtwjqI0mgBQTsZWNWYVg+4ThjKZYmqN1/rFKZG
 BJzV8onMhyHWIAG2GvhurFStwkkwRbyPQuILFEWhT6HuT/IOjeQZq5D4rcOGqCsHTiWG
 ltdQ==
X-Gm-Message-State: AOJu0Yw3uV1ODhlY1ZkGpon/ekRUEbiphR6/waQqJOWc+Lhw1ryHIYo9
 qud4yWIX/44rBXWbiK4m54za/6t9Hl2Yp5hQkLW2A6WZ4pckSePGTqyoOO/QsN3boQCckbusIFC
 06zseOUYBrVT5BGXDHJMZaoRHe6J2Ox70pSwZmSe2THvbc8svEfEx
X-Received: by 2002:a17:902:ea92:b0:1d7:4e2:293 with SMTP id
 x18-20020a170902ea9200b001d704e20293mr3315807plb.0.1705623754202; 
 Thu, 18 Jan 2024 16:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE0kcUI5+fUE7tnCWwOOnCPnjz41lU1ySQkbxItEQuCnRpGhGMQXt3AmPL8x5xkofJ4+kf8A==
X-Received: by 2002:a17:902:ea92:b0:1d7:4e2:293 with SMTP id
 x18-20020a170902ea9200b001d704e20293mr3315788plb.0.1705623753886; 
 Thu, 18 Jan 2024 16:22:33 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i1-20020a1709026ac100b001d538ee9ff3sm1896977plt.183.2024.01.18.16.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 16:22:33 -0800 (PST)
Date: Fri, 19 Jan 2024 08:22:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that takes
 a discontiguous iovec
Message-ID: <ZanAws0f4s8tbKaL@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de> <ZaYpKorhxEi3CEmv@x1n>
 <875xztxhyh.fsf@suse.de> <ZaeiXra5hLSo0jnt@x1n>
 <87fryvdeco.fsf@suse.de> <ZajW26IiC8JMWSO9@x1n>
 <87zfx2erl5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfx2erl5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 18, 2024 at 09:47:18AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jan 17, 2024 at 03:06:15PM -0300, Fabiano Rosas wrote:
> >> Oh no, you're right. Because of p->pending_job. And thinking about
> >> p->pending_job, wouldn't a trylock to the same job while being more
> >> explicit?
> >> 
> >>     next_channel %= migrate_multifd_channels();
> >>     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> >>         p = &multifd_send_state->params[i];
> >> 
> >>         if(qemu_mutex_trylock(&p->mutex)) {
> >>             if (p->quit) {
> >>                 error_report("%s: channel %d has already quit!", __func__, i);
> >>                 qemu_mutex_unlock(&p->mutex);
> >>                 return -1;
> >>             }
> >>             next_channel = (i + 1) % migrate_multifd_channels();
> >>             break;
> >>         } else {
> >>             /* channel still busy, try the next one */
> >>         }
> >>     }
> >>     multifd_send_state->pages = p->pages;
> >>     p->pages = pages;
> >>     qemu_mutex_unlock(&p->mutex);
> >
> > We probably can't for now; multifd_send_thread() will unlock the mutex
> > before the iochannel write()s, while the write()s will need those fields.
> 
> Right, but we'd change that code to do the IO with the lock held. If no
> one is blocking, it should be ok to hold the lock. Anyway, food for
> thought.

I see what you meant.  Sounds possible.

-- 
Peter Xu


