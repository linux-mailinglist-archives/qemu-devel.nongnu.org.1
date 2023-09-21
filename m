Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCF37A9642
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjN8i-0008Fb-Rb; Thu, 21 Sep 2023 13:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qjN8g-0008Cl-0J
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qjN8e-0001uk-Ak
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695316011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vuewaxkneoMvmnITYc+3CWIJP8tGf6MQIW+T+ugcSIg=;
 b=ckEGlu0r9P9CkKBY4KVU4Y2fDOeJKNN6xaXvZoHa+fz+Wrg9kLuCfWARjeTpPa/XdWoY3+
 0mBZuvM6bhCGnt4aMBSJ3OULabtEp1/zYpav1fDjJR1effvf732i4p8JhB+T3Vwrox2pJz
 gi4xd641FzHFNTkpFvPug3u64dxQ8AY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-h9uQZoElO96vzicoUlhcZg-1; Thu, 21 Sep 2023 13:06:47 -0400
X-MC-Unique: h9uQZoElO96vzicoUlhcZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 908303C0F370;
 Thu, 21 Sep 2023 17:06:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F4820268D6;
 Thu, 21 Sep 2023 17:06:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2345D18007AA; Thu, 21 Sep 2023 19:06:45 +0200 (CEST)
Date: Thu, 21 Sep 2023 19:06:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, devel@edk2.groups.io, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, 
 Sami Mujawar <sami.mujawar@arm.com>
Subject: Re: EDK2 ArmVirtQemu behaviour with multiple UARTs
Message-ID: <qd54ldsiclno5gzl2heyefx3bso6leq7v3tjsjipszxkeqdlvb@yjzar5rrmlov>
References: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
 <b7wuvs5qtdvjzb5getkggsi772gqvmb4xnuhq4ssxdu5lgiyi7@nprpol5z2t5u>
 <CAFEAcA8LMmWTEJB3jsUEn_pPnUDanWgdUurFu=vRRFxn4X8S2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8LMmWTEJB3jsUEn_pPnUDanWgdUurFu=vRRFxn4X8S2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 21, 2023 at 04:34:27PM +0100, Peter Maydell wrote:
> As long as EDK2 does something sensible when the DTB says "two
> UARTs here and here" and it also finds a virtio-serial PCI
> device, I don't mind what exactly it does. The problem here is
> more that EDK2 currently does strange things when told that
> the hardware is present, rather than that anybody specifically wants
> EDK2 to use multiple serial outputs.
> 
> Though given there's no way to say in the DTB "use a PCI card
> for your console" I think the virtio-serial approach is likely
> to be awkward for users in practice.

edk2 adds a virtio console to the edk2 console multiplexer if
present (for both pci and mmio virtio transports), and systemd
spawns also spawns a getty on /dev/hvc0 if present.  So this
works mostly automatic.  Only if you also want the linux boot
messages show up there too you need to add 'console=hvc0' to
your kernel command line.

take care,
  Gerd


