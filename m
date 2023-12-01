Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4C800CDF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:06:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9491-0004Od-Gq; Fri, 01 Dec 2023 09:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r948s-0004Nq-V1
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:05:19 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r948i-0007Qh-NE
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:05:18 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c54a3b789so1233275a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701439505; x=1702044305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GXVnY5gcb6WVUU34Zw3qA5TR/PBHpiFz51PWZTPDVPk=;
 b=U3fkgmIuYHWJQKWPX2dAaDBEpySGkiSeU2tKHippYkZ4LM/RwVNeNRZQkf7umc4Zow
 3qJmcP1oLyU0pPFPP/4UFkBcoHe3f8AL6ySlXEcvLiKbdvfF2MNpukpX+A5bXtHOHnAO
 xf26cU3XP38sRTEwqJ3CVUrb6mk9RdUTaJV6dA1cdoJs1SNPGiQxP6ISOV2XF5/tVTXP
 SmC+duOaH0uhb+NIdGG4gUyt2nDcfNQUzOntUEncyVNea9X0SbyUM9Q8oNMbunXF1Gkw
 9S6dJJsfpPY773V2JUCuHJvf0ZiTlkrtCtGlruIfRRm2NO2SWOTCflnWbfUkOul29CK8
 Hppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701439505; x=1702044305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXVnY5gcb6WVUU34Zw3qA5TR/PBHpiFz51PWZTPDVPk=;
 b=FOVx1YSkrftvkgDsUtVWsfQ0gA6k8v24ofz8zMxqHAg1i752hQ7Pl0zZnKfFMq0Fi0
 Zb+b2KZ/nO+DvZs8NXHDmYlJVk01F0R2ExE5gwdPjtNVyGcGY5A7dRz8DIpa7ErA3gYr
 JjLijGpujSc2y91gj8Jzrfxjox95lii2zAYtFvEJNMJa2KuV01rfA7GsOsfN/QJRcoJq
 Y6FBv7JthcWLhpvQdtLlRtHDI/P/hwkUywDuC2gNzkSxHt80Wxz3zWcxFdY1YCKmn3TH
 mIE1sZqAwSPIsTEZP4zlhxkmWCad+ivoWPHVI9H8/ZLM/9tJJMaaMzw3uXJaVEI+Mcay
 zI6A==
X-Gm-Message-State: AOJu0Yx6PIkC4H7GijeArZ6cSaazkPTq/QmpkZO3jDNB/zoGd9AEXL8w
 wAbXXzUYvfLq4GrHsEgIzQbiwg==
X-Google-Smtp-Source: AGHT+IFWuyEzmcF3T18erY4ajahbnIlA3B8tJP3umbeljyI0tHkBQoMPslOySJdkyRQXvSO04JQJPw==
X-Received: by 2002:a50:9313:0:b0:54c:553e:67f5 with SMTP id
 m19-20020a509313000000b0054c553e67f5mr1302866eda.8.1701439505403; 
 Fri, 01 Dec 2023 06:05:05 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 bx11-20020a0564020b4b00b0054c4b6da934sm294789edb.9.2023.12.01.06.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 06:05:04 -0800 (PST)
Message-ID: <f8738d36-2527-4620-9532-fca530ef8f0d@linaro.org>
Date: Fri, 1 Dec 2023 15:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tests/avocado: drop malta yamon tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
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
 <45077c53-ed18-4821-bfbe-6dba3ca994d4@linaro.org>
 <87ttp25bqh.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ttp25bqh.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 1/12/23 13:49, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Alex,
>>
>> On 1/12/23 10:36, Alex Bennée wrote:
>>> The assets are no longer available on the website so these are
>>> blocking CI.
>>>
>>
>> How are these "blocking CI"? Missing artifact wasn't be fatal,
>> is it now? Also, did the artifact cache got flushed? These tests
>> pass locally, I disagree with removing them.
>>
>> I can send a patch using YAMON_PATH like we have with RESCUE_YL_PATH,
>> but I still consider missing artifact shouldn't be an issue. We are
>> missing the point of the Avocado cache and the possibility to manually
>> add artifacts.
> 
> Sure but in this case the binaries are gone, you can't share them and no

Per https://mips.com/develop/tools/boot-loaders/:
"To support existing users of these, and the QEMU project, YAMON is now 
available under the GPL License."

Their link https://mips.com/downloads/yamon-version-02-22/ is incorrect,
Mark emailed the webmaster to ask for the correct one.

Mark, any update?

> one else can ever run the test. At that point it just becomes dead
> weight in the repository. This doesn't stop you keeping your own branch
> where old tests live on while close to a warm cache but it does somewhat
> limit the use of the test to the wider community.
> 
>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    tests/avocado/machine_mips_malta.py | 37 -----------------------------
>>>    1 file changed, 37 deletions(-)
>>> diff --git a/tests/avocado/machine_mips_malta.py
>>> b/tests/avocado/machine_mips_malta.py
>>> index 959dcf5602..3a1ec85c20 100644
>>> --- a/tests/avocado/machine_mips_malta.py
>>> +++ b/tests/avocado/machine_mips_malta.py
>>> @@ -122,40 +122,3 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>>>            :avocado: tags=mips:smp
>>>            """
>>>            self.do_test_i6400_framebuffer_logo(8)
>>> -
>>> -class MaltaMachine(QemuSystemTest):
>>> -
>>> -    def do_test_yamon(self):
>>> -        rom_url = ('http://www.imgtec.com/tools/mips-tools/downloads/'
>>> -                   'yamon/yamon-bin-02.22.zip')
>>> -        rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
>>> -        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
>>> -
>>> -        archive.extract(zip_path, self.workdir)
>>> -        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
>>> -
>>> -        self.vm.set_console()
>>> -        self.vm.add_args('-bios', yamon_path)
>>> -        self.vm.launch()
>>> -
>>> -        prompt =  'YAMON>'
>>> -        pattern = 'YAMON ROM Monitor'
>>> -        interrupt_interactive_console_until_pattern(self, pattern, prompt)
>>> -        wait_for_console_pattern(self, prompt)
>>> -        self.vm.shutdown()
>>> -
>>> -    def test_mipsel_malta_yamon(self):
>>> -        """
>>> -        :avocado: tags=arch:mipsel
>>> -        :avocado: tags=machine:malta
>>> -        :avocado: tags=endian:little
>>> -        """
>>> -        self.do_test_yamon()
>>> -
>>> -    def test_mips64el_malta_yamon(self):
>>> -        """
>>> -        :avocado: tags=arch:mips64el
>>> -        :avocado: tags=machine:malta
>>> -        :avocado: tags=endian:little
>>> -        """
>>> -        self.do_test_yamon()
> 


