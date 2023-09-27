Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC207AFB56
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOK6-0000mk-97; Wed, 27 Sep 2023 02:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlOJz-0000l4-TZ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlOJy-0006eq-BQ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695797212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHfWNUttDEkIkq0qYXjARtt+U1SQwB08GwRFOswqbn4=;
 b=MUQAPzHTPDo9ffENHd8ik9mKyMClfsrIxim0dGKw+bzqjgJ98lc/yFZ56ZlN9agCa5zrLt
 zTbaI+voeAVjMPoGaojeZTE+/yNfNunue3rVfisWMvWZr3n6Epfo5hEX7t4x0zV5f82YrV
 EBh3/0ro/vFcm9xFm0abgtYuBjUcqmM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-DLYaCIXSOKWAn10nNANU9A-1; Wed, 27 Sep 2023 02:46:49 -0400
X-MC-Unique: DLYaCIXSOKWAn10nNANU9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 713233814588;
 Wed, 27 Sep 2023 06:46:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F381B2026D4B;
 Wed, 27 Sep 2023 06:46:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5B1821E6900; Wed, 27 Sep 2023 08:46:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>,  Peter Maydell
 <peter.maydell@linaro.org>,  Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH 08/19] aspeed/timer: Fix behaviour running
 Linux
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-9-clg@kaod.org>
 <a4a62040-0127-4f39-4fc3-a1795e4daad8@kaod.org>
 <CACPK8XcCn4hK5Lu-6o7LUyUFVH-dkbjJ-1_fHr4_90_4cZf_+Q@mail.gmail.com>
 <bf0703cb-3626-a3e9-efda-842cd0393f37@kaod.org>
Date: Wed, 27 Sep 2023 08:46:47 +0200
In-Reply-To: <bf0703cb-3626-a3e9-efda-842cd0393f37@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 27 Sep 2023 07:44:16 +0200")
Message-ID: <87sf70f6zs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 9/27/23 04:12, Joel Stanley wrote:
>> On Fri, 22 Sept 2023 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>=20
>>>> +    t->start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>> +    return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));
>>>
>>> This MAX(MAX(x, y), 0) looks strange to me. Would you remember where it=
 comes
>>> from ? Thanks,
>> That looks very strange. I think you've sorted it, so I wanted to
>> bring up the MAX macros themselves. It's unfortunate that they create
>> a non-unique local variable. Are we allowed to borrow the kernels
>> macros? They have some infrastructure for creating a unique local
>> variable name, as well as handling the const and non-const variants
>> with the one macro.
>> https://elixir.bootlin.com/linux/v6.5/source/include/linux/minmax.h
>
> I believe that's what Markus does in its own way :
>
>   https://lore.kernel.org/qemu-devel/20230921121312.1301864-8-armbru@redh=
at.com/

I wasn't aware of the kernel's infrastructure.  We can steal it if
people think it provides additional value.  Make your case :)


