Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC5826E2E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:36:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoq0-0008Ah-8i; Mon, 08 Jan 2024 07:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMopw-000892-SG
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:34:36 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMops-0003sE-Rz
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:34:35 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-557bfc7f7b4so893247a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704717269; x=1705322069; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=byMq28vj5LAurtfTDW7cElHZIAVAUQdv3RGPOevF/jU=;
 b=xhKqN3sjpfpanmht4weRlO4R6SjCN6GP7V5dopp56IhWNhcshthjffHiCwxAOoR+zJ
 OYXgoDZrG+oo8XpOEGEsh0xgqnmk2+Vv5l5Y9eMLABURubdiyqV1btKkhkNE7tA/cRMi
 /PStnYCzIUIVZOchgJaO2DsKsryecvbvjwMHpDkozTKsVqNCarn0AWDJEBv0wmwVw54v
 XGupNFwZlhjyvB9WhxhpcDQZWJM3/kjWJJgfFcb/v60OMZK2DBKyTp+ZQ/dZIM1tGytm
 kNPH77IKobiYsZd5piXp/CEKcDwFMZJ75L7Kk27UvWQ1YSbYxnTxafZC4V/kE+Lyx3qP
 aI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704717269; x=1705322069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=byMq28vj5LAurtfTDW7cElHZIAVAUQdv3RGPOevF/jU=;
 b=lAQ+oozTbbNIZMqG/ZDtp7nzzCIeXrJop+DYScy1E4t8h7OMLK7h00xBtUZeZzrpxY
 7qIWvVWsiQZvI73MYFWPNbl0DHhnxGf02tbDtc/lX7bLVH9n1s5OPDLFah99WjtedYvl
 HKWQR89/p3LLdxpujQw4IHj+pvmCRsT7ytSUBKwoT62RzFM20CZ/o4d5i4ZN+JKF97GD
 9jjKWHKP5DkN8R5H9RXPrKMcSaLQwLq58oILqqI2Cb8kff1NfAu90uARuyDlFRgx7LQD
 ZUcB5foFSTTtq7mvR5qjb0M3YlgQKy/G+WPaasFMDLQv32ZfhCAZrsAN/iv8r+tZSUpW
 gH0A==
X-Gm-Message-State: AOJu0Yzcv86Nc8hFL/j0GujuTk4JBs9G5FZSxVAVJlvP3MRdm01mHL42
 StQ/xGF/6VDKlp4diToLBJ/x5sJ73SZyor+PNyFK19M905hMSA==
X-Google-Smtp-Source: AGHT+IGGmDMM2mTizDPpXyXvVG+Ycjr2Mbasd8QpwLlXP45Yi/y3MQStIZLkXiNecB5EHJevQ+S9kDQ/h6JA8rapPeI=
X-Received: by 2002:a50:c282:0:b0:556:d3d7:b7b with SMTP id
 o2-20020a50c282000000b00556d3d70b7bmr3107288edf.20.1704717269241; Mon, 08 Jan
 2024 04:34:29 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA93kpreNOOKz6-qbVE_9Kg6tgZNaMowNLwc+G_47MXLHg@mail.gmail.com>
 <9f0615dc-c162-4ac6-9ead-7f9d28e5d318@redhat.com>
In-Reply-To: <9f0615dc-c162-4ac6-9ead-7f9d28e5d318@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 12:34:18 +0000
Message-ID: <CAFEAcA8j3aKMWzb2zSZ5gUaV4uosa2GLBaEKTcqf93iU42FbDA@mail.gmail.com>
Subject: Re: CI "pages" job failing with incomprehensible error message from
 htags
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bui Quang Minh <minhquangbui99@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 8 Jan 2024 at 11:03, Thomas Huth <thuth@redhat.com> wrote:
>
> On 05/01/2024 20.11, Peter Maydell wrote:
> > https://gitlab.com/qemu-project/qemu/-/jobs/5871592479
> >
> > failed with
> >
> > $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU
> > sourcecode"
> > htags: Negative exec line limit = -371
> >
> > Does anybody have any idea what this is about ?
>
> In case you haven't spotted it yet:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014394.html
>
> Is anybody already already creating a patch to clear CI_COMMIT_MESSAGE when
> invoking htags ?

As a first step, I filed a bug for us for it:
https://gitlab.com/qemu-project/qemu/-/issues/2080

We should probably report this upstream, I suppose. It's
easy to reproduce without requiring the QEMU source tree:

mnementh$ mkdir htags-bug
mnementh$ cd htags-bug/
mnementh$ cat >hello.c
#include <stdio.h>

int main(void) {
    printf("hello world\n");
    return 0;
}
mnementh$ gtags
mnementh$ htags -anT
mnementh$ BIGVAR=$(perl -e 'print "x" x 100000') htags -anT
htags: Negative exec line limit = -80391

thanks
-- PMM

