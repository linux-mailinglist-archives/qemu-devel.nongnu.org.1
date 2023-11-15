Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF67EC0FA
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:54:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3DWB-0002CK-Ml; Wed, 15 Nov 2023 05:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3DVw-0001u2-DU
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3DVu-0003Pc-AX
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700045571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sz68DnduqL/6BAmwTwh8YmaOBs3Cel4pc5c0/QA69FY=;
 b=hYAFgDVYTQr2AMxYNvAG5+h93RGCt2MWWPJbWFogHyIzWTdCxulPSzAPrtyfeVlh/xDpK7
 RLhgphTz27fsjfxykf0VrhNZOUuywgdGOlit1qIHJl4PBHAHpTFBOG7YX/hqVEhzCqYrH5
 YazSoFhdSiOrvwTlzxlJq2pO4SMmwcY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-17L_fWQaN8SiEbW3ScJpoQ-1; Wed,
 15 Nov 2023 05:52:50 -0500
X-MC-Unique: 17L_fWQaN8SiEbW3ScJpoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4E6D28B72EF;
 Wed, 15 Nov 2023 10:52:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB34C2166B27;
 Wed, 15 Nov 2023 10:52:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7A5E6180AC06; Wed, 15 Nov 2023 11:52:48 +0100 (CET)
Date: Wed, 15 Nov 2023 11:52:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
Subject: Re: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
Message-ID: <6gdtym4ezmtdbxk5bstbg4qwh7enp3cqdeq4c4p74jv72kj2qw@j2gu6hkrlx3j>
References: <20231113073239.270591-1-vivek.kasireddy@intel.com>
 <794ccd1e-a308-382f-dab7-438e2f62b8b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794ccd1e-a308-382f-dab7-438e2f62b8b4@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> > +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
> > +        phys_bits = iommu_phys_bits;
> > +        if (!warned2) {
> > +            warn_report("Using physical bits (%u)"
> > +                        " to prevent VFIO mapping failures",
> > +                        iommu_phys_bits);
> > +            warned2 = true;
> > +        }
> > +    }
> > +
> >      return phys_bits;
> >  }
 
> - As I (may have) mentioned in my OVMF comments, I'm unsure if narrowing
> the VCPU "phys address bits" property due to host IOMMU limitations is a
> good design. To me it feels like hacking one piece of information into
> another (unrelated) piece of information. It vaguely makes me think
> we're going to regret this later. But I don't have any specific, current
> counter-argument, admittedly.

It boils down to:

  (a) do MIN(cpu-phys-bits,iommu-phys-bits) in qemu (this patch)

or

  (b1) communicate iommu-phys-bits to the guest firmware
  (b2) do MIN(cpu-phys-bits,iommu-phys-bits) in the guest.

We certainly had cases cases in the past where taking shortcuts in the
design to simplify things caused problems later on.  So variant (a)
leaves the somewhat ugly feeling that we might regret this some day.

On the other hand switching from (a) to (b) at some point in the future
(should the need arise) shouldn't be much different from doing (b) now.
And the whole phys-bits situation is already messy enough even without
a new iommu-phys-bits setting for the firmware.

So, all in all I think I'm fine with taking this approach.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


