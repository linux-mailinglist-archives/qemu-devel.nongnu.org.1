Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 726B87AB090
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeHh-0001cd-PC; Fri, 22 Sep 2023 07:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjeHa-0001aL-69
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjeHX-0004Yv-Ad
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695381909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBb0sEY3RxPWOrkbIzp1tag74MTM76cM28qYTRJpEXg=;
 b=ex6csOmlO3nK8whIwfqRSVFb/cMCPDAJrk2iOEtc0mIO7axezHmyuoQx5nhwW+KRj2s3DB
 DUBcj7rdHBEqcjhnTjGRaKZD2fSzJxYnNGkYm7Ew2fvIR49I8VnGQw/q1BRSaNzHsco5zH
 xXsn2/f8zCXSQPOp23CuOfhmtSQMdlI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-Mkt5BKcJNMaC1zY2VKJZwg-1; Fri, 22 Sep 2023 07:25:05 -0400
X-MC-Unique: Mkt5BKcJNMaC1zY2VKJZwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 044413C147E4;
 Fri, 22 Sep 2023 11:25:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F8D3711282;
 Fri, 22 Sep 2023 11:25:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BAC521E6900; Fri, 22 Sep 2023 13:25:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>,
 Alberto Garcia <berto@igalia.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Andrew Jeffery <andrew@aj.id.au>,  Brian Cain
 <bcain@quicinc.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  "Daniel P. Berrange"
 <berrange@redhat.com>,  David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,  Eric Auger
 <eric.auger@redhat.com>,  Eric Blake <eblake@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Fan Ni <fan.ni@samsung.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Joel Stanley <joel@jms.id.au>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Keith Busch <kbusch@kernel.org>,  Klaus
 Jensen <its@irrelevant.dk>,  Laurent Vivier <laurent@vivier.eu>,  Laurent
 Vivier <lvivier@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Peter
 Xu <peterx@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,  Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Xiaojuan Yang
 <yangxiaojuan@loongson.cn>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: Help wanted for enabling -Wshadow=local
References: <87r0mqlf9x.fsf@pond.sub.org>
 <5255ABB8-8D1D-4AF4-9015-84573056973C@redhat.com>
 <20230922063552-mutt-send-email-mst@kernel.org>
Date: Fri, 22 Sep 2023 13:25:01 +0200
In-Reply-To: <20230922063552-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Fri, 22 Sep 2023 06:36:19 -0400")
Message-ID: <878r8yh2lu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Sep 22, 2023 at 04:03:27PM +0530, Ani Sinha wrote:
>> 
>> 
>> > On 22-Sep-2023, at 3:07 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> > 
>> > Devices
>> > -------
>> > ACPI/SMBIOS
>> > M: Michael S. Tsirkin <mst@redhat.com>
>> > M: Igor Mammedov <imammedo@redhat.com>
>> > R: Ani Sinha <anisinha@redhat.com>
>> >    hw/acpi/cpu_hotplug.c
>> >    hw/i386/acpi-build.c(*3*)
>> >    hw/smbios/smbios.c
>> 
>> I will look into this after enabling
>> 
>> diff --git a/meson.build b/meson.build
>> index 98e68ef0b1..9fc4c7ac9d 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -466,6 +466,9 @@ warn_flags = [
>>    '-Wno-tautological-type-limit-compare',
>>    '-Wno-psabi',
>>    '-Wno-gnu-variable-sized-type-not-at-end',
>> +  '-Wshadow=local',
>> +  '-Wno-error=shadow=local',
>> +  '-Wno-error=shadow=compatible-local',
>>  ]
>
>
> Am I right that one can equivalently do
> ./configure --disable-werror --extra-cflags='-Wshadow=local -Wno-error=shadow=local -Wno-error=shadow=compatible-local'
> ?

Should do, although the --disable-werror is redundant with the
-Wno-error=...


