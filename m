Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5DD999246
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 21:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syynl-0006Ca-RE; Thu, 10 Oct 2024 15:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syyni-0006Bz-Da
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syyng-00074r-12
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728588374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G66ghszLfd+abNzfICJT4sKSzh8mKB9ii1tvPnXtU+g=;
 b=fLTb5tKy8yvI8hLrPCuVaIyQaPFbN/n3C8buX8X9RLQjcz3otGoUHJeQK5gP3MobS/kHAa
 AeQu2kwqxWJ2PZzPqDTnjH+RZq1JMCKx2EDY8mzzLx1VqBjU+dh7Jw+mOQaQUugcsvmbWV
 LAcMsnFoKdzKhwELY6eU4A2XE5sFBzw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-xj0pqK2LNBipIaWIwG31_g-1; Thu,
 10 Oct 2024 15:26:08 -0400
X-MC-Unique: xj0pqK2LNBipIaWIwG31_g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F5819560A3; Thu, 10 Oct 2024 19:26:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158AA19560A2; Thu, 10 Oct 2024 19:26:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 561CC21E6A28; Thu, 10 Oct 2024 21:25:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  xieyongji@bytedance.com,  kwolf@redhat.com,
 hreitz@redhat.com,  Coiby.Xu@gmail.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,
 mark.cave-ayland@ilande.co.uk,  michael.roth@amd.com,
 kkostiuk@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 5/7] target/i386/cpu: Improve errors for out of
 bounds property values
In-Reply-To: <eed14342-3b79-450c-a617-533d3256a241@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 10 Oct 2024 14:38:15
 -0300")
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-6-armbru@redhat.com>
 <eed14342-3b79-450c-a617-533d3256a241@linaro.org>
Date: Thu, 10 Oct 2024 21:25:57 +0200
Message-ID: <878quvg3p6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 10/10/24 12:01, Markus Armbruster wrote:
>> The error message for a "stepping" value that is out of bounds is a
>> bit odd:
>>      $ qemu-system-x86_64 -cpu qemu64,stepping=3D16
>>      qemu-system-x86_64: can't apply global qemu64-x86_64-cpu.stepping=
=3D16: Property .stepping doesn't take value 16 (minimum: 0, maximum: 15)
>> The "can't apply global" part is an unfortunate artifact of -cpu's
>> implementation.  Left for another day.
>> The remainder feels overly verbose.  Change it to
>>      qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=3D=
16: parameter 'stepping' can be at most 15
>> Likewise for "family", "model", and "tsc-frequency".
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   target/i386/cpu.c | 20 +++++++++-----------
>>   1 file changed, 9 insertions(+), 11 deletions(-)
>
>
>> @@ -5623,16 +5622,15 @@ static void x86_cpuid_set_tsc_freq(Object *obj, =
Visitor *v, const char *name,
>>                                      void *opaque, Error **errp)
>>   {
>>       X86CPU *cpu =3D X86_CPU(obj);
>> -    const int64_t min =3D 0;
>>       const int64_t max =3D INT64_MAX;
>>       int64_t value;
>>         if (!visit_type_int(v, name, &value, errp)) {
>>           return;
>>       }
>> -    if (value < min || value > max) {
>> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
>> -                   name ? name : "null", value, min, max);
>> +    if (value < 0 || value > max) {
>> +        error_setg(errp, "parameter '%s' can be at most %" PRId64,
>> +                   name ? name : "null", max);
>
> Confusing:
>
>     qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=3D-1=
: parameter 'stepping' can be at most 15

For better or worse, visit_type_uint64() with the string input visitor
parses -1 modulo 2^64, i.e. as 2^64-1, just like strtoul() & friends.

>>           return;
>>       }
>>=20=20=20


