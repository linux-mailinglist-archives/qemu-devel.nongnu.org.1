Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A47B07FA
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWJ8-0004c8-Lv; Wed, 27 Sep 2023 11:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWJ6-0004an-4m
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWJ3-0007oJ-Lv
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695827908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIyIGDSuGKX2wMGk5Ea6PCMbCg9Btdx8WDQoUSGbl4k=;
 b=TG7d5NfqPLLvWdDiC8W+Ma9Z+aIczerTlHL+XkF22OO8Hc+XvDMc249w7ZLipc6HYxp+Wq
 pXLvetyhPedRiV8Z9miAOWDyImixvscJBwFZSM0+da7B2em/BtYtlhZ8OMykhYip4j6oFk
 hW1lvgQve23N0qebJdFQ3dFISO2xZd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-0HbYwvwnNfCE1OMXyfBgJw-1; Wed, 27 Sep 2023 11:18:26 -0400
X-MC-Unique: 0HbYwvwnNfCE1OMXyfBgJw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso97987075e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827905; x=1696432705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIyIGDSuGKX2wMGk5Ea6PCMbCg9Btdx8WDQoUSGbl4k=;
 b=JnOVjZCadXZgU/2nog98YRlQuyoOfcFieVbWZ11o7G7yJQMwJX0zKZl+Jt9+BOxyE8
 weotiMxcJTOWiwSgWTKjlXVKTchRSR5YJYbe7+EvMp3pGcVLuLbvC710XhiIjJbmS2LB
 fwZAZQKu1Nc0LhiYK0b1EfR9QNY9JQdcM2vmJl6JR84Mp5OQ3XC1uS9mtFLGpUl0teTa
 n+d6giKwMCe4BkLpENffv/ejXccp/KjIEkLqLXkeii3GPcFlCnur2YroUqhzrwL1ObEh
 gPnYb7WaC1spTwSgbiJPgc53fBvJHR6WyWc87BnhFQGxJxgR/rTNfvWhxhAiWz/N4x8O
 Kvzg==
X-Gm-Message-State: AOJu0YxkYfJ+y21k4+YA0jRe6+ZV/3f4Q84XFxtnCq2ttT/YskS4xUv+
 yFgXrgLkAF+CiPbAg+QykQr4ZYin6VXQnUFrdln7k5qAqm9dTUm8hID5zeBm7hq6DIeBfVGGIOf
 61ULhQCzSApWDNnU=
X-Received: by 2002:a1c:4b11:0:b0:405:37bb:d93e with SMTP id
 y17-20020a1c4b11000000b0040537bbd93emr2299718wma.9.1695827905824; 
 Wed, 27 Sep 2023 08:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeTcVuyXr4SnrHDkcHX5ooobmKl5qUNEMsibhY+eZJW4LJMlYQHMI4nNjcZkteXnII87GHOA==
X-Received: by 2002:a1c:4b11:0:b0:405:37bb:d93e with SMTP id
 y17-20020a1c4b11000000b0040537bbd93emr2299703wma.9.1695827905559; 
 Wed, 27 Sep 2023 08:18:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
 by smtp.gmail.com with ESMTPSA id
 k10-20020adfd22a000000b0032320a9b010sm9506839wrh.28.2023.09.27.08.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:18:24 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:18:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: lixianglai <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Bernhard Beschow <shentey@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 1/7] Update ACPI GED framework to support vcpu
 hot-(un)plug
Message-ID: <20230927111809-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <14ee117df13b08403032eb07843b91e1861228d9.1695697701.git.lixianglai@loongson.cn>
 <20230926070229-mutt-send-email-mst@kernel.org>
 <bc29c4fe-7180-6e00-2e91-a6a89c37b85a@loongson.cn>
 <20230926080738-mutt-send-email-mst@kernel.org>
 <e8fbec0306d24cdab3398772a8301fc7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fbec0306d24cdab3398772a8301fc7@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 26, 2023 at 12:38:44PM +0000, Salil Mehta wrote:
> Hi Michael,
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, September 26, 2023 1:08 PM
> > 
> > On Tue, Sep 26, 2023 at 07:26:40PM +0800, lixianglai wrote:
> > >
> > > Hi, Michael S. Tsirkin :
> > > > On Tue, Sep 26, 2023 at 05:54:26PM +0800, xianglai li wrote:
> > > > > ACPI GED shall be used to convey to the guest kernel about any cpu
> > hot-(un)plug
> > > > > events. Therefore, existing ACPI GED framework inside QEMU needs to
> > be enhanced
> > > > > to support CPU hot-(un)plug state and events.
> > > > >
> > > > > Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > > > Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> > > > This is not the way to handle multiple emails.
> > >
> > > Oh, sorry, I'll delete the first one.
> > >
> > > Thanks,
> > >
> > > Xianglai.
> > 
> > Can you guys figure out together with Salil Mehta what's the
> > correct order to merge this? I can't figure out with dueling patches.
> 
> We already have an agreed approach and Loongson folks will
> rebase from the common patch-set. There is no contention. 
> 
> Thanks
> Salil.
> 
> 

Great, thanks a lot!

-- 
MST


