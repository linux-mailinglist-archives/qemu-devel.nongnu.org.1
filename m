Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50179EAD8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQgT-000283-F7; Wed, 13 Sep 2023 10:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgQgQ-00027Z-8H
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:17:34 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgQgN-0007TQ-Av
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:17:33 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso877038566b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694614647; x=1695219447; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjK3LS5aRN9LaENJ2TnBfugdwMFBD6/7cYcTD/0QDSc=;
 b=Tf321Tl/LUSFyDa6NHLsHFZ9bPzAm2+mw/TLLOSkvx5FY32NWrF7sJrxfDVFXvVwIk
 ILc6oGHtkfwRmlc/PqS7RRtg24SbtIjkz/C7vFuffExSi1pZn+oAo/+AnJVcwTsiC23A
 oqLzHxunfEq/NNaNK4EdoO1njFxwfDmocZvTYQouPeAbcYDFgQYMOr/NlVrZeJovhkeY
 WX/kDDnnBS2cCVuZi5OgvVNp3dmoE3qjbMk++IdqkBUviloVGJ2rOhMIcbWfoky1UYkR
 Un2himXVTbp9UL1cSsb8UXz2Cvc+mdcowf/wTRVRji3Qo3P8whFNANuMpudzSDYZ277T
 ul2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694614647; x=1695219447;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CjK3LS5aRN9LaENJ2TnBfugdwMFBD6/7cYcTD/0QDSc=;
 b=KHFxdEnnM0tj89s3EXE9X29d6qboxii/4i8th93ALz79XlcTIvxvWn5RBGxrd1nfyX
 YJ7n5UIy5p7uc87dwnv53u3+PWJGTtQwUKcCZWxECQo0DDE9wB+/NTU9X+OoSozST9Lp
 VW9nzKE4qon0qlW3t4cU1G50oMy5yqW4BXHkVfXwT4l/sVM9stF4WK0McKVYzcDbIopw
 y4SD0s4DqR6w0/CUIcU4BcszlrPfuxK3U/fGfRyVIu5Vu3vJHn7tBocKza8f/cMJmtSt
 O+3XGSTMDu+8WShEit7YPT/5mP+koEaZlE24G/B4UcXJ+qnGnndcESaeeqK1JFTLs2jA
 jmkQ==
X-Gm-Message-State: AOJu0Yyy/ionwy9NVd5zjhbJ5fGqT8ILxDlt72hjoe2FkgdXQqyHJjeY
 Mi03Acb3coYbCigte0K3GpEdaQ==
X-Google-Smtp-Source: AGHT+IFkD1BB9A6PP/Lh1CJbTovds90E9CKcecUxVCKYg1fR5OtVEs3ljjMuWY/fQNCJaVNg/vek/Q==
X-Received: by 2002:a17:906:cc0c:b0:9a9:fcfa:b6a7 with SMTP id
 ml12-20020a170906cc0c00b009a9fcfab6a7mr1835602ejb.36.1694614647388; 
 Wed, 13 Sep 2023 07:17:27 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 sa30-20020a1709076d1e00b009ad75d318ffsm3458377ejc.17.2023.09.13.07.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 07:17:26 -0700 (PDT)
Message-ID: <4169f3e6-96b8-81af-ef09-35629b34caa7@linaro.org>
Date: Wed, 13 Sep 2023 16:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Content-Language: en-US
To: avocado-devel@redhat.com, Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: Did Avocado assets hashing system changed?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

We are trying to figure out why old assets saved in our Avocado
cache (which we populate in our various CI jobs) isn't used
anymore.

Trying to reproduce locally, I see for example:

2023-09-13 14:39:18,834 test             L0520 INFO | START 
14-tests/avocado/machine_mips_malta.py:MaltaMachine.test_mipsel_malta_yamon
2023-09-13 14:39:18,834 test             L0205 DEBUG| DATA 
(filename=output.expected) => NOT FOUND (data sources: variant, test, file)
2023-09-13 14:39:18,861 asset            L0339 INFO | Asset not in 
cache, fetching it.
2023-09-13 14:39:18,862 download         L0067 INFO | Fetching 
http://www.imgtec.com/tools/mips-tools/downloads/yamon/yamon-bin-02.22.zip 
-> 
/home/philippe.mathieu-daude/avocado/data/cache/by_location/70c32932b7794b6b37a5040a8808ac943699b944/yamon-bin-02.22.zip.csi3gk2v
2023-09-13 14:39:18,940 asset            L0144 INFO | Temporary asset 
file unavailable due to failed download attempt.
2023-09-13 14:39:18,940 asset            L0378 ERROR| HTTPError: HTTP 
Error 403: Forbidden

I remember this test used to pass last year, so checking the file I
can see:

$ find ~/avocado/data/ -name yamon-bin-02.22.zip\* -ls
   1489611   6629 -rw-r--r--   1 philmd primary   6776580 Dec 30  2022 
/home/philmd/avocado/data/cache/by_location/c1961386ba52f06c6005b48cd32195a371152769/yamon-bin-02.22.zip
   1489613      1 -rw-r--r--   1 philmd primary        46 Dec 30  2022 
/home/philmd/avocado/data/cache/by_location/c1961386ba52f06c6005b48cd32195a371152769/yamon-bin-02.22.zip-CHECKSUM

But the hash is different... Looking at QEMU git history we haven't
changed the URL in tests/avocado/machine_mips_malta.py, so I wonder,
did Avocado changed its asset hashing during the last year?

Thanks,

Phil.

