Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD337E5A92
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 16:56:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ktJ-0000z9-Am; Wed, 08 Nov 2023 10:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0ktF-0000vu-Pe
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:54:51 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0kt9-0006bW-6l
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:54:46 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c5720a321aso92897291fa.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 07:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699458874; x=1700063674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPj+hhoX5oJim/6+cL4jO+vG0waKMeo7DPnTNQdMfAg=;
 b=R2tCdhiEdGy+3GstDWAIqzQ9Edbor4P+gwvoEY0UL+De8phe/76ESaPpnhS0GZDTUp
 fjkr1YnBDOK0eQiocCX2i1Rb20q7xe9rZXOyshZFZmg7MdxqiQCTB+wHlXWA406ZBOUi
 aBCBaPe45P4brrvGoTalOBWYhUMUYUUNYdE2nsSajBb+ByqsHodupRP5kP/UTr4+KxtJ
 whpQ280YfG0a54Gjcras0f82REQP5HXyS1QfzKS8/UDPQEzfPUuQ/US9qVZbiG9wer3k
 CGfvIpZD/gDIBbz6Wnl3ylA+wV/B8vX+4X19jbs3nmHzEpv1eHxKP2gJxPSxiuly2e3d
 BWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699458874; x=1700063674;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sPj+hhoX5oJim/6+cL4jO+vG0waKMeo7DPnTNQdMfAg=;
 b=K46zoJ22KS83qqMVUA1yMoRWj9HQbsJSBDOmBAvq1RkENYqB2lYomzxaWgEwbRVbbn
 5lxgNXcHGRtPA/PFTLc/q7P3rU1jcOqc6t5dCE8uaM2YNJCZShLvlMlzYTZWs7wZ5l39
 D5tifHS5Lk4mX5BYFlJDVtPxPpC8454IWALyuz71u0Hroyc0dbG8LsLr72AjklkuNR83
 YkqXhU40pjXOklpLtBdoWF6rQjF2C6FBtZ/uOvPn6tBpLNNWSROfEMbf6s8tg1zdQHkh
 Rx5Ei4qWZMpj5SoF0keu1idIehvgWVsUGGppOZ2qdePPhgDmet53OpFb3OW7PEGLYaD5
 bp+Q==
X-Gm-Message-State: AOJu0YwtWKl5D6gG/GaPieZbBcGcQi6F61HLMBVd/Y3y3CqxlKPWaPwb
 YnAFL4adukEbiCTgmdoimx+rMUS1NJ5WjnZ1UkS/Pg==
X-Google-Smtp-Source: AGHT+IFTV8wG7pUYdKP5/gRZIxIvkXojlQBPGQ83OAMpm+Io7ih7Lwl7FXFRCFIWEWF+ySO0bp618w==
X-Received: by 2002:a05:651c:c97:b0:2c5:52d:c9ff with SMTP id
 bz23-20020a05651c0c9700b002c5052dc9ffmr2855745ljb.10.1699458874640; 
 Wed, 08 Nov 2023 07:54:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m23-20020a05600c461700b004060f0a0fdbsm19068191wmo.41.2023.11.08.07.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 07:54:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD63F5F751;
 Wed,  8 Nov 2023 15:54:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/23] Final test, gdbstub, plugin and gitdm updates for 8.2
In-Reply-To: <CAJSP0QU5eNAVBskQDNq7eSHvhdVcaunAMWUxYEWWkF0gOjp-CQ@mail.gmail.com>
 (Stefan Hajnoczi's message of "Wed, 8 Nov 2023 20:36:33 +0800 (3
 hours, 5 minutes, 43 seconds ago)")
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
 <CAJSP0QU5eNAVBskQDNq7eSHvhdVcaunAMWUxYEWWkF0gOjp-CQ@mail.gmail.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Wed, 08 Nov 2023 15:54:33 +0000
Message-ID: <8734xg9r5y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22d.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, 7 Nov 2023 at 22:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b=
683:
>>
>>   Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau=
/qemu into staging (2023-11-07 19:00:03 +0800)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-halloween-omnibus-071123=
-1
>>
>> for you to fetch changes up to 00da668de6856d912cd75474ba759927e29d0e49:
>>
>>   Revert "tests/tcg/nios2: Re-enable linux-user tests" (2023-11-07 14:18=
:29 +0000)
>>
>> ----------------------------------------------------------------
>> Final test, gdbstub, plugin and gitdm updates for 8.2
>>
>>   - fix duplicate register in arm xml
>>   - hide various duplicate system registers from gdbstub
>>   - add new gdb register test to the CI (skipping s390x/ppc64 for now)
>>   - introduce GDBFeatureBuilder
>>   - move plugin initialisation to after vCPU init completes
>>   - enable building TCG plugins on Windows platform
>
> Hi Alex,
> Please take a look at the following CI failure:
>
> i686-w64-mingw32-gcc -m32 -o tests/plugin/libempty.dll
> plugins/qemu_plugin_api.lib tests/plugin/libempty.dll.p/empty.c.obj
> tests/plugin/libempty.dll.p/.._.._contrib_plugins_win32_linker.c.obj
> -Wl,--allow-shlib-undefined -shared -Wl,--start-group
> -Wl,--out-implib=3Dtests/plugin/libempty.dll.a -fstack-protector-strong
> -Wl,--no-seh -Wl,--nxcompat -Wl,--dynamicbase -Wl,--warn-common
> /usr/i686-w64-mingw32/sys-root/mingw/lib/libglib-2.0.dll.a
> /usr/i686-w64-mingw32/sys-root/mingw/lib/libintl.dll.a
> /usr/i686-w64-mingw32/sys-root/mingw/lib/libgmodule-2.0.dll.a
> -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32
> -luuid -lcomdlg32 -ladvapi32 -Wl,--end-group
> /usr/lib/gcc/i686-w64-mingw32/12.2.1/../../../../i686-w64-mingw32/bin/ld:
> tests/plugin/libempty.dll.p/empty.c.obj: in function
> `qemu_plugin_install':
> /builds/qemu-project/qemu/build/../tests/plugin/empty.c:30: undefined
> reference to `_imp__qemu_plugin_register_vcpu_tb_trans_cb'
> collect2: error: ld returned 1 exit status
>
> https://gitlab.com/qemu-project/qemu/-/jobs/5487689202

Please see:

  Message-Id: <20231108151743.3834165-1-alex.bennee@linaro.org>
  Date: Wed,  8 Nov 2023 15:17:43 +0000
  Subject: [PULL v2 00/23] Final test, gdbstub, plugin and gitdm updates fo=
r 8.2
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

CI currently running:

  https://gitlab.com/stsquad/qemu/-/pipelines/1065418931

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

