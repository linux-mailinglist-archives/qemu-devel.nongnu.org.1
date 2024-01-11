Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B182AEAB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:26:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNu7E-00086p-5d; Thu, 11 Jan 2024 07:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNu79-00085E-M7
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:24:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNu72-0002Ym-86
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:24:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso4742606f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 04:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704975880; x=1705580680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1RkaaWOJSu3tRt3fMogcSn7L2SZU/h+k8yCADoRVlk=;
 b=Nzm10UBhRRiOy1ikGXyY0mur8k+jy0DCPeqqTOd3zdGD85tA9GhNugh0nxRJ0TNIJT
 ZWO1IR41hpTbn4LJTZDap8r4J0UgzBj8B5AFxR/BBlFyUwhNYWLq7gzOrh6xsGqcf/5U
 8xwRPf3xD4BGp/SZuBqdzNYkvZmQEKcXYT+d7kEn/lIfvFsIxQkodS//V3DWMBhz8Hj8
 N4gyRGgY42qmO/2EIO8l55lHbJlBGEzmE/lFXX2ozQr6NAEahy3pSVIDzndyaE3i9rq4
 24B7DH1aNHK8MD5PmtJhcDKKV2eQ/tPgT9XbiFlLOPZ3pdcHRjY3AbEk/D+mMSqDUSvY
 hxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704975880; x=1705580680;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A1RkaaWOJSu3tRt3fMogcSn7L2SZU/h+k8yCADoRVlk=;
 b=rD637TAPwGqZMLZNP1HmJzIxNKAgX9tUTxC4FjAZPr5RcpY8WMd6piwFe0wtfR3Ovi
 0jxEqXNbnh+81IrCT4ohMcEXEshmkD9hzttXqikRZGQy75kfXVzYMB/+tKHr9jmQoByT
 AOfVSA6OA8B2f0B5z1Bm7s2dC9HbilnAUtRf/euLl2uZqWpyHDpyqCcClX67Y+bGw20S
 3wfdt1Mwg3bali2nLUYGudNBt8vVlmOyt4n0bbZ43rvGCS5Iip5udQZg8TH4os1kJxoY
 z4xGX4+Oz380fZEXxwbewGoUOJm0GmEeHuEaK+6F6NbFrzydS47QTnnlSwD8QJpm7dhN
 e0SQ==
X-Gm-Message-State: AOJu0Yy3sGTQWLcnTfeBT9Z3Tz/c7IIZM6oIv8G1RsbgxyZOpASLBcCr
 3CFlei21wq47JRO31nkPVMMI1a43I9Vcgg==
X-Google-Smtp-Source: AGHT+IEqJmabPEzUTHGU1RLVecC2ffwvZaKXWABKkEz3S4ahDb+PVctSP5LR9cXaQbb+fPNjjPq6rg==
X-Received: by 2002:a5d:4b4e:0:b0:336:6db3:1d7a with SMTP id
 w14-20020a5d4b4e000000b003366db31d7amr644820wrs.103.1704975879726; 
 Thu, 11 Jan 2024 04:24:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p19-20020adf9d93000000b003378ea9a7desm303358wre.33.2024.01.11.04.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 04:24:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F36AA5F7AD;
 Thu, 11 Jan 2024 12:24:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Song Gao
 <gaosong@loongson.cn>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>,  Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>,  Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  David Woodhouse
 <dwmw2@infradead.org>,  Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Brian Cain <bcain@quicinc.com>,  Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Beraldo Leal <bleal@redhat.com>,  Paul
 Durrant <paul@xen.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Thomas
 Huth <thuth@redhat.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>,  kvm@vger.kernel.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  qemu-arm@nongnu.org,  Weiwei Li
 <liwei1518@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  John
 Snow <jsnow@redhat.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Nicholas Piggin <npiggin@gmail.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 40/43] contrib/plugins: extend execlog to track
 register changes
In-Reply-To: <9f9b8359-d33b-4c94-8eb1-fc500d8fc2b4@univ-grenoble-alpes.fr>
 (=?utf-8?Q?=22Fr=C3=A9d=C3=A9ric_P=C3=A9trot=22's?= message of "Fri, 5 Jan
 2024 11:40:07 +0100")
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-41-alex.bennee@linaro.org>
 <9f9b8359-d33b-4c94-8eb1-fc500d8fc2b4@univ-grenoble-alpes.fr>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 11 Jan 2024 12:24:38 +0000
Message-ID: <87o7dsf46x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes.fr> wri=
tes:

> Hello Alex,
>
>   just reporting below what might be a riscv only oddity (also applies to
>   patch 41 but easier to report here).
>
> Le 03/01/2024 =C3=A0 18:33, Alex Benn=C3=A9e a =C3=A9crit=C2=A0:
>> With the new plugin register API we can now track changes to register
>> values. Currently the implementation is fairly dumb which will slow
>> down if a large number of register values are being tracked. This
>> could be improved by only instrumenting instructions which mention
>> registers we are interested in tracking.
>> Example usage:
>>    ./qemu-aarch64 -D plugin.log -d plugin \
>>       -cpu max,sve256=3Don \
>>       -plugin contrib/plugins/libexeclog.so,reg=3Dsp,reg=3Dz\* \
>>       ./tests/tcg/aarch64-linux-user/sha512-sve
>> will display in the execlog any changes to the stack pointer (sp)
>> and
>> the SVE Z registers.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Based-On: <20231025093128.33116-19-akihiko.odaki@daynix.com>
>
>> +static registers_init(int vcpu_index)
>> +{
>> +    GPtrArray *registers =3D g_ptr_array_new();
>> +    g_autoptr(GArray) reg_list =3D qemu_plugin_get_registers(vcpu_index=
);
>> +
>> +    if (reg_list && reg_list->len) {
>> +        /*
>> +         * Go through each register in the complete list and
>> +         * see if we want to track it.
>> +         */
>> +        for (int r =3D 0; r < reg_list->len; r++) {
>> +            qemu_plugin_reg_descriptor *rd =3D &g_array_index(
>> +                reg_list, qemu_plugin_reg_descriptor, r);
>
> riscv csrs are not continously numbered and the dynamically generated gdb=
 xml
> seems to follow that scheme.
> So the calls to Glib string functions output quite a few assertion
> warnings because for the non existing csrs rd->name is NULL (and there
> are a bit less than 4000 such cases for rv64g).
> Checking for NULL and then continue is a simple way to solve the issue, b=
ut
> I am not sure this is the proper way to proceed, as it might stand in the
> generation of the riscv xml description for gdb.

I think in this case it might be easier to not expose it to the plugin
user at all. Is the lack of names an omission? How does gdb see them?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

