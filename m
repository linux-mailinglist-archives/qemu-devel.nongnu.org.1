Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945367252CA
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 06:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6kgx-0007wS-VO; Wed, 07 Jun 2023 00:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6kgs-0007wA-1a; Wed, 07 Jun 2023 00:22:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6kgo-0000WT-1K; Wed, 07 Jun 2023 00:22:32 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-977d02931d1so525831066b.0; 
 Tue, 06 Jun 2023 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686111747; x=1688703747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dG3vT/I7X8O+E9ISnicEpKC8vPA0KjJB56fRYw0WYmE=;
 b=iwTiysVsdLDV3j4VpGrewgj2x/TJG5y5/puVCS1/v7V4kTH2OBpGPnV8OqhTev3DHn
 Aplwv61eMr2ajhApM6i/cRzNclB9xuBQUxC1if2qqMSbNEfD9PyqEYWZPZWw7tVjRBQz
 cRiF6hxSEJoUG+H5do5BOt8ur+hKCBeHZL8pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686111747; x=1688703747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dG3vT/I7X8O+E9ISnicEpKC8vPA0KjJB56fRYw0WYmE=;
 b=eBqJK7SMm+3h7zmLsMXutNt1Y40VqEV/cmIMdgoB58uTkDChVsF9OSYLG3wxVZ68XJ
 leFVFwzsxYI+mumLH9gvwqlpckLgdfq3Qy0lIrL34cx0UTySoNV+baa3UmcPjDasrkCr
 AeB6imby5iNwzIeecTMwujHj0Hg/ni3aVm5/KGJT26jE3yVlC/EtPF0+iLCm1WrsfW+2
 R5FVj07hSvu1pxqUUbAsEngG4VUxi0b/k/tO5hxoupNnQUX4bGLD2AVQJEPcQAlxfy4D
 PBqBoDxeaaoWTqpc4rsq9GA1TuYInKWDgsNG5pFnJRvXRC0TpLbImrOQZbxHKBjbgJhq
 0rRw==
X-Gm-Message-State: AC+VfDxH9VP+Z3IvGdcaM4VybWyOwlKzQHcm5tmOBlI4AYCY0NdB2xST
 snOscpo1G7xF5hi4UvzD4KO8Sus7VOLe1CUEO/U=
X-Google-Smtp-Source: ACHHUZ5L1AOv9ihHzZ9dVsVmLHpYSTesj+EUjCBqiVlgNRAg2Zr62Bw1RUESCcqLFIIpb0SsA2ja1Q4fnEIbHFxH48k=
X-Received: by 2002:a17:907:1c17:b0:974:bd60:63c8 with SMTP id
 nc23-20020a1709071c1700b00974bd6063c8mr4413995ejc.26.1686111746913; Tue, 06
 Jun 2023 21:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230606192802.666000-1-thuth@redhat.com>
In-Reply-To: <20230606192802.666000-1-thuth@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 04:22:14 +0000
Message-ID: <CACPK8XcFC5pYwnu9gtMQx7i8kM5p+m3=TJ2cGG0ZgzKVn8u7fQ@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Kautuk Consul <kconsul@linux.vnet.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 6 Jun 2023 at 19:28, Thomas Huth <thuth@redhat.com> wrote:
>
> The ppc64 tuxrun tests are currently failing if "slirp" has been
> disabled in the binary since they are using "-netdev user" now.
> We have to skip the test if this network backend is missing.

Do the boot tests require networking? I doubt they do.

You could instead remove the -netdev user option if slirp is not present.


>
> Fixes: 6ee3624236 ("improve code coverage for ppc64")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/avocado/tuxrun_baselines.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
> index 3a46e7a745..e12250eabb 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -184,6 +184,7 @@ def common_tuxrun(self,
>
>      def ppc64_common_tuxrun(self, sums, prefix):
>          # add device args to command line.
> +        self.require_netdev('user')
>          self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
>                           '-device', 'virtio-net,netdev=vnet')
>          self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',
> --
> 2.31.1
>
>

