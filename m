Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF980EC55
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:43:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD259-0008OO-SA; Tue, 12 Dec 2023 07:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD24W-00087a-6g
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:41:15 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD24M-0002xW-NB
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:41:10 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50bfa5a6cffso6425950e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384858; x=1702989658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bJt43AIbhUmmvSAMK/8lVTb5lvxxaMxp7J4i2FlhrIo=;
 b=wKj+fTduNF336+KKbnhf04XI9fT0Kxy9K59fgJOWF6YOiEzKFzM/LjnN7ECIM9Byek
 2sAWdtMBtrvw1NdD6HZyHM7dkijs3fuscra7NBJTrqmBkDlueWluXBR0AoQva9Ai/Ca7
 qSKXMfxPfrQt181DS2TTcG/xyYQkvFbxJIeLnS4zGWjAOGwcYvtOZMhEivr+Eo7lOhhv
 wJSDu88vGSJgE7GNBMW6rt8fQ9MBstXfLwrwlWxtuM7Xk1ryL9MX5CLziexwChE2EVAd
 LXcZxjPw8k4PGfti9/t7ryTE53amtGhWYAHAnxqmATgHtHXZ3aYopugxZGkwinVpJTjL
 wyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384858; x=1702989658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJt43AIbhUmmvSAMK/8lVTb5lvxxaMxp7J4i2FlhrIo=;
 b=MAlxBV6i4TZV1ms15z2RGSvuGBc0gP3qLscn5XtBKRLbdGGDXH9LyRnYu3fNHcJVEG
 sW9CgMN1ulysm7oLiXWAoX/rvQq3KsVQbitGsLZ/BSwpSR+jy931r/8sUoxXUPge2oaZ
 WRHPovYtLXlwedOnNI86DhvHrE494PCTyasSDbGW/xmOcfOILVqfOXfh2bnFYr2QuMRN
 wKl38pTYPNw4+ihkbbOechQp2hkKrKQKllEd/4tIqtjmpHDEMny+gkpIPVtSk8YrYmEs
 IHG/0HZJoVjGVe1YHGTutEss3NK4KvpSs2AumB2nS9fX3cB6FbdOLDLowCY2p+ZuTD4Z
 ZZ6w==
X-Gm-Message-State: AOJu0Yw5MVJEDZP7ortO4Gbdl6ABmlbxTFhDEa34flRP1JkjXVf9rXFT
 wI4aR9M1Ws4p4TPizjuu1HqgOdC0dR57s9Hg1Vrhcg==
X-Google-Smtp-Source: AGHT+IH6zZMwEc/xgU5NZ955pA5Qt3rG+hEkCZ1KpqKbR6JPb2fUCVJXGlyCPE4QGMxJSwhbACkdLBFeUM+uWoJXl+g=
X-Received: by 2002:a05:6512:46f:b0:50c:f1bb:b059 with SMTP id
 x15-20020a056512046f00b0050cf1bbb059mr2401872lfd.45.1702384858311; Tue, 12
 Dec 2023 04:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20231025092915.902814-1-gaosong@loongson.cn>
 <07f56184-5b40-fb9f-ee96-6d963d362b4c@loongson.cn>
 <806a3237-ee1c-9604-7fc5-430671661928@loongson.cn>
In-Reply-To: <806a3237-ee1c-9604-7fc5-430671661928@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 12:40:47 +0000
Message-ID: <CAFEAcA80ANxiRqFfCn91rqobAMm9Na-UTSY0yd4+6u9fvEOOsg@mail.gmail.com>
Subject: Re: [risu PATCH 0/5] Add LoongArch LSX/LASX instructions
To: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 alex.bennee@linaro.org, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Fri, 24 Nov 2023 at 08:26, gaosong <gaosong@loongson.cn> wrote:
>
> Ping !!
>
> Since [1]  series had merged into master three weeks ago,
>
> I ping this series again.

Apologies for taking so long with this, I think I
lost track of it and then we've had the release period.
I have no particular issues with the first four
patches, and have left some review comments on the
last one.

thanks
-- PMM

