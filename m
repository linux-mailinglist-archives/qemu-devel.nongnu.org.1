Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D16027FBF61
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:43:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r81AM-0007MX-Ph; Tue, 28 Nov 2023 11:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r81AI-0007KN-Md
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r81AF-000885-Ny
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701189742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYzWN6N52VkWv+bl9tnSg8e+Cw0sVqiE4LaeFAa1jRM=;
 b=D+lX5dangZ5CdGUJKFv7g2jHZbOVbSWS+OU9Rh0XhUl0V67La8BCCTeF7r/4L/b5unkHpP
 ZMQogQvCjU7MzHUOg3ppWMSjv6G9xp0+WN9PmkvSojtUm++CKhTlg2cpFCTAEQSbYT24SH
 nrvgchMlMOcZk6oCXo+C6QoG6C2FONA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-VsIFAI2zPDKrPZOzNWDTzw-1; Tue, 28 Nov 2023 11:42:20 -0500
X-MC-Unique: VsIFAI2zPDKrPZOzNWDTzw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-548a12a78d4so4398493a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 08:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701189739; x=1701794539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYzWN6N52VkWv+bl9tnSg8e+Cw0sVqiE4LaeFAa1jRM=;
 b=QXFRLke8rtwdzbyKxGE6TCqqtzY74d0595qRegCsmEDpRoWd1kSMXeL4qZNx3iY3fp
 FBOjeLMXdjvOtXY2VcrN7Jpv1D/yHxAtRNdBb7Vbmv14hTcc6N19PD1MqTNnmO/HLLe3
 fMawi393QqtggvMF5S/siRGLZXPqhG24HK6zSscNSnn5rTG4+NxbPrQAumCvyZM+7KG2
 QyWptEehQRiAuakWeUeXMIrk/RL7qj6lXiMXnh4MulES1jtdewy6aepO4oqWioLv1u0x
 SONdTf8GQDjsqiHfxZDWtGm5V1iJOz4w1r5tfTjs0u3eRevDAztQZhY0lHBQUxE6ko5M
 3ECA==
X-Gm-Message-State: AOJu0Yy7caxWDXhgH3a52dkyr7p181lNizYEV8uoQ03OUphWZRsl/cEK
 s0VfPkqiZ5p4w/tc943NDScyODXqLixWWBx4K1v5+LS8/GH8KxcczjeniYNMnMKLVPVMqq7j4IH
 9X9D37akGvUhkkc8=
X-Received: by 2002:aa7:d658:0:b0:54b:1ca8:8522 with SMTP id
 v24-20020aa7d658000000b0054b1ca88522mr9152216edr.0.1701189739704; 
 Tue, 28 Nov 2023 08:42:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuCR51xQlaXfT1DtLVqShBUrl6jPUKl6a6hM6V6WTL909JVVBwIS9wTuJVmR0NaRBsGRV6uQ==
X-Received: by 2002:aa7:d658:0:b0:54b:1ca8:8522 with SMTP id
 v24-20020aa7d658000000b0054b1ca88522mr9152146edr.0.1701189739373; 
 Tue, 28 Nov 2023 08:42:19 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 cn6-20020a0564020ca600b0054b2a9dc69csm3931520edb.40.2023.11.28.08.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:42:18 -0800 (PST)
Date: Tue, 28 Nov 2023 17:42:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand
 <david@redhat.com>, Peter Xu <peterx@redhat.com>, Anton Johansson
 <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Marek Vasut <marex@denx.de>, David Gibson
 <david@gibson.dropbear.id.au>, Brian Cain <bcain@quicinc.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Claudio Fontana <cfontana@suse.de>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-ppc@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Aurelien
 Jarno <aurelien@aurel32.net>, Ilya Leoshkevich <iii@linux.ibm.com>, Daniel
 Henrique Barboza <danielhb413@gmail.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@kaod.org>, Alistair Francis <alistair.francis@wdc.com>, Alessandro Di
 Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Chris Wulff <crwulff@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, Yanan Wang
 <wangyanan55@huawei.com>, Luc Michel <luc@lmichel.fr>, Weiwei Li
 <liweiwei@iscas.ac.cn>, Bin Meng <bin.meng@windriver.com>, Stafford Horne
 <shorne@gmail.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, "Daniel P .
 Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>, Bernhard Beschow <shentey@gmail.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>, Michael Rolnik
 <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Markus
 Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 06/22] exec/cpu: Call cpu_remove_sync() once in
 cpu_common_unrealize()
Message-ID: <20231128174215.32d2a350@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230918160257.30127-7-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 18 Sep 2023 18:02:39 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> While create_vcpu_thread() creates a vCPU thread, its counterpart
> is cpu_remove_sync(), which join and destroy the thread.
>=20
> create_vcpu_thread() is called in qemu_init_vcpu(), itself called
> in cpu_common_realizefn(). Since we don't have qemu_deinit_vcpu()
> helper (we probably don't need any), simply destroy the thread in
> cpu_common_unrealizefn().
>=20
> Note: only the PPC and X86 targets were calling cpu_remove_sync(),
> meaning all other targets were leaking the thread when the vCPU
> was unrealized (mostly when vCPU are hot-unplugged).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/core/cpu-common.c  | 3 +++
>  target/i386/cpu.c     | 1 -
>  target/ppc/cpu_init.c | 2 --
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index a3b8de7054..e5841c59df 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -221,6 +221,9 @@ static void cpu_common_unrealizefn(DeviceState *dev)
> =20
>      /* NOTE: latest generic point before the cpu is fully unrealized */
>      cpu_exec_unrealizefn(cpu);
> +
> +    /* Destroy vCPU thread */
> +    cpu_remove_sync(cpu);
>  }
> =20
>  static void cpu_common_initfn(Object *obj)
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cb41d30aab..d79797d963 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7470,7 +7470,6 @@ static void x86_cpu_unrealizefn(DeviceState *dev)
>      X86CPUClass *xcc =3D X86_CPU_GET_CLASS(dev);
> =20
>  #ifndef CONFIG_USER_ONLY
> -    cpu_remove_sync(CPU(dev));
>      qemu_unregister_reset(x86_cpu_machine_reset_cb, dev);
>  #endif

missing  followup context:
    ...
    xcc->parent_unrealize(dev);=20

Before the patch, vcpu thread is stopped and onnly then
clean up happens.

After the patch we have cleanup while vcpu thread is still running.

Even if it doesn't explode, such ordering still seems to be wrong.

> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index e2c06c1f32..24d4e8fa7e 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6853,8 +6853,6 @@ static void ppc_cpu_unrealize(DeviceState *dev)
> =20
>      pcc->parent_unrealize(dev);
> =20
> -    cpu_remove_sync(CPU(cpu));

bug in current code?

> -
>      destroy_ppc_opcodes(cpu);
>  }
> =20


