Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E870DD67
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S0y-0000Sv-Nw; Tue, 23 May 2023 09:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S0u-0000Sj-Iq
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:25:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S0p-0004Q6-Ii
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:25:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so48282065e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848314; x=1687440314;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtGZesEU62fAFC0y2FGEx7VlGmC+whNGeR8NtQIdZ3I=;
 b=hoHRyxUX/iDoHMrQlDrJ0kLCDAoorhLlBDchwLqBUh524Zuwqnj8iJGSCCF3b3up1a
 XOw+g/BAYDJ/GbdL4sjKQPjonnlJTSWMChohJnZMay88IPSDphlqq0+VJH+ROd4HRw0Y
 0TPwKyW0664dwfq9JbphDbAZSe0G/EPQkkl9c1V/0lnQVyI79rM8yq/UKKd0f1tS3TNh
 ENAfe/6AxnFkf3GVFeM0SM8vEjT5hGabx1lGr9S3raNndpnk4pRX4TpRutxLfB3nFh5D
 8WVSxlkAyTuZUVsx8fhyPLnDR5eRUQWaTA7AStiLPrKtks82WyO/jrzanIkP4ecT/dTd
 UT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848314; x=1687440314;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QtGZesEU62fAFC0y2FGEx7VlGmC+whNGeR8NtQIdZ3I=;
 b=WyotLS6cUu7R4PffDSsr1af57UMboSEIM2PjanXAlRMzHwtN0ax6i+tvpzbrozPGeh
 eITCl7VaNacJZ2qRbPSEVGmJE0h9nP72fc1cBgRrdq3eKYWA8pbU3jsxv7LMmHqwoQ0u
 Ha/Ffh9mreh/vOYGGOuDpd+93KN39jBa6/J9u7De0vebfzJUE4f2fVavwTQkqptpTsWx
 js+oTwUWl/C+t0qBDcofM3+zYVCuH0TLmEhIlMRVAD9SQ6gi6nKQdI4MqmhhciFT0rp6
 z/5JT7DW836KIYHaQWs28HPsyFK7c81jkHkF69/57gzHJr7dD196+mq/NhU+66YIIrCb
 nHYQ==
X-Gm-Message-State: AC+VfDwpMIuqZu8GJSUxVE9rGI2pkHyJVwD7j7OiS/SQTrYBwpBInEQq
 X70FAg/Pj7YSaOn42zxFP2bcSw==
X-Google-Smtp-Source: ACHHUZ570E7sq2/VNPeM39m/jyZJIrZJMk8/99moB/co5dwNj6fEazjoclPqIVgEtDMS6AeKdXU05Q==
X-Received: by 2002:a7b:ce12:0:b0:3f6:38f:aa07 with SMTP id
 m18-20020a7bce12000000b003f6038faa07mr6094217wmc.24.1684848313983; 
 Tue, 23 May 2023 06:25:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a5d4ccd000000b003078bb639bdsm10966516wrt.68.2023.05.23.06.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:25:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1939D1FFBB;
 Tue, 23 May 2023 14:25:13 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-3-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 02/12] util/fifo8: Allow fifo8_pop_buf() to not populate
 popped length
Date: Tue, 23 May 2023 14:25:07 +0100
In-reply-to: <20230522153144.30610-3-philmd@linaro.org>
Message-ID: <87bkib5gef.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> There might be cases where we know the number of bytes we can
> pop from the FIFO, or we simply don't care how many bytes is
> returned. Allow fifo8_pop_buf() to take a NULL numptr.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

