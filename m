Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8207AB392
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjh6X-0001sn-HL; Fri, 22 Sep 2023 10:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjh6D-0001rH-E6
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjh6B-0003gG-17
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695392737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZJaJO09DDoslawxeSDUkultBT0JJOS8aIhHOOAgAnk=;
 b=UU/PtLkIHFrnYbGVr3h0h0mR/C6bt69a5dLMaCmbwRYlYH4mqBgXXWZQkSRI7Aiy6Xs/lm
 2vgN9JBF7eXffcj7WQOzr3nXj18zQ2XUupQuCEBiAlX2wqu4NPlZzstwZhXzKBk1Esfxe1
 V5iJv4qEKZxtOjjIxEWl8gDYUkfI2C4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-WLjKiNqwPDmqqXBnHLP_Kg-1; Fri, 22 Sep 2023 10:25:35 -0400
X-MC-Unique: WLjKiNqwPDmqqXBnHLP_Kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D9285A5A8;
 Fri, 22 Sep 2023 14:25:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EFBA40C2064;
 Fri, 22 Sep 2023 14:25:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A5B521E6900; Fri, 22 Sep 2023 16:25:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  peter.maydell@linaro.org,  pbonzini@redhat.com
Subject: Re: [PATCH 01/11] qdev: Add qdev_prop_set_array()
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-2-kwolf@redhat.com>
 <53c2cf8d-28ba-c866-876b-126714045ea6@linaro.org>
Date: Fri, 22 Sep 2023 16:25:34 +0200
In-Reply-To: <53c2cf8d-28ba-c866-876b-126714045ea6@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 11 Sep 2023 22:54:35
 +0200")
Message-ID: <87r0mqs2sh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 8/9/23 16:36, Kevin Wolf wrote:
>> Instead of exposing the ugly hack of how we represent arrays in qdev (a
>> static "foo-len" property and after it is set, dynamically created
>> "foo[i]" properties) to boards, add an interface that allows setting the
>> whole array at once.
>> Once all internal users of devices with array properties have been
>> converted to use this function, we can change the implementation to move
>> away from this hack.
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   include/hw/qdev-properties.h |  3 +++
>>   hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>
>
>> +void qdev_prop_set_array(DeviceState *dev, const char *name, QList *val=
ues)
>> +{
>> +    const QListEntry *entry;
>> +    g_autofree char *prop_len =3D g_strdup_printf("len-%s", name);
>> +    uint32_t i =3D 0;
>
> "unsigned"? Anyway,

Yes, or even plain int.  It all gets replaced in the last patch, though.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>> +
>> +    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
>> +                            &error_abort);
>> +
>> +    QLIST_FOREACH_ENTRY(values, entry) {
>> +        g_autofree char *prop_idx =3D g_strdup_printf("%s[%u]", name, i=
);
>> +        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
>> +                                    &error_abort);
>> +        i++;
>> +    }
>> +
>> +    qobject_unref(values);
>> +}


