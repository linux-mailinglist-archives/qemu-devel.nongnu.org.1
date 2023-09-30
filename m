Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986877B3F83
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 10:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmVXQ-0000AZ-OQ; Sat, 30 Sep 2023 04:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qmVXN-00008Y-EA
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 04:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qmVXL-0002qT-1K
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 04:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696063277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPNAWASY28nscpOpv89e+0lLojCyI9o7i75x2vcQH/I=;
 b=Jjq4bJKqSuwkAdBpewicA0kc0tk7qW3QICLq7U27wJSIMvPTqU+4EaCjxZymopA69MLyAM
 J7QRo4DhKjg8rTrMPwEm4jn7DAitlwVvwMnl/jLSdDc29fJzY6HMQNGZQ0xh5xijHieLkS
 NRxoW5uaBUEG4Xm+33jCQR9lp1nG08k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-OTOzssVZPzK-hShM25KF4g-1; Sat, 30 Sep 2023 04:41:13 -0400
X-MC-Unique: OTOzssVZPzK-hShM25KF4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67D083801EDE;
 Sat, 30 Sep 2023 08:41:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29AAA1005B96;
 Sat, 30 Sep 2023 08:41:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 187C121E6904; Sat, 30 Sep 2023 10:41:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  imammedo@redhat.com
Subject: Re: [PULL 38/56] hw/acpi: changes towards enabling -Wshadow=local
References: <20230929085053.2789105-1-armbru@redhat.com>
 <20230929085053.2789105-39-armbru@redhat.com>
 <8DAED4FD-46E5-461B-90C0-E14A3F83B137@redhat.com>
Date: Sat, 30 Sep 2023 10:41:12 +0200
In-Reply-To: <8DAED4FD-46E5-461B-90C0-E14A3F83B137@redhat.com> (Ani Sinha's
 message of "Sat, 30 Sep 2023 09:24:49 +0530")
Message-ID: <87zg142guv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ani Sinha <anisinha@redhat.com> writes:

>> On 29-Sep-2023, at 2:20 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> From: Ani Sinha <anisinha@redhat.com>
>>=20
>> Code changes in acpi that addresses all compiler complaints coming from =
enabling
>> -Wshadow flags. Enabling -Wshadow catches cases of local variables shado=
wing
>> other local variables or parameters. These makes the code confusing and/=
or adds
>> bugs that are difficult to catch.  See also
>>=20
>>    Subject: Help wanted for enabling -Wshadow=3Dlocal
>>    Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>>    https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
>>=20
>> The code is tested to build with and without the flag turned on.
>>=20
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Philippe Mathieu-Daude <philmd@linaro.org>
>> CC: mst@redhat.com
>> CC: imammedo@redhat.com
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> [Commit message tweaked]
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks!
> Are you not going to pick up "hw/i386: changes towards enabling -Wshadow=
=3Dlocal=E2=80=9D ?

Your conversation with Michael looked unfinished to me, so I didn't
include your patch in my pull request.  I did add it to shadow-next.


