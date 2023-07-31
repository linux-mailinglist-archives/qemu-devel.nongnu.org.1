Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 178217691E9
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPLk-0003ix-7b; Mon, 31 Jul 2023 05:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQPLi-0003iW-Jo
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:37:58 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQPLg-0006xM-W0
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:37:58 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5221b90f763so6321372a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690796275; x=1691401075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZC+dnKa/qp5jrTcc1wAu0yckcU8SthpzOdgpibtn6NY=;
 b=JQHF1SuH3gXRAOjr/1oCY335+4Pfjc6WCesNsdRIHzR4jo26mHmMYi9iUMnuzOkzww
 ziSd7ss/VKhZ9BTfRs395ODCCscLlSH1FG8Hmzg3E8WRwuooyhZ42N0YO6FqaaMfKIK1
 6FHnxfRQdW8SjMdQR7jmqYmqTTUKoLvcD3GHa1eVAUX3Nfw6UvEpjdrj87RFTVt3bV9n
 otaneX/YsmBirxMKlHga4FI6VHHojiwPGuZMKEjXunS9JuluZx6/CBmXEocT1j+u04jf
 cp8Kmv5uHnSJmykpvDKYjivMvIKEz91gcE/Ub3onWb/KXRG1sD4hP0vIuWG9FdCSV4On
 GYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690796275; x=1691401075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZC+dnKa/qp5jrTcc1wAu0yckcU8SthpzOdgpibtn6NY=;
 b=KqB4RNatqD20H6XxGBQJnlHeb9iOT4Oxj8sidjtc4mm8bJFUITHp7szzVzxSHxW4az
 4ocxrlh5Wf2sar3BtJZ+n19rkILsiXstmnqXKwZ8B129zHis47PeSMxYWrydTRaNVPo4
 +zWe9GLFojKyWDDcy0fStrFte1pIPlKDSvc0FsQ1HEfzmySnDiYO1eg0g1dwxvEAQYly
 6irxijen7jSUWCu+5pdBlXx3BIEi2a/q3dizzY5vOWiWR470lVXuzwFjDmUd5msUzmAe
 sEn+oU3ci0NBexi7Hzaz22CDA8wQjzvn9e0KWc7de2pOfqeJxWQKIPUURzYRhXQ1cdYY
 /4ug==
X-Gm-Message-State: ABy/qLYSCGCaD4stKGG2oXY7/8M69bl4rrayAgWyXTECFRfTr3w0tROD
 cduvMQRnD5aCmhMP429NcWlmwR2lvzCKc4yWLyhD/A==
X-Google-Smtp-Source: APBJJlGmaB+suTXADjLNNJSjrtzdrugR6VgJuOR02qXeYZ2I2ZOGupmRrdBOGSOkdxkR+1+vZsr0X5kXOlV0E3o3zYA=
X-Received: by 2002:aa7:c401:0:b0:51e:fbe:dc81 with SMTP id
 j1-20020aa7c401000000b0051e0fbedc81mr7643168edq.3.1690796274966; Mon, 31 Jul
 2023 02:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230730180329.851576-1-sw@weilnetz.de>
In-Reply-To: <20230730180329.851576-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 10:37:43 +0100
Message-ID: <CAFEAcA_SEUFgM8R=W0Ddm-UCPJhc=exMcXPaQJHg4tCqt3De9w@mail.gmail.com>
Subject: Re: [PATCH] Fix some typos in documentation and comments
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 libvir-list@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sun, 30 Jul 2023 at 19:55, Stefan Weil via <qemu-devel@nongnu.org> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

