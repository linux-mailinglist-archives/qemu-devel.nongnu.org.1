Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE18C4377
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 16:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WwR-0005Rd-7S; Mon, 13 May 2024 10:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WwL-0005PN-6v
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WwJ-00058L-El
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715611566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7B6uW/K4CC2aj8nx9xsHycuC/FZfiEUIdiRypxV4QtI=;
 b=aMlV5ja1uG7TTvTN+zM6ODDJkF1eRRWxfKpq5WmIiZ85auxP4EjAPZlbQOXTTG8Swpc0HW
 C8A4DDMs3+fV7oF6vZ/yK4QbnqboAPvOpXvrFbIDLhWJ6BlRrpH5PjgbQdG35NnNHD4Hku
 YExgGAtiU4VAlmlkJTqJXUn3hnebseI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-AC0rdW47N9Wkn8UhDJ0iGA-1; Mon, 13 May 2024 10:46:00 -0400
X-MC-Unique: AC0rdW47N9Wkn8UhDJ0iGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 603CC812296;
 Mon, 13 May 2024 14:45:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FB0249B523;
 Mon, 13 May 2024 14:45:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F38F21E5E5A; Mon, 13 May 2024 16:45:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  fam@euphon.net,  kwolf@redhat.com,
 hreitz@redhat.com,  marcandre.lureau@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 4/6] cpus: Improve error messages on memsave, pmemsave
 write error
In-Reply-To: <5ad42c0c-abd0-4fce-8204-9effa4765ab8@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 May 2024 16:27:49
 +0200")
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-5-armbru@redhat.com>
 <5ad42c0c-abd0-4fce-8204-9effa4765ab8@linaro.org>
Date: Mon, 13 May 2024 16:45:58 +0200
Message-ID: <87r0e56a8p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

> On 13/5/24 16:17, Markus Armbruster wrote:
>> qmp_memsave() and qmp_pmemsave() report fwrite() error as
>>      An IO error has occurred
>> Improve this to
>>      writing memory to '<filename>' failed
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   system/cpus.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> diff --git a/system/cpus.c b/system/cpus.c
>> index 68d161d96b..f8fa78f33d 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -813,7 +813,8 @@ void qmp_memsave(int64_t addr, int64_t size, const c=
har *filename,
>>               goto exit;
>>           }
>>           if (fwrite(buf, 1, l, f) !=3D l) {
>> -            error_setg(errp, QERR_IO_ERROR);
>> +            error_setg(errp, "writing memory to '%s' failed",
>> +                       filename);
>>               goto exit;
>>           }
>>           addr +=3D l;
>> @@ -843,7 +844,8 @@ void qmp_pmemsave(int64_t addr, int64_t size, const =
char *filename,
>>               l =3D size;
>>           cpu_physical_memory_read(addr, buf, l);
>>           if (fwrite(buf, 1, l, f) !=3D l) {
>> -            error_setg(errp, QERR_IO_ERROR);
>> +            error_setg(errp, "writing memory to '%s' failed",
>> +                       filename);
>
> What about including errno with error_setg_errno()?

Sure fwrite() fails with errno reliably set?  The manual page doesn't
mention it...


>>               goto exit;
>>           }
>>           addr +=3D l;


