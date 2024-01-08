Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1108826E2F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:36:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoqA-0008DY-3j; Mon, 08 Jan 2024 07:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMoq6-0008CS-3z
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMoq3-0003xx-5r
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704717281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJxmxAScyvhTcm/ebk3qt2FehYaTMJcsAp7R41TQZRo=;
 b=TO7jSZxOsT+1vcmb2TOSQAyr2vSLpH5vm0t+vSbrvf73QDnZbS+Q01AkfkEimdU7xG5a4T
 7O6DBsnA1weU02mYX+VeF/UHds9+vMOFQaNbh45EVvFQtDvJbfsyhsl8jk0nRLoaMT3j3E
 jMQlMIlaqd6G/BCArpkca/CCcj2KmG8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-q76f6NCXNV2LywH_Qy06EQ-1; Mon,
 08 Jan 2024 07:34:34 -0500
X-MC-Unique: q76f6NCXNV2LywH_Qy06EQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2968C1C2B660;
 Mon,  8 Jan 2024 12:34:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 080885190;
 Mon,  8 Jan 2024 12:34:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A267821E6682; Mon,  8 Jan 2024 13:34:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Avihai Horon <avihaih@nvidia.com>,  qemu-devel@nongnu.org,  Juan
 Quintela <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 09/11] migration: Fix migration_channel_read_peek()
 error path
In-Reply-To: <dafc11b4-3f56-4c22-b776-a8f644b2ad26@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 2 Jan 2024 11:05:56
 +0100")
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-10-avihaih@nvidia.com>
 <dafc11b4-3f56-4c22-b776-a8f644b2ad26@linaro.org>
Date: Mon, 08 Jan 2024 13:34:31 +0100
Message-ID: <87edest354.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> +Markus
>
> On 31/12/23 10:30, Avihai Horon wrote:
>> migration_channel_read_peek() calls qio_channel_readv_full() and handles
>> both cases of return value =3D=3D 0 and return value < 0 the same way, by
>> calling error_setg() with errp. However, if return value < 0, errp is
>> already set, so calling error_setg() with errp will lead to an assert.
>
> I suppose the API would be safer by passing &len as argument and
> return a boolean.

Doubtful, unless I'm misunderstanding something.

Function comment:

 * Returns: the number of bytes read, or -1 on error,
 * or QIO_CHANNEL_ERR_BLOCK if no data is available
 * and the channel is non-blocking

I understand this as:

* Success case: return #bytes read

* Error case: return -1, @errp is set

* Would block case: return QIO_CHANNEL_ERR_BLOCK

A zero return value must be the success case.  I figure this can happen
only at EOF.  A caller might need to treat unexpected EOF as an error.

>> Fix it by handling these cases separately, calling error_setg() with
>> errp only in return value =3D=3D 0 case.
>> Fixes: 6720c2b32725 ("migration: check magic value for deciding the mapp=
ing of channels")
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/channel.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>> diff --git a/migration/channel.c b/migration/channel.c
>> index ca3319a309..f9de064f3b 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -117,9 +117,12 @@ int migration_channel_read_peek(QIOChannel *ioc,
>>          len =3D qio_channel_readv_full(ioc, &iov, 1, NULL, NULL,
>>                                       QIO_CHANNEL_READ_FLAG_MSG_PEEK, er=
rp);
>> -        if (len <=3D 0 && len !=3D QIO_CHANNEL_ERR_BLOCK) {
>> -            error_setg(errp,
>> -                       "Failed to peek at channel");
>> +        if (len < 0 && len !=3D QIO_CHANNEL_ERR_BLOCK) {
>> +            return -1;
>> +        }
>> +
>> +        if (len =3D=3D 0) {
>> +            error_setg(errp, "Failed to peek at channel");
>>              return -1;
>>           }
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


