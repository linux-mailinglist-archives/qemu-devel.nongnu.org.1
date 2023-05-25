Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840E710C46
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AKe-0005RA-FG; Thu, 25 May 2023 08:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2AKb-0005Qg-Um
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:44:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2AKa-0000kZ-4e
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:44:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so2029617f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685018674; x=1687610674;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=id/Zq5XB2mYJQm6VYe6hxE5/akwCUV/BsTYBt6PNqSk=;
 b=qcckRUqkeylcBK/S751U7I9gtXZ0rsaZPX6Y4RsBEhEcutIECAYmLig49Gr0VimVb1
 BFu1i4uUV8Ji0fsOt7x92nZEPRYBPnLGcjihT4yX/siAk88fROFuY3iViICtAAjwOq3o
 6Ame0WH7gN0QKM2HSoppTmQA1zFTQg9OcttqqnjLu3NmlARX7fD72mmnDFSQr0LhjZXJ
 W+wDdpUZl7SJLMKS7TsIqOEFD8hXY7CATevM9DCHs5fWUuPkPeHdTSBzBOyameNEubxp
 X4S1sYoZM5jRUBnxn+Q6uo+Gllkj73kqvn6DwSJFxYfwJZUkDcUEmPimLl/ODEDJeqe2
 IjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685018674; x=1687610674;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=id/Zq5XB2mYJQm6VYe6hxE5/akwCUV/BsTYBt6PNqSk=;
 b=Z+XWFBI5IW9fPGSzE5qvRByBAyDwPxCECcAHpIcddHV2kYjzrixRLf7m83cFsFXPtF
 ojgL6xHcAyt6xQ+Fqannw13iwQOimQ/kEQ4mtGukmqWkZaZjTRmQHZlXGxL5imsTPey7
 Ii8B1rUWYobDaT9cK7hI20Rb/ruNZP0g98v7O/htvIy6ugr3PbVILdgKc3kJUtxHwekE
 pgx4leAE44SNc0KTANn+oZ+DOaQW+L4M/rYzlRXflK5Fhzme2ZhF2Yp7M3FuFnotzYF/
 4rUC3mNB0cA90xICQQGHNQnf9UqExUaqP1+XONw8iwOhTUq2OkcTI05/T7z7iqnXK2Zn
 2eBw==
X-Gm-Message-State: AC+VfDwsXQu/VO+ZANQR6rvH4k5P092p0FZfJ9YX049WVxoQG+o/i553
 e1bJ73mllwVoJ04lH+sxVrqOKg==
X-Google-Smtp-Source: ACHHUZ4PnnegAB7CnsKUv0RAgN+KrA8KP1zH3D6nT2NLvLyuSvMi2n1/W2luEvotTZI4xybCkTBBhA==
X-Received: by 2002:a05:6000:892:b0:309:22ba:dcdf with SMTP id
 cs18-20020a056000089200b0030922badcdfmr2269084wrb.32.1685018673798; 
 Thu, 25 May 2023 05:44:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a16-20020a5d4d50000000b003047ea78b42sm1732368wru.43.2023.05.25.05.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 05:44:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A8E711FFBB;
 Thu, 25 May 2023 13:44:32 +0100 (BST)
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
 <20230524133952.3971948-6-alex.bennee@linaro.org>
 <87353kskvz.fsf@pond.sub.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kyle
 Evans <kevans@freebsd.org>, libvir-list@redhat.com, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Greg Kurz
 <groug@kaod.org>, Eric
 Blake <eblake@redhat.com>, Warner Losh <imp@bsdimp.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Richard
 Henderson <richard.henderson@linaro.org>, Christian Schoenebeck
 <qemu_oss@crudebyte.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo  Bonzini
 <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 05/10] qapi: make the vcpu parameters deprecated for 8.1
Date: Thu, 25 May 2023 13:43:56 +0100
In-reply-to: <87353kskvz.fsf@pond.sub.org>
Message-ID: <874jo0vavj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> I don't think I can remove the parameters directly but certainly mark
>> them as deprecated.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20230523125000.3674739-6-alex.bennee@linaro.org>
>>
>> ---
>> v5
>>   - reword match description
>>   - fix reference to return for set operation
>> ---
>>  docs/about/deprecated.rst |  9 +++++++++
>>  qapi/trace.json           | 40 +++++++++++++++++----------------------
>>  2 files changed, 26 insertions(+), 23 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index e934e0a13a..e44cde057f 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -254,6 +254,15 @@ it. Since all recent x86 hardware from the past >10=
 years is capable of the
>>  QEMU API (QAPI) events
>>  ----------------------
>
> Not this patch's fault: the headline should be "QEMU Machine Protocol
> (QMP) events".  The section should directly follow section "QEMU Machine
> Protocol (QMP) commands".
>
> I'd go one step farther, and fuse the two sections under the heading
> "QEMU Machine Protocol (QMP)".
>
>>=20=20
>> +``vcpu`` trace events (since 8.1)
>> +'''''''''''''''''''''''''''''''''
>> +
>> +The ability to instrument QEMU helper functions with vcpu aware trace
>
> Should this be "vCPU-aware"?
>
>> +points was removed in 7.0. However the QAPI still exposed the vcpu
>
> s/the QAPI/QMP/
>
>> +parameter. This argument has now been deprecated and the remaining
>> +used trace points converted to plain trace points selected just by
>
> "remaining trace points that used it"?
>
>> +name.
>> +
>>  ``MEM_UNPLUG_ERROR`` (since 6.2)
>>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>=20=20
>> diff --git a/qapi/trace.json b/qapi/trace.json
>> index 6bf0af0946..e561f3d3da 100644
>> --- a/qapi/trace.json
>> +++ b/qapi/trace.json
>> @@ -37,13 +37,14 @@
>>  #
>>  # @vcpu: Whether this is a per-vCPU event (since 2.7).
>>  #
>> -# An event is per-vCPU if it has the "vcpu" property in the
>> -# "trace-events" files.
>> +# Features:
>> +# @deprecated: Member @vcpu is deprecated, and always false.
>>  #
>>  # Since: 2.2
>>  ##
>>  { 'struct': 'TraceEventInfo',
>> -  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} }
>> +  'data': {'name': 'str', 'state': 'TraceEventState',
>> +           'vcpu': { 'type': 'bool', 'features': ['deprecated'] } } }
>>=20=20
>>  ##
>>  # @trace-event-get-state:
>> @@ -52,19 +53,15 @@
>>  #
>>  # @name: Event name pattern (case-sensitive glob).
>>  #
>> -# @vcpu: The vCPU to query (any by default; since 2.7).
>> +# @vcpu: The vCPU to query (since 2.7).
>>  #
>> -# Returns: a list of @TraceEventInfo for the matching events
>> -#
>> -# An event is returned if:
>> +# Features:
>> +# @deprecated: Member @vcpu is deprecated, and always false.
>
> This isn't quite right: parameter @vcpu cannot be false, it's int.
>
> I figure specifying the parameter makes no sense anymore, because if you
> do, the command will return an empty list.  Correct?

Well its not longer checked so I guess "and always ignored" would be
more correct.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

