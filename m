Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DED7A202A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:49:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9BF-00044G-RT; Fri, 15 Sep 2023 09:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qh9BE-000440-6Q
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qh9BC-0002J9-B9
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694785696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rdtgocDR7xDH4ohn2sFbtABcWOLCxlCQv8vIIo71e/w=;
 b=IcRrpxP5r1ib+k+TkM4/FcJRBJ8FiRSHWWrkcS3bUROsy61DPNHd59zWSm8YKQBMYmksKS
 oxzyq4rRQPk0P2lBhQjSlyrrAzYu2LOd/pL582ifphGFWNh51PoOuP7Ge1AVSN728lILVs
 Ep925+LUqveZ67XUA/rUjNswgc4fyzc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-M9q8s2ctMoaPvY5TAQrrEw-1; Fri, 15 Sep 2023 09:48:14 -0400
X-MC-Unique: M9q8s2ctMoaPvY5TAQrrEw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a9e3f703dfso157349966b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694785693; x=1695390493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdtgocDR7xDH4ohn2sFbtABcWOLCxlCQv8vIIo71e/w=;
 b=EkcmIouZ/sd2xxJD0h9nIPDAuBK5hTajswxvDUY7e/FDSQf4lnfY9MbpyJeULagC6u
 sLFXlQ/5WK5Brj+GA4ggBhbR4Kad2+tEBqsQeXrOOc0i1pF0+MXdtVzIHDSVrcNuBOZk
 wCTgerzeDkTvXif/9VmV0kBD44wPZvjelv5HbWV/2sd8gxI6v54FrPq7RilZI1gSX9Ct
 7POFSKzypMqNp1GkUU2zyDattbu/ttZd/uEpywHTTqrH1R+X4AYor9mDhMyVl58c/meb
 eYWZius+M+BIN4rXWehjeuTr2ZdMjyho94C7SpHQXyLJzl+7SnsQ2kdNsxuaydUtFcQM
 rUjg==
X-Gm-Message-State: AOJu0YzltEb5DV0DKUA+gho8l/u5baAE6f6Vb7wgzWRQMr85qfA3+YqY
 YQYHmlkOQZLKNCsroC1oNxFNPd52UHcOMtZ5+8tlaTCUQYacBD/lvHWr8AHZGGDIjozu+g3VC9d
 vA030ZUGrkuGcZtQ=
X-Received: by 2002:a17:907:7719:b0:9a5:cb18:3b11 with SMTP id
 kw25-20020a170907771900b009a5cb183b11mr1626700ejc.17.1694785693458; 
 Fri, 15 Sep 2023 06:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUp7sKh8QJcSHhDKBFG1LuB2JNSPOctx2Pv+BEaEpy2aPjLymvzK1OqlJaJEaHXnEj/cl9Gw==
X-Received: by 2002:a17:907:7719:b0:9a5:cb18:3b11 with SMTP id
 kw25-20020a170907771900b009a5cb183b11mr1626682ejc.17.1694785693130; 
 Fri, 15 Sep 2023 06:48:13 -0700 (PDT)
Received: from redhat.com ([2.52.27.167]) by smtp.gmail.com with ESMTPSA id
 oz11-20020a170906cd0b00b009a1dbf55665sm2464385ejb.161.2023.09.15.06.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 06:48:12 -0700 (PDT)
Date: Fri, 15 Sep 2023 09:48:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Message-ID: <20230915094735-mutt-send-email-mst@kernel.org>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
 <ZPbRLtS6Txn0a2LX@liuzhao-OptiPlex-7080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPbRLtS6Txn0a2LX@liuzhao-OptiPlex-7080>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 05, 2023 at 02:56:46PM +0800, Zhao Liu wrote:
> Hi Michael,
> 
> On Fri, Sep 01, 2023 at 12:55:33PM +0300, Michael Tokarev wrote:
> > Date: Fri, 1 Sep 2023 12:55:33 +0300
> > From: Michael Tokarev <mjt@tls.msk.ru>
> > Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
> > 
> > 25.08.2023 06:36, Zhao Liu wrote:
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > Hi all,
> > > 
> > > This patchset is the follow up tests of previous topology fixes in
> > > smbios [1].
> > > 
> > > In this patchset, add these test cases:
> > > 
> > > 1. Add the case to test 2 newly added topology helpers (patch 1):
> > >     * machine_topo_get_cores_per_socket()
> > >     * machine_topo_get_threads_per_socket()
> > > 
> > > 2. Add the cases in bios-tables-test.c to:
> > >     * test smbios type4 table count (patch 2-4).
> > >     * test smbios type4 core count field (patch 5-7).
> > >     * update the test of smbios type4 core count2 field (patch 8-10).
> > >     * test smbios type4 thread count (patch 11-13).
> > >     * test smbios type4 thread count2 (patch 14-16).
> > > 
> > > With the above new cases, cover all commits of [1] in test.
> > > 
> > > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html
> > 
> > Hmm.  I definitely didn't expect such a large patchset..  I asked for just
> > a small, maybe manual (from command-line) reproducer of the original issue,
> > so I can verify it is fixed before applying the change in question to qemu
> > stable trees. 
> 
> Since these issues are found by coding reading, they are "byproducts" of
> other topology-related work I've been woring on, not directly identified
> by any anomaly...
> 
> ...So I'm not quite sure what the consequences of these few misuses of
> topology fields are, and how they might manifest themselves.
> 
> > It is a large work.  Lemme at least give it a try in the
> > gitlab CI...
> 
> The test cases are the ones that clearly define the relevant topology
> issues.
> 
> 
> Thanks,
> Zhao

I think it's ok, as long as Igor's happy.

> > 
> > Philippe, can you pick this up for the misc tree?
> > 
> > /mjt


