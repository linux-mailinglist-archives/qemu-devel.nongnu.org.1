Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7443284206E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 11:03:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkx9-0002sP-UG; Tue, 30 Jan 2024 05:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUkwy-0002qT-Ua
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:02:41 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUkwi-0002ge-40
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:02:40 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33af40493f4so928544f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706608941; x=1707213741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXv8iU8DCEHQSmkm00g53EAJi3wa3xd4NKs1BMRU5Es=;
 b=HLzmuLb9+Ub+FbgvZG1YYGd8T4ZCil2fmK5J6d6g8RG/szO3V7SF8y1sSoLXFf5abo
 DCyUnyBZhbYMB0HWQFFDDGT4U3qxNlypgu5klOoCxcqLyXd7b533prqKXzdXmJyni0e7
 SNb+ejBwOsck5EMtn6FM9fmQb+AqbZ2neDrajRu2YAFpFpo5zrTTx53eNLdopRaujAg4
 qAFdizzsvpyOTjaO4XswvS/iGKZgkv9qNYnNBq4dED6d0VaVsksQsQSo/FTy8YGrfFhr
 HV1PY9viPHF9g7Bapyya44Yk7rkWJdEvqkNsyxQSUgu/M1FON35t0ZsP3jFCob5KD/Gw
 Himw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706608941; x=1707213741;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXv8iU8DCEHQSmkm00g53EAJi3wa3xd4NKs1BMRU5Es=;
 b=G3WWVhUvaoRlOoGIPmd5y7T/MOmJE65KsYwkaR++k/n44UfBXakz4yMSFGukj9BxKr
 84O54JJ8PpTWmPEXm1FY8V/PbHb+Qu/3SnosKHCAB6p2siZ3PLzljFW+vBaW4sXhOny8
 hO7SW+doAcjh9aH0j7iSJgpX9ZK5M7rrD3CknbUP0cd67v/OQMSRIzc0JCrLeCiZGy66
 DqK0iYkQEhxuvdcvLwv1OCRnjjctB5bxiARCNXZ5hKa41/RbIR7zklmeRWpBrei+24d2
 7L9NinxUx8xJhAS0UrMsYUHnmm8vU6w/TVWfK5Q1Cd85XjxRJgccq8ltF9J0Dv2SX8gT
 XYHg==
X-Gm-Message-State: AOJu0YzJFEJ6MNc2lY2GXqlb8SBDA6UwtKZ/6Nmj0CEcosp6URYEhkFL
 n4fNdH1DUEGKmN+0R6ab2/1pXftbyKBwiV3ZDjxuGL8IpaLv7XNXLZ393NzIx74=
X-Google-Smtp-Source: AGHT+IGyvy8IUghvRL8jqLnHqCKeIgFqgbxR/QGg/MJrwz6BoDM4vgvrW5A4W/s/aqeC+CebeoXQmQ==
X-Received: by 2002:a05:6000:1449:b0:33a:eb50:43c9 with SMTP id
 v9-20020a056000144900b0033aeb5043c9mr4744747wrx.59.1706608941399; 
 Tue, 30 Jan 2024 02:02:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s14-20020adfdb0e000000b0033afce63fd0sm758630wri.53.2024.01.30.02.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:02:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ACB675F9D3;
 Tue, 30 Jan 2024 10:02:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 peter.maydell@linaro.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3 2/6] hw/arm/z2: convert DPRINTF to trace events and
 guest errors
In-Reply-To: <799c5141c5751cf2341e1d095349612e046424a8.1706544115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 29 Jan 2024 18:09:37 +0200")
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
 <799c5141c5751cf2341e1d095349612e046424a8.1706544115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 10:02:20 +0000
Message-ID: <87mssnqgur.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on trace events should be able to opt-in to each trace event and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into trace events. DPRINTFs that report guest errors are logged with
> LOG_GUEST_ERROR.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

