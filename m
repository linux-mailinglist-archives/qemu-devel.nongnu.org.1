Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B77E28D7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:36:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01eG-0000IP-SE; Mon, 06 Nov 2023 10:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r01du-00084H-LB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:35:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r01dp-0004vS-Cd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:35:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso28181175e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284951; x=1699889751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GH8LNuoVZYfXx5IOFVr7wSXy+LzChIBJaYy6Tg1fBeY=;
 b=p3tLyRvAUuPHoRmOwteUeZScvbbZn7KtkXwdOYTA9EbXJ9VxHi//Kuk3bY4Z2GyIUz
 tuojbm/nbk1nD67NDNcIxcPuYttV98soxThETmtqcwOoq2gQJu3ushiOG3hQ861W8rP4
 7b1Ss0wbEdQiCHY8KkP7/JN0xr30RMnk8Ec6ZfdJh0nPo2bgQhjguA0hi9CqUf8krL83
 VoDclp26N//7e9lxS+siYEmGOvwK0/vzkIsQ5ua3exfgGELT9g7E5pk0g4Bn6QJKj4zC
 xVTvqUAt8VO8CbSit7R17pB48Frz7uwUtMJEUMueayQujbzPZtZx2Qhbi7PGwb13sKT3
 Sweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284951; x=1699889751;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GH8LNuoVZYfXx5IOFVr7wSXy+LzChIBJaYy6Tg1fBeY=;
 b=MMEc1to4E6wEkgDCH6LVKRUwc6LI8gQf+qpe82VbkX3fjNiXi9X/Om6SAoOCyRC5aI
 uHQSAZ1zVwU8uzNNM7WlLa6I3O1HDWcUz45e/iZ4QriKYmpQabkdhYzJmVsLsd+sSeXE
 JmAoLVFMd7ei5faPORTeVe8rexfOljr91Yq4VtPtDI2R4J+K31UR/tim585WWh6bZYcb
 6LhxZ0Jc+eezUjt4Q6UWMZwPbebwp/6+5B8VYo7PznAJLfs70D66IxGf/UZY1HTOKwXh
 oZowAXOwHB4c6pwvn37aMMpVXJK8itnBhcLJVfoG/4EIzg5EB7ejnGqlGzdel/hV/md3
 oOng==
X-Gm-Message-State: AOJu0Yx4RkrqjpenzaWnOx2TuHh88hcNDv95iVzPH2HMtTpbp79xJswJ
 /m+J0TSHKvX+nwxB/zOPdMI+bg==
X-Google-Smtp-Source: AGHT+IEUoO4lZZWmpNMtbYFKQ3Ltt4+4MxzE+uwalVlkgY5FDSaZ9CVVgv5eyKfBsEmGHS5Z9hFagw==
X-Received: by 2002:a05:600c:3ba2:b0:401:c7ec:b930 with SMTP id
 n34-20020a05600c3ba200b00401c7ecb930mr44039wms.10.1699284951286; 
 Mon, 06 Nov 2023 07:35:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m1-20020a056000180100b0031980783d78sm9737891wrh.54.2023.11.06.07.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:35:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7EE9A5F79F;
 Mon,  6 Nov 2023 15:35:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Song Gao <gaosong@loongson.cn>,
 qemu-arm@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Weiwei Li
 <liweiwei@iscas.ac.cn>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Paolo Bonzini <pbonzini@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Brian Cain <bcain@quicinc.com>,
 qemu-ppc@nongnu.org,  Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alistair Francis
 <alistair.francis@wdc.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>,  qemu-s390x@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,  Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Bin Meng <bin.meng@windriver.com>,  Beraldo
 Leal <bleal@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Michael Rolnik <mrolnik@gmail.com>
Subject: Re: [PATCH 13/29] target/riscv: Use GDBFeature for dynamic XML
In-Reply-To: <87a5rrdy6d.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of
 "Mon, 06 Nov 2023 09:32:42 +0000 (6 hours, 1 minute, 47 seconds ago)")
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-14-alex.bennee@linaro.org>
 <87a5rrdy6d.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 15:35:50 +0000
Message-ID: <875y2edhd5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> In preparation for a change to use GDBFeature as a parameter of
>> gdb_register_coprocessor(), convert the internal representation of
>> dynamic feature from plain XML to GDBFeature.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20231025093128.33116-7-akihiko.odaki@daynix.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I bisected the following failure:
>
>  ./qemu-riscv64 -g 1234 ./tests/tcg/riscv64-linux-user/sha512
>
> and:
>
>  gdb-multiarch ./tests/tcg/riscv64-linux-user/sha512 -ex "target remote l=
ocalhost:1234" -x ../../tests/tcg/multiarch/gdbstub/registers.py
>
> gives:
>
> warning: Architecture rejected target-supplied description
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...

I don't know if the discontinuous register numbering could be the
problem:

  <feature name=3D"org.gnu.gdb.riscv.csr">
    <reg name=3D"fflags" bitsize=3D"64" type=3D"int" regnum=3D"67"/>
    <reg name=3D"frm" bitsize=3D"64" type=3D"int" regnum=3D"68"/>
    <reg name=3D"fcsr" bitsize=3D"64" type=3D"int" regnum=3D"69"/>
    <reg name=3D"cycle" bitsize=3D"64" type=3D"int" regnum=3D"3138"/>
    <reg name=3D"time" bitsize=3D"64" type=3D"int" regnum=3D"3139"/>
    <reg name=3D"instret" bitsize=3D"64" type=3D"int" regnum=3D"3140"/>
  </feature>

?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

