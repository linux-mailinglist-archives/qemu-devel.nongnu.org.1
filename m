Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F273611A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 03:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBQ6d-0001L4-GJ; Mon, 19 Jun 2023 21:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huasenzhang@foxmail.com>)
 id 1qBQ6Z-0001Ks-0l
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 21:24:24 -0400
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huasenzhang@foxmail.com>)
 id 1qBQ6T-0001k7-EU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 21:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1687224237;
 bh=/cjTdjEtHjGb96NTlO5JG/hmjYK205Y35rKTw69rr90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ATW4DGTLJyXr8rHyMydkeOhM4t5VVBN5QalqwyyRLs061BwpihcF9eoDkpFBRKXFD
 dsXil3wl9vnSCrKMwNOuDWinfZwRCQucJDUmwY4yVDpIZdOeafkwKPtOyysQJuzrJB
 jJQFYe043NWqpZRtqGIeqAxGdcESi17DZG7rIBgA=
Received: from localhost.localdomain ([14.18.187.46])
 by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
 id 5F7908AD; Tue, 20 Jun 2023 09:23:55 +0800
X-QQ-mid: xmsmtpt1687224235tslpuzf3m
Message-ID: <tencent_6110C6D51175862333F011AB17690AD0C007@qq.com>
X-QQ-XMAILINFO: N2bAIxLK0elnX/7p5RLZfb7iv5WmSkelIiAutBomwNBDg8mzBRtrSkPFTMDBR/
 POrUkidAVrOQKM6Ay/Xo36BI5dq/4B4dLm0s+mebQLqIhSf7nN9+170H3z0R5SJUol1nelfcqk74
 kpgozjtyLHiMMqEASLwJZm9h3mwWktj3JilsG/vBX7zBq3QanUYJjEqQHihv9cyh8hHIwPbr/3OL
 kjygulSIXmioh41z7mjqe0qo+P8Bg8sdylj/qMviCP6hBXn5Jnp7VVOkbtLHKAaDQFIEKOZH/HLp
 KWih2hUrxMCs97+/kCc4+PJ/rWrDJNLnpPY3vQ7Nsnc83f9Wj2znIOncFNCe6sZtTjoBgbA9XgVV
 6yhf8qF3xAj3i1lv26WYbsJAk8tXxC39LvvKjIMpoICHQV11y7fl0D6OoM87kKgtOjKP2b+BMe1s
 8Org5jDsZR+aFlb1IH9qFSirLUGCV0nhBhkkK2Qax54YqHcMlhZAo0HnS6ZmoFpLtFCQvOcuZZjz
 09AKVE7mJTU7m11E1YEwvzbpl23c3Ajk4N1SoZwhx9KcShZM5y9njsKmQi8hhCp1wL3N3pDSFFX1
 bKi1Dhv5VdkdyVJnh0A5JCooY0sGJcGrPrODJVWzp5RuQecnFs6RdprTczzWMVIbo9jjU0qDR4U7
 ehMoMAaEiPu5bKrlPEUZk/hCxJ/1Zci8LcIld7ZyMhtkofkMgHq9UB8nvR3H3AQ1MAchJgo3JpgL
 LtMA2dwjlscbwI88Up5teXx+ez+AhDbW1eFZ0c7rh1zv8Q68mH5G36LvKeTVSmVMhDVmM6tl9L9M
 fQBzC+KtQ/oZey6k5WTcswpwrJa6Yz+dst4/GC/jMQrZUyJ5/En86Va7yiPz8w33RQga/8UaM+ED
 okVTK0fSCXU5qYF4pNwwIDGBWlhXICbaVc7y0SAKxqELNtxk1kFt4rpTHvKMv+gMYq8RgYjc8V7N
 u4I2yGoQrC7Tw+V9br7Pkrm2QhQdseu4F+NmK2GRY0oqEfaMvS3A==
X-QQ-XMRINFO: N9UmAew/oWQdyj+ues2o31rfXVIHRUyJrg==
From: Zhang Huasen <huasenzhang@foxmail.com>
To: marcandre.lureau@redhat.com
Cc: huasenzhang@foxmail.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] chardev/char-win-stdio: Support VT sequences on Windows
 11 host
Date: Tue, 20 Jun 2023 09:24:01 +0800
X-OQ-MSGID: <20230620012402.349-1-huasenzhang@foxmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <CAMxuvax0L=9dPM1+K+2vW_pXRLpZ7WJsmai_qG5gtm9_GeOt7Q@mail.gmail.com>
References: <CAMxuvax0L=9dPM1+K+2vW_pXRLpZ7WJsmai_qG5gtm9_GeOt7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.49;
 envelope-from=huasenzhang@foxmail.com; helo=out162-62-57-49.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Huasen Zhang <huasenzhang@foxmail.com>

Hello,

On Sat, 17 Jun 2023 11:42:06 +0200 Marc-André Lureau <
marcandre.lureau@redhat.com> wrote:
Hi

> On Fri, Jun 16, 2023 at 7:41 AM Zhang Huasen <huasenzhang@foxmail.com>
> wrote:
> 
> > From: Huasen Zhang <huasenzhang@foxmail.com>
> >
> > Hello,
> >
> > On Thu, 15 Jun 2023 12:57:55 +0200 Marc-André Lureau <
> > marcandre.lureau@redhat.com>
> > wrote:
> > > Hi
> > >
> > > On Thu, Jun 15, 2023 at 12:36 PM Zhang Huasen <huasenzhang@foxmail.com>
> > > wrote:
> > >
> > > > If the monitor or the serial port use STDIO as backend on Windows 11
> > > > host,
> > > > e.g. -nographic options is used, the monitor or the guest Linux do not
> > > > response to arrow keys.
> > > >
> > > > When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is
> > > > disabled
> > > > by default. Arrow keys cannot be retrieved by ReadFile or
> > > > ReadConsoleInput
> > > > functions.
> > > >
> > > > Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to
> > > > SetConsoleMode,
> > > > when opening stdio console.
> > > >
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1674
> > > >
> > > > Signed-off-by: Zhang Huasen <huasenzhang@foxmail.com>
> > > > ---
> > > >  chardev/char-win-stdio.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> > > > index eb830eabd9..1a18999e78 100644
> > > > --- a/chardev/char-win-stdio.c
> > > > +++ b/chardev/char-win-stdio.c
> > > > @@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
> > > >          }
> > > >      }
> > > >
> > > > -    dwMode |= ENABLE_LINE_INPUT;
> > > > +    dwMode |= ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPUT;
> > > >
> > >
> > > I think we should set it only when is_console (although that may not
> > > make a
> > > difference otherwise)
> >
> > It is okay to set ENABLE_VIRTUAL_TERMINAL_INPUT only when is_console is
> > TRUE.
> >
> > I do not understand some points of original code.
> > If the stdin is not a console, i.e. GetConsoleMode fails, we still
> > call SetConsoleMode and set ENABLE_LINE_INPUT.
> > Could you please tell what the purpose is?
> >
> 
> I have no clue. It has been this way since the beginning (commit db418a0a7).
> 
> The code doesn't check SetConsoleMode() return value, so I'd just go with
> your patch for now.
Thanks for your review and comments.


