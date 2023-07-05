Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D712748548
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:44:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2nk-0008SZ-76; Wed, 05 Jul 2023 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qH2nh-0008SO-5A
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:44:09 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qH2nf-0004eX-C1
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:44:08 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fb96e2b573so10937064e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688564645; x=1691156645;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmb7+8Ahxbo6VEqgEEjhNiuZnaQ+DkWKY5YSSRm0RqI=;
 b=afJZkP0r+a3Qb4quqCikN8FVQa9Q8TrA/5TjB2tvjgvxphzktGCaskyXUE5aTlPiQn
 /RAOiuh4rb5nCQhVLT7cGRAaPZXNS7d1gAZx+Qfs2bHxJK5yKHG5sh/J2F2AK0fpCAhs
 br+c/YAsg26Sl2GK8Aix0Xn7wPwgJYRMniSjnWVtfe0fAmlK7MiRg1h6NvpEXOdrMOwQ
 aeSirBgWJnHQTKihSVa7BRKVjZUkiquFKONrOTegIa6KUJqm9gcGsDvrFqI8lNs1C6o6
 E5iTUa9zO9Fa7WJ0GwVyMfMyfM8YbsXanZLf0JxXDBLoKQpF+wtXn5D9hcQHbBwnalFH
 CBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688564645; x=1691156645;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rmb7+8Ahxbo6VEqgEEjhNiuZnaQ+DkWKY5YSSRm0RqI=;
 b=HP2Dg6cr36NLa0z5FdgffczDWafFAiEA7UEbafoFgOgqVxIlzzY/ZUqn4M0UOT63/s
 9PGFHYpsgG+ahaU0jetZ+rkzHUWqILICv2vWmxKshQX3PuulyIeJ/nGB5picbb85Mlnr
 k1bvlaWGxOw2WEdMW8mghLFohB9gKQqJmcb4CtU+9iQdAaerfgRAiQRfdJFD4vuFOx7m
 0p8Ef/uRok2lO8A1cR73B2O2y9g/c1lhnve08YFdPViE3YYb+TjMNEg2k3iFkqtmMk3P
 ffJWUrKbeN2YNRPCdkifw5wxVQhJmVMinz5o5HISq+ndApUErLJJyDxMBBCIZzA3UNTq
 qisQ==
X-Gm-Message-State: ABy/qLbk6fcMXbLqg5/Z10nJonr18UVFPt7Mo/qzO4yXS4ryHm2HPELz
 yBPJ3m7Tyml6bPMeqagK4M8LH/Lnhw2tUPjRiNM=
X-Google-Smtp-Source: APBJJlHyxyCj116icTIBseu1SDMOuUqDlYBU/OBtjcXJ3ECJ1CbCefkR9iNGEUI+JlVfXp8ypD/FDQ==
X-Received: by 2002:a05:6512:2510:b0:4f9:a542:91c with SMTP id
 be16-20020a056512251000b004f9a542091cmr13949603lfb.3.1688564645071; 
 Wed, 05 Jul 2023 06:44:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d5681000000b0030647449730sm31325442wrv.74.2023.07.05.06.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 06:44:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F8F71FFBB;
 Wed,  5 Jul 2023 14:44:04 +0100 (BST)
References: <20230705081813.411526-1-zhanghao1@kylinos.cn>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: zhanghao1 <zhanghao1@kylinos.cn>
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: add a new vcpu watchdog
Date: Wed, 05 Jul 2023 14:42:04 +0100
In-reply-to: <20230705081813.411526-1-zhanghao1@kylinos.cn>
Message-ID: <87fs62fp7f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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


zhanghao1 <zhanghao1@kylinos.cn> writes:

> Each vcpu creates a corresponding timer task. The watchdog
> is driven by a timer according to a certain period. Each time
> the timer expires, the counter is decremented. When the counter
> is "0", the watchdog considers the vcpu to be stalling and resets
> the VM. To avoid watchdog expiration, the guest kernel driver
> needs to periodically send a pet event to update the counter.
>
> Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
> ---
> v2:
>  - change the function name and remove the redundant word 'stall'
>  - add trace-events to replace DPRINTF and qemu_log
>  - call 'watchdog_perform_action()' to reset vm
>  - update g_new0 to replace malloc
>  - update only use '.generic_name'
>  - update the bool variable 'is_initialized' to uint32_t
>
> v1: https://lore.kernel.org/qemu-devel/20230615061302.301754-1-zhanghao1@=
kylinos.cn/
<snip>
> +static void virtio_vcpu_watchdog_device_realize(DeviceState *dev, Error =
**errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    vwdt =3D VIRTIO_VCPU_WATCHDOG(dev);
> +
> +    virtio_init(vdev, VIRTIO_ID_WATCHDOG, 0);

This will never compile because VIRTIO_ID_WATCHDOG isn't defined
anywhere.

Next time you post you need to also include a link to the kernel side of
the driver and the virtio specification (or inflight patch for it).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

