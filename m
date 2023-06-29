Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC57427AF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEs05-0004Ok-M4; Thu, 29 Jun 2023 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEs01-0004Mu-25
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:47:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qErzz-00054w-Bg
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:47:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31114b46d62so753510f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688046470; x=1690638470;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k61Leyz8RH0uXCD+zz9MjsAGcVT6FxV7QMv15itxANw=;
 b=F3Ffwhm9lCHGfLFPF051JSmAVZ3n5p9y5kZZenbWgkZVOME+UraX+vkLaLyx1ybzeY
 JgYTDowIUUptaUDiWc6+z79cNY5uPaiRCE1cJnmEvqdMkc0LUScsYrKs/tryzRlRIr9f
 XXIkPLDaK7cAuRCNNfLVymG+E8iteaqLuUlx7MmwefDe/ZJ/85OM+RgFfpQhs4hIPQ5G
 AWbZvLKGxmlZGAh0e8ZvcYzoLxqC02Z65iIHSl/m0VAhXdCBadgDtULuCikQI5SGo+Bm
 1u5MqBFGvbuiSfA5VGjvXURWrSaxQDukeCAovZYoke+w6JO9R79tvzwzTU7PBJ3z7SQV
 kpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688046470; x=1690638470;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k61Leyz8RH0uXCD+zz9MjsAGcVT6FxV7QMv15itxANw=;
 b=IGDrONyUyszNPuu/s1p3gBX3Rh9gHR047+lz5sQEOgfyNlNVqnqPCD7NvJ0fnFOe13
 5LqW9PuUzECTnbaP1Rt6dtqLkU+iUE5IjOxsrCGxO0I8eKyXvzRtutxlWlwKZGXvHmxO
 NuZZrOepfx19upZvjEf5RmSA3YfWGSUVpqNbEhGsI7DTUOfsFwLLPuqQCHtSaTCVpF/k
 YAF1hW4yLzEuFXyxWLo6jkUDo/z7nEV4tygnhUKaJ0q5Qt/sKq1HkV0QaXIU1VtUU7yR
 dXTS8tEa8vtPvArpYRQXuRlHjOeRsnkLC89jifLluhp4ccM1EQH3f0z8lBqMfw8lssl1
 gmZA==
X-Gm-Message-State: ABy/qLZNsMnjfPSVoI00Gupv9XNq04YGH2sumhP4kBXUPshLozRIpceY
 QODnWh2BTXYhE2qnWNGNFVVKHw==
X-Google-Smtp-Source: APBJJlFgeiT+zUr8daonrdphk5P9MqBoNy0+Id4b4kOU2Yj1Jl38s0k391tP6UiMZPF9vkb2WU45SA==
X-Received: by 2002:adf:e910:0:b0:314:10fe:2024 with SMTP id
 f16-20020adfe910000000b0031410fe2024mr3147957wrm.70.1688046469858; 
 Thu, 29 Jun 2023 06:47:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0030ae499da59sm903980wrn.111.2023.06.29.06.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 06:47:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB4341FFBB;
 Thu, 29 Jun 2023 14:47:48 +0100 (BST)
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-16-alex.bennee@linaro.org>
 <fd860df5-f8d0-77ef-f99f-629f1631d577@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Juan Quintela <quintela@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Beraldo Leal <bleal@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, Radoslaw
 Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Bandan Das
 <bsd@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Laurent Vivier <lvivier@redhat.com>, Qiuhao
 Li <Qiuhao.Li@outlook.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, Riku
 Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH v3 15/36] tests/docker: convert riscv64-cross to lcitool
Date: Thu, 29 Jun 2023 14:47:44 +0100
In-reply-to: <fd860df5-f8d0-77ef-f99f-629f1631d577@linaro.org>
Message-ID: <87o7kyxtvf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/27/23 18:09, Alex Benn=C3=A9e wrote:
>> --- a/tests/lcitool/projects/qemu-minimal.yml
>> +++ b/tests/lcitool/projects/qemu-minimal.yml
>> @@ -4,6 +4,8 @@ packages:
>>    - bash
>>    - bc
>>    - bison
>> + - ccache
>> + - findutils
>>    - flex
>>    - g++
>>    - gcc
>> @@ -21,3 +23,5 @@ packages:
>>    - pkg-config
>>    - python3
>>    - python3-venv
>> + - sed
>> + - tar
>
> Same comment as against v2: Why not squash this patch with previous,
> which adds qemu-minimal.yml.  Especially since you're changing it here
> in the next patch.

Done.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

