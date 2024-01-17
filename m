Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA7830CD6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:41:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQAqC-0003tI-PP; Wed, 17 Jan 2024 13:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQApz-0003so-FJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:40:31 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQApr-0000tO-4m
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:40:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3376d424a79so9154357f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 10:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705516821; x=1706121621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZeppGXx5nUys2HS8j9EEaf2EFUTGWiF4DpHucRhs4Y=;
 b=PP/yGnAawWg2dIsmF7KuQIV7nMwW+77RMKztmY8kVFVEopD1cw1AOishj8Yg7FxFGl
 rXwMJfZIxAD6+oka2WZwTsRweQvjG04jcjJGyHjaanTZ0qNYZMuf96E5En45iiZHay3E
 KN1920NfY3rjtJkYUjoqIzzpCg/M0+YI+SCWw42HkwReOkLo3bUTL+OHU0ng8qquCaZ1
 SCWxRUEmNcu9KQxbpX1wZqGzi1b7LjSEjrGafc3NA2DxlMoEsZZJUud0Ol0NIoK523pG
 rBrgsB/bZnoie/0I1hccWHocTyUSzmWlQhGRTEQ2O9l7tcILyJOq5/7U9Ca5ZWUdo/0s
 3I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705516821; x=1706121621;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZeppGXx5nUys2HS8j9EEaf2EFUTGWiF4DpHucRhs4Y=;
 b=e9YLnUGwvXe9oMLV8Q3PaLax5GzNc7auqha1e+dJrjyIl/ZkGl1KFbLypC068mkHSs
 ZffKy5Q/jR58/xlPSYF+E3RH41m3M6H858gnbaTY2TbEu8AsDS3a+PW+km+CK7junPt2
 9CgP+ac9Bu8t5gpRWBHgGlmYGYXtjJxSlKYKMEOlzy2/eLsfOzmfxzv0SCx7f81CC0H2
 phi6CCY1x54PKbXLuStKKocIKeNYqPX0A1PYoTaxP5M/1Q5tyTMMpS5Hmr5wy5NCPCUd
 Rr02wAWCA6kb23NS4wQ7n42bkLzG6MRgmlktil3iD3IUMoW73+EZXqKNxIyrUeWWcmqe
 ZUXQ==
X-Gm-Message-State: AOJu0Yz6v8Uwf/M4PJGP1+Pu8iWVa3xhdjFJvHxl5TF/8AR+Yphgnk99
 IzguARyAaT1s4hi5PVR6D2Ym+EQSpMqftQ==
X-Google-Smtp-Source: AGHT+IHbfEwBGP/fILw6BipyLQZF/PY3rST3ESHo1fBtHDU0qc/TRoxp6YGxhdlmKJe+PNdFNxszAQ==
X-Received: by 2002:a5d:6211:0:b0:336:7885:e387 with SMTP id
 y17-20020a5d6211000000b003367885e387mr4631536wru.57.1705516821603; 
 Wed, 17 Jan 2024 10:40:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0033668b27f8fsm2255431wrp.4.2024.01.17.10.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 10:40:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E348D5F8D8;
 Wed, 17 Jan 2024 18:40:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 bug-hurd@gnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] Allow tests to be disabled
In-Reply-To: <CAHP40m=pB6aOdoUL36vC=_ku2ynNj6j6n0PC4DkwCgSd5D2OPQ@mail.gmail.com>
 (Manolo de Medici's message of "Wed, 17 Jan 2024 19:14:02 +0100")
References: <CAHP40mkDymmXdvFUAEpiBTbVuaRUHVfW8UTdyuSDhoG4Ro+yzA@mail.gmail.com>
 <CAFEAcA_oEMqmc-coCSYpZw8vN+NSLYRQBowaDAR0i8vevoM3zQ@mail.gmail.com>
 <CAHP40m=pB6aOdoUL36vC=_ku2ynNj6j6n0PC4DkwCgSd5D2OPQ@mail.gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 17 Jan 2024 18:40:20 +0000
Message-ID: <87ttnbhkh7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Manolo de Medici <manolodemedici@gmail.com> writes:

> I agree with you, I mentioned that this was the "minimal effort"
> patchset to get qemu compilable.
>
> On Wed, Jan 17, 2024 at 6:35=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> [...]
>> should be guarded by a suitable check that means we don't
>> try to build it on hosts that don't have the host-specific
>> functions/whatever that it needs.
>
> This is the best solution for this problem, any pointers on how to
> best do this?

Look in tests/qtest/meson.build for lines like:

  config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-test'] : [])

It seems we have a bunch of logic for qtests_i386 and qtests_aarch64
which isn't applied to the qtests list. Commenting those out I still get
the full list:

 meson test --list | grep tpm
 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-test
 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test
 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-i2c-test
 qemu:qtest+qtest-arm / qtest-arm/tpm-tis-i2c-test
 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test
 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-swtpm-test
 qemu:qtest+qtest-i386 / qtest-i386/tpm-tis-test
 qemu:qtest+qtest-i386 / qtest-i386/tpm-tis-swtpm-test
 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test
 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-swtpm-test
 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-tis-test
 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-tis-swtpm-test

But I guess there are there to ensure the dependencies are correct so
I'm sure that's not the right fix.

Paolo,

Where is that meant to be done?

>
> Thanks
>
> On Wed, Jan 17, 2024 at 6:35=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Wed, 17 Jan 2024 at 12:59, Manolo de Medici <manolodemedici@gmail.com=
> wrote:
>> >
>> > tests/qtest/tpm-* compilation is not disabled by disable-tpm,
>> > for this reason compilation fails on systems that doesn't
>> > support the linux/bsd TPM api. Fix this by allowing tests
>> > to be disabled.
>>
>> This isn't the right way to fix this. Either the tpm test
>> code has portability issues that can be fixed, or else it
>> should be guarded by a suitable check that means we don't
>> try to build it on hosts that don't have the host-specific
>> functions/whatever that it needs.
>>
>> thanks
>> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

