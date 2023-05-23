Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6670DD9E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SEE-0002RR-Oc; Tue, 23 May 2023 09:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SEC-0002QI-4d
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:39:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SE7-0007Zh-QE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:39:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so48426535e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849138; x=1687441138;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXSItTkW8n5TBHCRy//2r2EWsxmL/Jhibg7qs0ceOK8=;
 b=m2M05gBxtOUPV2gXs/eWXde2AZBH4cX4pgJu6qCp5VJLe+Nw8FJ8oJffLG86fcxKkM
 1QEaNEPs+RKfV2UpWQMicUbDnxf24IRC5wtRRpnvjDvmc/He0ElnVdtcftVeZEOxj6En
 oiknBYfJkCjep6d7C+VvBiKjiZFL7jbASYGuwqd77NfFXhkdhfmL5OUnq3NdVKDbMyE5
 T6gzo+rLG3ILp9+PF5mfc4HTnTuwgiX52jbvyuZzGuwuX8q/8C9ESuvmq93BTNOhV5DZ
 tozHL6pS2zjabzOsQwFtxQChGo1zRNEWqkFYAzmp3TpSUB/ClAsWcEro1tLDuDMu8UR0
 fUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849138; x=1687441138;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TXSItTkW8n5TBHCRy//2r2EWsxmL/Jhibg7qs0ceOK8=;
 b=T+QVmU/Iq+Lx+2nPN7TzeDdUgkQ/BwgWo36WqiADLUZiNTh0cbM5Wszd8xn4gxOndX
 Cj5EuWSbcRN6CsZ5b02AZILqaxt6U9zqZ7J7WEmij8IT3wP1ZFpU+jetWsD0VWy+rqdG
 3XWMqlas1Pt0Pb2kVuMKI+MpFcw5U6aP/3DHIzb3dn2GZQVBI4S5XvFD15WVe6Au4VUV
 PpChqUeaP83iHCvqF/17Ib+TVaDO2CgF2b4LkVx7rvBZw8LtM2YVtJZ/WDD6mQAtkhmw
 JGUfmiPjwrwdQUx+UkI/EMxWX3PYlnPJa3iOCjjoWz6oIGIZREBp8frkBXjhs/x+5TM4
 plDg==
X-Gm-Message-State: AC+VfDy/fECPq4CpvvL4uBKelNboC7UcamYZtIs7+XalopzVQoHSb5y+
 wNHrAbOdFsRZ4fw+xQcX3ilYiw==
X-Google-Smtp-Source: ACHHUZ61qvkuUw2ex4ZKe0vYT2JK45HcnU0Ly+s+g65jtIfUWrNEEb+f/pxS1gbCydcLdyv5UpOVtw==
X-Received: by 2002:adf:fa47:0:b0:304:6fef:f375 with SMTP id
 y7-20020adffa47000000b003046feff375mr9313453wrr.70.1684849138025; 
 Tue, 23 May 2023 06:38:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z11-20020adff1cb000000b0030789698eebsm11096719wro.89.2023.05.23.06.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:38:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5ADEF1FFBB;
 Tue, 23 May 2023 14:38:57 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-11-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 10/12] hw/char/pl011: Check if receiver is enabled
Date: Tue, 23 May 2023 14:38:52 +0100
In-reply-to: <20230522153144.30610-11-philmd@linaro.org>
Message-ID: <87cz2r4172.fsf@linaro.org>
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Do not receive characters when UART or receiver are disabled.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

