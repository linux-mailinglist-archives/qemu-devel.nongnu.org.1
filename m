Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4E07AB344
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjglU-0000o0-Q9; Fri, 22 Sep 2023 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjglQ-0000nC-Pb
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:04:12 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjglP-0006vv-4s
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:04:12 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso2614748a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695391449; x=1695996249; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sBCXycvX4c7403ihyrLQH2/q+KEBEwlfu186efgMcj4=;
 b=vEmqckCCVPdMOnBlVlKueJa8wEeOqa8fVB/bNcm7Rouw91N1AQRZxHxsYnn+DjZSWL
 O7sBLokCZHXJHWF18p3/VoP22tnIZx3Vk6SsdTBENrsLEIcbqds8UboF6dv5ptJm0fIh
 wRvCPM8vt5GQEaq0hhmRsiMwOoDZY8IVNYyT4QpRDIYM4BkQMwWhcSjQpDR5k70SQhBS
 FJTcVy13sfRZkKOvJw5BKijt8jllgVACNKsgW8EA+4cNiH9EVHSJeTavcG+7JUYy+YJc
 3eBsM2IrzZIZu8xXU8A+aK5hRlojEAeTibVW2fUVgnstE8twy/vfkalvNtNiUdbJz0th
 vO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391449; x=1695996249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBCXycvX4c7403ihyrLQH2/q+KEBEwlfu186efgMcj4=;
 b=XLVzwZOMAUO3sQGkDKp+oMuq2a8QTs8fYHQgQuxPIfp1ah72FD+oQa3EGBPCd4nWTs
 lV+s86brs+Ow1cNc+JSrc9QdVjakM4n13+5UZ3813MjxIF1zae8haImG+GkEqztkXVDb
 9Piv3aJCjqqD1VBnCrvD88Bqcx8Yp89NHnv4ZsPXS6gxJa1mYFP8xE3FHcn4m7io8KBh
 gegwNifbz42e/B9zIvN8ICsAFRYJe9Zw+Jgk8k3UH2zUQoQ/dqEG2TTT3tJ7qDcTSfjN
 4JDEUqxgM7DtSBp/asrBWbYmoGio/JpGA2UP9f513N05yurYeJtTznaWHiqVVDZO6Ib2
 OjCQ==
X-Gm-Message-State: AOJu0Yy6WNnttRCkUwJgeC4el9JJ6afgWN2xuuHKeVcyjeajTDey0OOJ
 KYSo9MGeeMaFRIrXxBAFy6r4ESjLwJd3o0s4kaHQmQ==
X-Google-Smtp-Source: AGHT+IHHhMwdxzUiJLvXPsEWg8TPFO7BrmXiezxlM+9TLN6G8AG6L11+dzXfHqU8OlUW0Bcp23z0m7QvAZ7eDSWt0cw=
X-Received: by 2002:aa7:c1c7:0:b0:52a:1c3c:2ecc with SMTP id
 d7-20020aa7c1c7000000b0052a1c3c2eccmr8049385edp.25.1695391448717; Fri, 22 Sep
 2023 07:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <87r0mqlf9x.fsf@pond.sub.org>
In-Reply-To: <87r0mqlf9x.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2023 15:03:50 +0100
Message-ID: <CAFEAcA-ie8V9Z8yPWH2WwjZzY4dALyPhSLbfgLNKRp278f_o3g@mail.gmail.com>
Subject: Re: Help wanted for enabling -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Andrew Jeffery <andrew@aj.id.au>, 
 Ani Sinha <anisinha@redhat.com>, Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Fan Ni <fan.ni@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Joel Stanley <joel@jms.id.au>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 22 Sept 2023 at 10:37, Markus Armbruster <armbru@redhat.com> wrote:
>
> If you are in To:, we need your help to enable -Wshadow=local.
>
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
>
> Enabling -Wshadow would prevent bugs like this one.  But we have to
> clean up all the offenders first.
>
> I collected the patches posted so far:
>
>     [PATCH v3 0/7] Steps towards enabling -Wshadow=local
>     Message-ID: <20230921121312.1301864-1-armbru@redhat.com>
>
>     [PATCH v2 00/22] (few more) Steps towards enabling -Wshadow
>     Message-ID: <20230904161235.84651-1-philmd@linaro.org>
>
>     [PATCH 0/3] (few more) Steps towards enabling -Wshadow [3 more]
>     Message-ID: <20230904162824.85385-1-philmd@linaro.org>
>
>     [PATCH 0/8] ppc: Clean up local variable shadowing
>     Message-ID: <20230918145850.241074-1-clg@kaod.org>
>
> Thanks, Philippe & Cedric!
>
> In my local build with -Wshadow=local, warnings remain in just 56 files.

Do you have either a git branch with those accumulated changes,
or else a transcript of the build log with the warnings?

thanks
-- PMM

