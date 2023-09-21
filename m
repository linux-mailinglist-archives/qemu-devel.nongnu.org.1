Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBCE7A94DE
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:39:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJsm-0006VD-OK; Thu, 21 Sep 2023 09:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJsk-0006Tt-Ol
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJsj-0000xi-81
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695303492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I+FZ1HLn1enArtG6hbpwub79OeJ+adjJG7s+VPyKwac=;
 b=PK8HbV9P5vI6NSNrtdrDmWhgiXjTVQ1MQQIj5+SRdzJGEaRYecQLPPeWcwwZtVLKZ4ednv
 TGnDbQDdA+GM2CeFb/7EvYGG1sJh6RWLWRy8eFzdOfpTqdP0dXVHeL0fuyYkRUxu1ijNci
 CE0na4WB7Lznimtex+TeCn5+iLZRr/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-caWjci2_PU2vrCR-xOsTNg-1; Thu, 21 Sep 2023 07:23:51 -0400
X-MC-Unique: caWjci2_PU2vrCR-xOsTNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D80101A550;
 Thu, 21 Sep 2023 11:23:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF48D71128D;
 Thu, 21 Sep 2023 11:23:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D40E621E6900; Thu, 21 Sep 2023 13:23:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  hreitz@redhat.com,  eblake@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  idryomov@gmail.com,
 pl@kamp.de,  sw@weilnetz.de,  sstabellini@kernel.org,
 anthony.perard@citrix.com,  paul@xen.org,  pbonzini@redhat.com,
 marcandre.lureau@redhat.com,  berrange@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  stefanha@redhat.com,  fam@euphon.net,
 quintela@redhat.com,  peterx@redhat.com,  leobras@redhat.com,
 kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 7/7] qobject atomics osdep: Make a few macros more
 hygienic
References: <20230920183149.1105333-1-armbru@redhat.com>
 <20230920183149.1105333-8-armbru@redhat.com>
 <ZQwCEW4SBpI9f1Yx@redhat.com>
Date: Thu, 21 Sep 2023 13:23:48 +0200
In-Reply-To: <ZQwCEW4SBpI9f1Yx@redhat.com> (Kevin Wolf's message of "Thu, 21
 Sep 2023 10:42:57 +0200")
Message-ID: <87sf776a7v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 20.09.2023 um 20:31 hat Markus Armbruster geschrieben:

[...]

>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index 9003b71fd3..d36cc97805 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -45,10 +45,17 @@ struct QObject {
>>      struct QObjectBase_ base;
>>  };
>>  
>> -#define QOBJECT(obj) ({                                         \
>> +/*
>> + * Preprocessory sorcery ahead: use a different identifier for the
>> + * local variable in each expansion, so we can nest macro calls
>> + * without shadowing variables.
>> + */
>> +#define QOBJECT_INTERNAL(obj, _obj) ({                          \
>>      typeof(obj) _obj = (obj);                                   \
>> -    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
>> +    _obj                                                        \
>> +        ? container_of(&(_obj)->base, QObject, base) : NULL;    \
>
> What happened here? The code in this line (or now two lines) seems to be
> unchanged apart from a strange looking newline.

Accident, will fix, thanks!

>>  })
>> +#define QOBJECT(obj) QOBJECT_INTERNAL((obj), MAKE_IDENTFIER(_obj))
>
> Kevin


