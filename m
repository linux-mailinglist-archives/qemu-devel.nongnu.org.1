Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0377BA0D
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 15:31:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVXeG-0001wP-Eh; Mon, 14 Aug 2023 09:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVXe2-0001qd-Lm
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:30:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVXdz-0000bJ-Qm
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:30:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3197f632449so302328f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692019802; x=1692624602;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVxJFYXPoi/9OovzEtC5taLwJr0dwdS7vpv9hJv9G4U=;
 b=NF9rTpvP4/oSGzXf0pglurSQjWZ38wUDTV38xpDWipxWCcbYhtuTZ9cIDNZVluxpQi
 aH2xG6OWmk31vVQDtzFkmNaRa1E09BwjgDQhxF2R+APsJZ57jTYWaMjdjsM1VSdHNj9j
 gEJptwCppcF2spXUOdxv6Cs0Jhgs39IdIBaLhk4b60Rq+ZwIZnDDb94r6DvBupGv3fYo
 HujiEgp4+z47egJ/B0NDUXpDJefpNKpTjMwTpMfGTU+Jb/soRYEjIWG2u9+uBP45cMKb
 1j9Xfiyn1s01Lm78jg8IZCs58PRec8rexDBoMRirjopM3p7m06YGZ+RNuuL0ob6obz05
 sOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692019802; x=1692624602;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zVxJFYXPoi/9OovzEtC5taLwJr0dwdS7vpv9hJv9G4U=;
 b=fH0o0CmoyseItPTEti/IEYz2IeNLC0FIpjLdZXANmQZiEKCukuB7HuOgP/CyJHFh2k
 okOgoL6ehBFH/vlYz88EqZVN5Y7SGhv4yY8bsBwAguNEZNvj+IZ7kb1cUGoWXrnKGY9h
 Lm9rhhZt7LTu/84JX2oq6iTKrNtKU9pVnie9Gwg60p1TNKxo1PgLu1fUPYHPGJa6t5l8
 Q+d3M5PoMRRCQi/3VeAQosmPZR3YajQH5AzSIBQr8qmPodeKT+OWV0oxMPlEqf1G2g9Y
 D+f34hhEsgPMQFBlAbBoAfn88wtCwf+wawWyNULG2DisC0J3L/70diZmZIfLgPY5r+ud
 QJ7w==
X-Gm-Message-State: AOJu0YzFCNzv8PloeOvAACsDXzinPy0f+z1woG1DQPqCDcgysVXiRpn8
 GpyfrXRbr3nj00XXe3uyiqwzfg==
X-Google-Smtp-Source: AGHT+IFmGced8Zo7QoTy1BHJ7aK7BGsutRTeOWtY2o6wD0A7qawLcTRLt70hwQewPQfg+M8a+rRbWg==
X-Received: by 2002:adf:ce11:0:b0:313:ea84:147a with SMTP id
 p17-20020adfce11000000b00313ea84147amr7071849wrn.64.1692019802251; 
 Mon, 14 Aug 2023 06:30:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a5d550a000000b0031801aa34e2sm14596487wrv.9.2023.08.14.06.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 06:30:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9836A1FFBB;
 Mon, 14 Aug 2023 14:30:01 +0100 (BST)
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-14-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, Aurelien
 Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Chris Wulff
 <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne
 <shorne@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>, Weiwei Li
 <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Max Filippov
 <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH 13/24] hw/core/cpu: Remove gdb_get_dynamic_xml member
Date: Mon, 14 Aug 2023 14:29:53 +0100
In-reply-to: <20230731084354.115015-14-akihiko.odaki@daynix.com>
Message-ID: <87fs4lrbty.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This function is no longer used.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

