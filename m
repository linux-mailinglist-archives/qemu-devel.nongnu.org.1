Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B67B34ED
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:29:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmETW-0007a1-7f; Fri, 29 Sep 2023 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmETU-0007Zk-CR
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:28:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmETK-0008Iw-0M
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:28:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so124273235e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695997676; x=1696602476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3itf3/+8GRd88ZMuHIHWhAey4QvHjxYxukfH1t5Nkpo=;
 b=CDL/5eOJNmkGfx63r+Dg0uvzhVTr7TU+dk2P339J19W+gH92QHqaEdtqHkoGgTy9k2
 jppUHDaG34LtKi6wYRDwrqQ7uhXIrvf7lKkJQLuVAWDFj0lP6JxUnBwqp4ff6G9afiEc
 LH2lGGLfqIwHkosqE3wcLEwWoZNauJGY3D+4nWOkmK26jLlpc2IZ2OILbBtjrsuJvpxY
 sA6nyJ2Pj1ChRx7VxNh7mATjDrXy8bDXPsx4dGKOG5lRoX/PBMt3W3tBJoeoRUyjLbAx
 kDakjJ08VmyMO5n6yghZ3nePrLmraY6J2Q+B2e3gNVOqhNgbbAhvDBGSHrREBdTHcEZQ
 /VzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695997676; x=1696602476;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3itf3/+8GRd88ZMuHIHWhAey4QvHjxYxukfH1t5Nkpo=;
 b=Q1sM3Ljp5vaH3lrED98yEMpJ7O/4zNf4AF9em8gTorj/VjZEUdVwNTfEp0b/W7Ltg8
 4bGDHVRwEa4MdzIbSxh5dY5bJa5Qzc+KA2iIEAM9fIHlt1dy25EAenZFhGPAuzNDzHiS
 iC8uL7otXO+PaR3SsKsTLOm1LMx9yE2Sqsf/1pZeDOK42U/dYwXRtm1LzssURy/xEc4N
 VKF5uHP0cq07KvzrjV0EXGqI9R45+12sXJgu/F237LfaHhZ26KD+/Ap7Yigqxf3tMXI3
 PjAsLqciivhrvlmlXYg06mdltJDAV7Bd+7BCeOdDAwXyGzgzOOYsw/ZO4dJ4hoiyBM5K
 JlfQ==
X-Gm-Message-State: AOJu0Yzy0ph//y07gHfgWzUSjW2v7huexT8hE60wtJfmHviCxJsvWc9K
 2rNiBj6bT9Gy6zUk1JmmKzfPdA==
X-Google-Smtp-Source: AGHT+IE3SVlQN7EZBxd2Yf0iI4gUArlHPZ9cGMQr/P0vTtgbxt5g3GaxzZbrcH2xV7tJ/Xqrq62b3w==
X-Received: by 2002:a7b:c4d9:0:b0:405:4f8a:923d with SMTP id
 g25-20020a7bc4d9000000b004054f8a923dmr4228408wmk.20.1695997675707; 
 Fri, 29 Sep 2023 07:27:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x15-20020adfcc0f000000b0032330e43590sm10062587wrh.22.2023.09.29.07.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:27:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8B501FFBB;
 Fri, 29 Sep 2023 15:27:54 +0100 (BST)
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-4-salil.mehta@huawei.com>
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
Subject: Re: [PATCH 3/9] hw/acpi: Add ACPI CPU hotplug init stub
Date: Fri, 29 Sep 2023 15:27:27 +0100
In-reply-to: <20230929124304.13672-4-salil.mehta@huawei.com>
Message-ID: <87y1gpnjf9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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


Salil Mehta <salil.mehta@huawei.com> writes:

> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HO=
TPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_=
init()
> stub to avoid compilation break.

When does the compilation break? It's usually ok to include stubs with
that commit.

>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-s=
tub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent=
, Object *owner,
>      return;
>  }
>=20=20
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***li=
st)
>  {
>      return;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

