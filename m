Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59875EAC5
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 07:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNnvI-0003Il-CN; Mon, 24 Jul 2023 01:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNnvF-0003II-FO
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 01:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNnvD-00008c-Un
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 01:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690175750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6xiCOl41Ds0qX99F+cdWzeqEDUypjNm9ydWF3mUBU4=;
 b=OMUKncMZOpWCRK74xIlyVikp4i//EqckbvhfNwvqyvS6znPbhl6PysrfHlnuFRGQIilchh
 DThtV+URHehRZvGld1sccTOthnz2Gewojbvrl3dCH8alAw5dCBUvCCeaOlQoTf5F7oiHpe
 WW/r+ZYWcbTGRycCgbDQ2UMx3NxEWYs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-AWcEGP4FN6-Oen2FjdWWJA-1; Mon, 24 Jul 2023 01:15:46 -0400
X-MC-Unique: AWcEGP4FN6-Oen2FjdWWJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E6E12A59578;
 Mon, 24 Jul 2023 05:15:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA282200BA73;
 Mon, 24 Jul 2023 05:15:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CEFD21E692E; Mon, 24 Jul 2023 07:15:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>,  Joel Stanley <joel@jms.id.au>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Herv=C3=A9?= Poussineau
 <hpoussin@reactos.org>
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <7089eb6c-3b1f-278e-01d7-073e8bc516fe@linaro.org>
 <CAFEAcA_xWsNOROQqeLcuPX2XLOjbwKdEA75WcKn2qdTAHdVBGg@mail.gmail.com>
Date: Mon, 24 Jul 2023 07:15:44 +0200
In-Reply-To: <CAFEAcA_xWsNOROQqeLcuPX2XLOjbwKdEA75WcKn2qdTAHdVBGg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 21 Jul 2023 10:45:07 +0100")
Message-ID: <87wmypx533.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> On Fri, 21 Jul 2023 at 10:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> +Markus
>>
>> On 20/7/23 17:58, Peter Maydell wrote:
>> > This patchset was prompted by a couple of Coverity warnings
>> > (CID 1507157, 1517772) which note that in the m48t59 RTC device model
>> > we keep an offset in a time_t variable but then truncate it by
>> > passing it to qemu_get_timedate(), which currently uses an 'int'
>> > argument for its offset parameter.
>> >
>> > We can fix the Coverity complaint by making qemu_get_timedate()
>> > take a time_t; we should also correspondingly make the
>> > qemu_timedate_diff() function return a time_t. However this
>> > will only push the issue out to callers of qemu_timedate_diff()
>> > if they are putting the result in a 32-bit variable or doing
>> > 32-bit arithmetic on it.
>> >
>> > Luckily there aren't that many callers of qemu_timedate_diff()
>> > and most of them already use either time_t or int64_t for the
>> > calculations they do on its return value. The first three
>> > patches fix devices which weren't doing that; patch four then
>> > fixes the rtc.c functions. If I missed any callsites in devices
>> > then hopefully Coverity will point them out.
>>
>> Do we need to change the type of the RTC_CHANGE event?

[...]

> If I understand the 'Built-in Types' section in
> docs/devel/qapi-code-gen.rst correctly, the QAPI 'int'
> type is already 64 bits.

Correct.  Also needlessly confusing.


