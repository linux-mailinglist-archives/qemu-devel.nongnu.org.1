Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6162825AF9
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 20:13:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLpbd-0003Fz-3h; Fri, 05 Jan 2024 14:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLpba-0003Fc-TX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 14:11:42 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLpbZ-0004Wy-8T
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 14:11:42 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ccb4adbffbso23541781fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 11:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704481899; x=1705086699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b/xWt9HcFaZ8rZA7S0X5KGzzTrv3RzRl+XbBpqD19zk=;
 b=no3m/ybPprs2exqvvF7wol2WdKVMEPeVbcParX+78paLnFIY4paAyUk71DgnX/nKcN
 QW49iBhCmAdm1ATmEFgjK8TvsStwLHPGhc9/PkvTP1Aph1/l38w9YvAzpQzj26dawxz9
 /SJ8luDlGC9P6nCMhTeb+jPDzqJ6VnA5+9+u4LuheToLDPIqI1pZ4E9WsD+Bhf0g9yNK
 OZJerYoOsVAiWyhqcBJTkK7XkxhxzuZmjbEu+iXYAc3USfO09D+jrdCIJ4B/iu7jVKPR
 iznVp4b/oDXoVNxYL6RfsLGfI398SBLNEtaJxVzVdIR44vtz+V/MTK6qnuZad08zKYbG
 8RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704481899; x=1705086699;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b/xWt9HcFaZ8rZA7S0X5KGzzTrv3RzRl+XbBpqD19zk=;
 b=op2YWHK3wxEvOTq1l29EOzfKbOhu7RO9mN4nFbnUBqgGu5UKb4fSAJ9ASEdmCEUP7l
 RCLTEgb5c7DoQ36x4NRibAWnCRrS4dhjl7mBgQeHewidIPBYAW+2EWvPYvChM7Qu7wfR
 bI7doplP44uXPYwVGmHl904hPRgDzI11Acmf5tfuMHXnSO8OGkmnVzSUPXXPHoWnOsqb
 4WLc4INO8o7g25qrJDfNZcGzNP1G2Ghk4zQELyV4u0H+MW7RSCEYST7JWU9QaQpk5Qdd
 1tlsNRp2gBqxvRZ6R3E0d4UrTOSvjkkwRLC1ojB6apzvfD3J2zFK5dRY9sQotlH3d0Ga
 sVHg==
X-Gm-Message-State: AOJu0YzNvLqccTx8BEUHT6D82zHZQGS5XlvyYNwaKz0C166K+kirmskZ
 bRsuE/cVdqFSpklyusYpujTHIbBf9smaSPm3TkMG5qaZ3H4hkrMvnbrRdZ2c
X-Google-Smtp-Source: AGHT+IGTH/klVla2fkeTzeBU88S4DF4/TxnUzHBaRRSSoeweWJesX5Bj9VIEqtqnXj0rmIeCWpUaYeiGGvkf5q2Rwuo=
X-Received: by 2002:a05:651c:2325:b0:2cc:dc54:871e with SMTP id
 bi37-20020a05651c232500b002ccdc54871emr1310188ljb.24.1704481899468; Fri, 05
 Jan 2024 11:11:39 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 19:11:28 +0000
Message-ID: <CAFEAcA93kpreNOOKz6-qbVE_9Kg6tgZNaMowNLwc+G_47MXLHg@mail.gmail.com>
Subject: CI "pages" job failing with incomprehensible error message from htags
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

https://gitlab.com/qemu-project/qemu/-/jobs/5871592479

failed with

$ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU
sourcecode"
htags: Negative exec line limit = -371

Does anybody have any idea what this is about ?

thanks
-- PMM

