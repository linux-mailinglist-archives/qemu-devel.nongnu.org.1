Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA07DB294
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:00:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKML-00087E-Vs; Mon, 30 Oct 2023 00:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxKMK-00086n-Ch
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:58:40 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxKMI-0005hP-PT
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:58:40 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6cd1918afb2so2457603a34.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698641916; x=1699246716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uuq2c2B10YKRR2dwqe+TVNM44+/sPx7bQr0C9580Q3s=;
 b=WQHx9JatQ4Xz2/r6sOzNIpwe4TsFaf+grkJTJowZPNy/eJ5kwxXfbGGlcafTMlkfsS
 WigOHMVC1fvYjbVSoYsg/0U6wvKSnZVWvM6B7C9f6V0aOSAIZ/ZSWQBKgTnhXxVxKxOl
 UZazWxfPxNP1S9o7/qZ0B4SjS2laJGUYwQUj4RribVQ4ngLZmuOOXqlwaGD0puQELxcv
 RIHPVU7bi8CpCV0Wid3J26vbCcxDKurzgO685l4+7a4k4fjxq9S5ITNpslJVnWTpxbQQ
 +l7cy7VzsaF6HD6bCUVcoYYNT8lvMqE3lbCl7SMLF33mWTNlRQbXhciNdZJLUdib/ZAp
 2nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698641916; x=1699246716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uuq2c2B10YKRR2dwqe+TVNM44+/sPx7bQr0C9580Q3s=;
 b=tZaMtQXW6RELimDXJGN2x26cnGE3K6bY/L2jjCHYjq6/ZZWywGMXQ62/axRESbv8nm
 2SD96WyvgO6w5pAk3bR54FTLFG4C7RGEztCLVfR8mjy6Sx4W5lORX1GSH9m9QB8qBRQS
 YhWB8uTo583IKXAOYPdNvgJ5SrUuwl3UT8UERchwS29yYifJXPNKDJB7jkdY74vSj3Zq
 zHVaPVvYF2DqBgz5q9L5dC4pfT6DfHRY08rJIERkJ4PpSNPDqqH+QeqFXggAqvnv6ftm
 mTNXwlSxFxGuFgqJunDhC8Ic18KtAFGFrkABn1UilqR8JmeyKNiLQIyKs7V1pKdWGHC9
 vMBQ==
X-Gm-Message-State: AOJu0YzsPtSL/6iZE/00k34runT+w828fhMk2hPml9GyA2nsVPQ3lX5C
 m8wDPBy/zpuEoNuHa0a5RZsoLkEbdGXkn2giFpo=
X-Google-Smtp-Source: AGHT+IEiGSjLBr5XSTtCfj3ItXMjYa0ZWwZuzBcrFla9WGEjiIzXIg8WIbq3j5T10WTKXy3UoOtcT/A9el6ZZfhG6lw=
X-Received: by 2002:a9d:7d96:0:b0:6bc:f276:717f with SMTP id
 j22-20020a9d7d96000000b006bcf276717fmr8601533otn.13.1698641916160; Sun, 29
 Oct 2023 21:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231026053115.2066744-1-armbru@redhat.com>
 <CAJSP0QW2uVv1s6JnNFj5HC13vO=yGsGB0wb_mRJvUQXoeCLvQA@mail.gmail.com>
 <878r7o7k33.fsf@pond.sub.org>
In-Reply-To: <878r7o7k33.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 30 Oct 2023 13:58:24 +0900
Message-ID: <CAJSP0QX2aA1gfEYNPXaK-_0=fgR59X3R7gcpy57tDtjgsz5ZPw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Enable -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, bcain@quicinc.com,
 imp@bsdimp.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 27 Oct 2023 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Thu, 26 Oct 2023 at 14:32, Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Requires Brian's pull request and two patches from Thomas to compile:
> >>
> >>     [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes
> >>     [PATCH v2] block/snapshot: Fix compiler warning with -Wshadow=local
> >>     [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
> >>
> >> Stefan, the PR was posted a week ago; anything blocking it?
> >
> > It's not in a pull request, so I won't see it. I don't have tooling
> > that can spot individual patch series that need to go into
> > qemu.git/master, so I rely on being emailed about them.
>
> I'm inquiring about this one:
>
>     https://lore.kernel.org/qemu-devel/20231019021733.2258592-1-bcain@quicinc.com/
>
> Looks like a PR to me.
>
> > Would you like me to merge this patch series into qemu.git/master?
>
> Yes, I'd like you merge Brian's PR I linked to.

Sorry, I missed that because of a bug in the 'patches' tool that I
use. The PR is running through CI now.

I've fixed the 'patches' tool to decode emails with
Content-Transfer-Encoding: base64 now:
https://github.com/stefanha/patches/commit/35531a8668f551356c019f68670fcb154535ccd3

Stefan

