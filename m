Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31B7F2AB3
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:38:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5O8I-0005Hk-E1; Tue, 21 Nov 2023 05:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5O8G-0005HF-Vp
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:37:29 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5O8F-00022P-Cv
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:37:28 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41e58a33ec9so32601411cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700563046; x=1701167846; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAzgLbOvAONErR4d8pGEbyfhvno4DiyTbKAvLoS7iV8=;
 b=TTZH1jtSx8qxv9TG9kZWgK8qgLUu1A3NoNFQ+NGrkRH3YGZK0vguMasrMBH/Dl9M2E
 8UwXlLA5oBDS1F7Kvco2H+5CH6kZ/xCmFE17B45qVFLlHH1fB1g4OZVKSRsErRFJO1zF
 9rVd67s86ggbRJLZLTI5mfns8OUFgzx5gQDCjdwUQOecNBTcFvmPpHkNj7fJWg7rKMq7
 DnoIPumBQL6m7TpmsEByq2lrWSfZ6CmJi+BP7/fWGOFvaINAp2OizsMseDfpP14VmXhU
 w+3MQ2p2jRSKb0Ubb4NGKILodZ8dYB+w+r7XPNB6vZZLRGtDYXpKYoKkmthwf0sQHdEY
 qxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700563046; x=1701167846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAzgLbOvAONErR4d8pGEbyfhvno4DiyTbKAvLoS7iV8=;
 b=jVAWZGqdFNfOQ4lKSpOTvznK2p9G9n7gB0e/ei6eb3ulnuDBS5SSucdU0xDgo3aWCZ
 BNBxoyEpGQc0Ph2U8QNNLQAfhoNSzcvzI/gyX7W6fhqmdYiqcujXiSkrijjyMIp6sXq3
 RMrkRcCP2aEHk0G4iWajfBt7pkjdhNfrmn5S9wjNiKptiGta7dm0BXMhKF9fIumof/zQ
 D3N21o7qfnK4WWURn8OGEEivo5/dBdCF1nRQPcuKVnbMMYUX7C1yToZqJRO68/cWXV4n
 6tZrWo7iofa6PjJ4sAtF4/skaPWd7RJ+m+OcF4UWJaYbOOz6joUgY7BIqztnX3etvpMx
 R3XA==
X-Gm-Message-State: AOJu0YwjMTNmqaw9dhKKXOf+om3TxFskGHjoYInjLIuavo5atNgfQ2a5
 ppOiPOqomdDvcLMGfcHd8zBDoENvNvmtCY+16K0=
X-Google-Smtp-Source: AGHT+IGaHlgB9VeE+/Dp8ST6MT2Nnimvbw6KBqGNkfcLPlihygkimEWxf3MgyciiVSQXgbqXramwS9eKPlO3eWU6nJw=
X-Received: by 2002:ac8:5442:0:b0:41c:dfce:1289 with SMTP id
 d2-20020ac85442000000b0041cdfce1289mr12727676qtq.51.1700563045776; Tue, 21
 Nov 2023 02:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
 <CAJ+F1CL_a72vuH0ShLwVXKW-2sTzSX0LnWtSDT6BxKNx_ZUhzg@mail.gmail.com>
 <3c467e84bcbde020f9e3323de1abb69d78b552c9.camel@amazon.co.uk>
In-Reply-To: <3c467e84bcbde020f9e3323de1abb69d78b552c9.camel@amazon.co.uk>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Nov 2023 14:37:13 +0400
Message-ID: <CAJ+F1CJes+QAeJOHMKH6_aa0JV14Dkj0WAM-QarQkqRgiZ0V7Q@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/3] UI: fix default VC regressions
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, 
 "gmaglione@gmail.com" <gmaglione@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi David

On Tue, Nov 21, 2023 at 2:15=E2=80=AFPM Woodhouse, David <dwmw@amazon.co.uk=
> wrote:
>
> On Tue, 2023-11-21 at 11:37 +0400, Marc-Andr=C3=A9 Lureau wrote:
> > On Fri, Nov 17, 2023 at 6:36=E2=80=AFPM <marcandre.lureau@redhat.com> w=
rote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Hi,
> > >
> > > There are a few annoying regressions with the default VCs introduced =
with the
> > > pixman series. The "vl: revert behaviour for -display none" change so=
lves most
> > > of the issues. Another one is hit when using remote displays, and VCs=
 are not
> > > created as they used to, see: "ui/console: fix default VC when there =
are no
> > > display". Finally, "ui: use "vc" chardev for dbus, gtk & spice-app" w=
as meant to
> > > be included in the pixman series and also brings back default VCs cre=
ation.
> > >
> > > Marc-Andr=C3=A9 Lureau (3):
> > >    vl: revert behaviour for -display none
> > >    ui: use "vc" chardev for dbus, gtk & spice-app
> > >    ui/console: fix default VC when there are no display
> >
> > I wish to send a PR (rc1 today), together with "[PATCH] vl: add
> > missing display_remote++".
> >
> > Some R-B/A-B appreciated! thanks
>
> Not sure I can give coherent review on the other two, but the first
> patch does fix the Xen command line and looks sane.
>
> Please could I ask you to also include
> https://lore.kernel.org/qemu-devel/20231115172723.1161679-3-dwmw2@infrade=
ad.org/
> in the series as you push it?
>
>

Thanks for the quick test. I am bit reluctant to push your change in
8.2 too. It's a change in behaviour at this point, not simply a fix.
But as the maintainer of Xen stuff, you have perhaps the final call.?

--=20
Marc-Andr=C3=A9 Lureau

