Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4587E061E
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:03:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywdE-00050Q-06; Fri, 03 Nov 2023 12:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qywdA-0004yw-Fn
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qywd8-0004Ui-Sw
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699027360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jY6IfPiXv0DVgUjALsMmduOCXb+/KMBs6lBjj+WKis=;
 b=Rz6sp5Iqp8ZZftujA2g816TGHhUwpEr9sxAVvnI8ZL2JaNgUH3DFBQ6vf9Icf3lWSj2aDb
 HEH8EJ6mvYYdTXf/WCrIsMIRhb2QS1oveieZ4XyJAqnfH7K5n0/r+BMbuBLqNKXGXN5LpE
 4h/qnnX609KCEZvacirQ80uuvXKWWZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-u8skFhkjPOW3GptXZb3-gA-1; Fri, 03 Nov 2023 12:02:36 -0400
X-MC-Unique: u8skFhkjPOW3GptXZb3-gA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C71FC84EBC5;
 Fri,  3 Nov 2023 16:02:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A19232166B27;
 Fri,  3 Nov 2023 16:02:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B16A821E6A1F; Fri,  3 Nov 2023 17:02:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, michael.roth@amd.com
Subject: Re: [PATCH 1/1] sphinx/qapidoc: Tidy up pylint warning
 raise-missing-from
References: <20231025092159.1782638-1-armbru@redhat.com>
 <20231025092159.1782638-2-armbru@redhat.com>
 <CAFn=p-Y58FTVshF_y99bTOXJNRaec=_rGnJGrEtcRBMZbPq2LA@mail.gmail.com>
 <CAFEAcA8KaWXTinOLFitnYuTnqz2yXmgYdyUzE6FVFMvwwbLucA@mail.gmail.com>
Date: Fri, 03 Nov 2023 17:02:34 +0100
In-Reply-To: <CAFEAcA8KaWXTinOLFitnYuTnqz2yXmgYdyUzE6FVFMvwwbLucA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 3 Nov 2023 10:31:27 +0000")
Message-ID: <878r7en7tx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 3 Nov 2023 at 03:08, John Snow <jsnow@redhat.com> wrote:
>>
>> On Wed, Oct 25, 2023 at 6:10=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > Pylint advises:
>> >
>> >     docs/sphinx/qapidoc.py:518:12: W0707: Consider explicitly re-raisi=
ng using 'raise ExtensionError(str(err)) from err' (raise-missing-from)
>> >
>> > From its manual:
>> >
>> >     Python's exception chaining shows the traceback of the current
>> >     exception, but also of the original exception.  When you raise a
>> >     new exception after another exception was caught it's likely that
>> >     the second exception is a friendly re-wrapping of the first
>> >     exception.  In such cases `raise from` provides a better link
>> >     between the two tracebacks in the final error.
>> >
>> > Makes sense, so do it.
>> >
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> In this case it probably doesn't make a difference because Sphinx has
>> its own formatting for displaying the errors, but it's good hygiene.
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>
> Has somebody checked that the error Sphinx shows to the user
> is still the friendly one? The only reason to raise
> this error is so that Sphinx will catch it and display
> the friendly string, so anything about tracebacks is a red
> herring -- if the traceback is shown to the user then we got
> something wrong.

The exception type doesn't change, only the backtrace stored within the
exception.  Can't see how its catching could be affected.

To be sure, stick a '} at the beginning of qapi-schema.json and run
sphinx-build.  Result:

    Extension error:
    /work/armbru/qemu/docs/../qapi/qapi-schema.json:1:1: expected '{', '[',=
 string, or boolean

Satisfied?


