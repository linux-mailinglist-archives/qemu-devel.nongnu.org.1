Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F276EDC9
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRa32-0007ub-Ug; Thu, 03 Aug 2023 11:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRa2v-0007tR-QC
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:15:26 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRa2u-0005Xk-4b
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:15:25 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fe457ec6e7so1937277e87.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691075722; x=1691680522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mOMTqH5GRYn45YNLKp8lIdHx/5Md/Vg1xa9KzqH7pds=;
 b=n5kClUfwszNrS8nTVFZ2rFoV9yhjpwekK46MdALSV21L0uP9XC4HaCdGh4LtmnfnLq
 WnlXOmVBKxuM+i+F4BrSG627eyB96rDLeuoJEAJWx6Qj5fb3OAvQQtRu3cZHJ+mw7zQI
 T3F44cIErrXRkiRZCKM8cNrfOdRUWYh2gxfHBiJH+4rhplh5cjp42SZECMFh43E96YIf
 4yGkwUb3AyuovtpE3dPOXwZknkdoK5In7k38A27vLXEHbi28remNmWqRNGeQiQTiodOX
 nZtPKqt+btQAKPiJ04TxmCZ1bXg/k5Rhkl1X5J6l8cKVNbS3DV1rOv9RLni65vX4DHQ5
 Cppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691075722; x=1691680522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOMTqH5GRYn45YNLKp8lIdHx/5Md/Vg1xa9KzqH7pds=;
 b=cFES8Nrfbda0gI+NiS+4o8E+avdz3ELknWB1DpPsCvdjWOyy3xajzTnnPhI98AhM2G
 OhBDs7i6WrRPWHNc+nQ3usP4h3TCuLCRM44tQnTOrDkW1i9DCTeYM+JJomGL0zbQ1fca
 pda4OP71i7m8Zj7RLqW8QISpPO5ycR/hq17jzzfaC32lPbbwzw0PUsze5gDY2h/PnnhY
 g3apLcXycrumGZGa6Rfbn3xLO56eJdNhOF5+LbqnSIT44npSAO0x+5hWmrfjqdsS7hVJ
 T/VrrrlGoywOIhQWQml4Zy9cQjQH+xR9ck+rASy5ch75eOGEJ3eIvIUKwwwCXuu9KtyZ
 gnyQ==
X-Gm-Message-State: ABy/qLbxuGYWkbVMOKAYYHNQmhXnk/e9CPONNHOcWNW7hkUMHbvPWS9s
 zNee+d09avIYTcJbrZB1RxqsfcM+vgftdxv4PfNKRw==
X-Google-Smtp-Source: APBJJlFp3M6JXK6XIQnTRL3c0iPgAMTPUF55q7GyqIQtwhN7Rus+PQ2JahcT9rAn1oWOT3L63tLzDplUUDMB3Kz6Yn0=
X-Received: by 2002:a19:ca0b:0:b0:4f6:2b25:194e with SMTP id
 a11-20020a19ca0b000000b004f62b25194emr6078740lfg.58.1691075721635; Thu, 03
 Aug 2023 08:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230803105830.8722-1-m.tyutin@yadro.com>
In-Reply-To: <20230803105830.8722-1-m.tyutin@yadro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 16:15:10 +0100
Message-ID: <CAFEAcA8dsYuMaAG7RpO_47WaedR=2AaA7V5q02T3MYCUiDCCvA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix SEGFAULT on getting physical address of MMIO
 region.
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 alex.bennee@linaro.org, Dmitriy Solovev <d.solovev@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Thu, 3 Aug 2023 at 12:00, Mikhail Tyutin <m.tyutin@yadro.com> wrote:
>
> Apply save_iotlb_data() to io_readx() as well as to io_writex().

Could we have a bit more detail in the commit message about
when you can get this segfault?

In particular, does this happen only if you're using plugins?

thanks
-- PMM

