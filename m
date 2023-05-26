Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC907129E9
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:49:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zf5-00023E-E9; Fri, 26 May 2023 11:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zf1-00022W-VP
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:47:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zf0-0006KP-Dg
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:47:23 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso1291931b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685116041; x=1687708041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQpnie3Sk98heejnRX8zbr30sAdFvftBF8KU2yFa6lw=;
 b=HkquA1B/utP/7XJpjypKmptrt3GneeUmC7Ux5AT6sBzSDykrFvsOMSP2NRKZecGLg3
 xVOz5ClJmXLKEZBK8TCTnZttYbx2XXtF9B2V8TiIPZ74PWtoJUPOciFy3HSz2Z1ZBvAl
 OwH7Inpz3zFbl24AOe23nYnPPRNuEXdkmDLQFGAzfbQ9ApsSRbXvQE9WL3O3niOea5Ka
 M4kvZkpcaUaq7QF8Ts+lO/PCCinOaZbnpBVrEaHo0zkeR7bF2pVnSdan1Nc5WFQimxjU
 OgT3wvef3coRp2xmaFVDkrv3UNMAvno/tWMfNuOcHDjV2GiN7nF4ZLiM4j0GkbpELkUo
 GD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685116041; x=1687708041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQpnie3Sk98heejnRX8zbr30sAdFvftBF8KU2yFa6lw=;
 b=EZCqpl5pXnz5RGTdc+Ltq5Lk1ID3LmqDxdXl6BgAEnwRDJL/tNpU70lpvxCHG5O/03
 DnGCh2TxaIE/RrCJ4xDRg45bFHqNrXpLPKGemBqzl5bsZEpK0dqJ9l/TMbxXv1lxEhKi
 S2cmuGNZNmb0EbRMbOqJsCKXX2Pvwu4HsYoHDsxxLj810YF+hgNMFnqD8zvpR7s5UELl
 M1hoJvYG+DV5G6zWJfFB7cU9hd6Lp0cpugHRjTTnJgY4FF3DkI6kOcd/Q3i4Ba39mCns
 mG5RmkZs27I5vTjqkd2JjFCW42zJUJ52SMhHSRGzhEkrT4bvaWN7hmgFnr2tPd4CMWsm
 F83w==
X-Gm-Message-State: AC+VfDy1HGeaNkDMcMrm2etIm7ePmsAF3uKGVXy3yrbtwed7ZaFIG854
 HiSBQ4b0FOuhTWoDa5vwL1VyOQ==
X-Google-Smtp-Source: ACHHUZ6a1r6Y3LJhO/1Use+GTCB77VmK5RqX1oVYlwSsOpx8xxkm3/4bv9JUXOEzZhI38Cc0aK5ylg==
X-Received: by 2002:aa7:888e:0:b0:63b:8eeb:77b8 with SMTP id
 z14-20020aa7888e000000b0063b8eeb77b8mr4375174pfe.13.1685116040845; 
 Fri, 26 May 2023 08:47:20 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 s9-20020aa78d49000000b0064d413ca7desm2982375pfe.171.2023.05.26.08.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 08:47:20 -0700 (PDT)
Message-ID: <144e2ab5-8fe4-3b4a-7776-5722380b8616@linaro.org>
Date: Fri, 26 May 2023 08:47:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: io-qcow2 failures on zfs
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
References: <7b1805ad-56fd-77f7-48f7-fdf80f6a2e5b@linaro.org>
 <d1ab807e-3a9a-91b9-ad52-2d46c06ff54b@linaro.org>
 <333138b6-401b-d863-c2cf-90e36d16cc97@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <333138b6-401b-d863-c2cf-90e36d16cc97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 01:02, Thomas Huth wrote:
> What output do you get when running the tests directly? i.e.:
> 
> cd tests/qemu-iotests/
> ./check -qcow2 150

  === Mapping non-sparse conversion ===

  Offset          Length          File
-0               0x100000        TEST_DIR/t.IMGFMT
+0               0x10000         TEST_DIR/t.IMGFMT


> ./check -qcow2 copy-before-write

+======================================================================
+FAIL: test_timeout_break_guest (__main__.TestCbwError)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/richard.henderson/qemu/src/tests/qemu-iotests/tests/copy-before-write", 
line 200, in test_timeout_break_guest
+    self.assertEqual(log, """\
+AssertionError: 'write failed: Connection timed out\nwrite f[121 chars]c)\n' != 'wrote 
524288/524288 bytes at offset 0\n512 [182 chars]c)\n'


> ./check -qcow2 244

-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": 
true, "offset": 0},
+[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": 
true, "offset": 0},
+{ "start": 1048576, "length": 1048576, "depth": 0, "present": true, "zero": false, 
"data": true, "offset": 1048576},
  { "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, 
"data": false},
  { "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": true, 
"data": false, "offset": 4194304},
-{ "start": 6291456, "length": 60817408, "depth": 0, "present": true, "zero": false, 
"data": true, "offset": 6291456}]
+{ "start": 6291456, "length": 60817408, "depth": 0, "present": true, "zero": true, 
"data": true, "offset": 6291456}]


r~

