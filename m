Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289337D0105
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXDu-0007fV-5P; Thu, 19 Oct 2023 13:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtXDo-0007aD-Pf
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtXDn-0000dJ-2s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697738049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eeoJ3zPFxxPWkKP2Sqv/oPPlXYoE0sCE5sqS7Clfpco=;
 b=cgQjQ1q25CQjn0dbTSb+l8YLW3Uz6YdKZb/uZ3Nel0/Y095G/Am4N7ipMKX7m01x3MhYoJ
 QmSiW+ZkbC0YvbzKMsI3iJzGG7UcSFKKp+OXS3HFER/vKTrUkwkCAktGZjJpaXi4XdqIja
 pcxaemw8am5eE2ApTDbjBNbkCbQCNZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-B6eZOKxxN--VpUYP55bGNg-1; Thu, 19 Oct 2023 13:54:06 -0400
X-MC-Unique: B6eZOKxxN--VpUYP55bGNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A0E98E6D06;
 Thu, 19 Oct 2023 17:54:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B87F492BFC;
 Thu, 19 Oct 2023 17:54:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4348821E6A1F; Thu, 19 Oct 2023 19:54:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Gerd
 Hoffmann <kraxel@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2] hw/audio/pcspk: Inline pcspk_init()
References: <20231019073307.99608-1-philmd@linaro.org>
 <C044C8A9-952A-4F9A-8B9F-DE689A5FEF46@gmail.com>
Date: Thu, 19 Oct 2023 19:54:04 +0200
In-Reply-To: <C044C8A9-952A-4F9A-8B9F-DE689A5FEF46@gmail.com> (Bernhard
 Beschow's message of "Thu, 19 Oct 2023 10:23:14 +0000")
Message-ID: <87ttqmcxc3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Bernhard Beschow <shentey@gmail.com> writes:

> Am 19. Oktober 2023 07:33:07 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro.org>:
>>pcspk_init() is a legacy init function, inline and remove it.
>>
>>Since the device is realized using &error_fatal, use the same
>>error for setting the "pit" link.
>>
>>Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

[...]

>>diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>index 63e0857208..79ffbb52a0 100644
>>--- a/hw/isa/i82378.c
>>+++ b/hw/isa/i82378.c
>>@@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>     uint8_t *pci_conf;
>>     ISABus *isabus;
>>     ISADevice *pit;
>>+    ISADevice *pcspk;
>>=20
>>     pci_conf =3D pci->config;
>>     pci_set_word(pci_conf + PCI_COMMAND,
>>@@ -102,7 +103,9 @@ static void i82378_realize(PCIDevice *pci, Error **er=
rp)
>>     pit =3D i8254_pit_init(isabus, 0x40, 0, NULL);
>>=20
>>     /* speaker */
>>-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
>>+    pcspk =3D isa_new(TYPE_PC_SPEAKER);
>>+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_f=
atal);
>>+    isa_realize_and_unref(pcspk, isabus, &error_fatal);
>
> Why not pass errp here? I think that was Mark's comment in v1.

&error_fatal is almost always wrong in a function that takes Error **.
Happy to explain in more detail if needed.

[...]


