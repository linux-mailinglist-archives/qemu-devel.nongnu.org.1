Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F044680EA66
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:29:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0vY-0004ZJ-VT; Tue, 12 Dec 2023 06:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD0vW-0004Z0-85
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:27:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD0vU-0003b0-EQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:27:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c41b43e1eso29346215e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702380466; x=1702985266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcp/OytcLOup8WRnpM/gaBcyxEN7ujaDuhjYFgetfTs=;
 b=kSeiGElZBculuVIZkkjddTNCSYq5V7nvowFQPcVSDHeqlUUpW7x7nAGScNoZavxA68
 uWi9dkGs0NDD8dFTQmg2WemFf2QyxFxyWPO/CnAcCJ9PeGjQeUolffHC35NKZAM49OuI
 DnOYk4m5nX7j2b1VQDhgZhw/znegaw6pO6t+M9Go1Aj+BY4Lopjs1RtYfkWutDBoqHtI
 NeQTPyW9D4NdlsFs5494GJ5jx2NSL/kvDjTcSJlVMw4Jy+1YAfnPyWeOAKi9jLDSLPVh
 Mr5oWVWELrqldVzrxYt3DziNhHewTP9jOv3br6yfYCZ4GQdfJerufY8kCik8zT5RRNT6
 maGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702380466; x=1702985266;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mcp/OytcLOup8WRnpM/gaBcyxEN7ujaDuhjYFgetfTs=;
 b=rPgwMJSUSsDGC67cXHMOmKFhiQUq/idna94ld5xEnCqmXR82wi9l9Ote4EO8ykydVk
 L2MStN+WacM5jfJc4Yh0d9JfXgRQOZjCd7DqcisKCG/Ime0l5pw7mpZ91iuY6I1OgvYv
 ysvRXRJgQpIiTnF1KcNJQWTjI4YlEJjVSQpsa+jYHZA5dOAyFCNuYtNx4U4fMbxFW3XL
 igfsY3fw7OthvaVbW0ji9T5PxYgpV/VIKcAjF5lCT+3WYdKNYCHPOc78BnA4eRLlXnIN
 QXTHMPMWrFNBuulDOf8L+efLE2aaSY3cAHihKTQkD7reSYaM3cOaXldyhFkvqNuEzHMd
 25Lw==
X-Gm-Message-State: AOJu0YxH4ELFzvbSIEC7yqDZQEFJ5L6lREEcANmZNuLdKgU7gnzylCyn
 p4X3qFdnVgPAUsFCTOuK2nssEg==
X-Google-Smtp-Source: AGHT+IE8h4+LLk/UBoDqLQ3w3Jekdh03nWKXycS/0ClkgTkV435VTOpEJ0xNaeiRILW91PJKuQyoUg==
X-Received: by 2002:a1c:7404:0:b0:40c:357e:273 with SMTP id
 p4-20020a1c7404000000b0040c357e0273mr2889449wmc.142.1702380466209; 
 Tue, 12 Dec 2023 03:27:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bd21-20020a05600c1f1500b0040c25abd724sm18701332wmb.9.2023.12.12.03.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 03:27:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 847E45F7D3;
 Tue, 12 Dec 2023 11:27:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Cleber Rosa <crosa@redhat.com>,  qemu-devel@nongnu.org,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Radoslaw Biernacki <rad@semihalf.com>,  Paul
 Durrant <paul@xen.org>,  Leif Lindholm <quic_llindhol@quicinc.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org,  qemu-arm@nongnu.org,  Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?=
 <philmd@linaro.org>,  Beraldo Leal <bleal@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  David Woodhouse <dwmw2@infradead.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
In-Reply-To: <947ad8b2-14fe-456b-b914-6e1c86dc27e4@daynix.com> (Akihiko
 Odaki's message of "Tue, 12 Dec 2023 17:18:29 +0900")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-4-crosa@redhat.com>
 <8734w8fzbc.fsf@draig.linaro.org>
 <947ad8b2-14fe-456b-b914-6e1c86dc27e4@daynix.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 12 Dec 2023 11:27:45 +0000
Message-ID: <877cljek3y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2023/12/12 2:01, Alex Benn=C3=A9e wrote:
>> Cleber Rosa <crosa@redhat.com> writes:
>>=20
>>> Based on many runs, the average run time for these 4 tests is around
>>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>>> default 120 seconds timeout is inappropriate in my experience.
>> I would rather see these tests updated to fix:
>>   - Don't use such an old Fedora 31 image
>>   - Avoid updating image packages (when will RH stop serving them?)
>>   - The "test" is a fairly basic check of dmesg/sysfs output
>> I think building a buildroot image with the tools pre-installed
>> (with
>> perhaps more testing) would be a better use of our limited test time.
>
> That's what tests/avocado/netdev-ethtool.py does, but I don't like it
> much because building a buildroot image takes long and results in a
> somewhat big binary blob.
>
> I rather prefer to have some script that runs mkosi[1] to make an
> image; it downloads packages from distributor so it will take much
> less than using buildroot. The CI system can run the script and cache
> the image.

I'm all more smaller more directed test cases and I'm less worried about
exactly how things are built. I only use buildroot personally because
I'm familiar with it and it makes it easy to build testcases for
multiple architectures.

> [1] https://github.com/systemd/mkosi

If that works for you go for it ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

