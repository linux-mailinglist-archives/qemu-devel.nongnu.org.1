Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E18AF7C46CC
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 02:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqNDQ-0001Iy-LD; Tue, 10 Oct 2023 20:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqNDO-0001Ii-KD; Tue, 10 Oct 2023 20:36:42 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqNDM-0000Ja-P4; Tue, 10 Oct 2023 20:36:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27752a1e184so5030764a91.3; 
 Tue, 10 Oct 2023 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696984599; x=1697589399; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3VySredyLrOH2ifKTkXYdxvUgqE7ChSU0BXlXlx8lU=;
 b=AZeP9xV2yZnb4yjVjetYH1GQJ8S5TnScaC/ExFDD4cRILrf2mh40cu7D2u5Xo+k/TN
 LXu6S5XI+RGNxmyR9SPHo+rn6YOVEVEXXZX0DLcJAolhXBMXaLF5E2luPAKbVtytGFc0
 U7qYNQVwGbIeshdXrvzIu+AfrJjY0DD3k0tD/jY9QV8CaQ3N9/z97zFNEVGBBbk9hsND
 mh4q9QJrxmApPGSMhOo6QObIS6CQRevzCaFZ4EVsX1DZk6R3d+kJZi6WXVSzJpklg/ED
 fk6ydCZPR2f80BfKaSgWnq80cqD06FCerAVgg19Py1YZX+2sibItPEfIU7HnJrHBviRx
 bHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696984599; x=1697589399;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o3VySredyLrOH2ifKTkXYdxvUgqE7ChSU0BXlXlx8lU=;
 b=fnUTTzCcEeQBY2JVPN66GZ5Hnt1HJtjjUDepvR89qrbhA8IBjLA3ne9Ilv4sX8kL+i
 //x7AdzMAK/Ma3ekoxU/lxnhKbNqgH79xfNrEFm11hlRIHjjsFtegvR5gHPyUg2/vGCg
 aeU+SJkfE8OkKvViucmps19L0qqlad4ZM7q1Re7QZQ2S6PlQMf0hBMGuOLcuYeAdyJk/
 IxUjvgCrmLhKtotxKTmSWny3RG3Ys8p58G6aF9bVt387kWVgIASpxJSeCQNqiOGi017Y
 ybnoEVMzaKbpBPBlBDgbuB1WKXGuelAeqdTBJgk2WPbkUxy1nXnbtRbQqvJn4/qPO7/r
 OT8A==
X-Gm-Message-State: AOJu0YyjO2vwrPmAQNB3DUUH/ss8ngrk+sq8LnTJVIgjzX99uHflX8A5
 u06vKGwkRFcggYuU7ao3lLs=
X-Google-Smtp-Source: AGHT+IHsD2j8h/FQkUq1erx1vaVD1JK0ZChZwzDfwIwT460VD5Ju2wMUSX/3Sm2BH6QnofCLM+/OpQ==
X-Received: by 2002:a17:90a:db8a:b0:274:945b:6979 with SMTP id
 h10-20020a17090adb8a00b00274945b6979mr17769628pjv.16.1696984598802; 
 Tue, 10 Oct 2023 17:36:38 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a17090ae29500b0027768125e24sm465667pjz.39.2023.10.10.17.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 17:36:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 10:36:32 +1000
Message-Id: <CW56TZQEDIBH.36TCETGSU8X47@wheely>
Cc: <qemu-ppc@nongnu.org>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 06/11] tests/avocado: Add FreeBSD distro boot tests
 for ppc
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Warner Losh" <imp@bsdimp.com>
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-7-npiggin@gmail.com>
 <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
In-Reply-To: <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

On Wed Oct 11, 2023 at 7:55 AM AEST, Warner Losh wrote:
> On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin <npiggin@gmail.co=
m> wrote:
>
> > FreeBSD project provides qcow2 images that work well for testing QEMU.
> > Add pseries tests for HPT and Radix, KVM and TCG.
> >
> > Other architectures could be added so this does not get a ppc_ prefix
> > but is instead named similarly to boot_linux.
> >
> > Cc: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > CC'ing Warner to check if it's okay for us to use these images and
> > any comments or suggestions. avocado tests have many Linux boots so we'=
d
> > do much better to expand test coverage by adding some other systems.
> >
>
> I like this.... I'm a little worried at the exact hash encoded in it, but
> since there's a checksum
> to match, it's OK I guess. It will give this code a shelf-life of months,
> IIRC our retention policy.

Oh I didn't realise, I saw some 2021 dates in the directory listing but loo=
ks
like they're not for the artifacts themselves.

I don't suppose you know if there are any long-term artifacts kept
around, or someone who I could ask?

The downside of using short term images is that it can be harder to
reproduce reports from others, bisect, run manual testing, etc. I think
these would still be useful, so long as they get updated regularly.

>
> Other than that, I think this is good. Not familiar enough with Avocado t=
o
> understand
> skipping for gitlab CI, but given the extreme crunch on minutes, I think
> that's OK.

Yeah I'm not sure what the situation there is, I didn't want to add new
tests of any significant weight yet. We could always flip it on later if
people want it.

>
> Other than one nit below which is fine if it is intentionally left behind
> (or removed):
>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
>
> Please don't hesitate to reach out to me if this is failing. I'll act as =
a
> backstop to get
> it to the right people.

Thanks Warner.

>
> Warner
>
>
[snip]

> > +    def run_pseries_test(self, force_HPT=3DFalse):
> > +        # We need zstd for all the tuxrun tests
> > +        # See https://github.com/avocado-framework/avocado/issues/5609
> > +        zstd =3D find_command('zstd', False)
> > +        if zstd is False:
> > +            self.cancel('Could not find "zstd", which is required to '
> > +                        'decompress rootfs')
> > +        self.zstd =3D zstd
> > +
> > +        drive_url =3D ('
> > https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/a2440348eed75bb76=
82579af0905b652747fd016/powerpc/powerpc64le/disk.qcow2.zst
> > ')
> > +        drive_hash =3D '8ab11a05ccab3d44215fd4667a70454ed10a203f'
> > +        drive_path_zstd =3D self.fetch_asset(drive_url,
> > asset_hash=3Ddrive_hash)
> > +        drive_path =3D os.path.join(self.workdir, 'disk.qcow2')
> > +        # archive.zstd_uncompress(drive_path_zstd, drive_path)
> >
>
> Why is this commented out? It looks like a leftover maybe?
>

Ah yes, avocado recently got zstd_uncompress but it seems not
available for QEMU yet so we have to do it by hand. I'll remove.

Thanks,
Nick

