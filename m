Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC907CF92F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSKH-0008HA-7c; Thu, 19 Oct 2023 08:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSKE-0008GK-HJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:40:30 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSKB-0002nR-9V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:40:30 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c514cbbe7eso74568481fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697719225; x=1698324025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8+ZGXg3QALhBBYt5SOXOpRYBAi+zfA4xfcRwbZuMII=;
 b=UAMaWJO6+ngZfH8XxCK+3/30/CvUZsgqBLUU5QyPwykrVtJHqyKHPJveD6YV1msfza
 Wo1VlVBdiqCz/bGqfe+i7haMOrB3H635wZQdiU1EufaU/kqIZ9EERIHU24CnGLbPeoi8
 IY0reIPhc9opLWxro0KCQ/4XBOu5X8B5l0tcUBk5k1+9ektD/eim4/t7vvM56IV0yc1s
 Sm78MzHwPRn2j2QS2xq+Ow3LU7hePCyN6hQ/2mnbI7DoyUzUMZHnJAmOVaGIuw+iBahk
 vtJRpRdJS0NYhTmWhpfcSO2aJJGw55IH1NqlWRpfzqpcSFKYiIEoTNdZkFTb4DHgpKzQ
 Lc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697719225; x=1698324025;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/8+ZGXg3QALhBBYt5SOXOpRYBAi+zfA4xfcRwbZuMII=;
 b=t/qJuzhszFwc4vqqNUHFxgNi5lzsGLvLZ0wMXltdD7H4nc+FcRV9vtjU7zNDAmXRcX
 SnsBj8D0fWfirYP48zjl2FzEYqXJkb2nthPm1HhhbNFwuOGqinM/flptirHVR9zEz571
 /BxgOBOJsCOIHFE64su1eO1h2G1EBcrYbt9dH1zBYpE+t9ily2P0O+Wf2DW0LWyTe4rF
 uVo7OUzKucXp9WzNQo/xlLgGrzP7kdi7C6/1wbEpJc195odHymPVDoxqXD57MW+pkOmk
 XmxVuT2iR2xxrBX8tZjvgMVmOXo57CqE3nXlTxhON0dl28KPVi91/+p+VBkbPiBMJv/4
 zY/g==
X-Gm-Message-State: AOJu0YwHeLc2MNfXQuuV1xA9TdChS7wFG9OPy274ADpnEm1sdDoQGC0o
 VEQw0DvJjptj6NnlMus5i4kDnQ==
X-Google-Smtp-Source: AGHT+IHMr7gnoSTks9bWnl4MgCTmg9A7wTTknuUMeebWWrCjX3qlPGTuV6JKMnto2A285fiFXxyWng==
X-Received: by 2002:a2e:8654:0:b0:2c0:52e:eafa with SMTP id
 i20-20020a2e8654000000b002c0052eeafamr1594579ljj.29.1697719225496; 
 Thu, 19 Oct 2023 05:40:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a5d590b000000b003247d3e5d99sm4405132wrd.55.2023.10.19.05.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:40:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A1ACC1FFBB;
 Thu, 19 Oct 2023 13:40:24 +0100 (BST)
References: <20230731091042.139159-1-akihiko.odaki@daynix.com>
 <20230731091042.139159-3-akihiko.odaki@daynix.com>
 <8df33f0f-c394-5eb8-ca0c-5601790745f8@redhat.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Aurelien Jarno
 <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>, Chris Wulff <crwulff@gmail.com>, Marek
 Vasut <marex@denx.de>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/2] tests/tcg: Add -fno-stack-protector
Date: Thu, 19 Oct 2023 13:40:06 +0100
In-reply-to: <8df33f0f-c394-5eb8-ca0c-5601790745f8@redhat.com>
Message-ID: <87y1fy945j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Thomas Huth <thuth@redhat.com> writes:

> On 31/07/2023 11.10, Akihiko Odaki wrote:
>> A build of GCC 13.2 will have stack protector enabled by default if it
>> was configured with --enable-default-ssp option. For such a compiler,
>> it is necessary to explicitly disable stack protector when linking
>> without standard libraries.
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   tests/tcg/mips/hello-mips.c       | 4 ++--
>>   tests/tcg/Makefile.target         | 2 +-
>>   tests/tcg/aarch64/Makefile.target | 2 +-
>>   tests/tcg/arm/Makefile.target     | 2 +-
>>   tests/tcg/cris/Makefile.target    | 2 +-
>>   tests/tcg/hexagon/Makefile.target | 2 +-
>>   tests/tcg/i386/Makefile.target    | 2 +-
>>   tests/tcg/minilib/Makefile.target | 2 +-
>>   tests/tcg/mips/Makefile.target    | 2 +-
>>   9 files changed, 10 insertions(+), 10 deletions(-)
>> diff --git a/tests/tcg/mips/hello-mips.c
>> b/tests/tcg/mips/hello-mips.c
>> index 4e1cf501af..0ba5f1bf23 100644
>> --- a/tests/tcg/mips/hello-mips.c
>> +++ b/tests/tcg/mips/hello-mips.c
>> @@ -5,8 +5,8 @@
>>   * http://www.linux-mips.org/wiki/MIPSABIHistory
>>   * http://www.linux.com/howtos/Assembly-HOWTO/mips.shtml
>>   *
>> -* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -mabi=3D32 \
>> -*                  -O2 -static -o hello-mips hello-mips.c
>> +* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -fno-stack-protecto=
r \
>> +                   -mabi=3D32 -O2 -static -o hello-mips hello-mips.c
>
> You've lost the "*" at the beginning of the comment line here.
>
> But apart from that nit, the patch looks sane to me.
>
> Cc:-ing Alex Benn=C3=A9e ... could pick this patch up?

Queued to testing/next with tweak to comment, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

