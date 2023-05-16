Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E94704873
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:09:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqfo-0003iK-4X; Tue, 16 May 2023 05:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pyqfn-0003i4-1J
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:08:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pyqfk-0007iI-PW
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:08:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3078d1c8828so10624679f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684228123; x=1686820123;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eG2FiAdDCek0KWP239GymtrhVNXsakVCetTJ3Us82w=;
 b=OOf2e+RBObl/QqyiWE+aFU6Aii5Z7m/yHXvD9DLzYzmjic7BviAmRMJGibyGzLLiWf
 ovEBBQo0H73Ml+iOMMU3/od3zbaEdSoNyqO0Z3S5P5QkPLzolfgHCj2p83KZC0oN9dug
 dN9Pi54pPMFMOkSuKFlAg0qmZYSrdU8x7h6ZAczmXLChOIhU0WlVhNma1JorBKHOPMSz
 ral/at55F97b4o9M07pfVzF1PZtgA2xKIvQTI47NjMlERM2LBp7U2QQ+YMqiAB783bRi
 yRHX65nLUuX1n8zfMfjmW1xsfou5TUSrG0LQD2j7j9SaKCTq8CUNYdMn5X99bwShL4o/
 rVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684228123; x=1686820123;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1eG2FiAdDCek0KWP239GymtrhVNXsakVCetTJ3Us82w=;
 b=dqc6qCQ90DDpSvd171+lpK9RrMm6PsG41FsC0v7RrKBamGjCDf6ug01IZ/f3MMu31k
 9Eq8h9eTbtTk9qGZHOV2lRDDZ335kWbM9hGEPmFdbFwO5LwmuAvIL3P+sU79xV88+wHt
 guM+0dWn6ARV6koRYd0yqEIjiiKOv1i9mdHG/68pB9yyQsZiS9sZ3zYDJuERYI2eS/af
 3HOy5TpTzi5Xbw3i3ssB3zQ69I3otrlOF3aE1JmVL+FyHuc+JsBKIlfXov/b7DUssANM
 w+Wq7QzYpEyqS4PNzl3dDSLGpt7W46NMy7eH1ICrQ2fChb2HiyF07gvyvwHHu57FIVQ8
 vQVQ==
X-Gm-Message-State: AC+VfDy3a/MS9kyXw7fP4WleiWUFj4Icm+eGcVOx2iv6QVoMoAV3TTDS
 pKRCJg1SgO8wl2Q3Wdmoyb32Pg==
X-Google-Smtp-Source: ACHHUZ4jdz9ciQiDhSFJV1Z9S8OEZZO9USEGwMiDHOwVSJy24O65oHfzYlVlJqHca8U1eLZQLrO1DA==
X-Received: by 2002:adf:cd0e:0:b0:304:6a26:1f6 with SMTP id
 w14-20020adfcd0e000000b003046a2601f6mr28583116wrm.59.1684228122576; 
 Tue, 16 May 2023 02:08:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r7-20020adff107000000b003012030a0c6sm1885718wro.18.2023.05.16.02.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 02:08:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF6531FFBB;
 Tue, 16 May 2023 10:08:40 +0100 (BST)
References: <20230516072959.49994-1-m.elsayed4420@gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL SUBSYSTEM arm 0/8] TivaC Implementation
Date: Tue, 16 May 2023 10:00:09 +0100
In-reply-to: <20230516072959.49994-1-m.elsayed4420@gmail.com>
Message-ID: <87bkikprs7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


Mohamed ElSayed <m.elsayed4420@gmail.com> writes:

> ***
> This is an implementation for the TivaC board.
> For now it models the system control block, the general purpose I/O, the =
general purpose timers, the watchdog timers and the usart module.
>
> The code is available at https://github.com/moesay/qemu_TivaC.git
> ***

Hi Mohamed,

I'm afraid this pull request won't get processed. Pull requests are sent
by maintainers who are listed in the MAINTAINERS file with signed PRs.
If you want to get support for the TivacC board up-streamed you should
post a series of patches and participate in code review. We have some
general guidance for the process here:

  https://qemu.readthedocs.io/en/latest/devel/submitting-a-patch.html

A couple of general points to get you started:

 - patch 7

   This is obviously wrong as it updates the project README with your
   personal fork information.

 - patch 8

   code format fixes to your own code should be folded into the relevant co=
mmit

 - use of qemu_log

   direct use of qemu_log is discouraged. Generally for devices you
   would be using qemu_log_mask with LOG_UNIMP or LOG_GUEST_ERROR as
   appropriate. Think about if the log point would be better handled at
   a tracepoint (or removed completely if it was a debugging aid during
   development).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

