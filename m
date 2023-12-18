Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB5581675B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:28:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF81e-0003PL-Rc; Mon, 18 Dec 2023 02:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rF81c-0003Oy-NZ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rF81b-00005H-4b
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702884410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEP9cBYUupaX8fOw+ri2243FNDdUxVKWCm+ZN6/xHPU=;
 b=hg4gmtdbPp9IPdnZgDnB9WW94hL5N3Fe1xfVc2VNlhCY3iw6pu5O1vbLuH/22PDkVDQW7/
 pxBhiF7S69Y5z2S2oAur9Qps0Z7mvKvjaHmjvyVm75dvOwH6s3DRDFq9kaqyPBI4pT63mL
 9Q/rs1blBUhxfLcXtbZAXqFXVQMGONg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-EtXnlD6HM9aJ8mfvJTem4Q-1; Mon, 18 Dec 2023 02:26:45 -0500
X-MC-Unique: EtXnlD6HM9aJ8mfvJTem4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B42784AC62;
 Mon, 18 Dec 2023 07:26:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A86140C6EB9;
 Mon, 18 Dec 2023 07:26:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D43D21E6920; Mon, 18 Dec 2023 08:26:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,  qemu-arm@nongnu.org,  Leif
 Lindholm <quic_llindhol@quicinc.com>,  Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>
Subject: Re: [RFC PATCH] hw/arm: Prefer arm_feature() over
 object_property_find()
In-Reply-To: <CAFEAcA-Je+_tNCwiL_sQb-tDmCRJ2LWm5mAfuowtxbUBNEWQXQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 14 Dec 2023 17:25:36 +0000")
References: <20231214171447.44025-1-philmd@linaro.org>
 <CAFEAcA-Je+_tNCwiL_sQb-tDmCRJ2LWm5mAfuowtxbUBNEWQXQ@mail.gmail.com>
Date: Mon, 18 Dec 2023 08:26:43 +0100
Message-ID: <871qbkug24.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 14 Dec 2023 at 17:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> QOM properties are added on the ARM vCPU object when a
>> feature is present. Rather than checking the property
>> is present, check the feature.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>> RFC: If there is no objection on this patch, I can split
>>      as a per-feature series if necessary.
>>
>> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>>   "hw: Simplify accesses to CPUState::'start-powered-off' property"
>
> I'm not a super-fan of board-level code looking inside
> the QOM object with direct use of arm_feature() when
> it doesn't have to. What's wrong with asking whether
> the property exists before trying to set it?

I'm not a fan of using QOM instead of the native C interface.

The native C interface is CPUArmState method arm_feature().

Attempts to use it on anything but a CPUArmState * will be caught by the
compiler.  object_property_find() will happily take any Object.

Likewise, typos in its second argument will be caught by the compiler.
object_property_find() will happily return NULL then.


I also don't like adding QOM properties to instances.
arm_cpu_post_init() seems to do that.  I feel it's best to stick to
class properties whenever practical.

More so when management applications are expected to use them, because
introspection is much easier to use correctly when existence of
properties doesn't depend on run-time state.

Kevin's "[RFC PATCH 00/12] QOM/QAPI integration part 1" explores
QAPIfication of object configuration, loosely based on
<https://wiki.qemu.org/Features/QOM-QAPI_integration>.  A QOM class's
instance configuration interface becomes compile-time static.


