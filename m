Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4087D8733
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 19:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw3mK-0000DH-ER; Thu, 26 Oct 2023 13:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw3mB-0000Cd-9T
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 13:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw3m9-0004ZL-BR
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 13:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698339843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdJ0CskfvDQ5GdXLJaXJGRpIzhk0BcgUYB0GruAi3Oo=;
 b=dKwYZY5uKmBep3H0OhRyjfkKYT0p86n5oLzXF7Mre3CXDR8MYrbInK9E6MGHHtxpm9y1VX
 4QMvyF/qH5BRmXZjVpcFa1cqUTIQdzVHTUzgAHC4NgA1S2kp//3l2yvKe3c+odTBJGE0RB
 yWxwxNoHv+64JeVeHCtaQKMXvFTg2k0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-0cuomjU9N8uIHcg5D1vi6w-1; Thu, 26 Oct 2023 13:04:01 -0400
X-MC-Unique: 0cuomjU9N8uIHcg5D1vi6w-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-58165739b64so327212eaf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698339841; x=1698944641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdJ0CskfvDQ5GdXLJaXJGRpIzhk0BcgUYB0GruAi3Oo=;
 b=GbNQZ372C67uZ72ETHx4SCz+txBIGyRg4c2Hv6q4EfxMMetzjg4J6HIbDW/ske6GfE
 B2xACWtG07oc2RkUUKJMUJ+eTZObYCC348LPv3wRnJ6PJAk7UILK3jNrGmJPlgBerQv0
 5sDv5rhxPuYIOlF8OesISh14xjlysp9/VEA4OZxmckPMb0rAaGweu5LFI19DVPza9Ytz
 /2Byr7ha6NOqNQuxLKghw3iyH5uz+BBqteUOukAi/HXLAJADx6IRZGVGklky5AKVbRC1
 GHT4RjQXewVLmc1Yhpvz3jq0fRoqOvE14ziD2IEzPPEtKfJa3biVXL4mKwerqxZA/cfL
 NlDA==
X-Gm-Message-State: AOJu0Yzw8e3Ddz5vNl2wf34FJvqQUCM1T/SFV/nf9m1CTi14fJQbejjy
 gsolrbqJlCwmfO7mC+OlFDvgK8UByeYHh1krw7/MgTIsNzgbg+2UgPJ0itt5haN2DAVVCKUvaV6
 GJuZQM3sAxxJCor8=
X-Received: by 2002:a05:6358:7e47:b0:168:ec61:c36 with SMTP id
 p7-20020a0563587e4700b00168ec610c36mr237706rwm.2.1698339841141; 
 Thu, 26 Oct 2023 10:04:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfiZrOtPnqY7WC06swIOn+VpsRBMCiIE03lWOi+U7qHpCjP4LqoVGE4awOehzo32ITVVlhPw==
X-Received: by 2002:a05:6358:7e47:b0:168:ec61:c36 with SMTP id
 p7-20020a0563587e4700b00168ec610c36mr237677rwm.2.1698339840709; 
 Thu, 26 Oct 2023 10:04:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 px9-20020a056214050900b0066db33eeeb7sm3395070qvb.131.2023.10.26.10.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 10:03:59 -0700 (PDT)
Date: Thu, 26 Oct 2023 13:03:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Message-ID: <ZTqb/XDnwhkTUL3s@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
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

On Thu, Oct 26, 2023 at 05:06:37PM +0100, Joao Martins wrote:
> On 26/10/2023 16:53, Peter Xu wrote:
> > This small series (actually only the last patch; first two are cleanups)
> > wants to improve ability of QEMU downtime analysis similarly to what Joao
> > used to propose here:
> > 
> >   https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com
> > 
> Thanks for following up on the idea; It's been hard to have enough bandwidth for
> everything on the past set of weeks :(

Yeah, totally understdood.  I think our QE team pushed me towards some
series like this, while my plan was waiting for your new version. :)

Then when I started I decided to go into per-device.  I was thinking of
also persist that information, but then I remembered some ppc guest can
have ~40,000 vmstates..  and memory to maintain that may or may not regress
a ppc user.  So I figured I should first keep it simple with tracepoints.

> 
> > But with a few differences:
> > 
> >   - Nothing exported yet to qapi, all tracepoints so far
> > 
> >   - Instead of major checkpoints (stop, iterable, non-iterable, resume-rp),
> >     finer granule by providing downtime measurements for each vmstate (I
> >     made microsecond to be the unit to be accurate).  So far it seems
> >     iterable / non-iterable is the core of the problem, and I want to nail
> >     it to per-device.
> > 
> >   - Trace dest QEMU too
> > 
> > For the last bullet: consider the case where a device save() can be super
> > fast, while load() can actually be super slow.  Both of them will
> > contribute to the ultimate downtime, but not a simple summary: when src
> > QEMU is save()ing on device1, dst QEMU can be load()ing on device2.  So
> > they can run in parallel.  However the only way to figure all components of
> > the downtime is to record both.
> > 
> > Please have a look, thanks.
> >
> 
> I like your series, as it allows a user to pinpoint one particular bad device,
> while covering the load side too. The checkpoints of migration on the other hand
> were useful -- while also a bit ugly -- for the sort of big picture of how
> downtime breaks down. Perhaps we could add that /also/ as tracepoitns without
> specifically commiting to be exposed in QAPI.
> 
> More fundamentally, how can one capture the 'stop' part? There's also time spent
> there like e.g. quiescing/stopping vhost-net workers, or suspending the VF
> device. All likely as bad to those tracepoints pertaining device-state/ram
> related stuff (iterable and non-iterable portions).

Yeah that's a good point.  I didn't cover "stop" yet because I think it's
just more tricky and I didn't think it all through, yet.

The first question is, when stopping some backends, the vCPUs are still
running, so it's not 100% clear to me on which should be contributed as
part of real downtime.

Meanwhile that'll be another angle besides vmstates: need to keep some eye
on the state change handlers, and that can be a device, or something else.

Did you measure the stop process in some way before?  Do you have some
rough number or anything surprising you already observed?

Thanks,

-- 
Peter Xu


