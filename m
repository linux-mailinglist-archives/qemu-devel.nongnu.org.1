Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DC7A2105
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:32:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9qi-00084W-EQ; Fri, 15 Sep 2023 10:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh9qg-00084F-3a
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh9qX-0002o9-Lc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694788260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQO9HnqTEJUO3+XhcMPhocND21MsaKHX2FSxEV9cKDY=;
 b=GaYTi2rxv3ZzQJH6X0b5XvQs55rErNk+wE92UDZRNxS21g63bsI5ZO+R8lntqy0E9N5h2i
 rXTvKA5xkAVhGGnWxF63C36ldhW+EC5kAup5EvK4xCsjPZn+WwIM5xK60/CXzjz2bWqFK3
 FWR8qHj8ihz+SeyjnHc7IhBTfIPfX2Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-aoV4QDMINSW6ukk4h4pH9g-1; Fri, 15 Sep 2023 10:30:58 -0400
X-MC-Unique: aoV4QDMINSW6ukk4h4pH9g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9aa05c1934aso488606566b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694788257; x=1695393057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQO9HnqTEJUO3+XhcMPhocND21MsaKHX2FSxEV9cKDY=;
 b=N+CGiqfcn4uzLfcZPZw6Xo2ivcGScGUfrRl4hpDi5/cSbOwfImbZqDegEsE6EMjaMf
 Fthhw3Iku9fvTnyI8Du7k9gLxOtmLJhaQQLufN4CjdqrYHEpGBmEfN3tKA7JQtXVf7lh
 9W+Q2ci+W7h5y0k3X8VMJa0lyHJB3Rs4XZNDtnt5OI/bmx9WRbUqVlZ/NBnB9Zfx4buA
 dJNgMV3T4uvJBuQRWQeMWWT3UjfXVAyf+6INdWUYm3ttOXGySkiZzpHViz5+NUQuGfAc
 yJTwgmEHLlYaGsMGUiLJisV4KhCUHuFtEHXJ1iDRTAocsHCU2VIo+Q3y4oYkB8GP+Q1w
 eXDQ==
X-Gm-Message-State: AOJu0YyXDijV1tJfU+KzNhwjnMGQF3XOoSOqf4O+zYrBH6JkwEpmtxc3
 7ZeyxUEnInBjeqFcj314t4yUFon9t0FyxBBdCTRpnLLG5tbyOiqRbDRrWfbUKtM9lXjDGmhFnn1
 bRW++WkFksuAmm0A=
X-Received: by 2002:a17:907:1c1e:b0:9a5:7dec:fab9 with SMTP id
 nc30-20020a1709071c1e00b009a57decfab9mr5865385ejc.9.1694788257377; 
 Fri, 15 Sep 2023 07:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtqSoMzO3meBOH7EH9Ik1ql21mQ6Cwq7w1iBxxe8pUO1ythL1clXNB6FvkW/t/MBGr75IZyA==
X-Received: by 2002:a17:907:1c1e:b0:9a5:7dec:fab9 with SMTP id
 nc30-20020a1709071c1e00b009a57decfab9mr5865363ejc.9.1694788257058; 
 Fri, 15 Sep 2023 07:30:57 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i23-20020a1709061cd700b009ad8796a6aesm2470759ejh.56.2023.09.15.07.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 07:30:56 -0700 (PDT)
Date: Fri, 15 Sep 2023 16:30:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, qemu-devel@nongnu.org, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Message-ID: <20230915163055.7a989af4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230915094735-mutt-send-email-mst@kernel.org>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
 <ZPbRLtS6Txn0a2LX@liuzhao-OptiPlex-7080>
 <20230915094735-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 15 Sep 2023 09:48:08 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Sep 05, 2023 at 02:56:46PM +0800, Zhao Liu wrote:
> > Hi Michael,
> > 
> > On Fri, Sep 01, 2023 at 12:55:33PM +0300, Michael Tokarev wrote:  
> > > Date: Fri, 1 Sep 2023 12:55:33 +0300
> > > From: Michael Tokarev <mjt@tls.msk.ru>
> > > Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
> > > 
> > > 25.08.2023 06:36, Zhao Liu wrote:  
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > Hi all,
> > > > 
> > > > This patchset is the follow up tests of previous topology fixes in
> > > > smbios [1].
> > > > 
> > > > In this patchset, add these test cases:
> > > > 
> > > > 1. Add the case to test 2 newly added topology helpers (patch 1):
> > > >     * machine_topo_get_cores_per_socket()
> > > >     * machine_topo_get_threads_per_socket()
> > > > 
> > > > 2. Add the cases in bios-tables-test.c to:
> > > >     * test smbios type4 table count (patch 2-4).
> > > >     * test smbios type4 core count field (patch 5-7).
> > > >     * update the test of smbios type4 core count2 field (patch 8-10).
> > > >     * test smbios type4 thread count (patch 11-13).
> > > >     * test smbios type4 thread count2 (patch 14-16).
> > > > 
> > > > With the above new cases, cover all commits of [1] in test.
> > > > 
> > > > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html  
> > > 
> > > Hmm.  I definitely didn't expect such a large patchset..  I asked for just
> > > a small, maybe manual (from command-line) reproducer of the original issue,
> > > so I can verify it is fixed before applying the change in question to qemu
> > > stable trees.   
> > 
> > Since these issues are found by coding reading, they are "byproducts" of
> > other topology-related work I've been woring on, not directly identified
> > by any anomaly...
> > 
> > ...So I'm not quite sure what the consequences of these few misuses of
> > topology fields are, and how they might manifest themselves.
> >   
> > > It is a large work.  Lemme at least give it a try in the
> > > gitlab CI...  
> > 
> > The test cases are the ones that clearly define the relevant topology
> > issues.
> > 
> > 
> > Thanks,
> > Zhao  
> 
> I think it's ok, as long as Igor's happy.

series looks fine to me
(modulo cosmetic issues and better commit messages as noted in per patch review)

> 
> > > 
> > > Philippe, can you pick this up for the misc tree?
> > > 
> > > /mjt  
> 


