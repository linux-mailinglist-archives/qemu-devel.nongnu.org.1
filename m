Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73482651A
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 17:29:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMW1A-0007Go-Bw; Sun, 07 Jan 2024 11:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rMW0v-0007GL-6f
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 11:28:41 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rMW0t-0001UJ-LQ
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 11:28:40 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-59641a03f31so825894eaf.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 08:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704644917; x=1705249717; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yb4XDeNxoRpbXacAfKmJdYj+NZ9JlJOxh8RK2njUGl8=;
 b=KlgZpbDOtZ3+EjIpTuJkBR5JgPtWUsbzBt4OHZD9KbLn0Dq/XV+55ysnWgDw6B/kYB
 GTk3y4RhEGt3nILVBzpe8xFRlye/F8JQK10xKlbu7yhC/MoyWH7dvDJp7Nmvi9H8+W7w
 AN+Sr443z6cBFVjMdVZkJTQ2QlZPZFLYO54tCK6XtZlS+tHigsZ6MX9VRQHjVXmnJQHB
 hLcNNS+RY/E5aktBMajhMj+dq2lt8w28zisLv9QGQZrWRjNZkQMNIcJMtDyZeIl+VhHZ
 mt7eKNaaUw8kz1+narFfx+IQztPrgOk8u2mM96NIG8lF8Rv7D8oO5NMTi6FJt8FPY0Wv
 phrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704644917; x=1705249717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yb4XDeNxoRpbXacAfKmJdYj+NZ9JlJOxh8RK2njUGl8=;
 b=GxG5RONkg4b4PDwg5JbyNMufhITbzhWULd9D3sJJB49JCK+znYy87ZTNK5YIzz3BxK
 381GgfL6QkKzDriVAIapm0Xi2bKslMlN2h/Eu6gVk5xhHHjJ8b1y3SIwBN2g3VMmDawu
 Vk/WP8JndoUtGsP8m/BDcuZ4bxh63A3NuzQpGQ72Czul//c65llUnpzZjbgxvHdy256L
 pOqp8vzEev3zXvC2X7X2V3Grdy2c91IhL7yXT3Iu62q3amoUPJ2r4x8OnMzd+LjjV9ya
 4ccysDl9V9Y3/fn1xtQR/2NN++Rp+y6yH4qzV/vWqkA8xxMW/VFdXnC79I2G/UyE9RrN
 Ygig==
X-Gm-Message-State: AOJu0Yyd9XsvQsVOvqgELCnXe+ZSDhmMliOWhlehvCAID2n9eVLfXKYy
 tDMfX9nyn/nN9j4Ul2sVRrhy3eYbij3+mZOdtQM=
X-Google-Smtp-Source: AGHT+IHHGoQ99Czpi5ILNZ9j9+LxV7+QzbLGcIqeztEtzKXD0CvFomWn6aB0hMpzyT0KnnkfQuwMjAoMXsZu1MvumAk=
X-Received: by 2002:a05:6820:1ac1:b0:596:3aaf:3eca with SMTP id
 bu1-20020a0568201ac100b005963aaf3ecamr1192866oob.18.1704644917421; Sun, 07
 Jan 2024 08:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
 <ZZqaGf6nt0wkZgbS@x1n>
 <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
 <CAFEAcA9Wx4wcZj2MtBfb7u-y4wrbbjNhbLXA21pqmcrS+T8+hw@mail.gmail.com>
In-Reply-To: <CAFEAcA9Wx4wcZj2MtBfb7u-y4wrbbjNhbLXA21pqmcrS+T8+hw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 7 Jan 2024 11:28:25 -0500
Message-ID: <CAJSP0QX2bmZboYPyQ5AQz-q=n2N4sp=zzzDYvoie=vhiAYQ+7A@mail.gmail.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Steve Sistare <steven.sistare@oracle.com>, Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
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

On Sun, 7 Jan 2024 at 10:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 7 Jan 2024 at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Sun, 7 Jan 2024 at 07:34, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> > > > I notice that your gpg key doesn't seem to be signed by anybody
> > > > else; you might look at whether it's easy to get it signed
> > > > by somebody else (eg some of your redhat colleagues).
> > >
> > > Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
> > > server we normally use?  Maybe I missed some steps there?
> >
> > Yes, Peter's key is signed by me:
> >
> > $ gpg --list-signatures 3B5FCCCDF3ABD706
> > pub   ed25519/0x3B5FCCCDF3ABD706 2023-10-03 [SC]
> >       Key fingerprint = B918 4DC2 0CC4 57DA CF7D  D1A9 3B5F CCCD F3AB D706
> > uid                   [  full  ] Peter Xu <xzpeter@gmail.com>
> > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > <stefanha@redhat.com>
> > uid                   [  full  ] Peter Xu <peterx@redhat.com>
> > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > <stefanha@redhat.com>
> > sub   cv25519/0xD5261EB1CB0C6E45 2023-10-03 [E]
> > sig          0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> >
> > I have pushed to the keyservers again in case I forget.
>
> Thanks. Which keyservers did you use? I think these days the
> keyserver infrastructure is unfortunately fragmented; I
> probably didn't try refreshing from the right keyserver.

I ran gpg --send-key again and it said hkps://keyserver.ubuntu.com.

Stefan

