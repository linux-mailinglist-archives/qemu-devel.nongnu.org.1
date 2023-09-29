Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F47B35E5
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEey-0006QM-Vf; Fri, 29 Sep 2023 10:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmEeo-0006PP-0k
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:39:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmEeh-000233-KM
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:39:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32003aae100so488864f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695998385; x=1696603185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfSsAFLq+ozbbV3vOThRqr0DE94QBJrbP6HSXRedHd0=;
 b=HR3AF0s1F5CBeKhwxVaFyUhRCVsTUJsW10y+dYMPGNc8HMYm9gCJKlt0BPxLXq0ICU
 vsGqopidYhoV1OMVgwkaCkgg0Pf7D1ux8knJ8VAXeVDUP6v6F2+Ga+Fi1eF/iOoxzCUD
 R3IVbPSI4jSyX6QJeXCBAHHQWLdaqdRECg/THgzc8+6tSQLeC3MH87FMx0u1IOGaUcbq
 qAVaLS3I9Yg8lfNVCr8NL7JLuJb7SqQWT/lDOYRuGqqvsbatJBeuBASvHUQp2JXIITC6
 eOyn86HaaiesmQ/FyrqJ0py14LwenZjcX/wwYoS85Z4wWj7PFVGM7n8w8nYYhlUhHHJs
 hGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695998385; x=1696603185;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KfSsAFLq+ozbbV3vOThRqr0DE94QBJrbP6HSXRedHd0=;
 b=SlwC9gi3Xdi6NnD0YWqxNef/JqPPQwo353mcRo6mgIM6iyvMY2hujGIDm9QYxwOdC/
 rUojw8rZdD1uvMjLTAXIer1FjwPVM0yrcprinCIkOKDAF90QeKBI0uLkdqN0PuLbvukF
 WMIiDwkQlE2PL8et2+vuZqKpyPN9Vxk8OOfF88qTlik/ozS+tK3NnZHX9t4e6YTjTu44
 VqPZtJbYxzfpTcPk3ZSeRamxCuHGLKo1cVhSKcczNZDvJaAL2myQ2gx/2cltWBoyD7yq
 pSwc4QboaKtkgjN6DsrQipuz/RFfA+FpYELVQBPfTCCg8GM0Zuj1JfdaQp7P0/PXYUI9
 rAcg==
X-Gm-Message-State: AOJu0YxP8HFhfLU4tEtat1bowYrs88CsH7qejRBENfBNdI13IDEoSBCT
 PhtT1XBRs0j84T6bpbPc61O5Fg==
X-Google-Smtp-Source: AGHT+IEhKp0dF5H6LQAJGb+asLo6YYQ/YuZ98NWhYm3ZQZzr2mHdbiSnhQXLdwus4+fmRuROJ+wKPw==
X-Received: by 2002:a05:6000:3c9:b0:324:e284:fab4 with SMTP id
 b9-20020a05600003c900b00324e284fab4mr3480973wrg.0.1695998385261; 
 Fri, 29 Sep 2023 07:39:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a056000009000b0031c71693449sm21729739wrx.1.2023.09.29.07.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:39:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FBCA1FFBB;
 Fri, 29 Sep 2023 15:39:44 +0100 (BST)
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-10-salil.mehta@huawei.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
Subject: Re: [PATCH 9/9] target/arm/kvm: Write CPU state back to KVM on reset
Date: Fri, 29 Sep 2023 15:39:32 +0100
In-reply-to: <20230929124304.13672-10-salil.mehta@huawei.com>
Message-ID: <87pm21nivj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Salil Mehta <salil.mehta@huawei.com> writes:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> When a KVM vCPU is reset following a PSCI CPU_ON call, its power state
> is not synchronized with KVM at the moment. Because the vCPU is not
> marked dirty, we miss the call to kvm_arch_put_registers() that writes
> to KVM's MP_STATE. Force mp_state synchronization.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Seems reasonable:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

