Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DE7FA45E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:26:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dU9-000403-Nb; Mon, 27 Nov 2023 10:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7dU7-0003zY-5V
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:25:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7dU1-0002TY-WB
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:25:18 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54b532b261bso1799327a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701098712; x=1701703512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gU5vq134YeDJUg7KQ04fU73aoPTCMb0HLfwO/xPb5p0=;
 b=Mp52e5XocpIZ55Rtb0dpJ65gmCTo2XAv713ve/klhE4Q+wXygoY64tihSsPKz2LGW9
 fcZF5rxmKwc+PkGKsawKAJWZ6ILhgB+PbQ3qgog2SIGSw7DK8FxR1O2U7QU4UQjojIOq
 CxAAIIKqleQFZUobnKGFVos16TsY8DW5ltFcqNFC5wFPxUBl3tkwWZMnWVVrJMH0sCPH
 aPYOQrZ1djamKk1viCDJsVUK5NjTDuqDWJa4eA3xm/Bf3noaCqQOKjhf9t/bi9HRYRmb
 04lXZ5g8ao+OGZOYpD0x5CaD/6HSewI2JcUbFJWFE4C5KcYm+4KE0nlXHrroq/qEm/1W
 DLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701098712; x=1701703512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gU5vq134YeDJUg7KQ04fU73aoPTCMb0HLfwO/xPb5p0=;
 b=n1FmVht3DZs4Pv6HiW9fQbSZDs7iYYmx8s/rTa/xwEoSL4CuuqS2p6lQ50B/Q64Xa1
 zVC9tzYE0q58SZ2Lk2KAMOuKFpCPdl8q8oT0NyOdWzyW7/Nki8lXWTsJgcC6V+BjpldO
 7CncByPI1cavF6ra17m5BE4xYRQNIXKmfRQbP7YhIQQ712Km7NUOJhJXopjSic3x4rgb
 JNdQrxH4V4/WGRn9381fR9NSX00oweO0OKGMN8CHb+F+yTcWYLZ2Nt918x9vZmwxdgWP
 rHNE0WJhtBmg1g5Q8ddSWRPRyXJ3w79v4J9nD7nfnuh87cBJLT0jfyZhtIc0nAU7XTmT
 p0iA==
X-Gm-Message-State: AOJu0Yx9JjxS7aLuNGr6ObQ/cgH4w0047Br+wCMv1poGIWo/s8ehy58+
 bJHeE9MDlwNgwWTTNLgsr6IlTnffD2GfKtEF70vaow==
X-Google-Smtp-Source: AGHT+IEyK20eAAOWPPUluc61iRIzCX5rt9OiRFqsOYuCTghEf4VUTi+xhpYx5Run0kqqVAkryXZamfl8JT9RhikiMq4=
X-Received: by 2002:a05:6402:206d:b0:54b:f2c:2014 with SMTP id
 bd13-20020a056402206d00b0054b0f2c2014mr6858799edb.25.1701098711990; Mon, 27
 Nov 2023 07:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20231124183325.95392-1-philmd@linaro.org>
In-Reply-To: <20231124183325.95392-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 15:25:00 +0000
Message-ID: <CAFEAcA_iUzRysTrEv60Ptz2vyek_qXgYHjLHCGX2unYQdmCdzQ@mail.gmail.com>
Subject: Re: [PATCH-for-8.2? v3 0/2] hw/net/can/xlnx-zynqmp: Avoid underflow
 while popping FIFOs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>, 
 Jason Wang <jasowang@redhat.com>, Vikram Garhwal <vikram.garhwal@amd.com>, 
 Anton Kochkov <anton.kochkov@proton.me>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Vikram Garhwal <fnu.vikram@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 24 Nov 2023 at 18:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Series fully reviewed.
>
> Since v2:
> - Addressed Vikram review comments,
> - Added R-b tags
>
> Fix a pair of fuzzed bugs.
>
> Tested with the CAN tests from 'make check-qtest-aarch64'.



Applied to target-arm.next, thanks.

-- PMM

