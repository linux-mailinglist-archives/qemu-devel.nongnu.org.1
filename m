Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BE776164
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjPx-0002tB-2a; Wed, 09 Aug 2023 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qTjPu-0002t2-C7
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qTjPs-0002uu-P5
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691588399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flPDYzSyfp211f0MdFgt38SNZIp/oJAHUOcWzYx2ros=;
 b=GTFe58Qg2e85S0S1cpwuDrlppC4Dm0ru9fFMB7Bzd6pu7nfnkY2UzvoT3I+T+ga5Y0jrST
 7aBtf90ee+6VnZKa6vGW34KK60YZBGe8bZNswFyD07cqCyKZCcqbjkAk/uaYZtmFO66UtW
 6iA2VuauXxiEC0GBPZR8vU1SYAQfdZw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-qKPtEbjPP6OcPnppMgtXMQ-1; Wed, 09 Aug 2023 09:39:57 -0400
X-MC-Unique: qKPtEbjPP6OcPnppMgtXMQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso490847566b.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 06:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691588396; x=1692193196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flPDYzSyfp211f0MdFgt38SNZIp/oJAHUOcWzYx2ros=;
 b=dOpifvM66xe1rGmB+jBqgHfwmTg26GFl487exjK4nuZ/DMeBGkvAMSic5GlgjlaynV
 eLmHyxtbTXUlWbpGGk5mrN14JoxrJxHx9RiZfjkPx2m+C4NVRmkZ1KVkcCWm5kjXqafM
 Cip+9HJmeVz4CuOcHJOXEBDV7nWHlI4NZl6QJO22JMzUqYek3UbmiNFVWdKn0eZwfo1b
 /V1PTGrKJG0Y7bP8dM3XddC483qXbtMWDQGJW/E6Rw6fiRh3EUvyn1yOuLCdJP/RvbaS
 wGYoxOczzXqdeWhrxKl8zDDVe26gAiO1efDtiW9ru76K7JR43WFHS8urg1d4f1E8bxus
 M5uA==
X-Gm-Message-State: AOJu0YxF+BGyj3s5Z0nh3R2H11KXLlGHpzxUqpwtx1d8izqKj4rZ/7Gm
 a3Ry4IUHZEn95txc6b8yH28a6DHOa867S32EGTefv8N+AtPX7ofT901WyCKhS7HuEtRmQDatsz3
 q6fx/yKWVEQIQJKY=
X-Received: by 2002:a17:906:3096:b0:99c:f6f4:6306 with SMTP id
 22-20020a170906309600b0099cf6f46306mr2127169ejv.46.1691588396426; 
 Wed, 09 Aug 2023 06:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETK3NbNUM2FoiVWXuDriVpIJy0DKTuwt5G/vIyXo94zyWi2Ya4gCnyn6sLdaKEWmX5TORjAg==
X-Received: by 2002:a17:906:3096:b0:99c:f6f4:6306 with SMTP id
 22-20020a170906309600b0099cf6f46306mr2127159ejv.46.1691588396191; 
 Wed, 09 Aug 2023 06:39:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d11-20020a170906c20b00b00992d70f8078sm8071827ejz.106.2023.08.09.06.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 06:39:55 -0700 (PDT)
Date: Wed, 9 Aug 2023 15:39:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Message-ID: <20230809153954.64720adc@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZNEAR7nK1pY/BFH+@liuzhao-OptiPlex-7080>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <598990ac-e5f8-fdcc-5936-e219491c4d0f@tls.msk.ru>
 <32cfa897-4472-083f-88cd-a3c3e3c405b0@tls.msk.ru>
 <20230807115615.278fb838@imammedo.users.ipa.redhat.com>
 <ddfe932b-57b7-8f48-03aa-82e1964dda2a@tls.msk.ru>
 <20230807121129.30e6fe1e@imammedo.users.ipa.redhat.com>
 <ZNEAR7nK1pY/BFH+@liuzhao-OptiPlex-7080>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Mon, 7 Aug 2023 22:31:35 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> Hi Igor,
> 
> On Mon, Aug 07, 2023 at 12:11:29PM +0200, Igor Mammedov wrote:
> > Date: Mon, 7 Aug 2023 12:11:29 +0200
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
> > X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> > 
> > On Mon, 7 Aug 2023 13:06:47 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> >   
> > > 07.08.2023 12:56, Igor Mammedov wrote:  
> > > > On Sat, 5 Aug 2023 09:00:41 +0300
> > > > Michael Tokarev <mjt@tls.msk.ru> wrote:  
> > [...]  
> > > The whole thing - provided the preparational patch a1d027be95
> > > "machine: Add helpers to get cores/threads per socket" is also
> > > picked up - applies cleanly and in a stright-forward way to 8.0
> > > and even to 7.2, and passes the usual qemu testsuite. Sure thing
> > > since the issues weren't noticed before, the testsuite does not
> > > cover this area.  It'd be nice to have some verifier to check if
> > > the whole thing actually works after applying the patchset.  
> > 
> > Zhao Liu,
> > can you help us out with adding test cases to cover the code
> > you are touching?  
> 
> Yes, sure.
> 
> Just double check, I should add these 2 test cases:
> 1. in "bios-tables-test.c" to test smbios type4 topology related things, and
> 2. also in "test-smp-parse.c" to test our new topology helpers.
> 
> Do I understand correctly?

yep, I'd do both.
Also looking at test cases I don't see any test cases that
check topo end-to-end path (at least for x86). I mean
checking related CPUID values.
One possible place to it without writing testcase from scratch
could be test-x86-cpuid-compat.c.
Where I'd add test cases for some CPUID leaves at certain topo
configurations (values to check could be hardcoded magic numbers
as long as they are properly documented/reference specs) .

> 
> -Zhao
> 
> > 
> > [...]
> >   
> 


