Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84D72A674
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 01:01:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7l53-0001uU-Kv; Fri, 09 Jun 2023 18:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7l51-0001uM-QB
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 18:59:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7l4z-0003zl-St
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 18:59:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b23f04e333so10037065ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686351575; x=1688943575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LjdKC/yQ8eCPAjlJxYBF043KGpHNIiIUTdPhq2N4uI0=;
 b=sJxZpX7cgTP5xJ3XVEortBHxO+k0AOLBpLeX/qjkcQg0MvzN4ry3WRDH6pOhEZrg+f
 QmoUCvk4YaSEQVoke50L9oymZWywPhyN+2SS5+fCnX1c5uCksuiD6m7lIv3W/JPAMFsH
 34qeW3OvCbUYBv3ECpx+cI7B/VBkN1NszV9o/EsFcd7nqlOMsKb7vjwm2CtP3dbwJcGV
 OZSugl2ABgo2UfK+i/X7nKJLfTFYJZO+4geX4eFEeV6l51R1TLfM3JN41F5B1j3iMDw4
 j1VlzxWPdQH/KwC9Ryj3Jsck8A/zE8idHWzljEMhcZanZNdTrrKskzDFL3eaS1/oJBpW
 spAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686351575; x=1688943575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjdKC/yQ8eCPAjlJxYBF043KGpHNIiIUTdPhq2N4uI0=;
 b=Zrs4iQUtN4tjUyW+SgwwZvr6KF6fIqKA2xtN78hvJDkwgKRFG7r5GKijFVJJNfOzr/
 ZzcVDspZ+TN9chd9vYh2r0M2aHDu8/8jok+lYHdBL3ocHJPlaeaWYkFNlsRAFrt/c10c
 jiP0NfFfCeVFGrAbALdLU1VPtYJD6VUQ/C1U/IBZLEB/xs3IyRogMjJl+KWTnp2AlCtJ
 XKwX/E/3b+cqy3dsrBt723usYCnlKS30oYKnaOS8iQMquE/wBKkbG9xJs2TT0M+OPknE
 93YyWaCvube+5fKnnjyJYcY+in0Va+ikvsR3ZaEx1kdsnYAZm5Ftwhloe+zz5jtH6DUK
 cD+A==
X-Gm-Message-State: AC+VfDwYAfltg3vHxsePI+HXPT5KBfvOqJ7Z8UXCE31i9GHM12/RrmlE
 1PVyksb7Rm5nypKzKfiM3ATujQ==
X-Google-Smtp-Source: ACHHUZ57d2oP0GgqgfX9iJdHNijcNAQgKhEl6IyMUfxwrRDFQvfJgZ+dq+2y7stkMIxr/XLOh8gFMw==
X-Received: by 2002:a17:903:2441:b0:1ac:63b6:f1ca with SMTP id
 l1-20020a170903244100b001ac63b6f1camr288774pls.0.1686351575327; 
 Fri, 09 Jun 2023 15:59:35 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 q66-20020a17090a17c800b0024dfbac9e2fsm5473154pja.21.2023.06.09.15.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 15:59:34 -0700 (PDT)
Message-ID: <3925158f-cd95-781f-5f46-fe3f5d8326ab@linaro.org>
Date: Fri, 9 Jun 2023 15:59:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v4 09/10] hw/arm: introduce xenpvh machine
Content-Language: en-US
To: Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Stefano Stabellini <stefano.stabellini@amd.com>
References: <alpine.DEB.2.22.394.2306091007210.3803068@ubuntu-linux-20-04-desktop>
 <20230609170751.4059054-9-sstabellini@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609170751.4059054-9-sstabellini@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 10:07, Stefano Stabellini wrote:
> From: Vikram Garhwal<vikram.garhwal@amd.com>
> 
> Add a new machine xenpvh which creates a IOREQ server to register/connect with
> Xen Hypervisor.
> 
> Optional: When CONFIG_TPM is enabled, it also creates a tpm-tis-device, adds a
> TPM emulator and connects to swtpm running on host machine via chardev socket
> and support TPM functionalities for a guest domain.
> 
> Extra command line for aarch64 xenpvh QEMU to connect to swtpm:
>      -chardev socket,id=chrtpm,path=/tmp/myvtpm2/swtpm-sock \
>      -tpmdev emulator,id=tpm0,chardev=chrtpm \
>      -machine tpm-base-addr=0x0c000000 \
> 
> swtpm implements a TPM software emulator(TPM 1.2 & TPM 2) built on libtpms and
> provides access to TPM functionality over socket, chardev and CUSE interface.
> Github repo:https://github.com/stefanberger/swtpm
> Example for starting swtpm on host machine:
>      mkdir /tmp/vtpm2
>      swtpm socket --tpmstate dir=/tmp/vtpm2 \
>      --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
> 
> Signed-off-by: Vikram Garhwal<vikram.garhwal@amd.com>
> Signed-off-by: Stefano Stabellini<stefano.stabellini@amd.com>
> Reviewed-by: Stefano Stabellini<sstabellini@kernel.org>
> ---
>   docs/system/arm/xenpvh.rst    |  34 +++++++
>   docs/system/target-arm.rst    |   1 +
>   hw/arm/meson.build            |   2 +
>   hw/arm/xen_arm.c              | 181 ++++++++++++++++++++++++++++++++++
>   include/hw/arm/xen_arch_hvm.h |   9 ++
>   include/hw/xen/arch_hvm.h     |   2 +
>   6 files changed, 229 insertions(+)
>   create mode 100644 docs/system/arm/xenpvh.rst
>   create mode 100644 hw/arm/xen_arm.c
>   create mode 100644 include/hw/arm/xen_arch_hvm.h

Fails testing.

Summary of Failures:
  10/423 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp                  ERROR 
161.45s   killed by signal 6 SIGABRT
210/423 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test                  ERROR 
327.56s   killed by signal 6 SIGABRT

# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-669817.sock -qtest-log 
/dev/null -chardev socket,path=/tmp/qtest-669817.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -machine xenpvh -accel qtest
qemu-system-aarch64: The -accel and "-machine accel=" options are incompatible
socket_accept failed: Resource temporarily unavailable
**
ERROR:../src/tests/qtest/libqtest.c:474:qtest_init_without_qmp_handshake: assertion 
failed: (s->fd >= 0 && s->qmp_fd >= 0)
Bail out! ERROR:../src/tests/qtest/libqtest.c:474:qtest_init_without_qmp_handshake: 
assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
../src/tests/qtest/libqtest.c:186: kill_qemu() tried to terminate QEMU process but 
encountered exit status 1 (expected 0)


r~

