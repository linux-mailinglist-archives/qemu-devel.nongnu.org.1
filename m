Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B55C7D8826
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 20:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw4wi-0004Dy-3s; Thu, 26 Oct 2023 14:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw4wg-0004Do-IW
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 14:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw4wb-0006O7-Fo
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 14:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698344335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1I5ISfoitIjF+nDgBjkkLTQ6w7KWAhoMcvz67fV1dIc=;
 b=SxTyE0vLfau0Qmi4SX4lliLMJ9b5FIqCrOkMJKZmau0H9DNCQ4PrSx54itKgTEDGPngsr6
 ++qVnKUZTDUOecHT5JsSbpmdDTMJd3N0X9fYHzuY4tDinRWqp/RgYuJ+HYLhVET95x6dVw
 10tyDaKmPy0FSAE/s5Sc+WsOZxdoKZk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Jmy6xEGIO-GXmQe1fNIzgw-1; Thu, 26 Oct 2023 14:18:53 -0400
X-MC-Unique: Jmy6xEGIO-GXmQe1fNIzgw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66fab8e9f95so3163866d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 11:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698344333; x=1698949133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1I5ISfoitIjF+nDgBjkkLTQ6w7KWAhoMcvz67fV1dIc=;
 b=UPoyHqkSj23l5ClhjknWkmyo534oazTSodSMIMxn13aq3YHODoz4IwvsFiKxm0dgus
 /JPCzmtNTvZv4VO5rgGOfcwukICqSIkH5IHFPGt4AZCMjwafFg5nNs5aJNEY3Oxqlw4b
 wONloAGniTyQSRBzwJYSeAofzHD0AexKxycDPMB4CftRu0/SHNJkRyE+6jETKr3phK1b
 3Wc5usSIm+aZCVqy0m0lITihPR+aVpb7JdaH+9Gauy9MjJRvPPhT8TIpK0KyIiWidBdG
 gK+/vjcsVGAaxNAvMh3uTnmBnIClFWb9R6bX7stHWe1kcQDBOvI3Cv9iNipJmwLKGeZP
 OodA==
X-Gm-Message-State: AOJu0Yyi9uEviJw4o081ZaW0y3BEfnddYBkOzoqxeFenuM6vZry277Xh
 eBx3eR8cyLH3n1RuquuToVWFSXi8uSwMXHD/m66OK1SVPj94dZaRjZoYDV6YRLIYX6TCn8Jii48
 9zMNGL2dW+1K6i8o=
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id
 kr24-20020a0562142b9800b0065d048625c6mr417132qvb.3.1698344333192; 
 Thu, 26 Oct 2023 11:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBkWa4ZpfvJe6yY91xO0BiStEXpFNWzSeSvzTxVak0ZMBHKPLfJ3WMKWnEoj1E8rS2R0W0vw==
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id
 kr24-20020a0562142b9800b0065d048625c6mr417119qvb.3.1698344332917; 
 Thu, 26 Oct 2023 11:18:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w5-20020a0cf705000000b0066d1d2242desm5357064qvn.120.2023.10.26.11.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:18:52 -0700 (PDT)
Date: Thu, 26 Oct 2023 14:18:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Message-ID: <ZTqtieZo/VaSscp5@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
 <ZTqb/XDnwhkTUL3s@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTqb/XDnwhkTUL3s@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 26, 2023 at 01:03:57PM -0400, Peter Xu wrote:
> On Thu, Oct 26, 2023 at 05:06:37PM +0100, Joao Martins wrote:
> > On 26/10/2023 16:53, Peter Xu wrote:
> > > This small series (actually only the last patch; first two are cleanups)
> > > wants to improve ability of QEMU downtime analysis similarly to what Joao
> > > used to propose here:
> > > 
> > >   https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com
> > > 
> > Thanks for following up on the idea; It's been hard to have enough bandwidth for
> > everything on the past set of weeks :(
> 
> Yeah, totally understdood.  I think our QE team pushed me towards some
> series like this, while my plan was waiting for your new version. :)
> 
> Then when I started I decided to go into per-device.  I was thinking of
> also persist that information, but then I remembered some ppc guest can
> have ~40,000 vmstates..  and memory to maintain that may or may not regress
> a ppc user.  So I figured I should first keep it simple with tracepoints.
> 
> > 
> > > But with a few differences:
> > > 
> > >   - Nothing exported yet to qapi, all tracepoints so far
> > > 
> > >   - Instead of major checkpoints (stop, iterable, non-iterable, resume-rp),
> > >     finer granule by providing downtime measurements for each vmstate (I
> > >     made microsecond to be the unit to be accurate).  So far it seems
> > >     iterable / non-iterable is the core of the problem, and I want to nail
> > >     it to per-device.
> > > 
> > >   - Trace dest QEMU too
> > > 
> > > For the last bullet: consider the case where a device save() can be super
> > > fast, while load() can actually be super slow.  Both of them will
> > > contribute to the ultimate downtime, but not a simple summary: when src
> > > QEMU is save()ing on device1, dst QEMU can be load()ing on device2.  So
> > > they can run in parallel.  However the only way to figure all components of
> > > the downtime is to record both.
> > > 
> > > Please have a look, thanks.
> > >
> > 
> > I like your series, as it allows a user to pinpoint one particular bad device,
> > while covering the load side too. The checkpoints of migration on the other hand
> > were useful -- while also a bit ugly -- for the sort of big picture of how
> > downtime breaks down. Perhaps we could add that /also/ as tracepoitns without
> > specifically commiting to be exposed in QAPI.
> > 
> > More fundamentally, how can one capture the 'stop' part? There's also time spent
> > there like e.g. quiescing/stopping vhost-net workers, or suspending the VF
> > device. All likely as bad to those tracepoints pertaining device-state/ram
> > related stuff (iterable and non-iterable portions).
> 
> Yeah that's a good point.  I didn't cover "stop" yet because I think it's
> just more tricky and I didn't think it all through, yet.
> 
> The first question is, when stopping some backends, the vCPUs are still
> running, so it's not 100% clear to me on which should be contributed as
> part of real downtime.

I was wrong.. we always stop vcpus first.

If you won't mind, I can add some traceopints for all those spots in this
series to cover your other series.  I'll also make sure I do that for both
sides.

Thanks,

> 
> Meanwhile that'll be another angle besides vmstates: need to keep some eye
> on the state change handlers, and that can be a device, or something else.
> 
> Did you measure the stop process in some way before?  Do you have some
> rough number or anything surprising you already observed?
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


