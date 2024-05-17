Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193178C8460
	for <lists+qemu-devel@lfdr.de>; Fri, 17 May 2024 11:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uMd-0002WM-Ew; Fri, 17 May 2024 05:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7uMW-0002Vr-PO
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:58:53 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7uMU-0007l0-RU
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:58:52 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso4732068a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715939928; x=1716544728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qTPmUPODZLv6jI3MRsC+xVG4jzWTeuCONjyxcS7El7w=;
 b=VbJ+uvpgTi+VNE5tmQ9Y8vdQzr/azV526Tf8u0JlfHXJdgWsgACvy1mhduolWW0lPA
 usCXtPcX/tTK5YMGkhgWcio7PExDnYT7vbGGPHjqOcJHzbN9EhnavlN3ZbV63WTbrJ63
 w6vDjeJtoMgs3R0GCZLjTHZ/ygWGJQ5wUaD9WwXWHJZ0EZxilYZD3kovRK9kWjmrvIlU
 OBH/5ykL9EMuLoehfCytgqUWkDy6bP0mlkz0+sPjpo8EPXTxbQz2Lw9DqjacIN+j3weL
 zgRhsEYSJrgC5hEmCeB7e315fPkhO24piQNfbbRMqA4LdBepgXfS5fMLEfYIf6oaQMG2
 wGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939928; x=1716544728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qTPmUPODZLv6jI3MRsC+xVG4jzWTeuCONjyxcS7El7w=;
 b=hlYBKQGbemiSV0drAxY4uwFE1sMmbxvL5gMeE6CE61WllfnI1B8B6tIjx74hm7bCZ3
 N/MyewlvXstmoKf/VVmWIGYtaEkFfz7vLL/tPgFyyQzGRhxtZSCpUDxrEUFzM4wqK7LX
 SL6Sfc0JtvE2LvrnQSmemM8hy1D4aWcv6GIj7AxDIVM12itxC+DaNnkDLtG9wpRqTMpQ
 5pQTIeL06n7WptPS4QVA3i7LpCE6Xt6V9zB3dQhFYFEcJ4gqi05MCainMfruZ6POj2mj
 kHk9YpOB5tAa7B6Rr00tBn6+6CCczEYYYck0MAxEkLzyE+KaRQPCJqqb5qZeCJDhhlJS
 EuiA==
X-Gm-Message-State: AOJu0YxXhBTJzxaFxo7bRV+aKQ31dgGJY5VdYkBxik9fg+q4gmVtmhzO
 sYr4eNrJ20vLoqCG1B2jOebrMSyTeWCMlfhFBViqHhcz4ODrx9KBQPMFKMSvFIW/Y4faOTodj0w
 6oQf9/m3TXAdxBoeJy0smub5QXPGbwpsM9K5IWQ==
X-Google-Smtp-Source: AGHT+IE2/8c1/IEuLNtWNdGLdOz3qeLg9Wk17ocXA5xldhzVfTWjc6P//XZUhg9NyYFKOEF+d+DoxMsC0pQRvikNKkk=
X-Received: by 2002:a50:a6cf:0:b0:572:9d24:257a with SMTP id
 4fb4d7f45d1cf-5734d5cff4bmr15318912a12.23.1715939928399; Fri, 17 May 2024
 02:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240507130349.86851-1-sebastian.huber@embedded-brains.de>
 <78f54624-2a7f-4478-88b9-bc69b2a482cd@embedded-brains.de>
In-Reply-To: <78f54624-2a7f-4478-88b9-bc69b2a482cd@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2024 10:58:34 +0100
Message-ID: <CAFEAcA_xhvjeBKEonJqY-3SGdY542VL7kjJDDOmFApC8U3Kfag@mail.gmail.com>
Subject: Re: [PATCH 0/2] Zynq 7000 SoC improvements
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 17 May 2024 at 09:31, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Hello,
>
> is the mailing list the right place for contributions like this?

Yes it is, and this is on my todo list to review. Sorry for
not getting back to you earlier, but I was on holiday last
week and at a conference this week. I hope to be able to start
working through my code review backlog when I'm at my desk
again next week :-)

-- PMM

