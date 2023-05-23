Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA170DD8C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SBO-00083F-Hh; Tue, 23 May 2023 09:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SBN-00082k-1t
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:36:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SBL-0006yL-JP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:36:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30a8c4afa46so2068354f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848962; x=1687440962;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtKczKFhQvExHYnoygl9Qw2U54ol+pwYgNbsfdBTQIA=;
 b=e9Wevfgwqe1gUIpKhjrkry2I2tyQW74xO/cpm7PyVkccin1mLFs9YoUYIDyCNpYBrR
 auwytGw7FM9yMaw0N9N7oVoQYAmyj/28V444f8v5UA8XTHVSzWIdqqYfSaRk3TsdVRMT
 mP085FO9j0gU1CWPOpbIMClIm8G3S00hZ6hD5PY4j7FJsWwgX0+yvn2lAy9YK0SwQbgn
 IQPQzKWxSpjVL23ozYNGA+gOb+L8Kj1UzlI+fxwoUS1HyedR4hUlUd2iR+mnGWqOrpL0
 vldiLgGr5y7wo7t98dlNiFQ41fgoKX/dAf1SMX9HkcNx17bKBN3sWv+68+PKASS7time
 j1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848962; x=1687440962;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RtKczKFhQvExHYnoygl9Qw2U54ol+pwYgNbsfdBTQIA=;
 b=Kn3g0J0bRqmidQ/SZrWR3UpwcfMFqlizVWSuFI9iS94ux0hjeFOOSCmP2ZfU/skNEz
 i/azHWpVSHNt2djk1AhTkKB4elX5rZaj/Vwenh/mtGXVlu3VsBVC2GgJGsr7Ww4+/QJL
 gXqKVM9W0YSOKI7tnPPRgDowQsHvMtXzmpFz3VN23N/dj/MzorO14RQ0hO+LG8mvEO4o
 kkUrYNw+H7cLpKc/5MYQWZIQ+keXXEYYJpH3rl/w4kv+2vkDuIvl0EOeVU05eU0UWKMA
 bYudo8PsF2o9nHYnCJT7qrt1HOPT//tpwMqnMDugWw1oCQhebBe4ll1HeN9fK4xSPhFb
 zcAw==
X-Gm-Message-State: AC+VfDzqGWF7hjznJdDzui0unRLn8dYmZdFRqaABm8SDECI8Ohr3vlQM
 Vv5RPdqiTErho5alY5kQM5fLrA==
X-Google-Smtp-Source: ACHHUZ6+IL/jXkTLhrnUNNdWTM3Eeq566OYAi7S4//14Wj2h/vO0Csag8+hjBy+Bcup1JEvb923dpA==
X-Received: by 2002:a5d:4204:0:b0:307:7d1a:20fd with SMTP id
 n4-20020a5d4204000000b003077d1a20fdmr11457901wrq.12.1684848962614; 
 Tue, 23 May 2023 06:36:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00307c0afc030sm11345816wrs.4.2023.05.23.06.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:36:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D1EE71FFBB;
 Tue, 23 May 2023 14:36:01 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-8-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 07/12] hw/char/pl011: Split RX/TX path of
 pl011_reset_fifo()
Date: Tue, 23 May 2023 14:35:56 +0100
In-reply-to: <20230522153144.30610-8-philmd@linaro.org>
Message-ID: <87pm6r41by.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

> To be able to reset the RX or TX FIFO separately,
> split pl011_reset_fifo() in two.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

