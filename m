Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FF7326FF
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 08:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA2X6-0003kD-1E; Fri, 16 Jun 2023 02:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huasenzhang@foxmail.com>)
 id 1qA2Wy-0003jd-7U
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 02:01:59 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huasenzhang@foxmail.com>)
 id 1qA2Ws-00007j-Gu
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 02:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1686895302;
 bh=Tdjj5h0Ar/K0J42qcgOxMyhQOTRaHQPNZCgYg73e9ZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YzknCjZh8+6BKbzf9ocADx9KP6i2hO0LTnj2fwb2pMuhlqo3ZlMMdrzehUzMXkIRK
 x3vYtRjEJmmuEZhAP3XcQSaYJFXNcUgB6Q6Q5AL0HMlSTDcWpGa3DnIG9vMEmJyW5w
 8vRuOEda7JEFHVYJBSh+nKO+cLGC+By8DmJ6FoYk=
Received: from localhost.localdomain ([14.18.187.46])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id A56B56CC; Fri, 16 Jun 2023 13:41:22 +0800
X-QQ-mid: xmsmtpt1686894082tsy85sse5
Message-ID: <tencent_9F4A874CACFEABCB1C69837F59A54A3B820A@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zU5P7B3ZcabJESGsVgDmiSaQBuK4pIInuw6ZB2AYqy+c+s8rwYXm
 +QGDmuGNk+NJyT349aQdocR/IvVE0nmNIvN/OQef0L/D6QC6BMXdjlhKcBRFLCas+0j/IsTriwda
 RP1OawYqMUkawPFfXhFBMFM7FvHFZM9Aynv7sx/gYoh3YA+txQ3/vcKdPXHENJuY8am11sYqn4c0
 khdt6yggcDoglNebC0sAC2nzNL/KkrfAf7+FS5Ab6yHdwXmxktymCtys/syw0DYspNbzE7eZgIKl
 oQsunozhw4rLjkhle/12X7s9DTXis0SbzNh9+Jolkq0SDX/gShKw7/nk44g8crZX7m0tp8EZvBkY
 157FET20/zCPNBKSvy1PicB6NWbrh9LRdRZbkx3vPIYMp2q/AJxQFuXwk6zehysGommnxcoRX3zn
 FhvqbbyeLrEB9gSdf/n0uMXlkphMFRlMEvUgvzhncTMaOwO43Gff1Tcfa0DQZxK662xr4F/Yc4Iv
 M13qAvFn2EvZGh8y31FL9uvxRG8gM4zdZ4MjDcRTiKpUJx8zLKrVtuMff4Wldgvcv+Gx2rXttRuU
 GkwhD+Zvs0Z+tNhNNs1bFhk9UtKGpsCLBWuBuI/Y3BIj/QHAuBXUNVdKRG/GaYpfzpFMG4mKjC2S
 JTH5Y93s0bVSGSOEk7I/yLnevOG5n+FzQFd0HPa480bAfEBuXzexwvTPtyx2fNkGD+sp3Xbt4/cv
 dIrseWWB0gd4OFgV71qAEUX74hvkEsroYuKX2+w7ylnoSU4VXWvNhz47+gX3mXPbfbgi7ggRhAZi
 57FpsAf8d7GAZXZmyDL+0MaRYem/CIdeQAEuBsv7FIV4Gt9spItOFh11ymo450BoBancC/DHduKo
 6OWROpF76zKFLlDJLQsLfMdrgrkqm0nCioPhNHrNeHf8ftiBhc2FbZ57IkI1MbaYbz0CoPZ+1/0u
 TTTBZW4AVRI+vOcB+mXjGGQ8Mw4INd+LiPY5jzfjN0X1lmW8Ukwk8kqonmXpzGQxAEHK2nnV82G2
 HjTcAjsLHzI4uBUSB8Y12eCYB2LgVDSxeMJMv+qGCiip0CtLCY
X-QQ-XMRINFO: MMd9k4KOWfk4EI9u9DiMAPPHFKKkl9Wo5w==
From: Zhang Huasen <huasenzhang@foxmail.com>
To: marcandre.lureau@redhat.com
Cc: huasenzhang@foxmail.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] chardev/char-win-stdio: Support VT sequences on Windows
 11 host
Date: Fri, 16 Jun 2023 13:40:18 +0800
X-OQ-MSGID: <20230616054018.721-2-huasenzhang@foxmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <CAMxuvawc2x2mt4Kk4V1U0fMeNKZj5qE_Lai8Gjo38T_Q_cVdpQ@mail.gmail.com>
References: <CAMxuvawc2x2mt4Kk4V1U0fMeNKZj5qE_Lai8Gjo38T_Q_cVdpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.87;
 envelope-from=huasenzhang@foxmail.com; helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 15 Jun 2023 12:57:55 +0200 Marc-André Lureau <marcandre.lureau@redhat.com>
wrote:
> Hi
> 
> On Thu, Jun 15, 2023 at 12:36 PM Zhang Huasen <huasenzhang@foxmail.com>
> wrote:
> 
> > If the monitor or the serial port use STDIO as backend on Windows 11 host,
> > e.g. -nographic options is used, the monitor or the guest Linux do not
> > response to arrow keys.
> >
> > When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is disabled
> > by default. Arrow keys cannot be retrieved by ReadFile or ReadConsoleInput
> > functions.
> >
> > Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to
> > SetConsoleMode,
> > when opening stdio console.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1674
> >
> > Signed-off-by: Zhang Huasen <huasenzhang@foxmail.com>
> > ---
> >  chardev/char-win-stdio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> > index eb830eabd9..1a18999e78 100644
> > --- a/chardev/char-win-stdio.c
> > +++ b/chardev/char-win-stdio.c
> > @@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
> >          }
> >      }
> >
> > -    dwMode |= ENABLE_LINE_INPUT;
> > +    dwMode |= ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPUT;
> >
> 
> I think we should set it only when is_console (although that may not make a
> difference otherwise)

It is okay to set ENABLE_VIRTUAL_TERMINAL_INPUT only when is_console is TRUE.

I do not understand some points of original code.
If the stdin is not a console, i.e. GetConsoleMode fails, we still
call SetConsoleMode and set ENABLE_LINE_INPUT.
Could you please tell what the purpose is?

> thanks
> 
> 
> >      if (is_console) {
> >          /* set the terminal in raw mode */
> > --
> > 2.41.0.windows.1
> >
> >


