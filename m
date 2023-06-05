Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539B722BF0
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CTp-0003wi-P3; Mon, 05 Jun 2023 11:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CTn-0003vz-Mu
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:50:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CTm-0002pZ-1m
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:50:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so7624943a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685980244; x=1688572244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FZVt8oPOn3vFo3bMACFuIrwbjp9WHYCHWspt/wLwGro=;
 b=Qlf986o6Lrt9C7JfZ7Pgn2GPuNOiVoRWs7wGFn/aXbZctpsYS9S4n6toOjbwNuE/Zz
 4OkWVvW03pLkfHsb213gSK4vxCDkq47fcj0WbyBLVaOqFcNDLTf0HO5tmwJDTRM5Spyx
 1EOToadNLSPt9reRUATNSmvLj4aT0UOEer7t0y2/lrPbJjH/PruUmz1wMC7otA/yqgZW
 l+6AcFSuSzUg/abTLhUUQGr/YRjZb6OdePxnK/46LEWdbk89khVRF7Wz1k9D+h+rac3T
 kkdPMZvrZtEjo4xF/rJXSeTgN5vVZDjxQM/UN5DW6vKgxnEz06K4DLn7y1011DHJOw37
 xQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685980244; x=1688572244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZVt8oPOn3vFo3bMACFuIrwbjp9WHYCHWspt/wLwGro=;
 b=Y5KzWtG+CjR/R8q3kDTrytvfM6yC7Kp5d6xWbamd/Yg1ok3ahpJibI8pw3ph/Y0TIy
 OeGMed1fc7ZfmW30F2o1XuyH6f3pvSVRJoxxOosVL8Yhi7R3i8HmvxRqAdAKkVgL72jP
 lnK5VPRYEAj+9u32pOj6RMg/OAM6ZhC5npD3frNyfbUoGiO9Lq7K7xAlS199/P1QCMk0
 SAJudg6bwyZQLNtTTJIqArGqIntrb3pr2l/DT2Cx9eGxthsaonSTx3TUFAQ4ttDjP8Qh
 BYI7dBae+sFl/ti8yzgz4W1OfFgeN7eAz6d9A62ZrA9CKo029x1OVhX+vm9EdsU0B89V
 BBXg==
X-Gm-Message-State: AC+VfDwoh0dZecxc7VPTbvm31x4eXlWMMBwD8cBU2dQ4SogPiUw9QHIG
 1e46ZVtjwGjO1tlyDz55x3LTARANncSyHHYW41e2zQ==
X-Google-Smtp-Source: ACHHUZ7G2/N70aFSYtcdDJKtm5zA+46AcX3u7XZmWgloPKosATNthYjWXRGdAvC3ST1G2ioay14x4ZN0mydR3cGK64Q=
X-Received: by 2002:a50:ee98:0:b0:516:416b:f736 with SMTP id
 f24-20020a50ee98000000b00516416bf736mr5830147edr.35.1685980244168; Mon, 05
 Jun 2023 08:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100555.32718-1-qianfanguijin@163.com>
In-Reply-To: <20230523100555.32718-1-qianfanguijin@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 16:50:10 +0100
Message-ID: <CAFEAcA-muuRms2Js2-Q-PeLGV3KqM6ysdTt+hnmnisdM_NZkew@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] docs: system: arm: Introduce bananapi_m2u
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Tue, 23 May 2023 at 11:06, <qianfanguijin@163.com> wrote:
>
> From: qianfan Zhao <qianfanguijin@163.com>
>
> Add documents for Banana Pi M2U
>
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

The docs here turned out to have a couple of minor formatting
issues which meant they didn't build. I've fixed them up
with this extra change:

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index ae7194a9df4..b09ba5c5486 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -121,10 +121,11 @@ Let's create an bootable disk image:
 And then boot it.

 .. code-block:: bash
+
   $ qemu-system-arm -M bpim2u -nographic -sd sd.img

 Banana Pi M2U integration tests
-""""""""""""""""""""""""""""""
+"""""""""""""""""""""""""""""""

 The Banana Pi M2U machine has several integration tests included.
 To run the whole set of tests, build QEMU from source and simply
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 91ebc26c6db..a12b6bca051 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -83,6 +83,7 @@ undocumented; you can get a complete list by running
    arm/versatile
    arm/vexpress
    arm/aspeed
+   arm/bananapi_m2u.rst
    arm/sabrelite
    arm/digic
    arm/cubieboard


thanks
-- PMM

