Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9FD82AED6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:38:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuJV-0000Uh-61; Thu, 11 Jan 2024 07:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNuJS-0000TD-Ei
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:37:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNuJP-0007oi-AA
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:37:34 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33765009941so4163443f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704976649; x=1705581449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjWVrWLBuhexZhNzqcbaaji/ra/r9VF4ONEQ8D3AprU=;
 b=yZPFGqiG0LI22OIAHxdFL4L3OmR4S2CrjvWBlKI+K/0v9jcsu3pm98uAQeacvUg2iO
 DH7debgPOPf0me68Mg8XrFdGbKQ7/nsMX1i2/Yz7by11zeO5Mb+H1tvkrVQnYY8uEJMq
 j7ST5pybWNG4ePsbLSBLXaEwVsrEDNe+Ysk31LNP72njLlHxDGSZCF80rzo74lSjd+4p
 kDnRjNNGDuGea4TgGPBj+KiNuWAmxic3QFG1LhK/ZbasZGpb8wH94i5isI15f+uLoVCK
 +9jVKJgkCzBNjukZSwL04lr3yBEQlZttXgM7A32shgJn04hWQFUrNzwz27/5I8EY7yoF
 sF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704976649; x=1705581449;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XjWVrWLBuhexZhNzqcbaaji/ra/r9VF4ONEQ8D3AprU=;
 b=YM1PGlP3/Enn39OEW2gk0yjItQAhgPC6fqlT0y7glHh/ZfILCy6XczOG7pibGC2zLB
 12ncqW0wFkINgkTFesywSgmbOEO2Tk961qi2oJnWidIAH/MmQzZMCnxJTCGnD02INP8+
 6QgIoErpzPBLJL43AdaKTrXYrDxlZzN0AbmZd/7/e0kUVfs6SQaAAqkbPwfGySVYDDJ+
 1tK85jRRBcrcTn//SoU0N60zqBAIzqddMXLiKXiQ0cGj4yE7fsB4Xu7lkRoydu7F13tc
 NJPDpxom/RM99tUSSbz1t3xaljWh/fZqfSmrFpwaj3tpl1l4sA8aYcAe1dL8wyRAEWPq
 ttwg==
X-Gm-Message-State: AOJu0YxKm5r7hyrJVOskm9lkaogTgisvkKb1pwO+pvYcbghO77Mmy1fz
 xoH1wk9j0NGMUKG542xm93kMrg/toe7DBw==
X-Google-Smtp-Source: AGHT+IFZRj0uozQ33Kz3/zEEIWAh2I8FM6ycWyYCYl25J9YmcIK8POHwIM0XSklNJwKChNuv51rsAg==
X-Received: by 2002:a5d:4d84:0:b0:336:6dad:2c71 with SMTP id
 b4-20020a5d4d84000000b003366dad2c71mr672153wru.111.1704976649448; 
 Thu, 11 Jan 2024 04:37:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003375cf3b17dsm1130163wrr.42.2024.01.11.04.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 04:37:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 93E4C5F7AD;
 Thu, 11 Jan 2024 12:37:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  David
 Hildenbrand
 <david@redhat.com>,  Aurelien Jarno <aurelien@aurel32.net>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  Yanan Wang <wangyanan55@huawei.com>,
 Bin Meng <bin.meng@windriver.com>,  Laurent Vivier <lvivier@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 David Woodhouse <dwmw2@infradead.org>,  Laurent Vivier
 <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <bcain@quicinc.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,  Paul Durrant <paul@xen.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Thomas Huth <thuth@redhat.com>,  Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org,  Peter Maydell <peter.maydell@linaro.org>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  qemu-arm@nongnu.org,  Weiwei
 Li <liwei1518@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, John Snow <jsnow@redhat.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Nicholas Piggin <npiggin@gmail.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 00/43] testing and plugin updates for 9.0 (pre-PR)
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 3 Jan 2024 17:33:06 +0000")
References: <20240103173349.398526-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 11 Jan 2024 12:37:28 +0000
Message-ID: <87cyu8f3lj.fsf@draig.linaro.org>
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This brings in the first batch of testing updates for the next
> release. The main bulk of these is Daniel and Thomas' cleanups of the
> qtest timeouts and allowing meson control them. There are a few minor
> tweaks I've made to some avocado and gitlab tests.
>
> The big update is support for reading register values in TCG plugins.
> After feedback from Akihiko I've left all the smarts to the plugin and
> made the interface a simple "all the registers" dump. There is a
> follow on patch to make the register code a little more efficient by
> checking disassembly. However we can leave the door open for future
> API enhancements if the translator ever learns to reliably know when
> registers might be touched.
>
> v2
> --
>
>  - Review feedback for register API
>  - readthedocs update
>  - add expectation docs for plugins
>
> The following still need review:
>
>   docs/devel: document some plugin assumptions
>   docs/devel: lift example and plugin API sections up
>   contrib/plugins: optimise the register value tracking
>   contrib/plugins: extend execlog to track register changes
>   contrib/plugins: fix imatch
>   plugins: add an API to read registers
>   gdbstub: expose api to find registers
>   readthodocs: fully specify a build environment
>   gitlab: include microblazeel in testing
>   tests/avocado: use snapshot=3Don in kvm_xen_guest

Ping for final review? I'd at least like to get the testing stuff
cleared out of my tree.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

