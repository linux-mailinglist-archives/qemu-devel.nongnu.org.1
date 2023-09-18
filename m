Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0DE7A465F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAuL-0001UW-9L; Mon, 18 Sep 2023 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiAuB-0001UI-0V
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiAu9-0001wS-FI
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695030652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5w0PgAMMTVvPZScCGsoz2w2yhU6dWkWIJ2VLogmmuk4=;
 b=ciF/44Lvv0s/RL0moRx5KE2jGyBWZHrFN5bwq3tFHYRaLOCbd8nN1Spdmldedv2U2WQBJE
 dIOQVqw9Wz4WxfJHdubkznzOaidBFpCYIbUxud0bwI0rlYycxtYLLEPQZlATtM1WemAQuw
 iH8Bd/poXWjrufB0Cwj8LhsdFZ5X/24=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-kHYy5-HmNI2nnY-MQ_gznw-1; Mon, 18 Sep 2023 05:50:50 -0400
X-MC-Unique: kHYy5-HmNI2nnY-MQ_gznw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D34A811E7D
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:50:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FAB2C154CA;
 Mon, 18 Sep 2023 09:50:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BF54C18007A1; Mon, 18 Sep 2023 11:50:48 +0200 (CEST)
Date: Mon, 18 Sep 2023 11:50:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 2/3] seabios: turn off CONFIG_APMBIOS for 128k build
Message-ID: <oukf6qzukn5fdu3indrx3fuytkwl4aj7pncipmnchexcg6ffte@ewnnijlr4oab>
References: <20230912105359.563101-1-kraxel@redhat.com>
 <20230912105359.563101-3-kraxel@redhat.com>
 <5c35d3f5-91ab-4340-0363-04494bb6881b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c35d3f5-91ab-4340-0363-04494bb6881b@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Tue, Sep 12, 2023 at 03:55:03PM +0200, Paolo Bonzini wrote:
> On 9/12/23 12:53, Gerd Hoffmann wrote:
> > Needed to make the build fit into 128k.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   roms/config.seabios-128k | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
> > index d18c802c46e9..bc3ba7f65bcd 100644
> > --- a/roms/config.seabios-128k
> > +++ b/roms/config.seabios-128k
> > @@ -19,3 +19,4 @@ CONFIG_USE_SMM=n
> >   CONFIG_VGAHOOKS=n
> >   CONFIG_HOST_BIOS_GEOMETRY=n
> >   CONFIG_ACPI_PARSE=n
> > +CONFIG_APMBIOS=n
> 
> Why don't we instead drop ``pc-i440fx-1.4`` up to ``pc-i440fx-1.7``, which
> have been deprecated since 7.0?  We cannot get rid of the 128k ROM because
> isapc uses it, but we can remove PCI and ACPI from it, and solve the size
> problem once and for all.

I happily update the seabios config once the old machine types are gone.

take care,
  Gerd


