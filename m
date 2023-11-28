Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE87FBE8D
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:52:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80Mk-000605-Fi; Tue, 28 Nov 2023 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r80Mh-0005y0-DM
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r80Md-0007lu-U9
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701186667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7TaJ1fftDKYLjchnWgAH2T0JUqr3+5SdVc0/8Z4EIs=;
 b=cwM37Fq3LNEvtgAQnCwxpUZWpeMtth9bpanBnZLB+loi5ELGAD0dPe5FIUGPmP3o1Dlzir
 NvMxGr8neDLr1n9/FQg/9SdU8tjXTFhkgaR6r0gJzWaSW7AoZq89VZnGrZDW2kXe1gPxLJ
 NHE4Sy01MvwnQJvNNb/r/9+6SATpKu4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-h4pV1DGcOeWcjSwxnQqY3w-1; Tue, 28 Nov 2023 10:51:05 -0500
X-MC-Unique: h4pV1DGcOeWcjSwxnQqY3w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a15ce298cf4so66043366b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701186663; x=1701791463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7TaJ1fftDKYLjchnWgAH2T0JUqr3+5SdVc0/8Z4EIs=;
 b=C6nKxVDUZFFDXPK+5MSiA7NgkM/1UORuOCeuoarCpP7GjmTvYGCneuYG5cacJVVeZG
 7Nup7OXFjU/iR0KxKQYMCdtWp9eO8ys1RGOHCklDBSOFmLF46+B9FKnkiMkVWxwL+BKW
 INwCPh027pWfaZsX7q+2lI0YOpNh1xzUe00isZ/LvJwSzuvMHBf9AnKW/OLc0YWGeIyu
 zITlgcz24njMWq60DUMVQPiLtKLKZ8+jXrP16iUdWdnoWODt7n49sphLuIz1qcURuT/P
 VjZL1GktrFiXdUzeftpeIeVdv7GRvnwCsm76Xfd5NsIDbpn2odWqILO7Elrad+R92y0Y
 li9A==
X-Gm-Message-State: AOJu0Yxxe+FLAGU61V1fW82OOy2gjpw/HJv7T17w/E7NsSGpr0U/anH6
 GJ1XT1AvGtcyPB9GwXSlTzr3vQidDW3pD3kD0IIdNpV1suGAqXM4qdLlhLwybW8vtOPTYkyxyXD
 C99clWtvf7fAXpm8=
X-Received: by 2002:a17:906:eb08:b0:9fd:5708:cefd with SMTP id
 mb8-20020a170906eb0800b009fd5708cefdmr10544105ejb.76.1701186662902; 
 Tue, 28 Nov 2023 07:51:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb0zDYECHV55FNXL39hwvytpLNp50WfqgLZLPXS6enMvDKVaq+r28r7KsslsxMoD0RVFay7w==
X-Received: by 2002:a17:906:eb08:b0:9fd:5708:cefd with SMTP id
 mb8-20020a170906eb0800b009fd5708cefdmr10544093ejb.76.1701186662648; 
 Tue, 28 Nov 2023 07:51:02 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 cd19-20020a170906b35300b009ff783d892esm7045461ejb.146.2023.11.28.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 07:51:02 -0800 (PST)
Date: Tue, 28 Nov 2023 16:50:59 +0100
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
Subject: Re: [PATCH 03/22] target/i386/kvm: Correct comment in
 kvm_cpu_realize()
Message-ID: <20231128165059.0d991a0c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230918160257.30127-4-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 18 Sep 2023 18:02:36 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/kvm/kvm-cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 7237378a7d..1fe62ce176 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -37,6 +37,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **err=
p)
>       *  -> cpu_exec_realizefn():
>       *            -> accel_cpu_realizefn()
>       *               kvm_cpu_realizefn() -> host_cpu_realizefn()
> +     *  -> cpu_common_realizefn()
>       *  -> check/update ucode_rev, phys_bits, mwait
>       */
>      if (cpu->max_features) {


