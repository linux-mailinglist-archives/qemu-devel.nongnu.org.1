Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A83E817038
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:20:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDWB-00026i-Et; Mon, 18 Dec 2023 08:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFDW9-00025p-Dh
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFDW5-0002L4-NJ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702905519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RZN3eY72QYyfVqTZz/MXuVHB6eD2KxkM3DtfhsvlX8=;
 b=GCDEJq8qUCrlpSjLjfdTlfQmyoUg6XuPRnoBoBJsdcOnTlDg8CVA7pBytQv81laV/JZeLa
 XF/iaC4Y0iezkX/yqIHfyW5dyRpJAGEG4V2/juQeVIM+Lg3MIkLvnb2ibQkEv68zQFeJ6a
 QiCwS42rNEVMKzbi68LK3uilFky1X9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-8F1CS6t4NSiR23cmxIN_3g-1; Mon,
 18 Dec 2023 08:18:36 -0500
X-MC-Unique: 8F1CS6t4NSiR23cmxIN_3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94A2D3812581;
 Mon, 18 Dec 2023 13:18:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21CCC40C6EB9;
 Mon, 18 Dec 2023 13:18:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35A1E21E6920; Mon, 18 Dec 2023 14:18:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  crosa@redhat.com,  bleal@redhat.com,
 eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 alxndr@bu.edu,  bsd@redhat.com,  stefanha@redhat.com,  thuth@redhat.com,
 darren.kenny@oracle.com,  Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v6 2/4] qmp: add dump machine type compatible properties
In-Reply-To: <63dc1069-d3e9-4fb9-b553-7ffaf7a595f4@yandex-team.ru> (Maksim
 Davydov's message of "Wed, 13 Dec 2023 17:46:12 +0300")
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-3-davydov-max@yandex-team.ru>
 <87sf4mxnem.fsf@pond.sub.org>
 <63dc1069-d3e9-4fb9-b553-7ffaf7a595f4@yandex-team.ru>
Date: Mon, 18 Dec 2023 14:18:34 +0100
Message-ID: <87o7ensl79.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
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

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> Thanks for reviewing
> Sorry for replying late
>
> On 12/1/23 12:49, Markus Armbruster wrote:
>> I apologize for the lateness of my review.
>>
>> Maksim Davydov <davydov-max@yandex-team.ru> writes:
>>
>>> To control that creating new machine type doesn't affect the previous
>>> types (their compat_props) and to check complex compat_props inheritance
>>> we need qmp command to print machine type compatible properties.
>>>
>>> This patch adds the ability to get list of all the compat_props of the
>>> corresponding supported machines for their comparison via new optional
>>> argument of "query-machines" command.
>>
>> Sounds like this is to let developers prevent unwanted change.  Such
>> testing interfaces need not and should not be stable interfaces.
>> Thoughts?
>
> I'm not sure that rightly understand your idea about unstable: do you mean
> that we can allow this interface to be not robust (e.g. compat-props in
> MachineInfo can be not presented) or that this is new thusit can be
> unstable?

It's about external interface stability: incompatible change requires
deprecation and a grace period.  See docs/about/deprecated.rst first
section.

QMP is a stable external interface, except for parts marked unstable.

In my review, I wondered whether the QMP interface you add needs to be
stable in that sense.  Does it?

If no, I'll gladly show you how to mark it unstable.

>>> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index b6d634b30d..8ca0c134a2 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json

[...]

>>>  ##
>>>  # @query-machines:
>>>  #
>>>  # Return a list of supported machines
>>>  #
>>> +# @compat-props: if true return will contain information about machine type
>>> +#                compatible properties (since 8.2)
>>
>> "compatibility properties"
>>
>> Suppressing parts of the output makes sense only if it's fairly big.
>> How much additional compat-props output do you observe?
>
> now, there are 61 machines types, so this qmp command generates a 450KB JSON

Uff.

Recommend to explain this briefly in the commit message.  Something like
"Since information on compatibility properties can increase the command
output by a factor of 40, add an argument to enable it, default off."

Does make me wonder whether we want a separate command, though.

[...]


