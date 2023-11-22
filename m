Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F57F4677
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:42:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mXE-0000JI-3c; Wed, 22 Nov 2023 07:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r5mXA-0000Ie-8w
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r5mX8-0003Rt-JB
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700656845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gg1ZEULb1vRoVeanS+LDtyVvE1sc4/LWxzfgoUr2qdw=;
 b=d7TCxXvwouPxnxLXQeaMRDxPeF18S0q80l8HWtCJ2b+UQqJW4+4sc65Nq/UCDfHPHPcyfp
 bAzQ2K4degRJPoM8/MCcxe3ttlcUpjHlw3/Bi+4RxRQVzCALPfmWhIgbDsxmMlroZxNErl
 MrEqckLY1dTzQksVLD/M7+ZExiGTsJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-3wExUe4_N8mn2_RWycu0nw-1; Wed, 22 Nov 2023 07:40:42 -0500
X-MC-Unique: 3wExUe4_N8mn2_RWycu0nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6F7D80513E;
 Wed, 22 Nov 2023 12:40:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB09E1C060AE;
 Wed, 22 Nov 2023 12:40:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3378D1800DD8; Wed, 22 Nov 2023 13:40:40 +0100 (CET)
Date: Wed, 22 Nov 2023 13:40:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <graf@amazon.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 mimoja@mimoja.de
Subject: Re: [PATCH 00/16] hw/uefi: add uefi variable service
Message-ID: <hjthgmi2wgaamejnla4sifvzaftz53txmwvfa3rcfh2gld55h2@qiyemv2j6djr>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <9db15906-9474-4a6e-82a9-5275c72cf2b4@amazon.com>
 <nxzed5dhgjpn3fafjttocvxe6ztxxf5xhghaqncpdxup6y7o7y@47i3eyoehio2>
 <7bfb52e6-3698-7c44-5927-31d47d031d57@redhat.com>
 <ZVzV6Au_FYK6Rav6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzV6Au_FYK6Rav6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> One option I've illustrated before is that have SVSM (or equiv)
> expose an encrypted storage service to EDK2. Given the proposed EDK2
> side protocol/modifications for variable storage, I wonder if it is
> viable for SVSM (or equiv) to replace QEMU in providing the backend
> storage impl ?  IOW, host QEMU would expose a pflash to the guest,
> to which SVSM would apply full disk encryption, and then store the
> EFI variables in it

Yes.  IIRC (it's been a while I've looked at the spec) the SVSM can
request that access to specific pages trap, so it could use that to 
emulate the mmio/sysbus variant of the device.  Not sure if that could
work for io/isa too.  Another option would be to add a third interface
variant which uses SVSM service calls.

And one advantage of a rust implementation would be that integrating
with coconut-svsm (which is written in rust too) might be easier.  On
the other hand the SVSM is a very different environment, the rust stdlib
is not available for example, and the way persistence is implemented
will probably look very different too.  Another difference is crypto
support, qemu uses nettle / gnutls whereas svsm will probably use
openssl.  So not sure how big the opportunity to share the code between
qemu and svsm on the backend side actually is.

take care,
  Gerd


