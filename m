Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920773DB7A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDic3-0002cl-4j; Mon, 26 Jun 2023 05:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDiby-0002by-Cs; Mon, 26 Jun 2023 05:34:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDibw-00025U-6R; Mon, 26 Jun 2023 05:34:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-666e6ecb52dso1284708b3a.2; 
 Mon, 26 Jun 2023 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687772053; x=1690364053;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW15eKBe9Bt15o5KjTb/As2EuSBzaz+HD6L8Bkh/djU=;
 b=ZmoTohx6CjgXEbrK1JJM/RLqFzZqR2D8c6aRrO1zVcM92/KyDlvqATihFMPY8tU84F
 V7argdcO+6/Marm25cW9y9Ao8TV7GLDxDm3gNGPnS1Bp0sQCvoRKwOVRMH5LcNSLLd0J
 KWoowJva3wqdRi0YhRE9BxqYpIuAvQcoJCCZuaZcqL3R4Oq4JEXyqikPfKnQ56Xj7mfp
 MxCKwAK7U/J3kgnBBdV2/72dKZVP+0uHA2nKbaRb5Tx0LbDJGNfL07Q2VuMJ1m8J5y6Y
 KD9y3GKhbCieQ7igh8MKUT+tKy0imKyKG6+taj3ISoQrX1SmyAbzxdRNUdWV+HbLKTgi
 8KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687772053; x=1690364053;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eW15eKBe9Bt15o5KjTb/As2EuSBzaz+HD6L8Bkh/djU=;
 b=lHUbuKkPDNIwbBDPZcv5GkPgiIjvYM4Y6iQEGj5NIkt8gVlgiK6yw8GuAVrby5Urw/
 E8qcBy3zElvI944g28cW3gEZ9yNpNR6aeT2noqsP34bHVvVn1EJOf7g7FVUaYk2gRwbo
 +/p5aOF2VEjyaCyaTOD4nkgHUdQphSPnbU5R2gYvnYzhoQw3/ILaNZVGCf8SWPJckHhk
 ampA/rmC+C8RepT6QVGyCZ26DWV8b/iH8DZi4Pytdz+cuwzoswud1bC6Cx/jzUUbi788
 /mHcDRQEHBNkmv2G5t9CyhFWjs10OEfZSKgfV5NnvSYX5rhbK31dr4td5XEKevnLcSLC
 oI+Q==
X-Gm-Message-State: AC+VfDxNe9euQi6ThKOm3XBaDf/TpvreArKj+kDOQPlB/h5OSVsbPaU9
 c8SIP+yQIUQhPUdStRw6RLc=
X-Google-Smtp-Source: ACHHUZ4nwE/SZgfUDGXSdHsG77ml1E8Ci1ZL4v6mWtJwlp3FK+nmhy29isjwmjxqz2/ZkmVFhVzX2A==
X-Received: by 2002:a05:6a00:2482:b0:66a:6339:e909 with SMTP id
 c2-20020a056a00248200b0066a6339e909mr8388114pfv.11.1687772053163; 
 Mon, 26 Jun 2023 02:34:13 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 h20-20020aa786d4000000b00677af363905sm1280931pfo.59.2023.06.26.02.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 02:34:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jun 2023 19:34:03 +1000
Message-Id: <CTMH98YLMT2F.2C2Q4KXXZMEB1@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "John Snow"
 <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>, "Richard Henderson"
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 7/7] tests/avocado: ppc64 pseries reverse debugging test
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-8-npiggin@gmail.com>
 <74691561-c288-abf5-9673-6e230d55b813@ispras.ru>
In-Reply-To: <74691561-c288-abf5-9673-6e230d55b813@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Mon Jun 26, 2023 at 5:49 PM AEST, Pavel Dovgalyuk wrote:
> On 23.06.2023 15:57, Nicholas Piggin wrote:
> > pseries can run reverse-debugging well enough to pass basic tests.
> >=20
> > There is strangeness with reverse-continue possibly relating to a bp
> > being set on the first instruction or on a snapshot, that causes
> > the PC to be reported on the first instruction rather than last
> > breakpoint, so a workaround is added for that for now.
>
> It means that the test reveals some kind of a bug in PPC debugging=20
> server implementation.
> In this case it is better to fix that instead of adding workaround.

I agree, and I'm trying to find the cause it hasn't been easy. I
thought the test was still interesting because it otherwise seems
to work well, but hopefully I can find the issue before long.

Thanks,
Nick

>
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/avocado/reverse_debugging.py | 28 +++++++++++++++++++++++++++-
> >   1 file changed, 27 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse=
_debugging.py
> > index 680c314cfc..553c931994 100644
> > --- a/tests/avocado/reverse_debugging.py
> > +++ b/tests/avocado/reverse_debugging.py
> > @@ -94,7 +94,7 @@ def gdb_bstep(g):
> >       def vm_get_icount(vm):
> >           return vm.qmp('query-replay')['return']['icount']
> >  =20
> > -    def reverse_debugging(self, shift=3D7, args=3DNone):
> > +    def reverse_debugging(self, shift=3D7, args=3DNone, initial_skip=
=3DFalse):
> >           logger =3D logging.getLogger('replay')
> >  =20
> >           # create qcow2 for snapshots
> > @@ -135,6 +135,10 @@ def reverse_debugging(self, shift=3D7, args=3DNone=
):
> >               self.fail('Reverse continue is not supported by QEMU')
> >  =20
> >           logger.info('stepping forward')
> > +
> > +        if initial_skip:
> > +            self.gdb_step(g)
> > +
> >           steps =3D []
> >           # record first instruction addresses
> >           for _ in range(self.STEPS):
> > @@ -216,3 +220,25 @@ def test_aarch64_virt(self):
> >  =20
> >           self.reverse_debugging(
> >               args=3D('-kernel', kernel_path))
> > +
> > +class ReverseDebugging_ppc64(ReverseDebugging):
> > +    """
> > +    :avocado: tags=3Daccel:tcg
> > +    """
> > +
> > +    REG_PC =3D 0x40
> > +
> > +    # unidentified gitlab timeout problem
> > +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> > +    def test_ppc64_pseries(self):
> > +        """
> > +        :avocado: tags=3Darch:ppc64
> > +        :avocado: tags=3Dmachine:pseries
> > +        """
> > +        # start with BIOS only
> > +        self.endian_is_le =3D False
> > +        # reverse-continue fails (seems to end up at the start) if a b=
reak
> > +        # is put on the first instruction. initial_skip skips one befo=
re the
> > +        # first bp, and it works. Could be due to break at the same ic=
ount
> > +        # as the snapshot?
> > +        self.reverse_debugging(initial_skip=3DTrue)


