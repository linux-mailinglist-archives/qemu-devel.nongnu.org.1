Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB17921FC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTce-0001Lh-TI; Tue, 05 Sep 2023 06:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdTcc-0001L6-Dp
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdTcZ-0005kE-Ou
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693910961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auviijGTnvOn7CdDLLZ6JIiGQHDT3hn9DMbRuwR3FSQ=;
 b=HjSw5JfvtvbRJ39/k82pLQWpz/4ucKtV/UAtTyfjO5yGBtFEMkwokCYkfn3NLjx1eGY8X4
 qsoC6OMt4e7JuRLMYy+x5l8sVynMvSClB8X1oqo020AIkyHUW6JOz9zJEsVgl6X5J/1PZC
 KkefpM9MHs9PSytNS7pgWYbaOI5VOJ0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-qevSu5rbNqqAnoVqmF1XoA-1; Tue, 05 Sep 2023 06:49:19 -0400
X-MC-Unique: qevSu5rbNqqAnoVqmF1XoA-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-44ea3b36cb9so597172137.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693910959; x=1694515759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auviijGTnvOn7CdDLLZ6JIiGQHDT3hn9DMbRuwR3FSQ=;
 b=dGmnGPSXLgVoiXH8bcKE0IJlTgXRe+b/Y+PUk1YJ1tp5zA9pBHLcqVs7o5y86OK1oW
 wNDrtjcuoMGytIRg6Lqj14kQHYhgW/Ktq27oj1MAzfeTNJ2Y7LNCo+HtZsIHVtH6Nq6t
 b7JIr+OSjsXPGAZeuDMgWf0PMDp0LnxvM3Aqr4hN8q00uxZjtJ1HF0JM4o4KurlaQMoZ
 55sVWucn6n6LC7TneK4Mwn3E8I7mIvguZhIRL+dI19UFCNM0ZTL+gv+Tm2SMESG+2EOw
 /r9vEMCpNs8JQGoPAZEt6dbxbV2l/IDJUxQeaZTX0HnnY4eBYIuIAVMTkOQm0Y5dtXoR
 fG7g==
X-Gm-Message-State: AOJu0YzGjaTJW5Go/5IyAxqX6iTlQ64qwBY7Pd6c+DbAvDL3eKXNfmcQ
 BwcMDWYkEmm43+p+BOX1+5g7gkF26sTBO7+kmQdOoPzio7j5bFqa4rkrutIxm/9ydaP4ZCR9CZe
 tth60p9tHxIe5V/RbyJNzPshtcleNSBc=
X-Received: by 2002:a67:ec55:0:b0:44e:8ef9:3371 with SMTP id
 z21-20020a67ec55000000b0044e8ef93371mr11216031vso.8.1693910959018; 
 Tue, 05 Sep 2023 03:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGusEYRP2WIxFb5UglwkDslzNCmDX2HRzgcz7kbDu6UaMqwhf36g95sHzaYO+3uHMj6WzdrrwqzXqXQWNNUexk=
X-Received: by 2002:a67:ec55:0:b0:44e:8ef9:3371 with SMTP id
 z21-20020a67ec55000000b0044e8ef93371mr11216027vso.8.1693910958767; Tue, 05
 Sep 2023 03:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <eac059f4-72e2-d1fe-27b2-9657d1777e45@ventanamicro.com>
 <CABgObfYPYH=78UV3gk1m7xv8_=F7KwVxyj9J=uHZ8fCAA6FHmA@mail.gmail.com>
In-Reply-To: <CABgObfYPYH=78UV3gk1m7xv8_=F7KwVxyj9J=uHZ8fCAA6FHmA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Sep 2023 12:49:07 +0200
Message-ID: <CABgObfZGDrKoMZ9oOWHw-Xp0z+Z033bYqW0qyh97h6_h5eno2Q@mail.gmail.com>
Subject: Re: 'check-avocado' fails after c03f57fd5b ("Revert "tests: Use
 separate ...")
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Tue, Sep 5, 2023 at 12:39=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> > /home/danielhb/work/test/qemu/build/pyvenv/bin/python3 -B python/script=
s/mkvenv.py ensuregroup --online /home/danielhb/work/test/qemu/pythondeps.t=
oml avocado
> > mkvenv: checking for avocado-framework(>=3D88.1, <93.0)
> > mkvenv: checking for pycdlib>=3D1.11.0
> >    AVOCADO tests/avocado
> > /home/danielhb/work/test/qemu/build/pyvenv/bin/python3: No module named=
 avocado.__main__; 'avocado' is a package and cannot be directly executed
> > make: *** [/home/danielhb/work/test/qemu/tests/Makefile.include:139: ch=
eck-avocado] Error 1
>
> Can you run it with "V=3D1" and also "cat
> /home/danielhb/work/test/qemu/build/pyvenv/bin/avocado" please?

Also:

1) run the following under the pyvenv/bin/python3 REPL:

from importlib.metadata import distribution
avocado =3D distribution('avocado-framework')
next((x for x in avocado.entry_points if x.name =3D=3D 'avocado'))

FWIW here with a similar system I get

EntryPoint(name=3D'avocado', value=3D'avocado.core.main:main',
group=3D'console_scripts')

2) try running "pyvenv/bin/avocado --help" and see if it works

Paolo


