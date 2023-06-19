Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5E7352C3
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCFZ-0006gb-Ri; Mon, 19 Jun 2023 06:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBCFS-0006g5-GR
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:36:40 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBCFQ-0002pJ-Nm
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:36:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51a2661614cso4527159a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687170995; x=1689762995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6jct1q5lacDM58VmVdH1mphAGq2zPurPNXj0DlXZxs=;
 b=WMNg+2uwXKc5dP9UueUuYBydYKj2ZehAHR6XDHyLHGM/2EFqTFnCOkYsqqgR2se59E
 svuer5UTWJvIsTCQqqqV+xNTt8gtsXmLwRcPoG6NA/GWMEnxabaF3ky+cpnplZDfNOug
 ZAWj7mQuJx235xkJGa+iH79rmqv/oorrxP+aMg/9wD4JahCVlOotnHxquQDlNKCqy3r9
 NfnpWnOuwV0gFZRaQi1Ef68DDpwpmWtJ8P/BXQBgEtYGhhRbIk1y5gs2Rc9IiSUpuJ0J
 emsb0P6u+AXdyK2pKPWxVt/rXbpdZ0N9P3CWBETW94xDakbz2B0+vJPHPzG4O7LFby52
 +kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687170995; x=1689762995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6jct1q5lacDM58VmVdH1mphAGq2zPurPNXj0DlXZxs=;
 b=aHuxJcpf58xI/4eB5nb399DBz6vUxB+72Xh5oJyl53hjCJRVYiXtRjngbkx/3NSeJc
 woEta14eek7Q0kyZJZZ44guNEHwZF7vpMKxTDz475fH3IGpOBFvJluRYiyQMMTVCcd0l
 S3Sc0sWAj16izmtGGtjJsYuJqWAfIhEQwNnzP7IH2XEKrN0t5bY7rgHXapCKwqpo3834
 1JFOYma6TEiHsFohhvyFLgH7LQpLTxjywHF08zrVh8EDrLN/UXLN52wPcAXLDNgVegVH
 s3mPWvjwJ35lQVMNli65X/xu12QsacSdBoFfYzdLZ3NLP3rliRnjxWOSR450aK/C4gpL
 3B3Q==
X-Gm-Message-State: AC+VfDwhDseCYWwRj6GpZcsJtga8hFKN9FAUdc4OQkoWkzqieLBWpWKG
 fGc2c/WUjHzfUITjH1fMOuJ0q811hLkjXm0oGkjBrQ==
X-Google-Smtp-Source: ACHHUZ7/67r3N5Y7jk7bujjVPXa1B4wPoGdKaZ3WGM/rdgPDQjgxpNC6hMiC/M4srfNxTe2cHZ12LS6rxvU8g9WV1JY=
X-Received: by 2002:a05:6402:64a:b0:510:f462:fc47 with SMTP id
 u10-20020a056402064a00b00510f462fc47mr6553339edx.7.1687170994993; Mon, 19 Jun
 2023 03:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154129.133169-1-martin@kaiser.cx>
 <20230615142256.1142849-1-martin@kaiser.cx>
In-Reply-To: <20230615142256.1142849-1-martin@kaiser.cx>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 11:36:23 +0100
Message-ID: <CAFEAcA84ng=jMTvb+XHrvGatf7UOPNxg7u+m-LXKVYT_kaDm5g@mail.gmail.com>
Subject: Re: [PATCH v3] imx_serial: set wake bit when we receive a data byte
To: Martin Kaiser <martin@kaiser.cx>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 15 Jun 2023 at 15:24, Martin Kaiser <martin@kaiser.cx> wrote:
>
> The Linux kernel added a flood check for RX data recently in commit
> 496a4471b7c3 ("serial: imx: work-around for hardware RX flood"). This
> check uses the wake bit in the UART status register 2. The wake bit
> indicates that the receiver detected a start bit on the RX line. If the
> kernel sees a number of RX interrupts without the wake bit being set, it
> treats this as spurious data and resets the UART port. imx_serial does
> never set the wake bit and triggers the kernel's flood check.
>
> This patch adds support for the wake bit. wake is set when we receive a
> new character (it's not set for break events). It seems that wake is
> cleared by the kernel driver, the hardware does not have to clear it
> automatically after data was read.
>
> The wake bit can be configured as an interrupt source. Support this
> mechanism as well.
>
> Co-developed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>



Applied to target-arm.next, thanks.

-- PMM

