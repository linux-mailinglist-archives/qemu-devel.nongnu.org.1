Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F579779426
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUoM-0007D2-0f; Fri, 11 Aug 2023 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUUoI-0007Cr-U1
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUUoG-0002c0-MO
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhRtK85J+38GFMGOVuX6M3LYoGrmP64t52ryvG69xzY=;
 b=At8JLogQPS9NqwT/yjSvKn0zBruOJjIVMx7n07wVDy1HavHpzQNNdSortaV+NHNvfmiETZ
 aM7HHaUAFF8GyhahEI+6wuL1RoYewlyAF2Th0F9DbL4OGjta9JysddW91cojRnScdcuFt9
 Jw+DeT2iQyBRS3NPIhsx8Ym+H1+pTSQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-1mDHb5KqO-qiLn6fm54MFw-1; Fri, 11 Aug 2023 12:16:18 -0400
X-MC-Unique: 1mDHb5KqO-qiLn6fm54MFw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-645778904dfso204626d6.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770577; x=1692375377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhRtK85J+38GFMGOVuX6M3LYoGrmP64t52ryvG69xzY=;
 b=NS3EAE3/vKrny9Z3NThuLHp6UC9bnifST/8fMSfCweWZw05e0Rt1bwF8ZrWdFrNYQ+
 vI6WHsO9PfACB2T7e6mmYMEi9Wl1DFPQ3hBwCi/VmHv7bDg9uY91M35orQgicqt+1SHS
 RZ0MzX0GI7GBtsNxoIC89QwMTK6QMOsUKi05DD30LSXRq+oPC6SVuFSZ9ncEFIeavcw1
 UDiq/9YShVxDXW2JX1jaj8suGw8+3CsT6npLAH9Yybg/xTeFIEGbSd6LZv3oZjZ9/QSf
 xIT+VZE67BfI+HpnXEQWQi3yJAX/PvMaFJ8RKRxAa7IrI95Sj17jKsLwaTvV5bEi8MOj
 eqsw==
X-Gm-Message-State: AOJu0YyE+hcPz2LJBG5TKVkgMyv27aGQk7+0I/np9uCRWR62ALsVSr+f
 05h76u2O7+TEo+JzhFJdxrkPeoGKhN+imcql1pqQB4cWnFgVdcrhkLTKA3TBOK06jC3cmAR9vZw
 RZOBVyc1VbmpxZBs=
X-Received: by 2002:a05:6214:3006:b0:641:8d4a:1a83 with SMTP id
 ke6-20020a056214300600b006418d4a1a83mr2359821qvb.3.1691770577636; 
 Fri, 11 Aug 2023 09:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa2B1HAcaHlFVoNVozw0t/IEKNAjhTM3p3PN7Lcsbu26gaAOTxaUpzj2s2/r/u41N73clHVA==
X-Received: by 2002:a05:6214:3006:b0:641:8d4a:1a83 with SMTP id
 ke6-20020a056214300600b006418d4a1a83mr2359803qvb.3.1691770577340; 
 Fri, 11 Aug 2023 09:16:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b16-20020a0cc990000000b0063d2a70dff5sm1315440qvk.72.2023.08.11.09.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:16:17 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:16:15 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNZez9ICBBf+D/d2@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
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

On Fri, Aug 11, 2023 at 05:26:24PM +0200, David Hildenbrand wrote:
> I just started looking into the origins of "-mem-path".
> 
> Originally c902760fb2 ("Add option to use file backed guest memory"):
> 
> * Without MAP_POPULATE support, we use MAP_PRIVATE
> * With MAP_POPULATE support we use MAP_PRIVATE if mem_prealloc was not
>   defined.
> 
> It was only used for hugetlb. The shared memory case didn't really matter:
> they just needed a way to get hugetlb pages into the VM. Opening the file
> R/W even with MAP_PRIVATE kind-of made sense in that case, it was an
> exclusive owner.
> 
> Discarding of RAM was not very popular back then I guess: virtio-mem didn't
> exist, virtio-balloon doesn't even handle hugetlb today really, postcopy
> didn't exist.
> 
> 
> I guess that's why nobody really cared about "-mem-path" MAP_PRIVATE vs.
> MAP_SHARED semantics: just get hugetlb pages into the VM somehow.
> 
> Nowadays, "-mem-path" always defaults to MAP_PRIVATE. For the original
> hugetlb use case, it's still good enough. For anything else, I'm not so
> sure.

Ok this answers my other question then on the compat bit.. thanks.  Feel
free to ignore there.

But then I'd lean back towards simply adding a fdperm=; that seems the
simplest, since even if with a compat bit, we still face risk of breaking
-mem-path users for anyone using new machine types.

-- 
Peter Xu


