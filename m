Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6A8272EB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:23:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrST-0007PD-0m; Mon, 08 Jan 2024 10:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMrSQ-0007L3-9D
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:22:30 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMrSO-0006Ba-3m
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:22:29 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e7c6e3c63so1792143e87.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704727346; x=1705332146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LvJQvzhO5jjL+q5UqXm2fqRqymZa+7h0l8JwxK1WpBU=;
 b=js4lRbY+IHEe4Ono59wJKebCeDYD3RuzQN06f/0kMFtEheKM4HnwVVT3DcIjzddCC3
 XKcwmc5gALQ79EgXV7mJZqavRp4cPIPQIHmq3BrLkmQfkp86ZZ0FHe/GHen4s9mHMlPw
 BDI9GzsZVMEuL5QvdkYK4RMWWqJmc2pRqhRWCvZ04omK01P5QJSMQAtcll3s5Hp9iDIW
 QyE6WfeVLg52lZwssF2Df/CBhUeSupJtsObPB/JiYgW+zzea74ZJ9te8J9Ag1YZhTXhd
 b/KCda0ZywvV2HVM7WTGUAWAgXviDEPNx/TQsNCzeKLoCglHKlvPsdPnCFmY8PIJwqKw
 Ng2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704727346; x=1705332146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvJQvzhO5jjL+q5UqXm2fqRqymZa+7h0l8JwxK1WpBU=;
 b=ID5wbXcugGZbMGDJ+unib1ildfxhEknhNmXxx09mnJ/4wtJhe8JwWqu+b/GpyiWfFD
 6ivo5F5XkHnsm9XBfZHT8F5ojoZdrKsHGpaYvuh1Iy/rCoOF9P1glNB1EVAv7ZlGJuav
 yp8212IjW+vonUXjoQyFXRzgiy0jsYFyqnzs0VMw2qkFTPbAEf59lTfdD1Tg58U61uzh
 TqTSF0xzZ655YSOS53wTmcb8KS0cABOJatL3bXilBBITEKxKe6DQwzV97NT2w4/FgnYe
 +2ZafO2ikFyRTpTz98M16JCKPI/fPMdyf4iv1vQwyyhXORAfcGenZxmvu7u8zdRlqiiV
 JBow==
X-Gm-Message-State: AOJu0YzRJqW0JkNSZGLpT5Hhj93GMQKiZBokjhq+oOkZ/5l552S3nRzh
 ehIjSvWmPlSGzEtt8moVcG85GCFJ78vu5+bpqfYW8r/nQMtwAQ==
X-Google-Smtp-Source: AGHT+IGV7hdmGxaM0bezHAvUluSSJsPZdKs7TbncHhSKCnKay0np9cjIexkGE697ETNb7x4UB9Wyq90n5l1I5HKeUfQ=
X-Received: by 2002:ac2:4119:0:b0:50e:4d84:c5a2 with SMTP id
 b25-20020ac24119000000b0050e4d84c5a2mr643187lfi.209.1704727345782; Mon, 08
 Jan 2024 07:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
 <ZZqaGf6nt0wkZgbS@x1n>
 <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
 <CAFEAcA9Wx4wcZj2MtBfb7u-y4wrbbjNhbLXA21pqmcrS+T8+hw@mail.gmail.com>
 <CAJSP0QX2bmZboYPyQ5AQz-q=n2N4sp=zzzDYvoie=vhiAYQ+7A@mail.gmail.com>
 <ZZtZkE7w9Rvv8_7H@x1n> <ZZtfTX-sTBR3aXti@x1n>
In-Reply-To: <ZZtfTX-sTBR3aXti@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 15:22:14 +0000
Message-ID: <CAFEAcA8NRuQUP0KEi69QGSgitAXsshM7BiKrjKzH-F968vPpqg@mail.gmail.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Steve Sistare <steven.sistare@oracle.com>, Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Mon, 8 Jan 2024 at 02:35, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jan 08, 2024 at 10:10:24AM +0800, Peter Xu wrote:
> > On Sun, Jan 07, 2024 at 11:28:25AM -0500, Stefan Hajnoczi wrote:
> > > On Sun, 7 Jan 2024 at 10:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > On Sun, 7 Jan 2024 at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > >
> > > > > On Sun, 7 Jan 2024 at 07:34, Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> > > > > > > I notice that your gpg key doesn't seem to be signed by anybody
> > > > > > > else; you might look at whether it's easy to get it signed
> > > > > > > by somebody else (eg some of your redhat colleagues).
> > > > > >
> > > > > > Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
> > > > > > server we normally use?  Maybe I missed some steps there?
> > > > >
> > > > > Yes, Peter's key is signed by me:
> > > > >
> > > > > $ gpg --list-signatures 3B5FCCCDF3ABD706
> > > > > pub   ed25519/0x3B5FCCCDF3ABD706 2023-10-03 [SC]
> > > > >       Key fingerprint = B918 4DC2 0CC4 57DA CF7D  D1A9 3B5F CCCD F3AB D706
> > > > > uid                   [  full  ] Peter Xu <xzpeter@gmail.com>
> > > > > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > > > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > > > > <stefanha@redhat.com>
> > > > > uid                   [  full  ] Peter Xu <peterx@redhat.com>
> > > > > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > > > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > > > > <stefanha@redhat.com>
> > > > > sub   cv25519/0xD5261EB1CB0C6E45 2023-10-03 [E]
> > > > > sig          0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > > >
> > > > > I have pushed to the keyservers again in case I forget.
> > > >
> > > > Thanks. Which keyservers did you use? I think these days the
> > > > keyserver infrastructure is unfortunately fragmented; I
> > > > probably didn't try refreshing from the right keyserver.
> > >
> > > I ran gpg --send-key again and it said hkps://keyserver.ubuntu.com.
> >
> > Thanks Stefan.  Indeed I can only see Stefan's sig there on the key server:
> >
> > https://keyserver.ubuntu.com/pks/lookup?search=3b5fcccdf3abd706&fingerprint=on&op=index
> >
> > I am guessing Juan forgot to do a "gpg --send-keys 3B5FCCCDF3ABD706". I'll
> > also try to ask maybe one or two more people to exchange keys.  Maybe
> > that'll also help.
>
> Besides that, just now I also tried to do a remote --recv-keys on my own
> key and I found that indeed the signature from Stefan was not attached.
>
> Then I found this:
>
> https://daniel-lange.com/archives/178-Getting-gpg-to-import-signatures-again.html
>
> So it seems the default behavior of gpg command changed recently that it'll
> stop to receive signatures besides the self signature to avoid DoS to the
> keyservers.
>
> https://dev.gnupg.org/rG23c978640812d123eaffd4108744bdfcf48f7c93
>
> In short, now we seem to need:
>
>   $ gpg --recv-keys --keyserver-option no-self-sigs-only $KEY_ID
>
> To recover the old behavior to receive signs from others.

Ah, thank you. Yes, that did the trick and I now can see the
signatures on your key from other people.

-- PMM

