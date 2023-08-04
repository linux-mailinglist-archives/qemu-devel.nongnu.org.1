Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70D7703AD
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwDV-00086P-90; Fri, 04 Aug 2023 10:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwDK-0007x1-OD
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:55:39 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwDF-0001gE-JD
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:55:38 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5231f439968so734285a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691160927; x=1691765727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HgP6h0/ECBz1/dNWRWiP9Pt93RjoL+qixBbdmjY0Sis=;
 b=pGhB4/yWYptnl1CMKm919QhOYnZJg+LTmB3psCgTd3y1H2jagtLk2ve/U41GbfSdD4
 pu0bPqT7MTURvW4VXQfU9RQg/vqz5YGLo3gKX3lMPEWwMsL8qFpFUH1oRC95eOlMV8cw
 6foUYX4f4sLr38ReH2pUG5LH3iHCvUYabZ7eiSKun7GaVOLV+DIrsuZ/uUuxgrWS2Kja
 fbVUGoOGhtc9kzARyQqfB6g3finl0iND2Vhwbnkubts7znvJwdMGkcZXCKnSUZNfa2G4
 CMEHX0rVQ6eoglm+l+BshgPNWm6vJa3Uiv9whdDhAFJS3wzzwndblAQZTQ4PzIFCvCZE
 dtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691160927; x=1691765727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HgP6h0/ECBz1/dNWRWiP9Pt93RjoL+qixBbdmjY0Sis=;
 b=Q6O2pUOnKPDR4YXSiVzYJJ/iNv52ER5tq6Py1v1AAsSrj9lvDqAv8S1pzccDCDjwSY
 s4G61t2oSTyZB/KPsgHSOgGTcMGeXXyH+cdnYE/7Qhk7Pgxh8eLqUeXlOdcKn8xWr0zo
 r+epVzE7RKiCRdjQawOma4CwvC1OSvigf7Y8ULLn6t1fETKjRnQ4cY2+6n280Te0x023
 EqFWF0hIpcDI3ztp0DpP66pK7OcfinKN79DWmWsDM5kf/TLJr//XouOvaLT4uj7ebGX1
 ruLmKVKKYBKQIqaP4QzIP414uYld5Z0GcFzUOCZ2/jslImAn49DF5qMzgzy/0cctwOzK
 vFxw==
X-Gm-Message-State: AOJu0YwadpB+D3epueJSGxJbea+6xJ/XXYiUPw5JnM564QMaI0ov3hJo
 rL7cuCHUjMZN93sBQhAgwBEhGqhraedi16lQxXh+SA==
X-Google-Smtp-Source: AGHT+IGDxW781Bp2YXun5oiphufH9T51u2qA5bqDVa/FxhS/mMqYw0LSnnnp1ZvHVh/dEXaP4DEw5Cie3PtaFKs6l08=
X-Received: by 2002:aa7:d90d:0:b0:522:ab77:36b7 with SMTP id
 a13-20020aa7d90d000000b00522ab7736b7mr1690855edr.4.1691160926895; Fri, 04 Aug
 2023 07:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-36-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-36-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:55:16 +0100
Message-ID: <CAFEAcA83wcKVRcEngEbi-dToiaEBHfhLPuuue_e1URU6WmMfZQ@mail.gmail.com>
Subject: Re: [PATCH 35/44] Add mailbox test stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 26 Jul 2023 at 15:12, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.c | 70 +++++++++++++++++++++++++++++++++++
>  tests/qtest/bcm2838-mailbox.h | 48 ++++++++++++++++++++++++
>  tests/qtest/meson.build       |  1 +
>  3 files changed, 119 insertions(+)
>  create mode 100644 tests/qtest/bcm2838-mailbox.c
>  create mode 100644 tests/qtest/bcm2838-mailbox.h

> index 0000000000..a81b325af9
> --- /dev/null
> +++ b/tests/qtest/bcm2838-mailbox.h
> @@ -0,0 +1,48 @@
> +/*
> + * Declarations for BCM2838 mailbox test.
> + *
> + * Copyright (c) 2023 Auriga LLC
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +typedef union {
> +    uint32_t value;
> +    struct {
> +        uint32_t channel: 4;
> +        uint32_t data   : 28;
> +    } fields;
> +} MboxRegWrite;

Again, you can't use bitfields for this kind of thing, I'm afraid.

thanks
-- PMM

