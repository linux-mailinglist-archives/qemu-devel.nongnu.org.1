Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6770F762205
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONOh-0007VY-Hr; Tue, 25 Jul 2023 15:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qONOf-0007Ug-JG
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:08:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qONOe-0007YZ-1K
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:08:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso49396415e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690312114; x=1690916914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYboOsqfHBxkM698yZzGsBQHaCMG/lGNEKx9s4Nz6hc=;
 b=dJsqaNoNjrnzFjKwCOrUjewDlMpFSk7oLBz7KaAoqIOwdTORAJ03I7l7aZLEclTYWd
 2eInXqtMSSXUydtVYqKb5MPtswKMndxXEXLA4Z2WUK3ubEsZcmfPfv7sgujYhHNP+HnS
 /EweVl77RYVYcEKcF7grluefyrb9mrVYWQPIsRvhuoHWLProxvW9YLWvk9gR0A1OI5S5
 L7FbouLet5ribPHoxy7GLFtBKvzoKE3Xc9HFvwXJQkNqnbi1JWjNntOKm+MB3YrxHCQ1
 vZIQ7ivFNqsBiF/hcrSJCt8qpMukOE1T/1M1LVJm3o5jbgcMQRBw5D5e/beiUgsTzNyw
 Z3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690312114; x=1690916914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYboOsqfHBxkM698yZzGsBQHaCMG/lGNEKx9s4Nz6hc=;
 b=hOl2tQIlS3l7jMZuEne+QOuHucNlTA71yMYUIvTGlOzG0VZZAuvcHQ5omY/OwcEUOC
 +/ERAol7VH7VruqVwa+5NM+PPlBg1WkfN5a4Qc4eeVE7XZPXVy/Mkb8w6p/EnrOGwwOE
 l8n0CekZcFgAYa1L/Rxolk/NybaRdDYaAm0O89e9iTIm+GnSDrZulmVDRkTUjXU8ycf1
 o1GxhPD85JLGL2Gtp3sTv3NfEkLmtkRuIMzwtmJnveax/bemqCIzb3nfhUTEzTXcNZHh
 uNEaEKd0DQAGzxjdaQzmysg2ktXW2YJ6LExR82s6uBJnt3SV0s8J4Y5ZORrbz5oaqqpj
 x//A==
X-Gm-Message-State: ABy/qLajbEKZ0ruYj+tnz9TG1VgoBAd1WK1CE+1oZK2pMMaXjrlFHeHk
 62HgJ3uDIh9mdD+N68CmguV80zs35OGPRgLmLpoST/gyboqKFDOT
X-Google-Smtp-Source: APBJJlH76Zk5a+Fs16xh5iIi4cAwhpYd9RE6G3TSaMEU/DCwBCw3IV7SwQV0KybNQkJDfzY6YfOWzIqmFPAqMb2WB0Q=
X-Received: by 2002:adf:f390:0:b0:313:edaa:24fd with SMTP id
 m16-20020adff390000000b00313edaa24fdmr9229468wro.21.1690312114114; Tue, 25
 Jul 2023 12:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230725145829.37782-1-philmd@linaro.org>
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 20:08:23 +0100
Message-ID: <CAFEAcA8g_+gFQQGLh+j+1OYPp+1tii0BWHsdQgQMuFawdcsw+A@mail.gmail.com>
Subject: Re: [PULL 00/10] Misc fixes for 2023-07-25
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

On Tue, 25 Jul 2023 at 15:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 3ee44ec72753ec0ff05ad1569dfa609203d722=
b2:
>
>   Merge tag 'pull-request-2023-07-24' of https://gitlab.com/thuth/qemu in=
to staging (2023-07-24 18:06:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/misc-fixes-20230725
>
> for you to fetch changes up to f8cfdd2038c1823301e6df753242e465b1dc8539:
>
>   target/tricore: Rename tricore_feature (2023-07-25 14:42:00 +0200)
>
> ----------------------------------------------------------------
> Misc patches queue
>
> hw/sd/sdhci: Default I/O ops to little endian
> hw/mips/loongson3-virt: Only use default USB if available
> hw/char/escc: Implement loopback mode to allow self-testing
> target/mips: Avoid overruns and shifts by negative number
> target/sparc: Handle FPRS correctly on big-endian hosts
> target/tricore: Rename tricore_feature to avoid clash with libcapstone
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

