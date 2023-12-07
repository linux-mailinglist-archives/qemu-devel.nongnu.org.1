Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83D80837E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:47:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBA1b-0006QP-SG; Thu, 07 Dec 2023 03:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBA1W-0006QA-5n
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:46:22 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBA1T-0007PW-Gb
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:46:21 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 914A440737C0;
 Thu,  7 Dec 2023 08:46:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 914A440737C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1701938776;
 bh=t32TG1M+T5kiNe/ASa6FYE9OjzjpY9kIwRLzyW1WecY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qU5KDrqTvXGVEMb4uMNBrIc74e7UwTXQq7gwJdQVMgrpjnTZiZA0m12ULrV8JHb77
 +7v6nZyIhX/wYM5VHZp8oImUXc0rel6VVyS+Wgwnf/tqWkFB0uObQcHCqulU7KotnR
 PVQpeHr3gAXpS5Qwd13p3YevsX4/3EPb9CVnMkM8=
Message-ID: <f79306bf-33bd-46ed-ba0d-113609b5f5ea@ispras.ru>
Date: Thu, 7 Dec 2023 11:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] tests/avocado: remove skips from replay_kernel
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-12-alex.bennee@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231205204106.95531-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05.12.2023 23:41, Alex Bennée wrote:
> With the latest fixes for #2010 and #2013 these tests look pretty
> stable now. Of course the only way to be really sure is to run it in
> the CI infrastructure and see what breaks.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/avocado/replay_kernel.py | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index 1eaa36444c..c54e96c9ff 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -98,8 +98,6 @@ def test_i386_pc(self):
>   
>           self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
>   
> -    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
>       def test_x86_64_pc(self):
>           """
>           :avocado: tags=arch:x86_64
> @@ -135,8 +133,6 @@ def test_mips_malta(self):
>   
>           self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
>   
> -    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>       def test_mips64el_malta(self):
>           """
>           This test requires the ar tool to extract "data.tar.gz" from
> @@ -152,7 +148,6 @@ def test_mips64el_malta(self):
>   
>           :avocado: tags=arch:mips64el
>           :avocado: tags=machine:malta
> -        :avocado: tags=flaky
>           """
>           deb_url = ('http://snapshot.debian.org/archive/debian/'
>                      '20130217T032700Z/pool/main/l/linux-2.6/'
> @@ -200,8 +195,6 @@ def test_arm_virt(self):
>   
>           self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
>   
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -
>       def test_arm_cubieboard_initrd(self):
>           """
>           :avocado: tags=arch:arm
> @@ -354,7 +347,6 @@ def test_m68k_mcf5208evb(self):
>           file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>           self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
>   
> -    @skip("Test currently broken") # Console stuck as of 5.2-rc1
>       def test_microblaze_s3adsp1800(self):
>           """
>           :avocado: tags=arch:microblaze
> @@ -389,7 +381,6 @@ def test_or1k_sim(self):
>           file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>           self.do_test_advcal_2018(file_path, 'vmlinux')
>   
> -    @skip("nios2 emulation is buggy under record/replay")
>       def test_nios2_10m50(self):
>           """
>           :avocado: tags=arch:nios2


Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>


