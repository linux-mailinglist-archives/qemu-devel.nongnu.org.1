Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7037DFF96
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 09:05:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyp9l-0002ak-MF; Fri, 03 Nov 2023 04:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyp9h-0002Z1-RN
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyp9f-00050Y-Bt
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 04:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698998626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nClG9ccEZC0QF2L/MnX2qNfu1EoY9WKuPBTKGbzovao=;
 b=BnBjO6sSH+PjheQr25aKzyDJlOFihiiil5cCkh0qYe4UYCJtwmgrK4eSqgU0ETkhR/intW
 DLaAzfXpheIL16yiglif8HaCQ5XW1jcvKupqJJMDt/nQ6hGL0Ja5U+qdQGrlt30kZ5nAOC
 51y99QaI6XAeAZsmkvDBOQFMNeNrPgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-2uUoRCSRNcW0t7XyM7aNVw-1; Fri, 03 Nov 2023 04:03:42 -0400
X-MC-Unique: 2uUoRCSRNcW0t7XyM7aNVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E24AB83B865;
 Fri,  3 Nov 2023 08:03:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A327EC1290F;
 Fri,  3 Nov 2023 08:03:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADD0221E6A1F; Fri,  3 Nov 2023 09:03:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Luc
 Michel <luc.michel@amd.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,  qemu-ppc@nongnu.org,  "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>,  "Daniel P . Berrange"
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 5/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-6-philmd@linaro.org>
Date: Fri, 03 Nov 2023 09:03:40 +0100
In-Reply-To: <20231030143957.82988-6-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 30 Oct 2023 15:39:56
 +0100")
Message-ID: <87wmuz1cwz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Devices should avoid calling qemu_get_cpu() because this call
> doesn't work as expected with heterogeneous machines. Such
> devices often iterate over a cluster of CPUs, which the device's
> parent has direct access (when creating the child device).
>
> We can pass QOM as 'link' between objects, but we can't pass an
> array of links. Here we exploits QAPI simplicity, by using

Do you mean qdev simplicity?

> DEFINE_PROP_ARRAY and a list of strings, each string being the
> CPU canonical path in QOM tree (which is constant and unique).
> When the device realizes itself, the original CPU pointer is
> recovered via a object_resolve_path() call.

We have link properties, see DEFINE_PROP_LINK() and qdev_prop_link.
Would an array of link properties be feasible here?

> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Inspired-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Tested with:
> $ make check-qtest-ppc{,64}
> $ make check-avocado AVOCADO_TAGS=3D'machine:ppce500 machine:mpc8544ds'
>
> RFC: See cover
>
> FIXME: Should we free spin_cpu_list using g_autoptr(QList)?


