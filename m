Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4257F26BF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:56:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LcA-0005Ae-Vj; Tue, 21 Nov 2023 02:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5Lby-000532-DE
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5Lbw-0005Xk-KY
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700553355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kyFoBKqDExKcjDhTGC+rhAwI1vFJGKiebjHY64SKyE=;
 b=bRljKD7rxP00ELutkoPHzMcYoqnsf7H4i9jlVkiwENlK+91fZSrrc/d2WUFofD6n9vaT7i
 wM6a+6Fmfy496bEgqzv0UB7dp/uGbq1CRU1Zkbjpz5t16TWOx/5ydZ+kczOgNjfdY1muJh
 FnHOFBffiQ6XF7PuyqDTyG1K3uI62a0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-JQwfGbqdMOyZBjmT6ZdBqA-1; Tue, 21 Nov 2023 02:55:51 -0500
X-MC-Unique: JQwfGbqdMOyZBjmT6ZdBqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14DAE80346A;
 Tue, 21 Nov 2023 07:55:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E47FE1C060AE;
 Tue, 21 Nov 2023 07:55:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBC5E21E6A1F; Tue, 21 Nov 2023 08:55:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,  qemu-arm@nongnu.org
Subject: Re: [PATCH-for-8.2?] hw/arm/fsl-imx: Do not ignore Error argument
References: <20231120115116.76858-1-philmd@linaro.org>
 <CAFEAcA-YRPL_UOu5JPwfY4yRU=USk678JayDjqL=DKQjv+SWWw@mail.gmail.com>
 <87y1ermx1b.fsf@pond.sub.org>
Date: Tue, 21 Nov 2023 08:55:49 +0100
In-Reply-To: <87y1ermx1b.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 21 Nov 2023 07:37:52 +0100")
Message-ID: <87zfz7leuy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Mon, 20 Nov 2023 at 11:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
>>>
>>> Both i.MX25 and i.MX6 SoC models ignore the Error argument when
>>> setting the PHY number. Pick &error_abort which is the error
>>> used by the i.MX7 SoC (see commit 1f7197deb0 "ability to change
>>> the FEC PHY on i.MX7 processor").
>>>
>>> Fixes: 74c1330582 ("ability to change the FEC PHY on i.MX25 processor")
>>> Fixes: a9c167a3c4 ("ability to change the FEC PHY on i.MX6 processor")
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>
>>
>>
>> Applied to target-arm.next, thanks.
>
> With or without my commit message clarification?

Uh-oh, I had mail trouble.  Resending stuck messages.


