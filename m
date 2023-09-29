Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C895B7B2C37
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6kp-0000Es-0N; Fri, 29 Sep 2023 02:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6km-0000DY-Nd
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6kk-0001t8-V7
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695968010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxxI8AI74cEd4XTgmsvmoUMzwm/Unn6LrI+5bn/2boo=;
 b=V52P7jnK2j9okPBkisQsFxADZxVjsUKBCMyQh/syIHilL0FpnEIRGHnYFMjUTlL+5tCWJl
 uNzz8QLyaU3yPWiBL0qhopBqkhG6+6jU4uld7fpPcnUJVWmbtD/Kkv4omfXLghxHxqdPRr
 WV9SFa3qRW6bk+AjYDjKAp/5zJvOR6s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-4eWAKwiAOYikScHuogXbHA-1; Fri, 29 Sep 2023 02:13:25 -0400
X-MC-Unique: 4eWAKwiAOYikScHuogXbHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 201FA29AA3B6;
 Fri, 29 Sep 2023 06:13:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED8E4492B16;
 Fri, 29 Sep 2023 06:13:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0509621E6904; Fri, 29 Sep 2023 08:13:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
References: <20230922124203.127110-1-anisinha@redhat.com>
 <87msx5jztb.fsf@pond.sub.org>
 <5A625074-8DE2-4B58-8B7D-C7FA578F6688@redhat.com>
Date: Fri, 29 Sep 2023 08:13:24 +0200
In-Reply-To: <5A625074-8DE2-4B58-8B7D-C7FA578F6688@redhat.com> (Ani Sinha's
 message of "Fri, 29 Sep 2023 11:24:19 +0530")
Message-ID: <87r0mhik1n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

>> On 29-Sep-2023, at 11:17 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> 
>> Ani Sinha <anisinha@redhat.com> writes:
>> 
>>> Code changes in acpi that addresses all compiler complaints coming from enabling
>>> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
>>> other local variables or parameters. These makes the code confusing and/or adds
>>> bugs that are difficult to catch.
>>> 
>>> The code is tested to build with and without the flag turned on.
>>> 
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> CC: Philippe Mathieu-Daude <philmd@linaro.org>
>>> CC: mst@redhat.com
>>> CC: imammedo@redhat.com
>>> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>> 
>> This is my "Help wanted for enabling -Wshadow=local" post.
>
> Yes indeed. I wanted to refer to that thread for context in the commit log.

I appreciate your diligence.  We just don't have an established tag
convention for "see also" references to e-mail.  I could append

    See also

        Subject: Help wanted for enabling -Wshadow=local
        Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
        https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org

to your first paragraph.  Want me to?

>> A commit's Message-Id tag is supposed to point to the patch submission
>> e-mail, and git-am will add that:
>> 
>>  Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
>> 
>> We'll have two Message-IDs then.  Confusing.
>> 
>> Could perhaps use
>> 
>>  See-also: Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>> 
>> but I doubt it's worth the bother.
>
> OK
>
>> 
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> 
>> Queued less the extra Message-Id, thanks!


