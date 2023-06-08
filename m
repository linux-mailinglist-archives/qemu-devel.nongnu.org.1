Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAE97279F6
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 10:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7B0b-0001HU-TY; Thu, 08 Jun 2023 04:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7B0a-0001HM-Ga
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7B0Y-00033a-Rq
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686212917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlcJoef7y3vl/Ujhn3hv9VUwApVHXqV4NhVw2R7Jl7g=;
 b=BTSMpNi+oJwGd+Q63Louv1VVMLHvZTDeM+tRMnxQFJV8WoBCVcueuoLY+fMEpigmuxWAyM
 FdSS3SNbFk5AGjwc3DC78jgSDmdL5uwYMUpR8yttN+qFX4J620WVS/4HBESzk9bBCMJLW8
 yBMXbkFlOVHOM9k0VIXDySyCIPaNcx0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-8NFlpoh1NwqKUxikcwINmw-1; Thu, 08 Jun 2023 04:28:34 -0400
X-MC-Unique: 8NFlpoh1NwqKUxikcwINmw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51664cc4bddso344354a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 01:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686212913; x=1688804913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlcJoef7y3vl/Ujhn3hv9VUwApVHXqV4NhVw2R7Jl7g=;
 b=LhpaU91blVz9AWANpNMR7LYuFJp99RP8YlwADauRYGa4R1e7zeRWwKSbjGPStWA30w
 heZabn04Rt2y/Z37gOQsX2hSs/DjMNzRA9wEP7lZH0f4+i+HS2CdyEk1JUpHm2uUV3Mi
 i4u9aEoUw1/rAc9ka6XQQp2OIddTmATEM+87wF9GS2a3byZCNXu5OBDzbfrbA6RDh4SL
 6bg5/hob/6xYyrt6v3CaeKQs9z7XZduL8QBPuqiFhYT1dpKYZlOcdpxYzXKnYoCtmszT
 KwnpTGZChawdd4itD/ORF0JL8xQ5n4yIqpgq8M1vqWsJA7TZckGWokIQk4d8T3lgbWoP
 QEVg==
X-Gm-Message-State: AC+VfDzpP3LkYr8nOylVSwwrz0elRIpJWrF/VQwDn3tPejEyxd+P1Svt
 V1Fj9ScQUEeMmVT5IVKJ97esQE/I2pthr86hkw42ZYeFTzXyucxaDPYYoixrv3+ob+SALW2qQ42
 EwwDRVsLyVP3nN9o=
X-Received: by 2002:aa7:cd1a:0:b0:516:642e:f935 with SMTP id
 b26-20020aa7cd1a000000b00516642ef935mr6832642edw.22.1686212913162; 
 Thu, 08 Jun 2023 01:28:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lAXc0jW1rS0ZWvIsKgUmhjDmo1aJIMQsSxA+5nlxcW4cTEVhMFjC17L9bk1xK8rBfihCSdg==
X-Received: by 2002:aa7:cd1a:0:b0:516:642e:f935 with SMTP id
 b26-20020aa7cd1a000000b00516642ef935mr6832627edw.22.1686212912850; 
 Thu, 08 Jun 2023 01:28:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 j25-20020aa7c0d9000000b005148f0e8568sm270542edp.39.2023.06.08.01.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 01:28:31 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:28:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Message-ID: <20230608102831.22a9dc37@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZIFCGWdkTcfwiG37@liuzhao-OptiPlex-7080>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <20230607164934.51805cb0@imammedo.users.ipa.redhat.com>
 <ZIFCGWdkTcfwiG37@liuzhao-OptiPlex-7080>
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

On Thu, 8 Jun 2023 10:51:05 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Wed, Jun 07, 2023 at 04:49:34PM +0200, Igor Mammedov wrote:
> > Date: Wed, 7 Jun 2023 16:49:34 +0200
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
> > X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> > 
> > On Thu,  1 Jun 2023 17:29:51 +0800
> > Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> >   
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > From SMBIOS 3.0 specification, thread count field means:
> > > 
> > > Thread Count is the total number of threads detected by the BIOS for
> > > this processor socket. It is a processor-wide count, not a
> > > thread-per-core count. [1]
> > > 
> > > So here we should use threads per socket other than threads per core.
> > > 
> > > [1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count
> > > 
> > > Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > > Changes since v1:
> > >  * Rename cpus_per_socket to threads_per_socket.
> > >  * Add the comment about smp.max_cpus. Thread count and core count will
> > >    be calculated in 2 ways and will add a sanity check to ensure we
> > >    don't miss any topology level.
> > > ---
> > >  hw/smbios/smbios.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > > index d67415d44dd8..faf82d4ae646 100644
> > > --- a/hw/smbios/smbios.c
> > > +++ b/hw/smbios/smbios.c
> > > @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> > >  {
> > >      char sock_str[128];
> > >      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> > > +    unsigned threads_per_socket;
> > >  
> > >      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> > >          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > > @@ -747,17 +748,20 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> > >      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
> > >      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
> > >  
> > > +    /* smp.max_cpus is the total number of threads for the system. */
> > > +    threads_per_socket = ms->smp.max_cpus / ms->smp.sockets;  
> > 
> > what I dislike here is introducing topo calculations with its own assumptions
> > in random places.
> > 
> > I'd suggest to add threads_per_socket (even if it's just a helper field) into
> > topo structure and calculate it with the rest on topology.
> > And then use result here.  
> 
> Thanks, I will try this way.

maybe instead a field, a helper function located close to topo code
would be better/more acceptable

> 
> Zhao
> 
> >   
> > > +
> > >      t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> > >      t->core_enabled = t->core_count;
> > >  
> > > -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> > > +    t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
> > >  
> > >      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
> > >      t->processor_family2 = cpu_to_le16(0x01); /* Other */
> > >  
> > >      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> > >          t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > > -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> > > +        t->thread_count2 = cpu_to_le16(threads_per_socket);
> > >      }
> > >  
> > >      SMBIOS_BUILD_TABLE_POST;  
> >   
> 


