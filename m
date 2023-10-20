Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5667D0E35
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:13:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnQb-0007mN-Jf; Fri, 20 Oct 2023 07:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnQQ-0007dW-IJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:12:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnQN-0002cO-83
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:12:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so493694f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697800333; x=1698405133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s8Zds+O18ysmBZbk6kMV0bcZ11Wfv6kfFTr219tnBu8=;
 b=wnJi6mV83LoWMnpeHO23f3PXJ/oP9LZ8RLoOe0DFPx82tKfKX1KRk+w4mY/t06tgHL
 RRUXWo3LHIvDekMcUdFQuCT4UOKlFyQoXZfkPqVEcqruxsS26iCrrfZwIdPC+4uH82+B
 uslxTsJoReOxjakdnX7mfKcdoW/XUtdWaXVSt4ICs/Jez0QnHpJBjkOwaIpYShUtwLGA
 7d3vNCSjt/HlSLT/jsW7XQ5wNLuz8d4zJ+mrWsJCCRLz7d2fOpj1BsK92ic1DN1qgxmq
 NkMlMAuY491whSo9J+jHZ9alOjLfsdf75rNPy8Nl+BLKbOKSK4B32in83VEG41NcwblB
 l3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697800333; x=1698405133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8Zds+O18ysmBZbk6kMV0bcZ11Wfv6kfFTr219tnBu8=;
 b=OP0EylotWmYDjbIJVE7mBmJ/w+7mvhrld4Ycr/y8+t+Nuo1HLSfZaJOeBEbfXtqcjC
 qhMnOJg5mcVgAkB1Tik9ywKFxKzqac3AyvldVpiE7LD4kTOUZeUFrSeH52VRod79x+6v
 PVbTc0d/b08qz6wiDyMe8tUO95zOb4IiQtX4MIxNV0w8Su7QTjc+YfjbW4G3ekvTTqtR
 dXOMFVdCA5lwnIQIfJlz1oxtBDCCPPmky4tQwYhRb5HBX5vNQ/2PSPS2ah3e0PqzeL7j
 FrxJuX7Gi/g4eP0wBbMaZynvc3+O78MDYdc3bJ5PVAJelWxH8EXeDNtNWzf6gvQ3nncf
 Dc6w==
X-Gm-Message-State: AOJu0YxxYitFs/oFftgb5IZtFIaiGSjEtmF6XXgonPGEUuVoa91sUF9l
 ZkQSpUA+mZJF/Dnrbmy7oaZGdzzGk/nP8AcPb+w=
X-Google-Smtp-Source: AGHT+IG4enB7zcyxPqRHogT8mW4sKG+BIrmvQZ0MMLnh4DHzsuUikRttvHuwElGZ+ay00ds45fu/yQ==
X-Received: by 2002:a05:6000:71e:b0:32d:b06c:d30b with SMTP id
 bs30-20020a056000071e00b0032db06cd30bmr1142881wrb.55.1697800333627; 
 Fri, 20 Oct 2023 04:12:13 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0032db430fb9bsm1451597wrq.68.2023.10.20.04.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 04:12:13 -0700 (PDT)
Message-ID: <5f21191b-bbb3-a61a-86b7-bc8273f64bd1@linaro.org>
Date: Fri, 20 Oct 2023 13:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] target: Use env_archcpu() instead of
 ARCH_CPU(env_cpu(env))
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231009110239.66778-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009110239.66778-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 9/10/23 13:02, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):
>    target/ppc: Use env_archcpu() in helper_book3s_msgsndp()
>    target/riscv: Use env_archcpu() in [check_]nanbox()
>    target/s390x: Use env_archcpu() in handle_diag_308()
>    target/xtensa: Use env_archcpu() in update_c[compare|count]()
>    target/i386/hvf: Use x86_cpu in simulate_[rdmsr|wrmsr]()
>    target/i386: Use env_archcpu() in simulate_[rdmsr/wrmsr]()

Series queued.


