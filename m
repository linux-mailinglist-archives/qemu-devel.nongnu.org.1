Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E684845E50
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 18:17:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVafw-0007wF-4N; Thu, 01 Feb 2024 12:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVafs-0007uK-AJ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:16:28 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVafq-0003Z0-Pk
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:16:28 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5101cd91017so1426853e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706807785; x=1707412585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K6gpWkZMo4j9ipRz7cb2OycqrVAx4KbCzOm1eq2wK4=;
 b=wxFsfEZfHp6Ztq5ROPuYGyzv+AX42kjOrjt8v8WGxpkbMoYdJYSgftt/VVE12JFWeb
 oP+LUbBo7sqYPj+K1LqDtjHlpXyad/pPf1FURy9s2qqryOFlWhHApB/Y+a1N7wWBqONl
 uBX2avG2vwaUQjDejpJDLD40hWoBWl+UCVfhEBhYS83de+pHhRcQE3SjyvhP+QVZJOMV
 phXoMPBTPVibm74D/79hLHu9OEf8Cw4S0iHMm6mjduzGHNW/RfDZh67Payr+O/jkRtX+
 1wx6ZjMo/S90kd7eSXpVfQFwUqM1xHWxUXT4GJecQI1WQcFOap0gMmOwH42bMjdovjkS
 HJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706807785; x=1707412585;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8K6gpWkZMo4j9ipRz7cb2OycqrVAx4KbCzOm1eq2wK4=;
 b=IuwUc4yfTT/3vc2hC4p0hYTyluVNaM+XO+zKVxwtxg4KVa4JwPpjFGtLGn7FB0BUZ3
 gpMBDIgpyTFo67tpGJXeYy3bW3xtMy/ksLrtrMoI3XgA4clRufH9pXNd0NQYUTbUGtDi
 ILqYmAq8KGTyWO33fSskgy3fiE5G9458l/WlMIwJTGM6mh1cfAQtkjCUXu9ZDNrcsxvA
 251t5M69dAWrKK0FNVKWw8Ij928WzTDKTJR7q1k7LuQugLf/SZIQ4Ooj39J53i0gV2Y3
 XCiukiBaKcJ/hlnshJPe4d1WbczJm7RJZLPv2dB8D0Ebw03PkhVxfgjFjgevLKWAtjKh
 3gXA==
X-Gm-Message-State: AOJu0YwxPw1jgOl9zfsxb+vqIdxVQhKtzdVwm8x/wYgIWTxACb8veUG8
 O8Pq7oyueUGA0Vy52eCZRppS5BTgoWKdiek0lJzvve8hD1zbI8f07LMn4rPvERs=
X-Google-Smtp-Source: AGHT+IFA69oyPDUL80VFgTGBDRgJAW+dAOizX4yOl83rwL+8ubVVvj2jW8sIVBiRYV3G4iXYQaAaSA==
X-Received: by 2002:a05:6512:11ed:b0:511:297f:2732 with SMTP id
 p13-20020a05651211ed00b00511297f2732mr1992813lfs.31.1706807784864; 
 Thu, 01 Feb 2024 09:16:24 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXEFuPj8CpU6cmv7sYUJMzCqIkrI3ZnPaTuEHnkduRcA4bvvjEuyU/FBXcHX/MJO7oNqt/hAFHz4r6zSx+ywDShP9gF9m3MYi+6J06o9gXnrYm1H6s6ePw5
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q9-20020a05600c46c900b0040ef718cf81sm183346wmo.28.2024.02.01.09.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 09:16:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 47BF65F7AF;
 Thu,  1 Feb 2024 17:16:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] tests/tcg: Add the syscall catchpoint gdbstub test
In-Reply-To: <20240116094411.216665-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 16 Jan 2024 10:41:54 +0100")
References: <20240116094411.216665-1-iii@linux.ibm.com>
 <20240116094411.216665-3-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 17:16:24 +0000
Message-ID: <87wmrojeaf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Check that adding/removing syscall catchpoints works.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

