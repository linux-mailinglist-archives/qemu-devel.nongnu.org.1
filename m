Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60D7EBD64
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:14:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A6L-0001Ue-SF; Wed, 15 Nov 2023 02:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3A62-0001Ox-Ux
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3A61-0001AX-Is
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700032437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KZcCyZ7DYFN96iW0pf73fVMxiHfkj1Q4aPot78Zwco=;
 b=LSEx0X8MGH/Uzx3MLM3i5RvEwPMNbAYPouXpbCQZqZ0N2b8+lc2yv6pFpm6uxd6+JpFgHE
 YdnrlJwH21dfCB4kD35QmGbcPaOP/s1sS2lIad6/BCTfCWbEMRXr4PoYSEQQicHhReUEpX
 0aWnm+ZQRF/lIMi3NuSKPp+CUNddSGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-60GkYaErMOyY3JI6Pb1SQw-1; Wed, 15 Nov 2023 02:13:54 -0500
X-MC-Unique: 60GkYaErMOyY3JI6Pb1SQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E81A82A62E;
 Wed, 15 Nov 2023 07:13:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10D30492BE8;
 Wed, 15 Nov 2023 07:13:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04E8721E6A1F; Wed, 15 Nov 2023 08:13:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  npiggin@gmail.com,  danielhb413@gmail.com,
 clg@kaod.org,  david@gibson.dropbear.id.au,  harshpb@linux.ibm.com,
 dave@treblig.org,  jasowang@redhat.com,  michael.roth@amd.com,
 kkostiuk@redhat.com,  mst@redhat.com,  david@redhat.com,
 kraxel@redhat.com,  marcandre.lureau@redhat.com,  qemu-ppc@nongnu.org
Subject: Re: [PATCH 7/7] target/i386/cpu: Improve error message for property
 "vendor"
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-8-armbru@redhat.com>
 <d2c8e554-3bdf-e89d-c579-c9a432e8e08f@linaro.org>
Date: Wed, 15 Nov 2023 08:13:52 +0100
In-Reply-To: <d2c8e554-3bdf-e89d-c579-c9a432e8e08f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 31 Oct 2023 15:07:00
 +0100")
Message-ID: <87bkbvtrnz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 31/10/23 12:10, Markus Armbruster wrote:
>> Improve
>>      $ qemu-system-x86_64 -device max-x86_64-cpu,vendor=3Dme
>>      qemu-system-x86_64: -device max-x86_64-cpu,vendor=3Dme: Property '.=
vendor' doesn't take value 'me'
>> to
>>      qemu-system-x86_64: -device max-x86_64-cpu,vendor=3D0123456789abc: =
value of property 'vendor' must consist of excactly 12 characters
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   target/i386/cpu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index fc8484cb5e..e708628c16 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -5192,7 +5192,8 @@ static void x86_cpuid_set_vendor(Object *obj, cons=
t char *value,
>>       int i;
>>         if (strlen(value) !=3D CPUID_VENDOR_SZ) {
>> -        error_setg(errp, QERR_PROPERTY_VALUE_BAD, "", "vendor", value);
>> +        error_setg(errp, "value of property 'vendor' must consist of"
>> +                   " excactly " stringify(CPUID_VENDOR_SZ) " characters=
");
>
> Typo "exactly" (and in example), otherwise:

Fixed.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>>           return;
>>       }
>>=20=20=20

Thanks!


