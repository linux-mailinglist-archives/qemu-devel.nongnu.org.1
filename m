Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1627DC60F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 06:44:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxhYB-0007Ip-Ay; Tue, 31 Oct 2023 01:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxhY8-0007Gi-O2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 01:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxhY7-0005N7-59
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 01:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698731061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEc/VG1vFbrKMpF9uEuSmxa8Fyz9lwsX90QYG8d2GUs=;
 b=a6e5szUF9GPMxvonuaa+3Bewbq3a1sQ+uZ3QSoji1MTERhrXbphJk8gJNXlt8CcFx7dsWN
 Q368b/Q9orPlxO9oLy0wPh2/F1SWfgknYaWkNT9eh++0VmuvkP4Nk8JJuk+It+Qbj4beIY
 DWixG5bid4cUSXG3Y058hERG9FUAI/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Jbb0keevP4uDx8SZg2D8zg-1; Tue, 31 Oct 2023 01:44:18 -0400
X-MC-Unique: Jbb0keevP4uDx8SZg2D8zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2401C185A780;
 Tue, 31 Oct 2023 05:44:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94CBD1121306;
 Tue, 31 Oct 2023 05:44:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EAB1821E6A1F; Tue, 31 Oct 2023 06:44:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com
Subject: Re: [PATCH 4/5] dump: Improve some dump-guest-memory error messages
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-5-armbru@redhat.com>
 <473f2bd5-ebd4-00be-b8dd-c046505da9d8@linaro.org>
Date: Tue, 31 Oct 2023 06:44:16 +0100
In-Reply-To: <473f2bd5-ebd4-00be-b8dd-c046505da9d8@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 30 Oct 2023 15:05:57
 +0100")
Message-ID: <87edhbmjm7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi Markus,
>
> On 30/10/23 14:37, Markus Armbruster wrote:
>> Zero @length is rejected with "Invalid parameter 'length'".  Improve
>> to "Parameter 'length' expects a non-zero length".
>>
>> @protocol values not starting with "fd:" or "file:" are rejected with
>> "Invalid parameter 'protocol'".  Improve to "parameter 'protocol' must
>> start with 'file:' or 'fd:'".
>>
>> While there, make the conditional checking @protocol a little more
>> obvious.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   dump/dump.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>> diff --git a/dump/dump.c b/dump/dump.c
>> index a5e9a06ef1..d888e4bd3c 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -1812,7 +1812,8 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
>>         s->fd =3D fd;
>>       if (has_filter && !length) {
>> -        error_setg(errp, QERR_INVALID_PARAMETER, "length");
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "length",
>
> Per commit 4629ed1e98 ("qerror: Finally unused, clean up", 2015):
>
>  /*
>   * These macros will go away, please don't use in new code, ...
>
> Instead we can use:
>
>            error_setg(errp, "Parameter '%s' expects %s", "length",

I left this to the next version of your "qapi: Kill 'qapi/qmp/qerror.h'
for good" out of laziness.  Since you prefer the deed to be done right
away, I will in v2.

>> +                   "a non-zero size");
>>           goto cleanup;
>>       }


