Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB6715F9C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yTn-00025d-5f; Tue, 30 May 2023 08:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yTL-0001j8-RN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:29:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yTE-0000tO-3Y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:29:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so4515689a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449735; x=1688041735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IJHjy7EvRW6rB6ywYV3fseC3hbDe3gWjmarVrItmGRA=;
 b=El2JljDqMB1II2GsN6qpdoC3QEhXbNbRx23gH0cIo7SMxiwbnswkBsoB6XTgtl+THH
 gEAzjC+ecm6sMN/DvI3A420l6KOuyJ8MxTQeRuwFKfM3sAlgZGQWEZ/oyEBT22XT+zLI
 g1xhCb0ERIAum+nz67Qq94O4S2BQZvgHzBl8uiJrgHTJHuGLl/K6weHe6rdvivF+VLnY
 gIKoslutbG1cIDZgppWP7wwhMgaPSonvEkVjLsSFB0b1G2DK8Z2B8CHhBSCYWf9aLXhL
 c+V3PTp+h5R2be5bxQN2Y2yfvqHn44x+9xROf0WiD30vZwH0pFa499XCdYDfi1yZuzAo
 dnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449735; x=1688041735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJHjy7EvRW6rB6ywYV3fseC3hbDe3gWjmarVrItmGRA=;
 b=WhOnYyjF+63qanVTFmAFABsPrtOJerHiKfZeQKNrOEAMpsycRL54SQhxYjZMtLA/00
 neBHBJuaKW8TivLracuFN8LBCkZVpt/kst5bIJvI5YKmoAzHQSUijmkCiE8zbeCo7Omb
 X8ZWvFLJdl39ARjR0qS12OUvK9AVMfN/UtT+919IBBpVpnpBuWWWe0Y1oZVDstL/a3OV
 Y9j+uGAAFY7bh8oJHMB0i1eCXN+4YnGMgKJpEdoEVyr52GnpPLIg7SJcCVy3WrptDeSY
 8hQ5nbJZUT0L1ajXuGbw/isav6oas2GURKYtl12jIo/EX/pj6LmnrNStIZYzKu69//Hl
 j0CQ==
X-Gm-Message-State: AC+VfDydZsVRs+cDF6fAHG+/9NhdjcCBhWilqjK90dhMekpgycRzpY82
 6Ps7dwlrCquhbtrHdwN+rg2wFVbDeaDJsz8ro3qm5g==
X-Google-Smtp-Source: ACHHUZ5GfJqSCtuCV+iDZNafaCMlhDM95xr92uwV29MRmrx8oJBzRfgagAMehI8IXMdA6ATXN8Nvth1g2f0XwhPwX9g=
X-Received: by 2002:aa7:ce04:0:b0:514:75ff:6a86 with SMTP id
 d4-20020aa7ce04000000b0051475ff6a86mr1504796edv.29.1685449735573; Tue, 30 May
 2023 05:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
 <DS7PR12MB6309A170F8BC7D7C956D6C97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6309A170F8BC7D7C956D6C97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:28:44 +0100
Message-ID: <CAFEAcA8+hq3zvnowmxN+7FKv0FFu56VbA1WUTnDukGExpFS0Nw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tests/tcg/aarch64: add DC CVA[D]P tests
To: Zhuojia Shen <chaosdefinition@hotmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 19 May 2023 at 23:12, Zhuojia Shen <chaosdefinition@hotmail.com> wrote:
>
> Test execution of DC CVAP and DC CVADP instructions under user mode
> emulation.
>
> Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
> ---
>  tests/tcg/aarch64/Makefile.target | 11 ++++++
>  tests/tcg/aarch64/dcpodp.c        | 58 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/dcpop.c         | 58 +++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 tests/tcg/aarch64/dcpodp.c
>  create mode 100644 tests/tcg/aarch64/dcpop.c

> diff --git a/tests/tcg/aarch64/dcpodp.c b/tests/tcg/aarch64/dcpodp.c
> new file mode 100644
> index 0000000000..6f6301ac86
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpodp.c
> @@ -0,0 +1,58 @@
> +/* Test execution of DC CVADP instruction */

All new files should start with the standard brief
comment stating the copyright and license.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

