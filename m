Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D17DFFDB
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 09:57:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qypyu-0000cC-Cw; Fri, 03 Nov 2023 04:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qypyn-0000bv-KZ
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 04:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qypyl-0004Nn-Oo
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 04:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699001794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN527/9+Hy8nwALpaDsi4NF2Q+LpFMmagiFpfnqo7Vk=;
 b=cPKyWjNhL+1apLW5CyYRuPfk6DIvoEji9WaCYGxwJjr8tzBhkJTa8WPJQtmO4ivREWfxgS
 Yc/1rK/NuN5WKwi4TiPT1GXGiW9gkRQbJRTWuALxe/GJ1e1WGUm7o4pzW085luEg+ZOMqk
 DWB5nP2r1m2GjpQ4X9embzULRwjvR4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-WBZ6RYQ7O9qLa6QyXeJytg-1; Fri, 03 Nov 2023 04:56:31 -0400
X-MC-Unique: WBZ6RYQ7O9qLa6QyXeJytg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55D81811E7D;
 Fri,  3 Nov 2023 08:56:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6C72026D4C;
 Fri,  3 Nov 2023 08:56:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02DE421E6A1F; Fri,  3 Nov 2023 09:56:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,  =?utf-8?Q?Herv=C3=A9?= Poussineau
 <hpoussin@reactos.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v4 0/4] hw/audio/pcspk: Inline pcspk_init()
References: <20231020171509.87839-1-philmd@linaro.org>
 <D0ECDB9D-F04B-46F5-BFE6-94257FB4FF65@gmail.com>
Date: Fri, 03 Nov 2023 09:56:13 +0100
In-Reply-To: <D0ECDB9D-F04B-46F5-BFE6-94257FB4FF65@gmail.com> (Bernhard
 Beschow's message of "Sun, 22 Oct 2023 22:23:14 +0000")
Message-ID: <87cywr1ahe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Bernhard Beschow <shentey@gmail.com> writes:

> Am 20. Oktober 2023 17:15:04 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro.org>:
>>Unfortunately v2 was merged as commit 40f8214fcd,
>>so adapt v3 to clean the mess.
>>
>>Philippe Mathieu-Daud=C3=A9 (4):
>>  hw/i386/pc: Pass Error** argument to pc_basic_device_init()
>>  hw/i386/pc: Propagate error if HPET device creation failed
>>  hw/i386/pc: Propagate error if PC_SPEAKER device creation failed
>
> I'm not sure if I'd do these first three patches. The reason is that mach=
ines don't inherit from DeviceState and therefore don't have canonical meth=
ods such as realize() to propagate errors. Propagating the errors in the ma=
chine init helper methods seem a bit ad-hoc to me.

The Error interface enables separation of error detection and error
handling.  On detection, we create an Error object, and handling
consumes it.

A function that leaves error handling to its callers generally requires
its callees to leave it, too.  Use of &error_fatal is wrong then.

Even when error handling need not be left to callers, leaving it can
result in simpler or more robust code.

When a function handles errors itself, say by use of &error_fatal or
error_report(), it's only usable in contexts where this handling is
appropriate.

Sometimes the context is obvious enough, and unlikely to change.
Handling directly is fine then, and can be simpler.

When the context isn't that obvious, leaving error handling to callers
liberates you from thinking about the context, and also enables safe
reuse of the function in other contexts.

I think pc_basic_device_init() doesn't *need* the change, as it's
context is obvious enough.  But the change is fine, and if we apply it,
we never have to think about the context again.  Matter of taste.

>>  hw/isa/i82378: Propagate error if PC_SPEAKER device creation failed
>
> The reason I suggested use of `errp` here is that it is already a paramet=
er.

Use of &error_fatal in a function taking @errp is almost always wrong.
The patch fixes an instance of "wrong".


