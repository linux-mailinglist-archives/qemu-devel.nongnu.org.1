Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14219712889
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:36:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YXI-0007hI-NH; Fri, 26 May 2023 10:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2YXG-0007bo-QN
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2YXF-0001Yu-AU
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685111716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23PSCkpCLEM1XAMPimMBbxbw0zy1QtLjE7VIpVbxVJA=;
 b=KLg6ki5oVbPjQ7smZpCfgw3MN27CNo+/BYjAbMpkzlj4MQDnRrvcNNj+4J16ecXhsJYUh2
 FWCjHMCX91YWMwqvbPV0riVGGl44QS/NjlGdM7UWCWDeSrMZ2CUzAulNGF3jNkHk3mTxlT
 LxMoZPV3xTAk8I0k27VZZd3jTs09miY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629--rWGzt62O9yj_4XPF4_JIQ-1; Fri, 26 May 2023 10:35:14 -0400
X-MC-Unique: -rWGzt62O9yj_4XPF4_JIQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-623a54565e6so1494526d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 07:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685111714; x=1687703714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23PSCkpCLEM1XAMPimMBbxbw0zy1QtLjE7VIpVbxVJA=;
 b=buKMqTCA4hUjZ7f4i3wmV7s5rgQ8KPlBRzHM+/GrBWoh1JRhSahGODvdIQoY+DpNq3
 N7iGilGHlpux6wgndQDEebNTYixvmaXzuBLIOMkqOlB4SiESamTsNZFGuXMRSkM0l3yS
 wAA7lUFHE9xs+flSp1zeKYsHs6EB05BjWVGOXEI76Pf4JAQujFJuoINWDcJys2bLMs2D
 vSOwmP0w3pyjfH9in4tsrmS/fAT8wHrvgGK7MAhEtbk5+Ozlne31aYeM1gFle7plegnH
 vSr3zc/wzXGblZkVT8aDOYKvRNrK3nNnNxyWVWqQoiKDMGVeKpHgwXVtAWwAsJ2uSE2c
 WQ5w==
X-Gm-Message-State: AC+VfDxGtMUIoy7fCP/4UYXQG2tRMYNymTjw8Xn2IPKSsGfc6mifArlz
 0RPq2WJutVKAqa28DxMq75pKBlG5j4Xa5Gy5jPV1e2ApD9YgK6dUNjE1XppmzcgLu7AIWFdrYK8
 p9X06h/viT2DgUL0=
X-Received: by 2002:a05:6214:4008:b0:616:870c:96b8 with SMTP id
 kd8-20020a056214400800b00616870c96b8mr2149488qvb.3.1685111714480; 
 Fri, 26 May 2023 07:35:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6r4aJ8YyIofU1+7F8+dMZZeNYM53hrV43dTRgB3F27+SBcixIPkeBzzKC9bu/uNdlf3gt/jg==
X-Received: by 2002:a05:6214:4008:b0:616:870c:96b8 with SMTP id
 kd8-20020a056214400800b00616870c96b8mr2149365qvb.3.1685111712648; 
 Fri, 26 May 2023 07:35:12 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 l12-20020a056214028c00b0061b608dc4c1sm1242350qvv.94.2023.05.26.07.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 07:35:12 -0700 (PDT)
Date: Fri, 26 May 2023 10:35:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: release memory objects in error path
Message-ID: <ZHDDn62S3MhwLhIp@x1n>
References: <20230522181021.403585-1-ppandit@redhat.com> <ZG9cc0yEAJ06N0XY@x1n>
 <CAE8KmOyeV2HB-Fd5PsqVPh7NZBQ7KRH9CrP_7xOsHLac2dwFVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyeV2HB-Fd5PsqVPh7NZBQ7KRH9CrP_7xOsHLac2dwFVA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 26, 2023 at 12:24:07PM +0530, Prasad Pandit wrote:
> Hello Peter, all
> 
> On Thu, 25 May 2023 at 18:33, Peter Xu <peterx@redhat.com> wrote:
> 
> > IIRC this bug used to only reproduce on rt kernels, is it still the case?
> >
> 
> * Yes, it's a same crash.
> 
> 
> > Here besides doing correct unregister, does it also mean that even if
> > event_notifier_init() failed there's totally no error message anywhere?
> > Should we dump something when it fails?  And did you check why that failed?
> >
> 
> * In the qemu logs we see following error
> 
>         VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
>         goto fail_mem
> 
> After this execution likely did not reach the event_notifier_init() call,
> because: goto fail_mem.

Ah so it's not about eventfd, okay!

> 
> * But in case it fails, no error message gets logged. Do we want to add it
> in this same patch?

I see you already sent one, will read.

Thanks!

-- 
Peter Xu


