Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 702EB82CCAE
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 13:29:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOd7C-0000w3-NE; Sat, 13 Jan 2024 07:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd76-0000vV-9H
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:27:48 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd74-0007ht-Nd
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:27:48 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-557ad92cabbso6944301a12.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705148864; x=1705753664; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wQkvjjqEDryM8k31V5oCQZcQEZE6V6uCpYZQ0hg+PFY=;
 b=qd/WZ9T9b+RmqV1rTgR0hKPcJFTnjnNXsegcfw3Rrotws/awDP125WMD+mb8tI9j5r
 7Rh5YlYztDPRMjevexCOgxcuh1WGeulxJCnMCQ+JgaFgnMI3puH4VQ8yu1JK3jLHK55y
 1vZWjWnIARcEc1xwubD/iS1jP3+JjNGPV0I3PJd9iKsIa/28fXOW33WBjN23/kty4NwR
 vd6ZmQV8wHGrbCGRG5gmjnwQV8BrWoJwqORO+1LXOtSt7tsqCmgHeA69HB+pchRTKQ6Z
 pibfYT7Qm5E9TnSfEs4g9f/TOWxoRusVwFKyc5xlEmdrmLlQeafIBFfoMKNgN4HyGjDa
 hgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705148864; x=1705753664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wQkvjjqEDryM8k31V5oCQZcQEZE6V6uCpYZQ0hg+PFY=;
 b=boKHatMXqwOKnsEBuYavsHV6JbOXy2H0rIR4cryYTKTJNFKKN3jfDAFUjZ2qxxt691
 chAWzAoR9Ao4RVwvQpE5NerV3SsI+P607YE+iLsyZM9Jz1og3u04d3t28XaX/XYA5TV3
 6tv/QXO2oQFCUwdXhYunJ5+OTC3TFQmXZvX2MXc4PgRu1OH1EzS93Z5mox7hyRacscj3
 e2E0dvnI4IG2oujo3c9ue4yOjUxcGjmjQSuW1g8WxWmxXLjhA98QyDmmW0yGTq76Y6Ht
 T6mS2B+2eHzmfwzU1x9WTTs7yyg95Zukd3XqE20s8uYOyVIzjn6cS8UkwC7egUbGK0jm
 cB+Q==
X-Gm-Message-State: AOJu0Yxvflav5lGhEs1aPfKblivAMHiIl5Rf8VzC+qXHQsWUwOkS7AFF
 t/0EsX2UIIkmQcov4DpNNHF1LCvkTgTvB517qYh/l3KO89+uzg==
X-Google-Smtp-Source: AGHT+IH23q8gIr+qj/c6wYmoCJN2SBx+84tKlE7EyToP2aCiXd17uTKQxwqf42FwIZbzXBW8jbg4hL3dmOkBNUJubJc=
X-Received: by 2002:aa7:cad3:0:b0:557:a8da:7dca with SMTP id
 l19-20020aa7cad3000000b00557a8da7dcamr745791edt.36.1705148864381; Sat, 13 Jan
 2024 04:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
In-Reply-To: <20240110234232.4116804-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 12:27:11 +0000
Message-ID: <CAFEAcA-2U=8nQH85tQQOPebDbpWuxsQ9_XdSSbiaR1Z8oNZ3PQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/10] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 10 Jan 2024 at 23:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> [Changes since v11]
> Was running into error syncing into master. It seemed to be related to a
> hash problem introduced in patchset 10 (unrelated to the macOS build
> issue). carried the patches from v9 (before the syncing problem) and
> added the fixes from patchsets 10 and 11 to remove the hash error.
>

I found some more issues with this which I've noted in the
individual patches: in particular the patchset is supposed
to compile after every patch, and to get that to happen
a few sections of code needed to be in different patches.
There were also a couple of other niggles.

However, since the fixes were minor, I have made them myself
in applying this series to target-arm.next, to save you having
to do yet another respin.

Thanks for this contribution to QEMU.

-- PMM

