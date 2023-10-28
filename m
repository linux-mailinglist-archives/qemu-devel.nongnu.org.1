Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 829257DA488
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 03:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwXmX-0007ib-9o; Fri, 27 Oct 2023 21:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qwXmU-0007i9-J2
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 21:06:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qwXmS-0002hk-2t
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 21:06:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so4121865a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698455176; x=1699059976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HC0/J9R5dPcHKhJkQ+n534eAHeWevT0sM8y1fWrSa9w=;
 b=WA+NVVBpEnt1VzCTi82OYlPpqDXbcziEY0eGem1V43KHh8a7XPEc8xLdzJuIeniG2G
 TWU+QSPlxBAoFy8JsqOgIv7cuiUn/rghjYKbJVRXVE/6EZc7IXB+a7KEQ5vLoHFCdGmi
 VKlxcBYv1CHey+5blSAOH4eAjWnp11l5IVGZ3E1rhpSE8mGxzcyA6zbkmOUUaya+paHb
 ggEMgKxG/OkygT1ceQ7R/7kuZs9gGQ6Z+EE8ONU5TRM5w17Qr+YO6fmcqvEGfqMzwNi2
 US9gM6ctc0j7V4hOTS5dGkq3vcyp2hgeLtAqgDigv884nzmik42/LjqfyZgWsxk8Rqg9
 h9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698455176; x=1699059976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HC0/J9R5dPcHKhJkQ+n534eAHeWevT0sM8y1fWrSa9w=;
 b=Ffvy+4DK+7Agf40tTfgThL5+ABYseG0wspm1n3pOjXoEte8NPgXdH1G3t8eADRdL4/
 P3724bJUj1LDt2L8xG74JCTsN/b40nyq4Bmf2wVJDyiMcLXOWbH6H0aV1Bk5fsYlHZVT
 yxyZ6jXfCY+qyM1J6DE19KpqeGNG+xoM5QU1XJn5cuVfrILj9lJqqGtLyuIqaMRhd5Y9
 RsLAHSfm7+lxAwDQzosUAQzpx8v4ytTdeb2sPrYS9aRhkUB7ojpp++E6Z3VTQCcxCVmz
 I3KubRns5U94vul8CdVahlRjnvSzeGeAzfUQ+qR4YTJjXiiyVV74B/a5Fo1OEWHpf/Sh
 5b8A==
X-Gm-Message-State: AOJu0YzyXZ4pR718emjCCS3FsQpxy2/JXS1BGnQWuy/WBDUG4lDRubSh
 k4SXEN4+Rm294rgb+IFNWT20jx5tymg511/B7DdL2g==
X-Google-Smtp-Source: AGHT+IEoW0CwG9THnXaiEjhnQulvO2rKAVRaD8nuqZ0Jlqf4IXQNBjObo8hpgHA4KkAlf++Td0iafoqT+yasH+b3Co4=
X-Received: by 2002:a17:907:9688:b0:9c3:b3cb:29b8 with SMTP id
 hd8-20020a170907968800b009c3b3cb29b8mr3143470ejc.0.1698455176365; Fri, 27 Oct
 2023 18:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-2-hao.xiang@bytedance.com> <87zg041c42.fsf@suse.de>
In-Reply-To: <87zg041c42.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 27 Oct 2023 18:06:05 -0700
Message-ID: <CAAYibXh+E-ZJ7SKMJie=NG8x8_hP9B5AxYZMXxXY2cK9QuuPrw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 01/16] Cherry pick a set of patches that
 enables multifd zero page feature.
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52d.google.com
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

On Fri, Oct 27, 2023 at 5:30=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > Juan Quintela had a patchset enabling zero page checking in multifd
> > threads.
> >
> > https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.com=
/
>
> Hmm, risky to base your series on code more than an year old. We should
> bother Juan so he sends an updated version for review.
>
> I have concerns about that series. First is why are we doing payload
> processing (i.e. zero page detection) in the multifd thread. And that
> affects your series directly, because AFAICS we're now doing more
> processing still.
>

I am pretty new to QEMU so my take could be wrong. We can wait for Juan
to comment here. My understanding is that the migration main loop was origi=
nally
designed to handle single sender thread (before multifd feature). Zero
page checking
is a pretty CPU intensive operation. So in case of multifd, we scaled
up the number
of sender threads in order to saturate network traffic. Doing zero
page checking in the
main loop is not going to scale with this new design. In fact, we
(Bytedance) has merged
Juan's change into our internal QEMU and we have been using this
feature since last
year. I was told that it improved performance pretty significantly.
Ideally, I would love to
see zero page checking be done in a separate thread pool so we can
scale it independently
from the sender threads but doing it in the sender thread is an
inexpensive way to scale.


> Second is more abstract but the multifd packet header is becoming just
> about small details about pages. We should probably take the time now
> and split that into a multifd header and a payload specific header. With
> some versioning stuck to them for migration compatibility.
>
> Now, I don't want to block this series due to my idealistic views on the
> code base, so I'll keep those aside while reviewing this, but I
> definitely think we should look at the big picture before we get too
> tangled up.
>

Totally agree. I actually have an implementation of this locally to do
exactly that.
The problem I see is that we use a fixed size page count in a payload but t=
he
payload size varies depending on how many zero pages are actually detected.
The sender/receive pair has a synchronous loop on payload transfer and
if we have
a long fat pipe, the current behavior is not optimal for network
bandwidth utilization.
We can make sure we accumulate enough normal pages and we send a large pack=
et.
And when we send zero pages, we can accumulate them until we have a very la=
rge
page count and we send them all at once.

