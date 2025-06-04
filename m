Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C30ACDA6C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 11:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMjxi-0000fR-J5; Wed, 04 Jun 2025 04:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMjxT-0000dg-BK
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMjxP-0002qg-Nb
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749027525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VP+qAzAl2Xg+sNyJ5AWfAphb/2D0+ijnaiIfXMV8SKo=;
 b=Gl66yEQLguodUQ9UCIPr6As2nRwXuyQ8T0U6BbBcb0btlqVWVBpryF2SK2bpqNNOfha5MR
 SGyTDbcagsG3JrAZ55OCXnPmeHYj++Cd6beHGMbKgEkUVvL+9V0X5PLf3bicnTxzfdqaVd
 r5HDIVjjiPQOhgiQqPIo4WtPFWPMdtI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-1xvVmxUkNL2aorVUXExJLQ-1; Wed,
 04 Jun 2025 04:58:44 -0400
X-MC-Unique: 1xvVmxUkNL2aorVUXExJLQ-1
X-Mimecast-MFC-AGG-ID: 1xvVmxUkNL2aorVUXExJLQ_1749027521
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C14161801A2D; Wed,  4 Jun 2025 08:58:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33E1C19560A3; Wed,  4 Jun 2025 08:58:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD4B921E6757; Wed, 04 Jun 2025 10:58:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  qemu-devel@nongnu.org,  Thomas
 Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  "Michael
 S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
In-Reply-To: <aD_yhelX-w4Vdm8Z@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 4 Jun 2025 08:15:47 +0100")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <87a56o1154.fsf@pond.sub.org> <aD_yhelX-w4Vdm8Z@redhat.com>
Date: Wed, 04 Jun 2025 10:58:38 +0200
Message-ID: <87frgfyjb5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>=20
>> > On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  >> +
>> >> +The increasing prevalence of AI code generators, most notably but no=
t limited
>> >
>> > More detail is needed on what an "AI code generator" is. Coding
>> > assistant tools range from autocompletion to linters to automatic code
>> > generators. In addition there are other AI-related tools like ChatGPT
>> > or Gemini as a chatbot that can people use like Stackoverflow or an
>> > API documentation summarizer.
>> >
>> > I think the intent is to say: do not put code that comes from _any_ AI
>> > tool into QEMU.
>> >
>> > It would be okay to use AI to research APIs, algorithms, brainstorm
>> > ideas, debug the code, analyze the code, etc but the actual code
>> > changes must not be generated by AI.
>
> The scope of the policy is around contributions we receive as
> patches with SoB. Researching / brainstorming / analysis etc
> are not contribution activities, so not covered by the policy
> IMHO.

Yes.  More below.

>> The existing text is about "AI code generators".  However, the "most
>> notably LLMs" that follows it could lead readers to believe it's about
>> more than just code generation, because LLMs are in fact used for more.
>> I figure this is your concern.
>>=20
>> We could instead start wide, then narrow the focus to code generation.
>> Here's my try:
>>=20
>>   The increasing prevalence of AI-assisted software development results
>>   in a number of difficult legal questions and risks for software
>>   projects, including QEMU.  Of particular concern is code generated by
>>   `Large Language Models
>>   <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
>
> Documentation we maintain has the same concerns as code.
> So I'd suggest to substitute 'code' with 'code / content'.

Makes sense, thanks!

>> If we want to mention uses of AI we consider okay, I'd do so further
>> down, to not distract from the main point here.  Perhaps:
>>=20
>>   The QEMU project thus requires that contributors refrain from using AI=
 code
>>   generators on patches intended to be submitted to the project, and will
>>   decline any contribution if use of AI is either known or suspected.
>>=20
>>   This policy does not apply to other uses of AI, such as researching AP=
Is or
>>   algorithms, static analysis, or debugging.
>>=20
>>   Examples of tools impacted by this policy includes both GitHub's CoPil=
ot,
>>   OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are=
 less
>>   well known.
>>=20
>> The paragraph in the middle is new, the other two are unchanged.
>>=20
>> Thoughts?
>
> IMHO its redundant, as the policy is expressly around contribution of
> code/content, and those activities as not contribution related, so
> outside the scope already.

The very first paragraph in this file already set the scope: "provenance
of patch submissions [...] to the project", so you have a point here.
But does repeating the scope here hurt or help?

>> >> +to, `Large Language Models <https://en.wikipedia.org/wiki/Large_lang=
uage_model>`__
>> >> +(LLMs) results in a number of difficult legal questions and risks fo=
r software
>> >> +projects, including QEMU.
>>=20
>> Thanks!
>>=20
>> [...]
>>=20
>
> With regards,
> Daniel


