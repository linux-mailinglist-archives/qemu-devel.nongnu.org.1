Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17E800B45
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:51:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92xk-0002lo-66; Fri, 01 Dec 2023 07:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r92xX-0002ez-O6
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 07:49:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r92xV-0006hh-Bk
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 07:49:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b3e7f2fd9so19544715e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701434968; x=1702039768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tx3EFWqudBWzKUVDQjLsPe5TU6E1CtJIeeIFWwdw7Tw=;
 b=orFn8cRYG+FCjE0mr/1CuvQ7ADxWJOaKr0F3snRTBktw1jNL2wTnCTpgZC/ri8RdWT
 dzwjRBbB9d8fMt2rU7TOXwHaFHVOAqhvvWMVCEiZLG50Er8OKuZ3mb2cRRRLhJg+Pixe
 Gg6CvQjroV/na8JRu+SCaP/krcg4o6DVTqiIizram1UOHodCfAa6p74PaFKslOvvkDPT
 pmMhoN9oL9/HUIR7BbGfpd1GtHw/TeC6z28v+cYJakUc/vbT6DjQIVpOyU3hn2VB4ifc
 cpxxYCqb5Yku+mYEP4Xv7q6NHu6eIAXK/yvh2H8siXyNW+ERCakfMaFWsCT0SsGO13zN
 8OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701434968; x=1702039768;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tx3EFWqudBWzKUVDQjLsPe5TU6E1CtJIeeIFWwdw7Tw=;
 b=n3gHqICILTfwMTDENm5sP4exUw9oHdk9LypVoDjhMESZNsH1fm6xnbP1wIZfS9fktu
 +KimU1K95zHZKnVJcyePBN/RWseu2ze9sIMuSPlv1TF8EeN4LsNFEH1xnEWQf3ahyCYa
 9UyDugKRjbz4xq/q03zPmf5nQD51yd4AzdWYgIl3SEnqYYP10ilJzieZorgwusJTse0H
 gikKI3idSWj3iSGsmT7tqse/5vvXVQo3jqWBmO8wFpXs60TGxPTHWJKWgbRHhaaHyvDo
 Pm14NC/yylgvNbVJp36OL/oBbTKMryu7arxBDRtHQoQ0uSQuk4UDLd621I7WhtI4vk1x
 pNnw==
X-Gm-Message-State: AOJu0YzYgtYXsgBGkyggaZu/lgYnBfiaEXtUHcTg7uEJQ38irAxkqf4f
 2ti3qE3i8Q+qLQXs0He83r0PbQ==
X-Google-Smtp-Source: AGHT+IGaPhBpG++ovez/2Ltb3qFAPfnPkMqdUCph7Cz1Q6OqwaSG48OC0vcToMvL0oGmhL7KiuySNQ==
X-Received: by 2002:a05:600c:4f55:b0:40b:5e21:c59d with SMTP id
 m21-20020a05600c4f5500b0040b5e21c59dmr262870wmq.107.1701434967720; 
 Fri, 01 Dec 2023 04:49:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c351300b0040b347d90d0sm8841404wmq.12.2023.12.01.04.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:49:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 096205FB5F;
 Fri,  1 Dec 2023 12:49:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Farman <farman@linux.ibm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Beraldo Leal <bleal@redhat.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  Eric Auger <eric.auger@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  qemu-s390x@nongnu.org,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Cleber Rosa <crosa@redhat.com>,  Joel Stanley
 <joel@jms.id.au>
Subject: Re: [PATCH v2 4/7] tests/avocado: drop malta yamon tests
In-Reply-To: <45077c53-ed18-4821-bfbe-6dba3ca994d4@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 1 Dec 2023 11:24:14
 +0100")
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-5-alex.bennee@linaro.org>
 <45077c53-ed18-4821-bfbe-6dba3ca994d4@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 01 Dec 2023 12:49:26 +0000
Message-ID: <87ttp25bqh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Alex,
>
> On 1/12/23 10:36, Alex Benn=C3=A9e wrote:
>> The assets are no longer available on the website so these are
>> blocking CI.
>>=20
>
> How are these "blocking CI"? Missing artifact wasn't be fatal,
> is it now? Also, did the artifact cache got flushed? These tests
> pass locally, I disagree with removing them.
>
> I can send a patch using YAMON_PATH like we have with RESCUE_YL_PATH,
> but I still consider missing artifact shouldn't be an issue. We are
> missing the point of the Avocado cache and the possibility to manually
> add artifacts.

Sure but in this case the binaries are gone, you can't share them and no
one else can ever run the test. At that point it just becomes dead
weight in the repository. This doesn't stop you keeping your own branch
where old tests live on while close to a warm cache but it does somewhat
limit the use of the test to the wider community.

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>   tests/avocado/machine_mips_malta.py | 37 -----------------------------
>>   1 file changed, 37 deletions(-)
>> diff --git a/tests/avocado/machine_mips_malta.py
>> b/tests/avocado/machine_mips_malta.py
>> index 959dcf5602..3a1ec85c20 100644
>> --- a/tests/avocado/machine_mips_malta.py
>> +++ b/tests/avocado/machine_mips_malta.py
>> @@ -122,40 +122,3 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(s=
elf):
>>           :avocado: tags=3Dmips:smp
>>           """
>>           self.do_test_i6400_framebuffer_logo(8)
>> -
>> -class MaltaMachine(QemuSystemTest):
>> -
>> -    def do_test_yamon(self):
>> -        rom_url =3D ('http://www.imgtec.com/tools/mips-tools/downloads/'
>> -                   'yamon/yamon-bin-02.22.zip')
>> -        rom_hash =3D '8da7ecddbc5312704b8b324341ee238189bde480'
>> -        zip_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
>> -
>> -        archive.extract(zip_path, self.workdir)
>> -        yamon_path =3D os.path.join(self.workdir, 'yamon-02.22.bin')
>> -
>> -        self.vm.set_console()
>> -        self.vm.add_args('-bios', yamon_path)
>> -        self.vm.launch()
>> -
>> -        prompt =3D  'YAMON>'
>> -        pattern =3D 'YAMON ROM Monitor'
>> -        interrupt_interactive_console_until_pattern(self, pattern, prom=
pt)
>> -        wait_for_console_pattern(self, prompt)
>> -        self.vm.shutdown()
>> -
>> -    def test_mipsel_malta_yamon(self):
>> -        """
>> -        :avocado: tags=3Darch:mipsel
>> -        :avocado: tags=3Dmachine:malta
>> -        :avocado: tags=3Dendian:little
>> -        """
>> -        self.do_test_yamon()
>> -
>> -    def test_mips64el_malta_yamon(self):
>> -        """
>> -        :avocado: tags=3Darch:mips64el
>> -        :avocado: tags=3Dmachine:malta
>> -        :avocado: tags=3Dendian:little
>> -        """
>> -        self.do_test_yamon()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

