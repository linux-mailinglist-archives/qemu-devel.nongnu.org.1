Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4307BDA3F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:47:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoit-00040J-Ou; Mon, 09 Oct 2023 07:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpoiU-0003oq-7p
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpoiS-0003lq-SH
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696851987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2jsKEKqZJG4LgL+yiUjMVkBDFOSa2RDSJm4MD8k5Jk=;
 b=ifb6UduoTkRFAtkwiX0OAoA5dqV+EPdsi1waI9LmuuiNj2Bz362vERSGLkZfLKaXA48Jau
 hgd99kBSy5TV0e/Gb7tlq5aQVFlJ7jnnvCWEuikVuVvZOeykMsT7pHw7zcM1lM89xa/cKY
 Vu41fPFOsTlt/syviGgJPJ91j+937hE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-66dTgu8QPUWp3Y7T7eTWZw-1; Mon, 09 Oct 2023 07:46:23 -0400
X-MC-Unique: 66dTgu8QPUWp3Y7T7eTWZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A42E7802C1A;
 Mon,  9 Oct 2023 11:46:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83AA6140EBB7;
 Mon,  9 Oct 2023 11:46:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7441921E6904; Mon,  9 Oct 2023 13:46:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com
Subject: Re: [PATCH] qapi: Belatedly update CompatPolicy documentation for
 unstable
References: <20231009110449.4015601-1-armbru@redhat.com>
 <78921033-d8f5-d736-0437-b805e78c1a55@linaro.org>
Date: Mon, 09 Oct 2023 13:46:22 +0200
In-Reply-To: <78921033-d8f5-d736-0437-b805e78c1a55@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 9 Oct 2023 13:19:06
 +0200")
Message-ID: <875y3g10j5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On 9/10/23 13:04, Markus Armbruster wrote:
>> Commit 57df0dff1a1 (qapi: Extend -compat to set policy for unstable
>> interfaces) neglected to update the "Limitation" paragraph to mention
>
> With retrospective, 'experimental' seems more meaningful. Anyway,
> too  late.

Experiments are a major use for interfaces without stability promise,
but there's also debugging aids and such.

>> feature 'unstable' in addition to feature 'deprecated'.  Do that now.
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/compat.json | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/qapi/compat.json b/qapi/compat.json
>> index f4c19837eb..42034d9368 100644
>> --- a/qapi/compat.json
>> +++ b/qapi/compat.json
>> @@ -43,8 +43,8 @@
>>   # This is intended for testing users of the management interfaces.
>>   #
>>   # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
>> -# with feature 'deprecated'.  We may want to extend it to cover
>> -# semantic aspects and CLI.
>> +# with feature 'deprecated' or 'unstable'.  We may want to extend it
>> +# to cover semantic aspects and CLI.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!


