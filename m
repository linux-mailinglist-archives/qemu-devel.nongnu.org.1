Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26099D29BC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 16:36:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQFx-00055F-3f; Tue, 19 Nov 2024 10:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDQFv-00054o-TF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:35:07 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDQFu-0000LP-9w
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:35:07 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53d9ff92edaso6243002e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732030504; x=1732635304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vso+956ajhKwGZbhZXvIaOVXhw51MJ7baXJPrDHNMJ4=;
 b=eIvi97xD1iQtni24UO9bn/iWFH/A4AmkQ++F4K6RtoPTIQyEwXqlZ/uVHxFvUDpIj5
 0oam9wDm147c3pfo8YEKlFF5pRCoaMCPuzMqvZ7vUBdlYf3L6KZQeMq0nZTxNX1POExj
 8lNzOsicvf9njBbYP+hJHSm+vQ6z8vIKXRTa0p+0Y50UjRqoVOdj/8AJKxmpTypra2NZ
 wy/GQVwoRXW3UEz4tteH3vAVsPPzibKEsv7ollhY3XP7rQ62JdalSR0S4pTjm5cma4zB
 DjyRocmGCCegitgVQF9ftqXHdvnD8lKlRcaqZ6iXW9lWNPXGUvedjqwIn0ztVcKLiBXG
 JYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732030504; x=1732635304;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vso+956ajhKwGZbhZXvIaOVXhw51MJ7baXJPrDHNMJ4=;
 b=V66LVwtiMyKTPtMVdwR7txBYVDPiVr3OFcOTTXSSBej1PN5v826PknJ6nWtJb8VCLj
 LruVnq4wv+03F4lCCEBZFDrCHIxK0xi6stkCX8EMNnCUPJQNo/q6fVDyEFplCiW/kyof
 jaXWPxL5JltuGOcOR/q1JNvGg2ENCkhcaKhPylQ/wbTgRT4WNwAZSvA5C0OUBVmLsz/f
 W2LX1zGKCTGg1Zp7kkPC/jiWAjqwF+llvjvM8yd2imwIl4enaeprIWWj5+O+fwPrh6Et
 qRZt0ArOJchLUkqQhrqPEA/zdeN+Yy1v1FnZUloGxxtVS213Awd2OMUf4uxjeMd2Sife
 WGuQ==
X-Gm-Message-State: AOJu0Yxbwm7sWrK+5AZ8xBh9kc6q156o5DzwAxkgjIaKrp+A4CHcbApU
 ydpgD4OWZ1cfHm8/Y5SGBaeqcTteHz8MNVJ7efOFEBLl7xiJi+bcKo2wbzOjAPU=
X-Google-Smtp-Source: AGHT+IFYerS/a0O/9qLnNMeR2qXlJeRunU8tUlWTuq0kXnrfEQ/XFqRR+MPOuG2drvdHc9EEA4k01Q==
X-Received: by 2002:a05:6512:3b86:b0:53b:4c7c:a7be with SMTP id
 2adb3069b0e04-53dab3b0653mr7329348e87.42.1732030504079; 
 Tue, 19 Nov 2024 07:35:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1f409sm193959765e9.37.2024.11.19.07.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 07:35:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80EFF5F769;
 Tue, 19 Nov 2024 15:35:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 01/15] tests/functional: fix mips64el test to honour
 workdir
In-Reply-To: <20241119150519.1123365-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:05
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-2-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 15:35:02 +0000
Message-ID: <87r077p789.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The missing directory separator resulted in the kernel file being
> created 1 level higher than expected.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

