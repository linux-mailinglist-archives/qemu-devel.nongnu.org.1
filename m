Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AC7FBF26
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:24:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80sQ-000111-Tj; Tue, 28 Nov 2023 11:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r80sN-00010T-SA
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:23:56 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r80sM-0004x4-9x
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:23:55 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d7e67c169cso3696341a34.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701188632; x=1701793432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BRbjogKMfSYVyfMWKfz9FXy2r6Ghnx55y3VWtW1rO34=;
 b=CVaiqmEBUms60Qk3H6Ojw0A79WBDm8NTOvQl2b/0b8cafneQPCFZs8LpE28O6kjR1o
 B4irV7DqQiWViFEAuN01eIBtrtWDM9pFmZ2ttFXUuYs73Q7LaesM9TzfIEUEkZS7Judy
 7B8Fk0h3UBKklcOfGoxNlMsznVzTiuPJ0l4f3meCdxB2pLglanszNarZhuDL/r/BgLNo
 g7f4JfjuZyq1dil0DU6gfWQeHTdl7Ei5kAruqoddgqirPB78DEu1fJnW/WU0XFCBhF+z
 bl3yfkyMMjy38hSRH3uhvjQZxp8HJLNBpfBLwH1EZTFQWE99AMhp7ybwbptrmePPRe6b
 WABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701188632; x=1701793432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BRbjogKMfSYVyfMWKfz9FXy2r6Ghnx55y3VWtW1rO34=;
 b=Vuc2EJOfXoMDoIU4G2m2dAixDsS+WhRiZ64lhcaPzyWpMm40qdy9vVBcONskK4CsUa
 Utrlc/iPEOh2CrrLmMvk99vTJcERFygFDETMHrKWjVv5T1N84HYYfKIBWWScg1vvY7mj
 fe+dr5JyyGRowVoTWOOIzmV4mDKy8ejdc86H+RmBopeRmEeL8u/qrqWjiNzWmyAZssvj
 gxcaGoRkwvT68WxzuEp4pfC6S9Kd+0xXH64J2Ell3T/NNm7tsVhEPfmQFhBwcRrbflOY
 yLjP7u2isP1OQqCiUCuvdSEKuTzyPg4V1Uuhdt+akT4PJLb5nm9CSYqq3/WRL5TgGcsx
 yJQg==
X-Gm-Message-State: AOJu0YxVttEXCeD9yPzaU/6TvZG16nbmV3XzupPw9jOD4AtQ6rCehb4A
 SbHhffHHOBT+89kUa3+w1lUstJoIs/OK2112zeQ=
X-Google-Smtp-Source: AGHT+IFBrc5Qc4n3dYXmb+Y9HoNKfpxYykPAeQJy2+D9xzQcx1TtJhfTF8nhIjm4TVzF0W7irBzoDae7GxBmt6iQZF0=
X-Received: by 2002:a05:6870:3c0a:b0:1fa:7b7:102 with SMTP id
 gk10-20020a0568703c0a00b001fa07b70102mr19321353oab.59.1701188632149; Tue, 28
 Nov 2023 08:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20231121173416.346610-1-kwolf@redhat.com>
In-Reply-To: <20231121173416.346610-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Nov 2023 11:23:40 -0500
Message-ID: <CAJSP0QVCPgG83iV-yc+WnRCaz4f0+=EP=dBCAvuJ47jtR-XtAg@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/2] qdev array property fixes
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, armbru@redhat.com, 
 philmd@linaro.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x332.google.com
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

On Tue, 21 Nov 2023 at 12:35, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Kevin Wolf (2):
>   qdev: Fix crash in array property getter
>   string-output-visitor: Support lists for non-integer types
>
>  hw/core/qdev-properties.c    | 33 ++++++++++++++++++++++++++-------
>  qapi/string-output-visitor.c | 24 ++++++++++++++++++++----
>  2 files changed, 46 insertions(+), 11 deletions(-)

Applied, thanks!

Stefan

>
> --
> 2.42.0
>
>

