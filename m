Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB8D836BE7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:54:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxYY-0005Cc-Ny; Mon, 22 Jan 2024 11:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxYX-0005CM-2p
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:53:53 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxYV-0004Iw-9d
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:53:52 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55a684acf92so3474235a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705942429; x=1706547229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ouCAUGiG/HN6wtEcgdOS3ToVZeS6s+J3KqfEjW4t2YA=;
 b=YPORGlUNaph901y8NEJJ+ni41e1vvNd7G6Sd3sDLcgaINKD1wtAQhWEDIruDTAweMV
 EEAYoUOp/c+PgRKxlZbO0hgGo9+GvN1Q7YrgrxsMTIHRHUS+H+YLIMCSWQHm0Hns2/J6
 AvQ2+hxKi/DWqqph/zlIU0tW8adaaVlXft3/CTNJUUECzfJjNjRexPPZTHVciD4sKGDG
 v3qq51+HSNDcd0YVvz7Kog5f3zTZoeF2Av64YVKZQoHP74duxsRWRyRLaSbCMxQmcPUA
 vTlZnAjvEu7sCJbbfXObZ4oa6hq/NGP0Rzuy7F9WPpTnT91JQNYeqA+abHQrfYUGXWAH
 alDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705942429; x=1706547229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ouCAUGiG/HN6wtEcgdOS3ToVZeS6s+J3KqfEjW4t2YA=;
 b=AGVHXrFBe0D4j03Ds1k6ncVCSuZLX09O9B0eHbAlcM4xIyit7uUWWfhi7dmEOZ6Fww
 A7XWg9ueDzUqW3xAH/nwA5jrTxwc15rNtFaIiU7hbpU60iTFUbbPpz7gWIJ8rLt8uXfw
 a/gPH7JngoP4DxO+Crpx1nTbxaVQuBwdiSCx1ZbM//RchmQVimsFHDyLd7/2g63ApD3v
 CBtdEdCC3hSclvc797N42A8txCBmQXiNhu9ocUksOx+XVBwcJFx2PEEj+JhLFrtnMdiB
 z0BAQNJ3CYFo+r+aYs0pG/Jdfrf8cJTdvX5DjAviarAvMabOzWFQKl3Bn9ljHlEZIVL8
 tQ1g==
X-Gm-Message-State: AOJu0Ywl1bmjdjNikhxoUwAYpCHx71K7POdoiwnipyMN164SttM7DOSf
 6fReuvpx0pw7w0dXpbs3Hc4yROIxkZNzhplz70xfIRYkZlElIr1MHzmLSzl64kKZQAICjMIHAb1
 HsEdF5gC2O9S4im/v2ruGf+JSj3h+MUi+IcLXWwj8+odg879x
X-Google-Smtp-Source: AGHT+IEwbyHRBB7Fx4hjFKlsxM3zWjTUbH89ZlcjlsBiWnwFyHOOW9anOPYbuWpm/JaIfaHRqN2wb7jKkKjP6Enlbp8=
X-Received: by 2002:aa7:d3d6:0:b0:55a:6d3:352f with SMTP id
 o22-20020aa7d3d6000000b0055a06d3352fmr83824edr.38.1705942429199; Mon, 22 Jan
 2024 08:53:49 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40m=UQ=F1-Vy4-wR18RjqzF9o+8UOjgpUsrTU8QXn=7eAeA@mail.gmail.com>
In-Reply-To: <CAHP40m=UQ=F1-Vy4-wR18RjqzF9o+8UOjgpUsrTU8QXn=7eAeA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 16:53:38 +0000
Message-ID: <CAFEAcA-6Eb-XDBYkcK4rbDcavNU7pY4dWHeQvVa4MFODBKiWsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Port qemu to GNU/Hurd
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 18 Jan 2024 at 16:02, Manolo de Medici <manolodemedici@gmail.com> wrote:
>
> Recently, a testsuite for gnumach, the GNU/Hurd microkernel, was developed
> that uses qemu. Currently qemu cannot be compiled for the GNU/Hurd, as such,
> this testsuite is available only for GNU/Linux users.
>
> This patcheset allows qemu compilation in GNU/Hurd. With this patchset applied,
> qemu can be compiled without any special configure options.
>
> Please review, thanks,
>
> Manolo de Medici (4):
>   Include new arbitrary limits if not already defined
>   Avoid conflicting types for 'copy_file_range'
>   Add the GNU/Hurd as a target host
>   Exclude TPM ioctls definitions for the GNU/Hurd

Hi -- something odd seems to have happened with these patchset
emails. The cover letter got to the list:
https://lore.kernel.org/qemu-devel/CAHP40m=UQ=F1-Vy4-wR18RjqzF9o+8UOjgpUsrTU8QXn=7eAeA@mail.gmail.com/

but it doesn't have any of the patches as followup emails
in the thread. Instead they got sent as entirely separate
emails, eg here's patch 1:
https://lore.kernel.org/qemu-devel/CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com/

This means the automated patch tooling thinks none of the patches
arrived, eg patchew says "0 patches received":
https://lore.kernel.org/qemu-devel/CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com/

git format-patch can help in getting this right (it is its
"--thread=shallow" style).

For this version, I'll send some review comments to the
individual patch emails, but it would be nice to get this
right on v3.

thanks
-- PMM

