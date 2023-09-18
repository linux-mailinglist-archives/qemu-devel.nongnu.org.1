Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC57A4AAC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEUo-0008Gr-RW; Mon, 18 Sep 2023 09:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiEUg-00087P-2h
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiEUd-0006OG-MW
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695044449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2shTjAbrGkbTUoQ4Jw2Gb/pz709/OKweba+ZxI0XiZA=;
 b=M7K2Tzm8ZAd6tXOt+UDosS8fkaBwCsc/f3ws6ZvbuQbqN9Cq7DXbgZY4QS8kKdw2skpfOa
 DzvYcIv/VVLIdhwXt/Y4oPZKyR/Bu1hC8Dv+PFG6DNMRVi2djF7/cyBuNX5ZSOrj5iX0sq
 X5F6Vm6dAPfJOI64DStLFNX9qQe94hE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-fVN-UIM4NdazwTTu9fXBsw-1; Mon, 18 Sep 2023 09:40:48 -0400
X-MC-Unique: fVN-UIM4NdazwTTu9fXBsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB3AA945920;
 Mon, 18 Sep 2023 13:40:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 812721005E27;
 Mon, 18 Sep 2023 13:40:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5867618007A1; Mon, 18 Sep 2023 15:40:46 +0200 (CEST)
Date: Mon, 18 Sep 2023 15:40:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] Firmware/seabios 20230912 patches
Message-ID: <dmo2b2bkzf57duhozdszpupt3o66fghhbwl6dppqgbaki4jk2r@ohyboxrmwq6i>
References: <20230912105359.563101-1-kraxel@redhat.com>
 <CAJSP0QX23UNOTCRsiHZWSa1j9KGA229S84+k7nNiDyp-AkNCFg@mail.gmail.com>
 <d7zwpgvdosd7ron3odscmwfqq5cwibyqi2drkjv22z5m5nzn3r@ltokhlip4ztv>
 <CAJSP0QU4EocB1FaAwwcUS9aZShXb5nr+ME1LEqe=Gujn39h-Lw@mail.gmail.com>
 <ZQhLI0EzYFbXv9sW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhLI0EzYFbXv9sW@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

  Hi,

> > I'm still seeing a CI failure:
> > 
> > 3/61 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test ERROR
> > 19.18s killed by signal 6 SIGABRT
           ^^^^^^^^^^^^^^^^^^^^^^^^^^

> Hmm, that's rather unhelpful - we need to get iasl added to the build
> env by default.

That is a good idea in general but unlikely to help in this specific case.

> > https://gitlab.com/qemu-project/qemu/-/jobs/5110608123
> 
> Note this is a aarch64 macOS environment

Which explains why I don't see this on my x86 fedora workstation ...

take care,
  Gerd


