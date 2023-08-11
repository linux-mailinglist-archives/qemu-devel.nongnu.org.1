Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E494C77937B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUMf-0000if-2I; Fri, 11 Aug 2023 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUUMP-0000gv-OB
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUUMO-00050C-2E
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691768850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2cicZPFtD1+DEzPMplD3B1x4uhcJje9HvoqWz6HL/A=;
 b=cctMlVk4QeacedjMNSFVGhJc4wRMJobUXBY4sqdalEAu6lc7md81hHsGPerFnqY9QQf05a
 HXR7Q1Iyvz5w/tn/6Wva2lrr6JGjOOnRgu7PV6WIJSGMQMpZwF2aLnaoaBQKKls9+/yJNt
 koDnNTQpSqFM2O1Rs6mlWGWe2T7Q/08=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-idWw9n5FOV-dkulgmMvwvQ-1; Fri, 11 Aug 2023 11:47:29 -0400
X-MC-Unique: idWw9n5FOV-dkulgmMvwvQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4059b5c3dd0so5586901cf.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691768848; x=1692373648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2cicZPFtD1+DEzPMplD3B1x4uhcJje9HvoqWz6HL/A=;
 b=KWpH/u5x960TvwG6724N6tfSC0Io4Ps/J3lYAxhOU4vOun9GtIn3dGnKvjfXKMR6kC
 jH+ihS36bfX4IvSwWQfXEO60i+qCO4wS9/7f1Y5Bu6ub6/WVVD+cePYoaDCIflQ1AAl+
 WCzNZb7jIeeU3AMHf9CIGNmo0aB1xtan32k+vSSnJ3cVoTEo38dIKJgiApP64dNQhTm0
 MrZx9stkTOqCnK6zLdeMWZgSz/4DJwk+LojPXV9gEpaSMZHyF8UVpoxIhJBgy0XboL4K
 TwVUqLYMtIOZhRP59xFK/lek78zU8vFWWm1s/hRt5q2aTn2mePen243AcoLNREjnEzzp
 rH9A==
X-Gm-Message-State: AOJu0YwFUoXljKAyaC83rTASd9f8PjOtnPOeuJ129J1PXSxq5mVC0oTm
 4hKIS4SB0ZO5S7Lv+5J94EQMt0RCsIXsJaaunom1jMHoEhH+j1eqUec+LzSGNQrXuSEwY3FFk/P
 l0ByzA49/p/t+g9g=
X-Received: by 2002:a05:6214:3002:b0:63f:7d29:1697 with SMTP id
 ke2-20020a056214300200b0063f7d291697mr2689618qvb.2.1691768848374; 
 Fri, 11 Aug 2023 08:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYCGqBkhtfbimejW7YEBfVOBwPsP+AbjrAPhNAfOzi13+DvBiAMX95GyB0xwxp7QCLT+MGbA==
X-Received: by 2002:a05:6214:3002:b0:63f:7d29:1697 with SMTP id
 ke2-20020a056214300200b0063f7d291697mr2689596qvb.2.1691768848074; 
 Fri, 11 Aug 2023 08:47:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o11-20020a0ccb0b000000b0062de6537febsm1306273qvk.58.2023.08.11.08.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 08:47:27 -0700 (PDT)
Date: Fri, 11 Aug 2023 11:47:26 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNZYDjtkQRJtZF9Y@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
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

On Fri, Aug 11, 2023 at 04:59:56PM +0200, David Hildenbrand wrote:
> On 10.08.23 23:24, Peter Xu wrote:
> > On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
> > > > I think we have the following options (there might be more)
> > > > 
> > > > 1) This patch.
> > > > 
> > > > 2) New flag for memory-backend-file. We already have "readonly" and
> > > > "share=". I'm having a hard time coming up with a good name that really
> > > > describes the subtle difference.
> > > > 
> > > > 3) Glue behavior to the QEMU machine
> > > > 
> > > 
> > > 4) '-deny-private-discard' argv, or environment variable, or both
> > 
> > I'd personally vote for (2).  How about "fdperm"?  To describe when we want
> > to use different rw permissions on the file (besides the access permission
> > of the memory we already provided with "readonly"=XXX).  IIUC the only sane
> > value will be ro/rw/default, where "default" should just use the same rw
> > permission as the memory ("readonly"=XXX).
> 
> Hmm, I'm not particularly happy about that.
> 
> > 
> > Would that be relatively clean and also work in this use case?
> > 
> 
> I get the feeling that we are over-engineering something that probably
> should never have been allowed: MAP_PRIVATE mapping of a file and opening it
> rw because someone might punch holes into it.
> 
> Once we start adding new parameters just for that, I get a bit skeptical
> that this is what we want. The number of people that care about that are
> probably close to 0.
> 
> The only real use case where this used to make sense (by accident I assume)
> was with hugetlb. And somehow, we decided that it was a good idea for
> "-mem-path" to use MAP_PRIVATE.
> 
> So, what stops us from
> 
> a) Leaving -mem-path alone. Keep opening files rw.
> b) Make memory-backend-file with shared=off,readonly=off open the file
>    read-only
> c) Gluing that behavior to a QEMU compat machine

So we want to make all users with shared=off + readonly=off to only open
the file RO always, failing file write ops rather than crashing others.

Sounds reasonable to me.

In that case, do we even need a compat bit, if we're 100% sure it won't
break anyone but only help, with the fact that everything should be
transparent?

-- 
Peter Xu


