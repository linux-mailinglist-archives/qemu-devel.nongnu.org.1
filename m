Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D029570DD66
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:23:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RyD-0007ko-Db; Tue, 23 May 2023 09:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RyB-0007kJ-4N
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:22:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Ry9-000401-JB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:22:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f60ec45314so2413035e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848147; x=1687440147;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UOdn3iCEP/AucTZvcMzpdCzOxEbgd0rNuq5SN8ncSM=;
 b=owFesSqNxw4RAX+obwyzyzecdVYvbDkFrHSUHe/9k00BHOcBmehNIpyCAGgIEpVYX9
 v1bclLsjIU8kRkXg6GwTCoWuLCYZ46LLPquEsmkTffwxOa7H3UcvRSf5teydg9M/Zsvm
 i+xXWt6q04hAod8lEwlOMqejZS46SgzGg0WEq6NrJo8yUvPo1bOHMBR45RBa0ceVr/gQ
 WaVOCaN91+Iab29EkyMEtc3g5MKKx9BR1xgRCWCiI8qaVG2EGIMzMKVsvPmLpKfdmPdz
 xPN8uyd4cYc3NeKmgQrQdwXFtNySQLOjitOiD46UN73H08fBf+wKay7NSc9FV6IeXFZn
 Bmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848147; x=1687440147;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6UOdn3iCEP/AucTZvcMzpdCzOxEbgd0rNuq5SN8ncSM=;
 b=b04vG5zfM/SWQbMFCyZkoh/vnRFk0dhSJ/VnOb2xvM5HyxMwWRjj/iMjQ8FepuOIRh
 uIAMQKMXy6ku8KQFoSAwu8s4MEX0Y9IYID9dapnST1pablI/yXQ1tH7ESgk4D64kfZkq
 DY4TQfsPiACBj0qDI8l1OCtI8FIIKBc/iphWbBfRfvlpf/lFkZ5r1QMHccxV0ud4dzfu
 aTtvDj0KPhTL9xG2Q19u5baB6uR+vUsR1r3O1QKFx0Byjia2Yo4UlirHEVre1UOh+Fwk
 Dc9XzJChvWtjSwM8pkgaw15HwFfDvniNDnS2NZd0D2v4d4t10xOdRDC2dZZiMainvtve
 cNXg==
X-Gm-Message-State: AC+VfDwSKL7C+a5Hn1WXh93/4IhN6qRwGU9++GZsgQabbX6yYsVTEEFC
 wzO8QplAFirMANoGpQkdDTX4RA==
X-Google-Smtp-Source: ACHHUZ5ZMTW/TQX5VF7dQLHumTI1INANMh71VcMITNfRnkqHui7PrqDSBBwqo58svOzQJEzkCgBA1Q==
X-Received: by 2002:a7b:c01a:0:b0:3f4:fc57:1c3e with SMTP id
 c26-20020a7bc01a000000b003f4fc571c3emr9516060wmb.12.1684848147670; 
 Tue, 23 May 2023 06:22:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a5d5390000000b00301a351a8d6sm11167463wrv.84.2023.05.23.06.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:22:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C90241FFBB;
 Tue, 23 May 2023 14:22:26 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-2-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 01/12] util/fifo8: Fix typo in fifo8_push_all() description
Date: Tue, 23 May 2023 14:22:14 +0100
In-reply-to: <20230522153144.30610-2-philmd@linaro.org>
Message-ID: <87fs7n5gj1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

