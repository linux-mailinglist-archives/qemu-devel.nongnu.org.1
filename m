Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D5832D65
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:42:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrwR-0007hj-O2; Fri, 19 Jan 2024 11:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrwF-0007Ys-MN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:41:53 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrwB-00026k-8u
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:41:50 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-559d95f1e69so1083470a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682496; x=1706287296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rd/sNQHqIi3M1PSH7+a0qNGw3PD0Eadt0z8LVLPgO5U=;
 b=kcJJZuAXyg5HMm3oPjDyO5esS9JeOcUlnVJcQlq13ajouzP7U7lVKIPbFdr/1Q5rd3
 0id3QFggShbmxFGuOMQo+IjDWymgGjzlbX0rMAjGDlCzXMLQvwYZ+gnl3JGj+ISo4yc3
 99Zxy/uSOjlY+EU7c9AyFrdXeH4gXIgPOl4+XqDwaR0aTk55ZqqrjfWjbsTq2b7vKC8e
 dHf4c0/+tcsYj8LHvIUEkrQATm3krqtH2ATySIvS9pHqCHKL8YPqTiyrssjN3uE+i/kH
 w3JgJ041epaKA/P8qAbKtqSa8vhh9gCEDtrXoGS3XnEFdu/eqh2KEFazbQ+NdffWJMwv
 b1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682496; x=1706287296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rd/sNQHqIi3M1PSH7+a0qNGw3PD0Eadt0z8LVLPgO5U=;
 b=skPwgrsPaHoOr6eIQorQy8+PFYIvz0Q5yuf3/ZC9EA46P79eQUy36p82f2mzLAw3RE
 BBK1Fm9UBrhOyWWUfW3x0nkYTuGZzTnB833wz/UO8aMkmzEN0/BtEXyIWfnxINFCt7U2
 WyPiJwFzwaF/W+SmI58ZHzozHTFuXDRsmZVXHYqQ1nvvOS8kZIaZMw1INaHDptaXqzMT
 /u4Ow5wpJnD5wiymbf9YKRIuX9i3Oa4k9Utd6+4tPLdAofCu/n5j/W+lnPm/uzaEPcQD
 VFviYtzU+VlAhOoq/HyZ0WWYp8PS8miki5LrLb1vtwZoixEewYiJsl4HTEoJsHlrPtcs
 D1Jw==
X-Gm-Message-State: AOJu0YyAh1GFASoSTdGSmJOdZq/nu+XUiFUlOxnfVM+aZu47yE3BHCdh
 MgqUGmJZ9BzT8oXPOoA6pXf+hbfAmqWk7nCkizGx79quX5H3escpOj7xVMdQ+OUFInM6lN87xWL
 F1rMRnZkgEEEJWqCaegirMuOMClPsVOYX/HThzw==
X-Google-Smtp-Source: AGHT+IGcrThxjVlJNx5ohBlAmFYV5SVUSGb/C0detyIdcSLCGwAB8MrCuY6gjVvnqxHmKi/bV7+/pjK+qTJsP/lfoXo=
X-Received: by 2002:a05:6402:b52:b0:559:f34f:8404 with SMTP id
 bx18-20020a0564020b5200b00559f34f8404mr28825edb.23.1705682496745; Fri, 19 Jan
 2024 08:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20240119113507.31951-1-philmd@linaro.org>
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:41:25 +0000
Message-ID: <CAFEAcA8JxJv7W1428eTaoereL6beSX0ET=zCih8CJ-Ni9QBrGA@mail.gmail.com>
Subject: Re: [PULL 00/36] HW core patches for 2024-01-19
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-block@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, 19 Jan 2024 at 11:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 88cf5fec91e50cd34bc002b633b4116228db0b=
c8:
>
>   Merge tag 'pull-target-arm-20240118' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-01-18 12:48:17 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-cpus-20240119
>
> for you to fetch changes up to 7ec5d7d91215815e885d2b38e62256e8fd8e2bce:
>
>   configure: Add linux header compile support for LoongArch (2024-01-19 1=
2:28:59 +0100)
>
> ----------------------------------------------------------------
> HW core patch queue
>
> . Deprecate unmaintained SH-4 models (Samuel)
> . HPET: Convert DPRINTF calls to trace events (Daniel)
> . Implement buffered block writes in Intel PFlash (Gerd)
> . Ignore ELF loadable segments with zero size (Bin)
> . ESP/NCR53C9x: PCI DMA fixes (Mark)
> . PIIX: Simplify Xen PCI IRQ routing (Bernhard)
> . Restrict CPU 'start-powered-off' property to sysemu (Phil)
>
> . target/alpha: Only build sys_helper.c on system emulation (Phil)
> . target/xtensa: Use generic instruction breakpoint API & add test (Max)
> . Restrict icount to system emulation (Phil)
> . Do not set CPUState TCG-specific flags in non-TCG accels (Phil)
> . Cleanup TCG tb_invalidate API (Phil)
> . Correct LoongArch/KVM include path (Bibo)
> . Do not ignore throttle errors in crypto backends (Phil)
>
> . MAINTAINERS updates (Raphael, Zhao)
>
> Note the following checkpatch error is deliberately ignored:
>
>   ERROR: space prohibited after that '&&' (ctx:ExW)
>   #143: FILE: accel/tcg/watchpoint.c:119:
>   +                && cc->tcg_ops->debug_check_watchpoint
>                    ^
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

