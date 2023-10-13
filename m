Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44C7C8B8C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLIL-0001k9-Ms; Fri, 13 Oct 2023 12:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLIJ-0001jv-Bj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:45:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLIH-0008VM-EZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:45:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so586878f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697215544; x=1697820344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrJui08UBAGYjB83TZHsbrcElQC0hqilt7ro+FTXQfA=;
 b=H+2eZGzLA+dmRwcN9lBlNppHSUNlDeWiVS6d7PCEPlNrRtFvyIBv5aX32kzyqjGXsn
 hkf7ulW8SP5nFUrM0dMyFdi4QTg643ZlekE6+4P7oKgpl+YCwX46QqPfDlS8dswtaBdg
 7UGODjPoCOBuppaS7T6FQnPnygfLvZlQo9vQsmS6vVxM/WdM7SvjXN0S09XrW7WpWfzZ
 5ZnKtTQB3Mh9dtxLPfndM/2G9hY3pKfOV+fem9JxJHq9OP9WNVbEg5n3sUmO9Koprl+b
 69AR1SiZu6BG1SVEmSJMT5KJIOkXQeTi4Sl9o/KhV1XiBSwqmoGArRZwlcsJrnL7fSyq
 ZI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215544; x=1697820344;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xrJui08UBAGYjB83TZHsbrcElQC0hqilt7ro+FTXQfA=;
 b=dNW2hpaDHwOk2za/PY68SqCu5SZgl1sb5ZmA2IsmV4TLaKiXjgPf4gfNV5Jbwqu7pW
 qtbpzF1qJNxruUdLZZ9snBaeZ6ZnBAqS9X0Y0ryvM53XMKoviv+P/cTpzhKF4aYYq6f6
 W30oKrC1VXQju4NJXWJX0TNuSIiWPKfDv/xeU3AF/IqrHDslXaOB+XqBKrVq4P8JcQs+
 EB+LdLMQZX+9OtCyjhnsKANXj1AELClgqFIZ3ODAvgXYn3sST1G38yxvFPz0Hf2T6H3A
 s52Ypl9n5rfpMaSLoi2WyEOnYvLC+ku9GkvAxlcKcGJjjFWjNY5iPsgb+O/xVkAuT2sB
 ItqQ==
X-Gm-Message-State: AOJu0YzbJu16k7+yWzhC10lMS1GNfFVh0I29TRudj4OLD2Qc+tEvMXOU
 0tlxPMOJfikZeRCsngHsylF5mg==
X-Google-Smtp-Source: AGHT+IFVWYnRM/avgnFjO2pjvCg4NWBRzluI0HAWxV3C5NqAjXAUZt7AXxbuGRjK53JVRxH/VJD14Q==
X-Received: by 2002:adf:f404:0:b0:31c:3136:60af with SMTP id
 g4-20020adff404000000b0031c313660afmr21719174wro.61.1697215543870; 
 Fri, 13 Oct 2023 09:45:43 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z17-20020adff1d1000000b0032d9caeab0fsm1870972wro.77.2023.10.13.09.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:45:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 05CBB1FFBB;
 Fri, 13 Oct 2023 17:45:43 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-27-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 26/29] moved all mcd related header files into
 include/mcdstub
Date: Fri, 13 Oct 2023 17:45:17 +0100
In-reply-to: <20231006090610.26171-27-nicolas.eder@lauterbach.com>
Message-ID: <87v8balbd5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> From: neder <nicolas.eder@lauterbach.com>
>
> ---
>  target/arm/mcdstub.h =3D> include/mcdstub/arm_mcdstub.h | 2 +-
>  {mcdstub =3D> include/mcdstub}/mcd_shared_defines.h     | 0
>  {mcdstub =3D> include/mcdstub}/mcdstub.h                | 0
>  {mcdstub =3D> include/mcdstub}/mcdstub_common.h         | 0

Just bring them in in the correct place from the start to avoid the
noise of all the code motion.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

