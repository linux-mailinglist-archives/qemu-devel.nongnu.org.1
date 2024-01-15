Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3582D798
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKQB-0006kQ-WE; Mon, 15 Jan 2024 05:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPKPq-0006S4-BP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:42:03 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPKPo-0003Qo-OX
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:42:02 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so6865756a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 02:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705315319; x=1705920119; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/xNNxed6Hg7WxZWc0eS+pbs3t4k5VbiOxQ7GINP0ec=;
 b=M2K+6IGllH1N2T3ScZXwNscQuLjN2deIoRIKFq69tnXcgpR7vrY+rgSuDATr4cMRyk
 CWrL9wISljpCn3yoGZqSMPTmAuPYfRGWkpvtjluff3ZrcF5VwC6+yf5lHJY7UTZUbe22
 kqJrw/ZB5NfehhiwjjWo0ITSOYiulrYCyiJTwaosLGdO33oo/Kvz0EE9UBQfenULjoAs
 3umv1ixyMw11USZoww3fFprpXrq4V0LxfLv4iBd5Kj814ytoDY8LIEegjUEJU6dQ7nES
 Jc0q70kmAVa4u/IXkHLm3ahZBC6nidMgQhUT1yBaB4blYAss3sptbQ2hmeETT3xM6Arq
 UHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705315319; x=1705920119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/xNNxed6Hg7WxZWc0eS+pbs3t4k5VbiOxQ7GINP0ec=;
 b=gk3blhRHDPRh002EdjsqpxcO5SX89PbUzY56p2P+rRVbw8px7VYqmE6jj+35R8eKxk
 DsO1vHsF8Hbd5QJHykM1ZmjOK2+D1sVq3bz8lkeALuGq3yp5ofswC/ZKJjg84NQjC71v
 YnqVNQVgNmiuVRd+PN1NEcH5+ZwCDeZ6DyZBbp+4pWDlEI6MeXGGYWhVRDGxpiqiShtq
 FzvtiyCj1EXttYsanZU8YN4pVwPBiJOD3sdtCq4Fju0/S0qTFgF8PDfGU/Hk9rIy5RUQ
 817ILLSr8sr/xDO6FzHcUo9h2WI6ViiM+hssywy+UDka6Az15VLTbOcPbebRKOsF9olg
 VJPA==
X-Gm-Message-State: AOJu0YyhK8KPTUhSkr7ZffDY3JTR6zxr/zyOQ91UrcpmRjzC2s9hbf6p
 583r4vUw2037KXrI+B/YoCNuEN+9gcS0NYwHlam2zR4WFxUzuQ==
X-Google-Smtp-Source: AGHT+IHwrEeQp9Eq/WtsGWwgVEkFpSFUeNYhrctPsevO8Zv/uWXk9SQIrK9pm9Oy2PrXUqJy3F5vMdhLSKBeXVBRbpI=
X-Received: by 2002:aa7:da48:0:b0:558:8f61:f3b0 with SMTP id
 w8-20020aa7da48000000b005588f61f3b0mr3002839eds.9.1705315319236; Mon, 15 Jan
 2024 02:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
 <20240115094852.3597165-3-zhao1.liu@linux.intel.com>
In-Reply-To: <20240115094852.3597165-3-zhao1.liu@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 10:41:48 +0000
Message-ID: <CAFEAcA91+EV7_iHvp2Kd8zgXAx2zg3odepQgg=vPpPLv8ETRKw@mail.gmail.com>
Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
 cpu-common.c
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 15 Jan 2024 at 09:37, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
>
> From: Zhao Liu <zhao1.liu@intel.com>
>
> Remove unused headers in cpu-common.c:
> * qemu/notify.h
> * qemu/log.h
> * qemu/main-loop.h
> * exec/cpu-common.h
> * qemu/error-report.h
> * qemu/qemu-print.h
>
> Though hw/core/cpu.h has been included by sysemu/hw_accel.h, to keep
> the dependency clear, still directly include hw/core/cpu.h in this file.
>
> Tested by "./configure" and then "make".
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/core/cpu-common.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Something seems to be wrong with your analysis of what
includes it is OK to drop. For instance, this file uses
the function qemu_log(), which is why it includes
qemu/log.h.

thanks
-- PMM

