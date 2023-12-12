Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C796280E5AA
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 09:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCxtX-0000p1-UR; Tue, 12 Dec 2023 03:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCxtW-0000oj-O9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:13:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCxtU-0005sd-TW
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:13:34 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d2eb06ab11so21180145ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702368811; x=1702973611;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWeXIAcPVQudRWVNMCBKAFyfnETiLoRy/MoLakk4Nn4=;
 b=ugF11/vhD+2WBMAsQcua47bt3mI49WwbswRlspvl+NBZA6f08yHByYIupFwSaC0rhj
 dPVDRebwwXQh3e0VvePnoadXqNrevQG2Z1oaevdxn9uvHNRvOWD8UcpzduXTulNgJnDd
 ImhOQxyDiPujcbeGxGfWApy85mo95je2q1zS/lZrlx8ckEkdyXMZUTcyeklaeC6tspQP
 iUtfRQoQDJfjkL9W9TZN7aPSA45AGA6a2W5GqT7EB0JLuy7+8/kRUxf98ud1qOXG5P+W
 HuikqKQeJ+JOk6WxJtDOK+0pxWwHfjeQvgUpZ2LKEyFQreEoJavYAbw6Mvus+T5/Vo1y
 4+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702368811; x=1702973611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWeXIAcPVQudRWVNMCBKAFyfnETiLoRy/MoLakk4Nn4=;
 b=ubpVOFZwbaBOSrdtxdz4rjB+oeT+fHhUgvtE0NKaPFJmknJrjy/BuGzS2Nq4K0emBE
 p6IAEJb4f80ndcR4dTOOxZqtGzMdhqMWWwTckqgqu1zLtwI57t1lFTaluOeexMHoTdul
 CFgnlTToP5f5L2gfRXcrsaB3u/d9Mn25pnF778jHXFTP3DNj6Ydg+8SHi795QDGjhykC
 E5cLW+BTsdJYIbE/wrHyJWQPhoofXL+b98XwjyGwPVI/JEWilzA1QcO1pynbGtjSMP3j
 ZvrVWImFAOzh+uKkEoclvkvOTPS6Sq192Ts1peMn3Fprj45PHu6AYYzSgMKI3ZnbhX1S
 0pVw==
X-Gm-Message-State: AOJu0Yze7uFRhZe2KpHbjzxbhE2NjH44I68aoL8i+8fdZNLlKgsi2Ttg
 Spz6WPs9WMjWllvAyDud7DoyxQ==
X-Google-Smtp-Source: AGHT+IFvUmziIWBs1OJTpYO7C68nwt4JBi4XL8fGer5kyd+qMcd75C6AEDDD+1T+2txWVzO/tVeY5A==
X-Received: by 2002:a17:902:650e:b0:1d3:34cb:231a with SMTP id
 b14-20020a170902650e00b001d334cb231amr377063plk.70.1702368811100; 
 Tue, 12 Dec 2023 00:13:31 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a170902d2c200b001cfcf3dd317sm7999185plc.61.2023.12.12.00.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 00:13:30 -0800 (PST)
Message-ID: <85f0bd13-9fe3-420d-939f-695955427f5a@daynix.com>
Date: Tue, 12 Dec 2023 17:13:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] testa/avocado: test_arm_emcraft_sf2: handle RW
 requirements for asset
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-8-crosa@redhat.com>
 <5377419a-88dd-4e5c-8be4-1345f6c2115b@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5377419a-88dd-4e5c-8be4-1345f6c2115b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/12 1:36, Philippe Mathieu-Daudé wrote:
> On 8/12/23 20:09, Cleber Rosa wrote:
>> The asset used in the mentioned test gets truncated before it's used
>> in the test.  This means that the file gets modified, and thus the
>> asset's expected hash doesn't match anymore.  This causes cache misses
>> and re-downloads every time the test is re-run.
>>
>> Let's make a copy of the asset so that the one in the cache is
>> preserved and the cache sees a hit on re-runs.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   tests/avocado/boot_linux_console.py | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/avocado/boot_linux_console.py 
>> b/tests/avocado/boot_linux_console.py
>> index f5c5d647a4..e2e928e703 100644
>> --- a/tests/avocado/boot_linux_console.py
>> +++ b/tests/avocado/boot_linux_console.py
>> @@ -414,14 +414,16 @@ def test_arm_emcraft_sf2(self):
>>                      'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
>>           spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
>>           spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
>> +        spi_path_rw = os.path.join(self.workdir, 
>> os.path.basename(spi_path))
>> +        shutil.copy(spi_path, spi_path_rw)
> 
> This is an implementation detail. By default fetch_asset() should return
> a path to a read-only artifact. We should extend it to optionally return
> a writable file path, with the possibility to provide a dir/path.

Apparently it is not OK to abstract fetch_asset() away; it confuses some 
static analysis according to:
"[PATCH 02/10] tests/avocado: mips: add hint for fetchasset plugin"

That said, it is still nice to have a method that does os.path.join() 
and shutil.copy().

