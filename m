Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02E9A626F
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Oct 2024 12:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pTS-0006Tv-1p; Mon, 21 Oct 2024 06:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t2pSx-0006Sw-BD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:16:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t2pSv-0008JA-Ll
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:16:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e93d551a3so2846400b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1729505802; x=1730110602; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VojtCDA3h+elD+VdZY6wIx7KFVIdLLDtaeDO6xJsKNQ=;
 b=OE/NU9Zdr0rbJmkBKz9ta4zEEjTNWVw0vmohbCEOJy3dH3/2xHWudrl3VVZ210U4eJ
 9LJJe4xqvS5IOo0dR91hsOObR1ehbigO2fT4qqW3KKLWWUKHDkADCuN+UHTekvCCeS1E
 v0RLpt2nIqO3jfhpg4kzhVMBZEdxrp7UAZ+VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729505802; x=1730110602;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VojtCDA3h+elD+VdZY6wIx7KFVIdLLDtaeDO6xJsKNQ=;
 b=Ycs50tjUfyACfEopgeManEzXEzv64/6cdJtP6d4LwG7ODbitlpZYCvINYx/MZGi+cV
 rWSQOku3Cwdef9YD1YbgPOdV546/T45dkY1uiVfgxgQotQwDvGs4Tv4d+Sy9nkhJPFFh
 9VApHDo0U+IE7jY7NMMsUIF0PFKverMvLcjoIu8r2StONsjv93M+KQX7JleIoJCcG/vv
 mkjk4ot1ge7Bkgdlnr6Kre2hx7GOxuCOLIFPjpzMFy8HG/Sooafse3a01G9sAPooWhDP
 fZyOsimGOmfGa4DDkUUYXTs/hrDG/2D6+DYmSmwX48aSoRlHVdMO9nF4Zq+zDKSmp+uY
 kAKQ==
X-Gm-Message-State: AOJu0YywSba4bXz+ML12KFpicDBx5scfkHadzkA/o8PX0TPiX7anYAAU
 brDKelbP9tmGdtwgQ9tsgv2J1+iFDzsccHpZlvFWP4jOib7NZbxjKRvXSQyxcjlc1BbyS5iE9yi
 uh2Y/g6/7VBMEz/B1Zzs6dzeEOPUZdrsq
X-Google-Smtp-Source: AGHT+IG1t8D9mcPpaITW9F7GUiJ3EPX1D61msnh4/sdPxnYWzLA4jKkMKJPhgada5uoa2+dE4Tq/WLde4PTSRFUezvY=
X-Received: by 2002:a05:6a00:139d:b0:71e:66b:c7eb with SMTP id
 d2e1a72fcca58-71ea32215d4mr15857157b3a.23.1729505801978; Mon, 21 Oct 2024
 03:16:41 -0700 (PDT)
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Oct 2024 20:46:01 +1030
Message-ID: <CACPK8Xc=jsz5iT_WR7s-rcu1cRzryiK+-0o=6vUK_D_qMMrP3A@mail.gmail.com>
Subject: Missing image on storage.kernelci.org
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.17,
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

I was attempting to run some boot tests today and saw this:

 (11/39) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_bpim2u_gmac:
CANCEL: Missing asset
http://storage.kernelci.org/images/rootfs/buildroot/buildroot-baseline/20221116.0/armel/rootfs.ext2.xz
(5.21 s)

Cheers,

Joel

