Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817DA73FF72
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAON-0003A0-Uq; Tue, 27 Jun 2023 11:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEAOM-00039X-6V
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:14:06 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEAOK-00056S-Iq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:14:05 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-98e109525d6so568194066b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687878842; x=1690470842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1hLkHKgBAbZUuk0W8oE9AqIRXF820+oX61/uVYQAwns=;
 b=RHSJC9x8UfCPz2FSbqOh2Ao54TcsCXhLbDK36yeB1DEJ4hj8Sl//hI37GaNYUgS+fs
 y4GXgRTnzQOM1uZVi38YmTqIyNo79pOMoci/EMI21MPW3l/lqt4OWFxhD0crUv1+Jlb9
 HAOtsR6oW56BaUJI4kAcsAxbPwP1gziEWSlXXCLlw13fsJZ46+EXCC7yWYT+y9jAT4m2
 e37yJcRCJEf80dlpoCKw2ihRR+G97nQEWmYOKSl3kIWFhrwA65/8u/9cIRWyQlcvD9VH
 FtltpgqEHEOcfVtyLsREChlxiSDkV4CjXzltjoOAxfty5o4YqGw18zEI/gJw6anC6zz4
 g8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687878842; x=1690470842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1hLkHKgBAbZUuk0W8oE9AqIRXF820+oX61/uVYQAwns=;
 b=Q2NDwIKrj8rKxR31r/UPCgQqeelaxEZjchdekJ90mbwTdyS1Pkjazl6pGIYOTBosNJ
 MKVgzSqfNJ80Gu1bV/kuPgar6PbgceVS3qsi74MvhOj3oyzoIf7HBk+X4/KNQacsQByC
 MMCnuYfSOIxWBeW5ZYGbXwLo1PLLECWdb1TqCpAWNsxjoUBfGnMhYORTMUx9qmBb+Cph
 QCCl1geXk751nb6x6XkmAWfhipMU5Y4kxy34SxS6pyx+XO2VGR/8DYMXBBlUD5dLD8qt
 O0lFzRfYWq/BL+0evnGDC4fVA0TE+ewzBvxYUMBHGGrwmoXqN10AAVRWhQZgISxf0Jtt
 GlQg==
X-Gm-Message-State: AC+VfDx1sygvN4G7BEUOOWBjiD8G2wrHvIqiUBQSAt1tP9B5zsK6IKKe
 vGWloIyUVDE7yzmzu45yKJLJ8cdLfK+4VxtguRk=
X-Google-Smtp-Source: ACHHUZ4N32hEou6vtUW/NAB1itCDeEMec+9QDxvX9fKtvB6/ovOV17I4ogYzFcIiFUizKhcJXoAQ3g==
X-Received: by 2002:a17:907:3f87:b0:977:d660:c5aa with SMTP id
 hr7-20020a1709073f8700b00977d660c5aamr30961510ejc.31.1687878842634; 
 Tue, 27 Jun 2023 08:14:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 ss26-20020a170907039a00b0098e422d6758sm3262608ejb.219.2023.06.27.08.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 08:14:02 -0700 (PDT)
Message-ID: <dcf96b9e-16c5-b1d5-14a5-276fc0556bee@linaro.org>
Date: Tue, 27 Jun 2023 17:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/16] accel: Share CPUState accel context
 (HAX/NVMM/WHPX/HVF)
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paul Durrant <paul@xen.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230624174121.11508-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 24/6/23 19:41, Philippe Mathieu-Daudé wrote:
> This series is part of the single binary effort.
> 
> All accelerator will share their per-vCPU context in
> an opaque 'accel' pointer within the CPUState.
> 
> First handle HAX/NVMM/WHPX/HVF. KVM and TCG will follow
> as two different (bigger) follow-up series.
> 
> Except HVF/intel, all has been (cross-)build tested.
> 
> I plan to send the PR myself.
> 
> Since v2:
> - Addressed rth's review comments
> - Added rth's R-b tag
> 
> Since v1:
> - Addressed rth's review comments
> - Added rth's R-b tag
> - Converted HVF intel (untested)
> - Rebased
> 
> Philippe Mathieu-Daudé (16):
>    MAINTAINERS: Update Roman Bolshakov email address
>    accel: Document generic accelerator headers
>    accel: Remove unused hThread variable on TCG/WHPX
>    accel: Fix a leak on Windows HAX
>    accel: Destroy HAX vCPU threads once done
>    accel: Rename 'hax_vcpu' as 'accel' in CPUState
>    accel: Rename HAX 'struct hax_vcpu_state' -> AccelCPUState
>    accel: Move HAX hThread to accelerator context
>    accel: Remove NVMM unreachable error path
>    accel: Rename NVMM 'struct qemu_vcpu' -> AccelCPUState
>    accel: Inline NVMM get_qemu_vcpu()
>    accel: Remove WHPX unreachable error path
>    accel: Rename WHPX 'struct whpx_vcpu' -> AccelCPUState
>    accel: Inline WHPX get_whpx_vcpu()
>    accel: Rename 'cpu_state' -> 'cs'
>    accel: Rename HVF 'struct hvf_vcpu_state' -> AccelCPUState

Except the MAINTAINERS patch, all the rest is reviewed, so I plan
to send a PR tomorrow (dropping the first patch, nobody complained
about Roman email bouncing for months so we can keep ignoring the
automated emails).

