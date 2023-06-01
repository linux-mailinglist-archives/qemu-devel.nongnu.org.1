Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D27719A7E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4g5b-0007Go-3S; Thu, 01 Jun 2023 07:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1q4g5R-00074f-TG
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1q4g5P-0004wm-Rk
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685617398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ScRc0BCV8wTrtMsnNd+ZZwFC1Zjb5mA21OhTBayELRA=;
 b=gvx0zgmS/YvZp5jUc6JqFlfWPdF7AMyCFQr0Vb8eV3+hyix5CCokytAIdCo7jkEwxTGGS9
 /tgL4z6YObxYzHBE4mV1t6mv8bNQ4U1qHxO0Bhqp30LZAgR5BQqDrs49HIE+Fa5qGuWnAa
 W5nhyoju2/vG0rPaVu4Gwz6kVVHR5s0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-b95hT-JgOqCYb3rCjq7PCQ-1; Thu, 01 Jun 2023 07:03:14 -0400
X-MC-Unique: b95hT-JgOqCYb3rCjq7PCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 643048037AB;
 Thu,  1 Jun 2023 11:03:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DE782166B25;
 Thu,  1 Jun 2023 11:03:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A565A180079E; Thu,  1 Jun 2023 13:03:12 +0200 (CEST)
Date: Thu, 1 Jun 2023 13:03:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, 
 imammedo@redhat.com, jusual@redhat.com, jon.grimm@amd.com,
 santosh.Shukla@amd.com
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1024
Message-ID: <2fcaovhddmhbfbu4nbgjkdipvmaeone2zloyouiyf2d3c7irj7@rwmym3m6atyy>
References: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
 <39a49814-28d8-ffc8-42b4-3af14bb9dd47@oracle.com>
 <ZHhwOrfXMjjOmcAK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHhwOrfXMjjOmcAK@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

  Hi,

> > I suspect smbios 3.0 (64-bit entry point) is already supported.
> > 
> > With current qemu and all the smbios fixes in the last cycle, perhaps this is
> > mainly just setting smbios_entry_point_type to SMBIOS_ENTRY_POINT_TYPE_64 if
> > MachineState::smp::max_cpus is bigger than 720 (e.g. in pc_q35_init()?)
> 
> The need for the 64-bit entry point depends on a combination of RAM config
> and CPU count. IMHO we need to unconditionally switch the latest machine
> types to use the 64-bit entry point by default, rather than trying to infer
> some special condition to dynamically change on the fly.
> 
> Before doing that we need confirmation that our firmware builds in qemu.git
> (SeaBIOS and EDK2) will be happy with the 64-bit EP. I suspect they should
> be fine by now, but I've CC'd Gerd to confirm.

edk2 is ready for quite a while (years).

seabios was lagging behind for a long time, but smbios 3.0 support
finally landed early last year, in release 1.16.0 (qemu 7.0).

So, yes, firmware-wise we are ready to flip the default now.

take care,
  Gerd


