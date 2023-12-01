Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD3800827
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:26:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90h8-0006cx-Ny; Fri, 01 Dec 2023 05:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90h6-0006cR-EV
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:24:24 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90h3-0006t7-KK
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:24:23 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1915034144so188045366b.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701426259; x=1702031059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z69m+Ls2QRiO8HKOnPAfJt2sPPkLLDc2+97xG3B9H+Y=;
 b=krk4dEQGSv0FuG2/7aogp25mq7k+dujThFwegNcaojUrMVW49+JnOsBLPKcK/Sys7A
 q+9kc34Ov+SHkJcau79aMkIq3578RLQTV0etSNcdwtMyN/4qGxLC7XoHhryz/vwjLDfG
 CL5FdaCXMfQ8xgYGFBaAii7kXI5SB/pb26X4iwO5qrB3rJUzupVnQSxyNuuoB0IAXiui
 PkUlYfGeQoMyPuYp1WhEfjw46j2cj9Aj1IXftNlxHewDaZA9rM06S68Bbxi4RQMN7cZn
 ehy+WpifxmUSApiI/KL6JDtzxE4Go10GdQBALk2smLdN7IJH7sNfr55Uc+Cjgdi8zhWB
 R0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701426259; x=1702031059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z69m+Ls2QRiO8HKOnPAfJt2sPPkLLDc2+97xG3B9H+Y=;
 b=hMNA+H4tCcoSZkIuHIWj9ZIp08e2smx/78TzVY87yKiIPwmrSpp8Qm60lmeD2jgPPD
 7iM6c1iIJTW+tVIYeMQByzu96nCzzBJWGeoMptkCazTe0EkRylmZp0+/PkFqglvtLYNV
 BKdHabY5uePuJAO5/IBb6Pok2kLg2AGBJOwTjvMz8dq4AoQYfB1KyiQUbtLv2wAH1w0f
 qHota0a49RJpxbwqGjZaJDI5X+Wf2kGKJ3um/PmWL/UQeLp1lcJ/QdjgPBwegrHSVSwi
 4f2yHiwVPu1agP4KDLGTJ1Jh1zSKjJzsEe4yyUCvT3EqiyMDCOhmoJm3ahBnKW0o5MW0
 PXNQ==
X-Gm-Message-State: AOJu0Yx/6tWcTQ6SkrTIcg8HArLsqI2yr3Iafj836TbQ5dIjmCU4/ZDG
 ZJo8fPnYFqWHSAO+ubsIwnzvDQ==
X-Google-Smtp-Source: AGHT+IHjqkZzb7XRQaPySAQaoQjVZkyJHVwWJRwgxxggG75IjWYXdxvEfmhSdzeYVLv3lJWzo7AaJA==
X-Received: by 2002:a17:907:6d1e:b0:a08:f837:7802 with SMTP id
 sa30-20020a1709076d1e00b00a08f8377802mr626875ejc.14.1701426259006; 
 Fri, 01 Dec 2023 02:24:19 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a1709062dc900b00a19d555755esm632159eji.117.2023.12.01.02.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:24:18 -0800 (PST)
Message-ID: <45077c53-ed18-4821-bfbe-6dba3ca994d4@linaro.org>
Date: Fri, 1 Dec 2023 11:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tests/avocado: drop malta yamon tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201093633.2551497-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi Alex,

On 1/12/23 10:36, Alex Bennée wrote:
> The assets are no longer available on the website so these are
> blocking CI.
> 

How are these "blocking CI"? Missing artifact wasn't be fatal,
is it now? Also, did the artifact cache got flushed? These tests
pass locally, I disagree with removing them.

I can send a patch using YAMON_PATH like we have with RESCUE_YL_PATH,
but I still consider missing artifact shouldn't be an issue. We are
missing the point of the Avocado cache and the possibility to manually
add artifacts.

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/avocado/machine_mips_malta.py | 37 -----------------------------
>   1 file changed, 37 deletions(-)
> 
> diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
> index 959dcf5602..3a1ec85c20 100644
> --- a/tests/avocado/machine_mips_malta.py
> +++ b/tests/avocado/machine_mips_malta.py
> @@ -122,40 +122,3 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>           :avocado: tags=mips:smp
>           """
>           self.do_test_i6400_framebuffer_logo(8)
> -
> -class MaltaMachine(QemuSystemTest):
> -
> -    def do_test_yamon(self):
> -        rom_url = ('http://www.imgtec.com/tools/mips-tools/downloads/'
> -                   'yamon/yamon-bin-02.22.zip')
> -        rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
> -        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
> -
> -        archive.extract(zip_path, self.workdir)
> -        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
> -
> -        self.vm.set_console()
> -        self.vm.add_args('-bios', yamon_path)
> -        self.vm.launch()
> -
> -        prompt =  'YAMON>'
> -        pattern = 'YAMON ROM Monitor'
> -        interrupt_interactive_console_until_pattern(self, pattern, prompt)
> -        wait_for_console_pattern(self, prompt)
> -        self.vm.shutdown()
> -
> -    def test_mipsel_malta_yamon(self):
> -        """
> -        :avocado: tags=arch:mipsel
> -        :avocado: tags=machine:malta
> -        :avocado: tags=endian:little
> -        """
> -        self.do_test_yamon()
> -
> -    def test_mips64el_malta_yamon(self):
> -        """
> -        :avocado: tags=arch:mips64el
> -        :avocado: tags=machine:malta
> -        :avocado: tags=endian:little
> -        """
> -        self.do_test_yamon()


