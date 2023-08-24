Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E678723C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBga-00063c-Rs; Thu, 24 Aug 2023 10:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qZBgY-00063F-6E
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:51:46 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qZBgV-0004UI-U7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:51:45 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-56e9fcfcd69so3818684eaf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692888702; x=1693493502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ECOin+S2PSLdDAnkXybR//GXan2XvMNjAz4oWxG4xr4=;
 b=XWKNcnHeTbc9c7FWnzQ16e5wncN8u7dqtnYRKje27s95ZmtX8C60OeThk7DK/ZDp5k
 dxlMswaM/rBpchkHA1Lo44zM23k5ALmO19PNJmoO/qDdZGgchZ3Laf6Aes3vDPpvcioS
 9p9XSdb9fbr0vyYPaziVeu9hEgo9XNKTbHwd4G0DOj8UQkSzFSEQCrCk6ktc3E249Lle
 ZCUXo2vK9/Z29ZCns30qkl/0DKw2nWRG2nPCyoyc3ydQnvnNoEvTQ8gm/U/T4R0Ta8Yo
 RBJxKo7zPLg7Nwmqz8R+iSPpprHdWzyudYNlDnEXU+Mzj3++NvHixld0a63wZ44J1eeQ
 DPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888702; x=1693493502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ECOin+S2PSLdDAnkXybR//GXan2XvMNjAz4oWxG4xr4=;
 b=gQd7cWI4PpbGfZhNYIJYIt7dGDRvSnf0wUt51cyFlHMvRYmuQWKiPvz337sIkCc2zY
 4XlpIrEDWcLpCAXGpiyRnXe8+QSR5eFY7v911wBFwydf1675fXMn2tR0eOKOJT6WB+Rq
 J1RpEFzB3O5Pmtf2yVMRKuSVhu3zTutMLbcQviAhE3p+a40/DS4m3bPVuyLz7PpZpRp7
 bf029UwDlJhVKn7YPyOLyXjAEdpqixZ1r0Ak0ZfMTt2Cs0Bhrs9wSHlQ3n/E4kHr9M7S
 cd1qMrd6CoEd/1jA0yIO2pq8q0V25Z+f44FrMigD6H2pjo7a8e12o5eOgE/NKUszuaUr
 g/6Q==
X-Gm-Message-State: AOJu0Yyqh9Ycc1Wc3kfr1ueFq4DV/dWyDJi8nd7DEYO1FrB7989b0J1/
 GWTEurVOhfGxU0wRTJrMWekUhrCX9CECK0Y9Ebg=
X-Google-Smtp-Source: AGHT+IH1uMD29lzP6l1J88a2udx6Jsn1kNSagUm8j/bXxJQDoZoQPhwiv7kZaVW3WUufZjQEkzEzpm0EEqDHfsDXw0A=
X-Received: by 2002:a4a:6c49:0:b0:56c:a41c:f264 with SMTP id
 u9-20020a4a6c49000000b0056ca41cf264mr2056506oof.8.1692888702177; Thu, 24 Aug
 2023 07:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823163440.GA851545@fedora>
 <aee5829f-37a4-4169-1a70-8f9a40b4f45d@redhat.com>
In-Reply-To: <aee5829f-37a4-4169-1a70-8f9a40b4f45d@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 24 Aug 2023 10:51:30 -0400
Message-ID: <CAJSP0QXO1QQ=4UyLXg_=iyc9=uy1CdeL0fq8_95ewZiewU6XTw@mail.gmail.com>
Subject: Re: [PULL 00/12] First batch of s390x patches for QEMU 8.2
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
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

On Thu, 24 Aug 2023 at 02:53, Thomas Huth <thuth@redhat.com> wrote:
>
> On 23/08/2023 18.34, Stefan Hajnoczi wrote:
> > On Wed, Aug 23, 2023 at 01:45:32PM +0200, Thomas Huth wrote:
> >> The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:
> >>
> >>    Open 8.2 development tree (2023-08-22 07:14:07 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23
> >>
> >> for you to fetch changes up to 6c49f685d30ffe81cfa47da2c258904ad28ac368:
> >>
> >>    tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)
> >
> > Hi Thomas,
> > Please take a look at the following ubuntu-20.04-s390x-all CI failure:
> > https://gitlab.com/qemu-project/qemu/-/jobs/4931341536
>
> It says: "TimeoutError: Timeout waiting for job to pause" ... could you
> please check the load on that host? ... I think that s390x runner is known
> for being too slow some times, so I assume that problem should go away if
> you re-run the job when it is less loaded.

I ran it again and it timed out. I've merged the PR and assume the
test is just flaky.

Stefan

