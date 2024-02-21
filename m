Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBAC85D259
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 09:16:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchlF-0005Zu-TO; Wed, 21 Feb 2024 03:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rchl6-0005Yc-GD
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rchl4-00017X-Vw
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708503313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/o2I1FJCJqhL6pg7n3b/itI/3xhGpOxXyaQMEu3UYGI=;
 b=HXa1VpZK8dClqJPRs6VtjrTKzQPZoNvcgdTDW51DTGP6Tmq98LVo2CC1++OuWD08/HiNGq
 IdfNik+Tq+NcZPddJy8keYGoR2Cxnn9LGgGSczms6eYlDho83JzKWDKAGu+pmzzAtgyS7w
 BtEyyjiAULf3BwjJzmKBIb89JxZt+Tw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-jNyBTo-WOKKi1IL5ztbk8g-1; Wed, 21 Feb 2024 03:15:09 -0500
X-MC-Unique: jNyBTo-WOKKi1IL5ztbk8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 178BC83101D;
 Wed, 21 Feb 2024 08:15:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F651C14B0C;
 Wed, 21 Feb 2024 08:15:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C6DA21E66C8; Wed, 21 Feb 2024 09:15:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Jason Wang
 <jasowang@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v6 13/15] hw/pci: Determine if rombar is explicitly enabled
In-Reply-To: <20240220-reuse-v6-13-2e42a28b0cf2@daynix.com> (Akihiko Odaki's
 message of "Tue, 20 Feb 2024 21:24:48 +0900")
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-13-2e42a28b0cf2@daynix.com>
Date: Wed, 21 Feb 2024 09:15:06 +0100
Message-ID: <871q961bed.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> vfio determines if rombar is explicitly enabled by inspecting QDict.
> Inspecting QDict is not nice because QDict is untyped and depends on the
> details on the external interface. Add an infrastructure to determine if
> rombar is explicitly enabled to hw/pci.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/pci/pci_device.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index ca151325085d..c4fdc96ef50d 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>      return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>  }
>  
> +static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
> +{
> +    return dev->rom_bar && dev->rom_bar != -1;

Compares signed with unsigned: rom_bar is uint32_t, -1 is int.

If int is at most 32 bits, the comparison converts -1 to
(uint32_t)0xffffffff.

If int is wider, it converts dev->rom_bar to int without changing its
value.  In particular, it converts the default value 0xffffffff (written
as -1 in the previous patch) to (int)0xffffffff.  Oops.

Best not to mix signed and unsigned in comparisons.  Easy enough to
avoid here.

Still, we don't actually test "rom_bar has not been set".  We test
"rom_bar has the default value".  Nothing stops a user from passing
rombar=0xffffffff to -device.  See my review of the next patch.

> +}
> +
>  static inline void pci_set_power(PCIDevice *pci_dev, bool state)
>  {
>      /*


