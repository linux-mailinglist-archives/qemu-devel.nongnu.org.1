Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C873EBC3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 22:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsk1-00035F-JJ; Mon, 26 Jun 2023 16:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsjw-00033l-TQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:23:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsju-0004bo-DP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:23:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31297125334so3263933f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687810988; x=1690402988;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oh7orIRxmqAh9touFfIQ3i81Vq6+d6bKsd0MmZRWUFE=;
 b=ZFWzYW3JVsSTnWB98K1Eg9az/UgnELKL/7gnktU/PpEMxPJyx4wewe0M3D/tjFRcsp
 zDjpWRUpGP0uIz0Uv73CZ0y8A6TjcVVF2p4pTpV89tl0wyWvz2Becf+o7xSpYSmijl+S
 S3JyOXMOgeX3TzHQid2lEq9wMAuVPUwema9/0Z4pF5+rtUXtyVn5365r/Lzuej/U7kDN
 DvxK8fQ8CohsWsBmeZPobjlksCV7KSWo6mxmuTQJSRZAEyHjemWSi8VEAqkCN248VifY
 26OO1Xx87ZBh2BKRnSucNZXxLh9ifGzfUzcXu1QepsFDLBbSpzf+e+rsj0eKU7QCkyFa
 Ob4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687810988; x=1690402988;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oh7orIRxmqAh9touFfIQ3i81Vq6+d6bKsd0MmZRWUFE=;
 b=LxYI26lD3YYmi7jruCc4bZ1GbyXxAEoLAej9P8Iy4PMS4laW/4BG/jvxybDlbzYSoC
 jMpngWFGfhcSayopRx7G+4nXYZqLEMaGR0t7A4Ho4HPrrLG7DGBmzSRoNKSI933618T3
 ncigZLvRZc1YNn9upBbotNTw/v2I+6gDBvDff+Sp0rg6lCIJEDaTrbLK0BZ6uk0SCTrU
 wq8zutqm+I82Gg/Fcg66BzZ58WeAtHskG7kWHP34hK68Htr4NBwiNhGVzEn/BXAYFunR
 43UbGVtimAzv0zprntuoZSXWgWk1tN7eJP0DrYOyBYo9w3VDvMC5LfKRXiHmd8lYAwz6
 1LZw==
X-Gm-Message-State: AC+VfDy2uc1z9KHBbXXwmxCsNuAeCXP2dpiOHWDiH0D8AxqqxRsxIQlz
 7ZlO5Gj/Hnnv6C80k4AsY+82xA==
X-Google-Smtp-Source: ACHHUZ7fQpa4969tiXnoT6HgwW2GpyBFDSsIxueIHdewArHlGcJPFRRphW8/Ali/DuQoTHMtK5StXQ==
X-Received: by 2002:a5d:45c9:0:b0:313:e88d:e6d3 with SMTP id
 b9-20020a5d45c9000000b00313e88de6d3mr6429956wrs.14.1687810988572; 
 Mon, 26 Jun 2023 13:23:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4649000000b0031118d80246sm8278477wrs.29.2023.06.26.13.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 13:23:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7DB6E1FFBB;
 Mon, 26 Jun 2023 21:23:07 +0100 (BST)
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-8-alex.bennee@linaro.org>
 <CAFEAcA8QX55yeTb+DFxwzd=ntOS8nH95xtQKPNGLiQRvC1=Fcg@mail.gmail.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Bandan Das
 <bsd@redhat.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng
 <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH 07/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Mon, 26 Jun 2023 21:21:14 +0100
In-reply-to: <CAFEAcA8QX55yeTb+DFxwzd=ntOS8nH95xtQKPNGLiQRvC1=Fcg@mail.gmail.com>
Message-ID: <87zg4m0y8k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 23 Jun 2023 at 13:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
>> as an overly wide shift attempt.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Same comments as on the first version of this patch:
> looks OK code-wise, but have you eyeballed the output?

I've eyeballed it but practically it doesn't seem to make any difference
to the output:

  =F0=9F=95=9921:20:36 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/=
22) [$!?]=20
  =E2=9E=9C  diff -ub gb.before gb.after
  =F0=9F=95=9921:20:43 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/=
22) [$!?]=20
  =E2=9E=9C  diff -ub ara.before ara.after

> Does the keyboard layout that triggers this have no
> AltGr at all, or does it call it by a different name?

Certainly not ara or gb:

  9: Alt
23:#    11: LAlt
24:#    12: RAlt
29:#    17: AltGr
294:Alt_L 0x38
1711:Alt_R 0xb8
=F0=9F=95=9921:22:14 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/22=
) [$!?]=20
=E2=9E=9C  ag "Alt" gb.after=20
21:#     9: Alt
23:#    11: LAlt
24:#    12: RAlt
29:#    17: AltGr
338:Alt_L 0x38
1757:Alt_R 0xb8

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

