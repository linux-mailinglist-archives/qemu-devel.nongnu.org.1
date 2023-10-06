Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F717BB409
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:14:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoguo-0003Ns-LF; Fri, 06 Oct 2023 05:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoguV-0003KH-7t
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoguS-0002kE-31
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696583651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfiRntaWMnCOId7f4El5EjDpb+AXj0XbLR8toYX0tq4=;
 b=eKoGL98uQ1rbU7TDGixWr3TpbNI5NswfNUeYjp2VeTFUYYwpPrhgFzarMtLh8pSrBBO0Pp
 5cFZHbFXfSh5AJXrt0Y/t8by15Y+KjKea9RYJeQLkN3OQqq+ZGVYh+DrNOvx3yKAiLXglV
 UEYMGzAKPPlWggUHq43Q4Y9EOo/y3g4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-Qmh8fgh6PUu-8VFPjdhsuA-1; Fri, 06 Oct 2023 05:14:08 -0400
X-MC-Unique: Qmh8fgh6PUu-8VFPjdhsuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 810203C23FCC;
 Fri,  6 Oct 2023 09:14:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ECDEC15BB8;
 Fri,  6 Oct 2023 09:14:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5233B21E6904; Fri,  6 Oct 2023 11:14:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 13/16] semihosting/arm-compat: Clean up local
 variable shadowing
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-14-philmd@linaro.org>
 <87h6n6h93v.fsf@linaro.org>
Date: Fri, 06 Oct 2023 11:14:06 +0200
In-Reply-To: <87h6n6h93v.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 04 Oct 2023 13:19:13 +0100")
Message-ID: <878r8gp0yp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> Fix:
>>
>>   semihosting/arm-compat-semi.c: In function =E2=80=98do_common_semihost=
ing=E2=80=99:
>>   semihosting/arm-compat-semi.c:379:13: warning: declaration of =E2=80=
=98ret=E2=80=99 shadows a previous local [-Wshadow=3Dlocal]
>>     379 |         int ret, err =3D 0;
>>         |             ^~~
>>   semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is he=
re
>>     370 |     uint32_t ret;
>>         |              ^~~
>>   semihosting/arm-compat-semi.c:682:27: warning: declaration of =E2=80=
=98ret=E2=80=99
>> shadows a previous local [-Wshadow=3Dlocal]
>>     682 |                 abi_ulong ret;
>>         |                           ^~~
>>   semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
>>     370 |     int ret;
>>         |         ^~~
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  semihosting/arm-compat-semi.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi=
.c
>> index 564fe17f75..0033a1e018 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -367,7 +367,6 @@ void do_common_semihosting(CPUState *cs)
>>      target_ulong ul_ret;
>>      char * s;
>>      int nr;
>> -    uint32_t ret;
>>      int64_t elapsed;
>>=20=20
>>      nr =3D common_semi_arg(cs, 0) & 0xffffffffU;
>> @@ -725,6 +724,9 @@ void do_common_semihosting(CPUState *cs)
>>=20=20
>>      case TARGET_SYS_EXIT:
>>      case TARGET_SYS_EXIT_EXTENDED:
>> +    {
>> +        uint32_t ret;
>> +
>
> I suspect this could just as well be an int with an explicit cast for ret=
 =3D arg1
> because the consumers are all expecting int anyway.
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Philippe, would you like to follow up on Alex's suspicion, or would you
like me to queue the patch as is?


