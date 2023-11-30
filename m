Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C127FEFFA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:22:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gzW-0002A4-Tk; Thu, 30 Nov 2023 08:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8gz5-00026V-Tj
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:21:40 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8gz4-0003mZ-Bp
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:21:39 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-58d9a4e9464so447405eaf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 05:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701350496; x=1701955296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=thK1CwdyPqo5okKJ0NhFoEW9xI9XBf8X+kffz9CT9x4=;
 b=WwvbRYXNJW1Lhhrh/YqCBGh5AxrIDMXy6H0CoI3jXfP62NZEHCdq9uK6cIPENq+fD2
 geBo+gzvX8164hKcYBAgU6PEFUhd1Qe938lUYICWep+OynawOXk32jQ7PRlNeSiVTeDT
 AvKvnf91mfAkZpZk0miUf8NDgMxSRO0PudtahWhLwmq1MUzk0nJxABUt7GvBWNSxqSd4
 0VZEgCG/c3Ys4k8QFaXgWJXdLq4ht1P+DiveJ+nXZiMFuKdrR6+XvcvG2cgl2Y6HS6i0
 +adH6D69jT4UPdtGBQTqyFatb23S6jitajiEVr/2d34M1jxMsSB0stsAhwBfDJbHio7O
 qrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701350496; x=1701955296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thK1CwdyPqo5okKJ0NhFoEW9xI9XBf8X+kffz9CT9x4=;
 b=aipvC7KYe0dsENci1SZUpx2wEYTok6CAfSncd5MAY6d6LsYzVZHUjcWio61WRgpKX+
 LyxeT4946sCKvQ2cGObrTWPQyIc91QKvEpJIB+pu/r9COSSCDW08BLb9V0aYFaKtvxKs
 7xkVGVGHXi1t1V4HUg574Kp/XmIMYzIyWIESW27WAjJRmTJRd2HGv6XcLTOPQxuy5RdT
 AXZdcwOrw9xif8D+h0xZp10a5dkSawyWoQHRAgWa4eFv1W/TtWnnXrG8I8yP53Uq4APR
 fXyfwQXzb9LCCprbRnHdQINEMEYCegZvwX4iYQf9TCv+V/pJAsh8hh7YbxSS4UKTsQUk
 CVGQ==
X-Gm-Message-State: AOJu0Yz1CFCluR4k+JtkVfDD9oUcRn5xrYM+tpXg/ZwqsobtrYphHiM7
 WtD++VCKP7ojwEl+4mLOET/G7h0+i9r9Raaoklw=
X-Google-Smtp-Source: AGHT+IHoW9b6fjeaVy7mpm8e4vNXVisKtIFXj+bseFNZyBEAp0mbwFqOzbQMXqZ+wyfJpzPKQsUVhNtQLv+t3g+T7PU=
X-Received: by 2002:a05:6820:1c99:b0:58d:d938:26ac with SMTP id
 ct25-20020a0568201c9900b0058dd93826acmr4521657oob.8.1701350496060; Thu, 30
 Nov 2023 05:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20231121173416.346610-1-kwolf@redhat.com>
 <20231121173416.346610-3-kwolf@redhat.com>
 <87bkbb9yht.fsf@pond.sub.org>
In-Reply-To: <87bkbb9yht.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 30 Nov 2023 08:21:24 -0500
Message-ID: <CAJSP0QXsbVV45587ufPM5MFErMQUonHzoCFc2ZzGWJKFqbYN7w@mail.gmail.com>
Subject: Re: [PATCH for-8.2 2/2] string-output-visitor: Support lists for
 non-integer types
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, 
 philmd@linaro.org, peter.maydell@linaro.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 30 Nov 2023 at 08:12, Markus Armbruster <armbru@redhat.com> wrote:
>
> I understand Stefan already took this patch.  I'm looking at it anyway,
> because experience has taught me to be very afraid of the string
> visitors.

Hi Markus,
I should have waited for your review. Sorry!

Stefan

