Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA087B1D38
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqeq-0005Az-8Q; Thu, 28 Sep 2023 09:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqeb-0004o8-CK
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqeY-00029S-Af
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695906120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFBJeQropeRJ1+MFEcUErkDO7v9yLkLjSDp67kIIMIk=;
 b=J7LeNCW7GhzN9wg4pBWs8XZM0//8NE60FwmaGIOEgY1C2QGYt7zs2tsdFR0NvWSeywsJyH
 gM1r2U7oqDLJ/bdBHBj2ti38Zuz3TGjFoMGMuFfy7RLGINW45fGOTN8OOpoGBq92CQwiQh
 MO9mLA37o2UNzqMzZOpRYhppPRd+v/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-4xBJ8JNIMpa0GnKa8eltGQ-1; Thu, 28 Sep 2023 09:01:57 -0400
X-MC-Unique: 4xBJ8JNIMpa0GnKa8eltGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E56B101A53B;
 Thu, 28 Sep 2023 13:01:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8A02026D4B;
 Thu, 28 Sep 2023 13:01:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF11321E6900; Thu, 28 Sep 2023 15:01:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 mkletzan@redhat.com,  vr_qemu@t-online.de
Subject: Re: [PATCH 02/13] audio: Require AudioState in AUD_add_capture
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-3-pbonzini@redhat.com>
 <af692de9-1bde-6af1-2d10-c6398d489673@eik.bme.hu>
Date: Thu, 28 Sep 2023 15:01:55 +0200
In-Reply-To: <af692de9-1bde-6af1-2d10-c6398d489673@eik.bme.hu> (BALATON
 Zoltan's message of "Sat, 23 Sep 2023 13:48:54 +0200 (CEST)")
Message-ID: <87pm221mf0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Sat, 23 Sep 2023, Paolo Bonzini wrote:
>> From: Martin Kletzander <mkletzan@redhat.com>
>>
>> Since all callers require a valid audiodev this function can now safely
>> abort in case of missing AudioState.
>>
>> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
>> Message-ID: <c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> audio/audio.c | 7 +++----
>> 1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index 90c7c49d116..42bfa330146 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -1876,10 +1876,9 @@ CaptureVoiceOut *AUD_add_capture(
>>     struct capture_callback *cb;
>>
>>     if (!s) {
>> -        if (!legacy_config) {
>> -            dolog("Capturing without setting an audiodev is deprecated\n");
>> -        }
>> -        s = audio_init(NULL, NULL);
>> +        error_setg(&error_abort,
>> +                   "Capturing without setting an audiodev is not supported");
>> +        abort();
>
> This looks suspicious to me but I don't know if you can do this. Probably Markus can advise. I would use error_report and abort() or error_setg if you have an errp then return but this func doesn't seem to have errp.

Missed this until now; my apologies.

qapi/error.h:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
 * Likewise, don't error_setg(&error_abort, ...), use assert().


