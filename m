Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D2826B63
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:14:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMmcG-0004IV-Ad; Mon, 08 Jan 2024 05:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tOGw=IS=kaod.org=clg@ozlabs.org>)
 id 1rMmcE-0004Hy-6N; Mon, 08 Jan 2024 05:12:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tOGw=IS=kaod.org=clg@ozlabs.org>)
 id 1rMmcB-0002FU-W6; Mon, 08 Jan 2024 05:12:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7qc96KH4z4wcd;
 Mon,  8 Jan 2024 21:12:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7qc32zmdz4wbr;
 Mon,  8 Jan 2024 21:12:03 +1100 (AEDT)
Message-ID: <ce645c24-7efb-444e-8c9b-0dd9a6584aa8@kaod.org>
Date: Mon, 8 Jan 2024 11:12:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] tests/avocado: mark boot_linux.py long runtime
 instead of flaky
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240107170119.82222-1-npiggin@gmail.com>
 <20240107170119.82222-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240107170119.82222-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=tOGw=IS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/7/24 18:01, Nicholas Piggin wrote:
> The ppc64 and s390x tests were first marked skipIf GITLAB_CI by commit
> c0c8687ef0f ("tests/avocado: disable BootLinuxPPC64 test in CI"), and
> commit 0f26d94ec9e ("tests/acceptance: skip s390x_ccw_vrtio_tcg on
> GitLab") due to being very heavy-weight for gitlab CI.
> 
> Commit 9b45cc99318 ("docs/devel: rationalise unstable gitlab tests under
> FLAKY_TESTS") changed this to being flaky but it isn't really, it just
> had a long runtime.

I agree. The same comment applies to the aspeed tests.
  
> So introduce a new AVOCADO_ALLOW_LONG_RUNTIME variable and make these
> tests require it. Re-testing the s390x and ppc64 tests on gitlab shows
> about 100-150s runtime each, which is similar to the x86-64 tests.
> Since these are among the longest running avocado tests, make x86-64
> require long runtime as well.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> ---
>   docs/devel/testing.rst      | 8 ++++++++
>   tests/avocado/boot_linux.py | 8 ++------
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index bd132306c1..3a9c1327be 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -1346,6 +1346,14 @@ the environment.
>   The definition of *large* is a bit arbitrary here, but it usually means an
>   asset which occupies at least 1GB of size on disk when uncompressed.
>   
> +AVOCADO_ALLOW_LONG_RUNTIME
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Tests which have a long runtime will not be run unless that
> +``AVOCADO_ALLOW_LONG_RUNTIME=1`` is exported on the environment.
> +
> +The definition of *long* is a bit arbitrary here, but it usually means a
> +test which takes more than 100 seconds to complete.
Defining a limit is the difficult part. The Aspeed SDK tests have been
tagged flaky for CI even though they run in less than 50s. Anyhow,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.




> +
>   AVOCADO_ALLOW_UNTRUSTED_CODE
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   There are tests which will boot a kernel image or firmware that can be
> diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
> index 7c4769904e..6df0fc0489 100644
> --- a/tests/avocado/boot_linux.py
> +++ b/tests/avocado/boot_linux.py
> @@ -93,13 +93,11 @@ class BootLinuxPPC64(LinuxTest):
>   
>       timeout = 360
>   
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
>       def test_pseries_tcg(self):
>           """
>           :avocado: tags=machine:pseries
>           :avocado: tags=accel:tcg
> -        :avocado: tags=flaky
>           """
>           self.require_accelerator("tcg")
>           self.vm.add_args("-accel", "tcg")
> @@ -113,13 +111,11 @@ class BootLinuxS390X(LinuxTest):
>   
>       timeout = 240
>   
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
>       def test_s390_ccw_virtio_tcg(self):
>           """
>           :avocado: tags=machine:s390-ccw-virtio
>           :avocado: tags=accel:tcg
> -        :avocado: tags=flaky
>           """
>           self.require_accelerator("tcg")
>           self.vm.add_args("-accel", "tcg")


