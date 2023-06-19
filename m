Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DA734B73
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 07:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB7oB-0005pA-Vq; Mon, 19 Jun 2023 01:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qB7oA-0005om-1c
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 01:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qB7o8-0007R0-BX
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 01:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687153926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlrjG10CZLJa3GvmOUGDn83nthNz240bNXtC2Rn7jPA=;
 b=HkbI57QZp14g2m6tsvA1no1c+1hrZnDTcr+OY/aknOGOlNvwPZTHeHkbR5IjuSiuWKXoXx
 cO+JDmaKJgpdSI19Lthr1aC8bvfZzLAOaVg5oKc9ePx4NKKyWV30hWhooN08uOfVoQdMNs
 o1QPlBwTMkJId//Ic6qpW+8JbY46oms=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-r718yv1DMUyJJxfdjW64rQ-1; Mon, 19 Jun 2023 01:52:04 -0400
X-MC-Unique: r718yv1DMUyJJxfdjW64rQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCBC638025EA;
 Mon, 19 Jun 2023 05:52:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E38EC1604C;
 Mon, 19 Jun 2023 05:52:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 733EB21E4AA0; Mon, 19 Jun 2023 07:52:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,  Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH V2 1/4] qapi: strList_from_string
References: <1675795727-235010-1-git-send-email-steven.sistare@oracle.com>
 <1675795727-235010-2-git-send-email-steven.sistare@oracle.com>
 <CAJ+F1CLFMUDvaOq2QXCKpb8Zj4PRr-tKV1q9L8m2EfgORPLj7A@mail.gmail.com>
 <32f34f74-213d-7107-907d-dda0a509878e@oracle.com>
 <87h6vwnstx.fsf@linaro.org> <87cz6j6tt0.fsf@pond.sub.org>
 <d25846e4-13fd-c683-b5e1-1660f4470d35@oracle.com>
 <875yca23dd.fsf@pond.sub.org>
 <7beaf84a-008e-c9a3-3698-2a230196acf9@oracle.com>
 <87cz6izmtz.fsf@pond.sub.org>
 <1bb65a74-d444-7601-47d3-290959239831@oracle.com>
 <87sffdvpmu.fsf@pond.sub.org>
 <555c8a46-a530-c258-8614-0485536c60ee@oracle.com>
 <87legnee48.fsf@pond.sub.org>
 <27092461-aa2c-5a0e-ea9d-3742d9284a15@oracle.com>
Date: Mon, 19 Jun 2023 07:52:02 +0200
In-Reply-To: <27092461-aa2c-5a0e-ea9d-3742d9284a15@oracle.com> (Steven
 Sistare's message of "Thu, 15 Jun 2023 17:25:21 -0400")
Message-ID: <87a5ww2e4d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 6/13/2023 8:33 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:

[...]

>>> What design principle does strList_from_string contradict?  Are you OK with 
>>> putting the simplified version shown above in qapi-util?
>> 
>> The design principle is "use JSON to encode structured data as text in
>> QAPI/QMP".
>> 
>> Do: "mumble": [1, 2, 3]
>> 
>> Don't: "mumble": "1,2,3"
>
> I don't mumble, but I sometimes mutter and ramble.

Hah!

>> We violate the principle in a couple of places.  Some are arguably
>> mistakes, some are pragmatic exceptions.
>> 
>> The principle implies "the only parser QAPI needs is the JSON parser".
>> 
>> By adding other parsers to QAPI, we send a misleading signal, namely
>> that encoding structured data in a way that requires parsing is okay.
>> It's not, generally.
>> 
>> So, I'd prefer to find another home for code that splits strings at
>> comma / delimiter.
>> 
>>> (and apologies for my long delay in continuing this conversation).
>> 
>> I'm in no position to take offense there ;)
>
> Thanks, that makes it clear.
>
> I propose to move strList_from_string and strv_from_strList to new files
> util/strList.c and include/qemu/strList.h, and leave QAPI_LIST_LENGTH in 
> include/qapi/util.h.
>
> (cutil.c already has string functions, but only uses simple C types, so
> not the best place to add the strList type).
>
> Sound OK?

Works for me.  Thanks!


