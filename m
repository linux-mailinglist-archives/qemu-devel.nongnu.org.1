Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E310F7865D1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 05:25:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ0x7-0007Nb-Mn; Wed, 23 Aug 2023 23:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qZ0x5-0007NT-VG
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 23:24:08 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qZ0x3-0001se-CN
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 23:24:07 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b72161c6e9so5412441fa.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692847443; x=1693452243;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sJnRiNL+Qlq/qMlxM+iMnFLHuqbJXF06ojNt2FxHb3M=;
 b=eqv9iQYHvTnhWzUdhi9C5p/hoNAr8bOd3JXWy2HC0Hf+jmRyQlUT2unHQR/7sPc61/
 SpruODVMUTjwHWFKtTnTJeIrbm+b+FvcodGLHH2Kly/TP0nvcFxz9CG0o0IU9Mt2yKsk
 bFS1Dbr4aMa+fpLJkEfGWnHq3GjSmaMospI+zG3tdZMwH2wdaSKZM32YTQ4phCYdNlE0
 /IrgT/TPBN+SpwdLaesni0UL2kjLm4GTEP3G5xKhnrknxvWU6fpNWPaO0TmWm2IaeViQ
 quJ4xIcfy2PAQRbG7yL/CIvnPkToo83JOkIRrJIurlZaaVXQ2XPe9l4EV7kyBNypRU10
 lO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692847443; x=1693452243;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sJnRiNL+Qlq/qMlxM+iMnFLHuqbJXF06ojNt2FxHb3M=;
 b=DK9nhK3M51dvdiwFBqX+R3XiGTdhT80xiRsPP3T6vhiU4LaXv08NjPuuio14JwJufo
 vSZMuJ5fQd0gsCsPuVm6A5x8VsX4+h7oGLd/fw7RkgZiV8TNsGz0zNLR8c1jc4RU7n1h
 ZgiukcfABsxbSL/0JYQiI7iRq80fV+zym4CfJu+5iUPFUEyP2tUFG7xBNfFbMXwSqcPc
 JYz+Y2QucOxr/ZGinp2vXX2aEb9vegDoNMjg+i8FfoYFRTluecC2L5hXi5l+RJwew4vZ
 0eM9WLU6M0G5/25UuJ5V9oxT1QUBZLhupG5u7fqPuWZQB/xIO94DNZeYCZlWN9fhiHbM
 XS1Q==
X-Gm-Message-State: AOJu0Yznqq5tU542hY75VRCU0p4purjZ3qXt0FSv0TopoimEvDOFNyIH
 rZoIlU29G/x+M1GqPYSreSsVt/akJUYayrS1oB0WAH3qAg==
X-Google-Smtp-Source: AGHT+IHOd9HGk8Yq7DxievvOG7XpLCRltV7kdXI+b0+0c67OjDtX8Lq1jNkRr0Ef/9SavMm8sWPMesJNNpN2Z5KYFzw=
X-Received: by 2002:a2e:b5bc:0:b0:2bc:b63c:e823 with SMTP id
 f28-20020a2eb5bc000000b002bcb63ce823mr4294776ljn.22.1692847442488; Wed, 23
 Aug 2023 20:24:02 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 24 Aug 2023 11:24:00 +0800
Message-ID: <CAOYM0N261g8zrDKq2jQo4mriHEhNXWo-oXZ0LCryL+BmUX-h6g@mail.gmail.com>
Subject: constructor vs. __constructor__
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000077f22c0603a2c2b5"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_20=-0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

--00000000000077f22c0603a2c2b5
Content-Type: text/plain; charset="UTF-8"

What's the difference between  "__attribute__((constructor))" and
"__attribute__((__constructor__))" in qemu source?

--00000000000077f22c0603a2c2b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>What&#39;s the difference between=C2=A0 &quot;__attri=
bute__((constructor))&quot; and &quot;__attribute__((__constructor__))&quot=
; in qemu source?<br></div></div>

--00000000000077f22c0603a2c2b5--

