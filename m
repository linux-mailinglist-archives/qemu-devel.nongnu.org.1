Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18E7BFA77
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBM9-0006bP-K0; Tue, 10 Oct 2023 07:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBM0-0006ZJ-HD
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:56:49 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBLv-000054-6Z
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:56:48 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b29186e20aso947321866b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696939001; x=1697543801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qlfm40CNX39U3MfQmCxVxB/8tsjjTRpwPggE6Oi56Es=;
 b=hSr/zcm8wGX2U8Id3aZHuC8Thg4hfmXdwMKt6+xbSY4K2S6LiQy1RMIRTHhJCekl3p
 bTv+HTOv8/1G3j7DIUVAUXpRX/bKaCn7ssStwJdJFvtskA0y2PZmIYesxnNDdwVwVRPQ
 3KFVsCv0St6sb23c7qXfXrxlxQ0ZMGsZW1ZyrNMo1T3M5ddT4LmOdmv5Hi7sPiWpMIqI
 P8am9Ox+YP3esEju62n3XXw6Q9xhJGaV0PtiBqs0S2zMNKip35RhBYRmblPLn9qW9qI/
 eEf+nsEWcyHXTCkv8/lllnkdY2Ms9WtB/f3Y+H9cG2sP5X4hr72KC7R7g+DM4Wz21oRa
 YlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939001; x=1697543801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qlfm40CNX39U3MfQmCxVxB/8tsjjTRpwPggE6Oi56Es=;
 b=X0EXWSk7Jnz7Cblf1onx/6J11KjIgDshjmi7xbzeAT/z45w2kK4abRNToJ6qHU9ct+
 90R3X8bwHFXVbKubwIoy4iXfr2j3HceaV5DtaReOTlBwID3YxUXIwJHyRUdnG3U/cO09
 er+MMNkC/xUxz1FyKFryR/wSCUUZRRSgvGp1eVypr+tovXdxBD58qsZGKLk+LnZvGlYr
 m8Sbj6YvLoaX0Wky1n2w1mjWotrN+p6iBONjqGpx4k9GLcSc0ZjDaS4HhJ9wXbc8Be/U
 zkOd+mvSlxyM3EzXgczkozr64IUmVYVePFB+SNWFbqZ8GVWUEXQ49S3scuR2wKaYNbUs
 IqrQ==
X-Gm-Message-State: AOJu0Yy9dI9w06nnbmx9mTQOO47L0m90l3O5Z4woBIb1F4K0EaDwzo0/
 6tvrGDGn2IbQGlxSsckI0QHb+g==
X-Google-Smtp-Source: AGHT+IF4BFuHaE3LqrKLl7o1W+AUINASUjohGYH7UDTjoiIC+sZBStWET44grVxDUUzv3JS6z77EIA==
X-Received: by 2002:a17:907:b11:b0:9ae:699d:8a29 with SMTP id
 h17-20020a1709070b1100b009ae699d8a29mr15104733ejl.6.1696939001009; 
 Tue, 10 Oct 2023 04:56:41 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 kb4-20020a1709070f8400b009adc81bb544sm8337672ejc.106.2023.10.10.04.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 04:56:40 -0700 (PDT)
Message-ID: <bbd46ddb-a848-4e6f-ac5e-dcd2cf99b5c7@linaro.org>
Date: Tue, 10 Oct 2023 13:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 02/25] tests/avocado: remove flaky test marking for
 test_sbsaref_edk2_firmware
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
 <20231009164104.369749-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009164104.369749-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/10/23 18:40, Alex Bennée wrote:
> After testing locally I decided to revert a5754847e0 (tests/avocado: Disable the
> test_sbsaref_edk2_firmware by default) as the test seems pretty
> stable:
> 
>     env QEMU_TEST_FLAKY_TESTS=1 retry.py -n 50 -c -- \
>       ./tests/venv/bin/avocado run \
>       ./tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware
> 
> yields:
> 
>    Results summary:
>    0: 50 times (100.00%), avg time 2.064 (0.04 varience/0.19 deviation)
>    Ran command 50 times, 50 passes
> 
> Maybe f0ec14c78c (tests/avocado: Fix console data loss) has made it
> more reliable?
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


