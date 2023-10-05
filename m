Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE77B9AE2
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGjm-0007u9-OI; Thu, 05 Oct 2023 01:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoGjk-0007q3-2e
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoGji-0007Jr-ER
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696483041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+241iCegdQbC1p6fzfrNKptSW+HRgpCsuUTk4uF98s=;
 b=AEIqY0OGuqZ2+TVkoGdOLajn9VBOnDTHMfJudpB5KRtd1c1VHahw8LzypS+Oq0ZyfQE9P4
 xQ46CVip6zF0uPIPo+w1oaTZLD4YWsFbnio2vejrv+feyHsZm5BjNzr/NNkisjYg1dgqgW
 +yJ62QKRtCoBQFeqD01scGkZOaUoFMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-N2bqe3P_OFGj9t40fJZyhg-1; Thu, 05 Oct 2023 01:17:19 -0400
X-MC-Unique: N2bqe3P_OFGj9t40fJZyhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C0EF185A79C;
 Thu,  5 Oct 2023 05:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A511402F1E;
 Thu,  5 Oct 2023 05:17:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 822EC21E6904; Thu,  5 Oct 2023 07:17:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: Wshadow: Better name for 'optarg'?
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
Date: Thu, 05 Oct 2023 07:17:17 +0200
In-Reply-To: <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Oct 2023 19:43:35
 +0200")
Message-ID: <87lechabs2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 4/10/23 19:35, Thomas Huth wrote:
>> On 04/10/2023 19.23, Richard Henderson wrote:
>>> On 10/4/23 03:05, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Hi,
>>>>
>>>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
>>>
>>> I thought things like this is why we were trying -Wshadow=3Dlocal.
>>>
>>> I think it's unlikely that we'll be able to prevent all such cases.
>> Given the broad range of operating systems and libraries that we support=
 in QEMU, I agree with Richard - it will likely be impossible to enable tha=
t option without =3Dlocal by default without risking that compilation break=
s on some exotic systems or new versions of various libraries.
>
> -Wshadow=3Dlocal doesn't seem to work here which is why I switched
> to -Wshadow. I probably misunderstood something from Markus cover
> letter. My setup is:
>
> C compiler for the host machine: clang (clang 14.0.3 "Apple clang version=
 14.0.3 (clang-1403.0.22.14.1)")
>
> I suppose we'll figure that out when eventually enabling -Wshadow=3Dlocal
> on CI. Meanwhile I already cleaned the 'optarg' warnings that were
> bugging me, see:
> https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.o=
rg/
> I'll try to get -Wshadow=3Dlocal, but the other series still seems a
> good cleanup, as I used more meaningful variable names.

I'm aiming just for -Wshadow=3Dlocal now.  If somebody else gets us all
the way to -Wshadow, I'll clap from the sidelines.

I'm mildly skeptical about -Wshadow without =3Dlocal when targeting a wide
range of toolchains over a long time.

Not an objection to cleanup patches such as yours!


