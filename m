Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD64980333B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 13:42:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA8G3-00084L-AW; Mon, 04 Dec 2023 07:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rA8Fw-00083Z-3f
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 07:41:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rA8Fr-0007SG-T7
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 07:40:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b397793aaso27032565e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 04:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701693649; x=1702298449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MB4enwjcEQksGMQQiJxq8p0IjPQPJKF9wg5JvIeTOg=;
 b=HNuEWy8EHzGjC1PmHYhKHHTh1Go1VlYNvLuBwH61vGEDNK59SkXHPqdS5NCHpAo0sL
 rRyyQQTIlNzmp9vLPlaBQ/v/Ueb+xK5rzlBoWLCV0QZ+MJkNe2zsinzIgGl5uEcdLXP+
 a2V6QCDO7Y+a7cU8aoZZweMZo7nabNxH64xrOQwzC2igcv8t77dce27zkJXPg2oe+etp
 3xfmENfga2axgpHU6s6e0Gv41BR14oZkq2VKzNmkibja6sOru31lrttLIHB8IROFtbg2
 cBorI4vVr201DlcQX6mecIEySg3ZeIEWTGAkF/wW/zAJPrr3ZuzEPjK/Goy4XqGk7nKZ
 rywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701693649; x=1702298449;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0MB4enwjcEQksGMQQiJxq8p0IjPQPJKF9wg5JvIeTOg=;
 b=RIgwtyKDRRHJ31oiCoieutSA7781hG37dNioZoMComX53MPwegOHBUSajn1Ua7TR1l
 GeqQAXQy67IHyDwV2lTVFXh6CHyvsQa2Xa+o6k7xNQuA4gg04pSzM+xVhDHrMuV1PlOb
 HypwimFyjUcZeaXdIz/fHUVEdzk/tVDZI07iza+O+KN1xtNIujDNub96L09e4HlB5uYc
 Zmc/gPd12Ur6NDvZk3dwJURw/3NWALvmjK5c2wZHMKH79L+p7G0UZ6nq4RTrmGl862UF
 HvqgMG/mhPUyeUwUVMeJb7iqNiFc8VTrvH44OIeBO7EX6Ti4DCaxztmTLqKrN5jqjkeK
 2pjQ==
X-Gm-Message-State: AOJu0YxDqrIV+2lG5o0Ay80cWpAsbj+Z3JlHbqa8ElZcaG9sIxEZo/Ax
 60bjm1SqhrYHGFe9yR4dYdVgXg==
X-Google-Smtp-Source: AGHT+IEP84mSpV0pNgmxvuY8XsM8YHbI1MB0FfFRUqU0khpAeGY96x5qVhaGAcATz75G4L9e9ALF/Q==
X-Received: by 2002:a05:600c:3103:b0:40b:5e4a:235f with SMTP id
 g3-20020a05600c310300b0040b5e4a235fmr2952612wmo.97.1701693649364; 
 Mon, 04 Dec 2023 04:40:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p8-20020a5d4e08000000b0033349bccac6sm2944476wrt.1.2023.12.04.04.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:40:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 860BC5F75B;
 Mon,  4 Dec 2023 12:40:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Farman <farman@linux.ibm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Beraldo Leal <bleal@redhat.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  qemu-arm@nongnu.org,  Radoslaw Biernacki
 <rad@semihalf.com>,  Yoshinori Sato <ysato@users.sourceforge.jp>,  Eric
 Auger <eric.auger@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Cleber Rosa <crosa@redhat.com>,  Joel Stanley
 <joel@jms.id.au>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2 6/7] gitlab: build the correct microblaze target
In-Reply-To: <a9b7f414-5229-4dc6-9d32-b95d36cdbaf7@redhat.com> (Thomas Huth's
 message of "Mon, 4 Dec 2023 08:54:52 +0100")
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-7-alex.bennee@linaro.org>
 <a9b7f414-5229-4dc6-9d32-b95d36cdbaf7@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Mon, 04 Dec 2023 12:40:48 +0000
Message-ID: <871qc29m3z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 01/12/2023 10.36, Alex Benn=C3=A9e wrote:
>> We inadvertently built the LE target for BE tests.
>> Fixes: 78ebc00b06 (gitlab: shuffle some targets and reduce avocado
>> noise)
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .gitlab-ci.d/buildtest.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 7f9af83b10..62b5379a5e 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -41,7 +41,7 @@ build-system-ubuntu:
>>     variables:
>>       IMAGE: ubuntu2204
>>       CONFIGURE_ARGS: --enable-docs
>> -    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>> +    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
>>       MAKE_CHECK_ARGS: check-build
>>     check-system-ubuntu:
>
> We've got microblazeel-softmmu here and microblaze-softmmu in the
> build-system-fedora job. So please don't change the ubuntu job here,
> otherwise we're building the same target twice instead.

Hmm - what would be really useful is an actual microblazeel test image
so we can test what we build.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

