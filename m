Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CDB70DD91
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SCL-0000hD-NQ; Tue, 23 May 2023 09:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SCC-0000Nd-Mf
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:37:00 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SCA-0007By-Ug
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:37:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4905956f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849016; x=1687441016;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3p5yjYC6uolz0hZLGq0PoSmB9bMAtZ5PVHveXlslvQ=;
 b=xCeuW9d7vPUafTIoMm3x+Lv0WtNZWQ89y7IGw6GDh5mYR7WtmRBwfn+wpzQ0tkPPfr
 xVQkkSjiLpXNQUoOq2G/FxqAEa1AbgKHOcgO0gJLINJ0BspxABmXWMwrGT+ViAfbmWR8
 sXYBpKmshhHkNQUE+rF0gKgIVc6zVa9Akx8ejKgbycFzcPAWZ5s89h7za8uf/HCkt8jg
 zqkgSmzjUffqfeqp3mfTzcN2YDgKWGeS+caOKUmC3Uzzr8/YQQcqpqTIpxoddFnm1Zdk
 uwebvC6XpKHCiD4HULn9rQH6vwIKcCsxEpo3Cv3/7/DPxT+V/5DvWzLdZyxGrt0dnLA2
 yHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849016; x=1687441016;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w3p5yjYC6uolz0hZLGq0PoSmB9bMAtZ5PVHveXlslvQ=;
 b=KnZ5lNCW9qcqRrRQ5+UuRbQ+HESE0sDR6CwtkdmEUZTdklPbzemajdtxzp6AnH0zfl
 CA2FNYB+5SZHen9/xScT7Nz6PuiJlwmsv3+jGBcicOa894F13cpQ0qiqcGczWu9fE5Iw
 WYTyxpi00mSOnS8XeY/YBc5LM04W2OO0ruJik89m0b5kyhuSFqTCjyhykkrsYtoubZvp
 88thA1x4j4u85WVldMUaNLABJovRhsC6489eArXDFU1MLWnmvsfVtqyLbQRT/px6JxZk
 llSJwPLJv7AjhytbBtBHuk4aRsQv/gP2bhLeycDnkcnnA58u4L3HyUUtLQic3uGgCgc7
 pCFQ==
X-Gm-Message-State: AC+VfDzU5cI4OvYUovrs9xBrnocdEeg1NZN7z6vbs6BoZX3m4GqeuAoW
 xXlRZikvE1atVIoL3+XOAH+2dQ==
X-Google-Smtp-Source: ACHHUZ5jDws7rEgdtdReAXHZhxW9WA0I5Io279FWJC7T7/z3Z5AZij15CUPfzn8+1TSExwLSsEg1Eg==
X-Received: by 2002:a5d:45c4:0:b0:309:1c89:c618 with SMTP id
 b4-20020a5d45c4000000b003091c89c618mr9169471wrs.56.1684849016419; 
 Tue, 23 May 2023 06:36:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t5-20020adfe445000000b003079986fd71sm11166021wrm.88.2023.05.23.06.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:36:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D96431FFBB;
 Tue, 23 May 2023 14:36:55 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-10-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 09/12] hw/char/pl011: Check if transmitter is enabled
Date: Tue, 23 May 2023 14:36:52 +0100
In-reply-to: <20230522153144.30610-10-philmd@linaro.org>
Message-ID: <87h6s341ag.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> Do not transmit characters when UART or transmitter are disabled.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

