Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B770DD81
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S80-00067K-3g; Tue, 23 May 2023 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S7x-00066l-4N
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:32:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S7u-0006BC-O2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:32:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f607059b4eso14722785e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848753; x=1687440753;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpUVKtcAQlNs6h03yBhRo5bwIEquoAP+Dq9JS6FhK7k=;
 b=WhtfISBQubze5PdP2VmS17qs4A8sQGtN3+dehAngzpqheq1sLPaa8LfKDqyl5kaA6q
 s5QDy0T41g29/rDMK9VIjNuPaSchukAzfi4hhmvnr3RphX9c+E1fmPTZ0F6voBSXWKAF
 VZr7yhg5GCOb9EOnbrkmYQKWTFE001/3oimHvYv7hFRe0bhSB7VwP6SIT8ER+0+gN8RP
 ALLxoNCRUNcFOLASNt+BLWfECCDFDYOU3c6lO6Ata7of9H0+W4hVigU0F2CO4UicPDgj
 Pk4+EPkYsZ0iI9kre91+nb7Hji0kwLP91LfNIfT2FfRhKJ1sc1S1kr/+QrPuioQHDJg9
 tyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848753; x=1687440753;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lpUVKtcAQlNs6h03yBhRo5bwIEquoAP+Dq9JS6FhK7k=;
 b=WjeKuAmFxRV/j4sFRjbMzXr6GhS2pPC17c29ZpHAaZUOG8iH8Qs2SrXQe0tSoqj95z
 AdEZQG7DOWsRpu+UYYp8QP2RFfXcSHHlgrB1WB5MxLEzOz4Gq4RxHqCpuxEi975NAaQE
 rkfrQHFcVTbQGqm74Nu6BF/2X9vJbaEwT0TuwimeAmBxAA5+KfMg4EpJg+PxNFDP39zG
 3vOSHDguv0N0c/qRHrTnJAz/Pp+k8XOk3USXbQL7st7dZq6ZoxnZsKGGrk0ldKikQPBt
 Xd4X0QYMDDVhCgFfz2jY/Rvf5BXx4aOH18nBy6tKTEPLAeqgG82wwJ8bMi1xvt0M1/Rm
 ZTiA==
X-Gm-Message-State: AC+VfDydk272ULrVLUZ2k6Rwge5I5O2hJvc7SKCelnypplj6JpJbcewG
 d5Pfv68tBqtU9At6WY+9rybAgg==
X-Google-Smtp-Source: ACHHUZ515Q2FnwAxMBh8f8+xeWHC5v5KX61Kt0DHbZvCRXRaS/9cV7cawOmlZi3tL61T5nJD1/orfA==
X-Received: by 2002:adf:de10:0:b0:306:2fab:1f81 with SMTP id
 b16-20020adfde10000000b003062fab1f81mr11313533wrm.21.1684848752825; 
 Tue, 23 May 2023 06:32:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b003078681a1e8sm11027074wrw.54.2023.05.23.06.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:32:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B2B61FFBB;
 Tue, 23 May 2023 14:32:32 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-6-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/12] hw/char/pl011: Remove duplicated PL011_INT_[RT]X
 definitions
Date: Tue, 23 May 2023 14:32:28 +0100
In-reply-to: <20230522153144.30610-6-philmd@linaro.org>
Message-ID: <87y1lf41hr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> PL011_INT_TX duplicates INT_TX, and PL011_INT_RX INT_RX.
> Follow other register fields definitions from this file,
> keep the shorter form.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

