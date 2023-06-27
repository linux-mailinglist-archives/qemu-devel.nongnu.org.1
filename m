Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCC73F5ED
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3MT-0005xR-VS; Tue, 27 Jun 2023 03:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE3ML-0005wH-Oh
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE3MK-0004ba-7b
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687851811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0MhEYloR0BYkYXG4ibAxX0xwlzTpW1u+g01Xv7K5Es=;
 b=R/ccfTHTnCmUz/G2jrcMLAZoI/fYgMVNMK9W4YO8GqQwN78oPrMIJh7a90W27R2y5pjDCk
 FsV3O2mEamtV1v8IQlrJMy0/XRAwT8yLeprMZOrzGrNTSPMAqPvDHHUGPwEeYFfi0aKEva
 mqFlhyL4yl1Dt/sru8aafIabwlz7awc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-H-K_aqlvP2GLaix9sVKo7w-1; Tue, 27 Jun 2023 03:43:29 -0400
X-MC-Unique: H-K_aqlvP2GLaix9sVKo7w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f9d7ff4b6aso25008645e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687851808; x=1690443808;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n0MhEYloR0BYkYXG4ibAxX0xwlzTpW1u+g01Xv7K5Es=;
 b=ETRD508jTQcU9adPZb0C0p6DCjUVXBc6jNbk9LCk12RHpaJY+/cFnzW/owTbD2cHUn
 3BlPbEiycyNzJrTxpUPXoZU6CajySco8sGlQ//LNj0N+qmV4E+OP0Pob5he+UpnDg0Xf
 Q7WATgiHwrpVx4ETytEuo1OPNVP4qxrtaDNegpx6X6uzLVrbSZUWVCn5XHD6BUZnhhCF
 htjensbRGVonLUKZZeTWTChNifrkpFGRXWymmU2fNEWGUVJp+R7WfSPqS0rGJ+bqspnv
 KXehu2XmeS2GPeUipySxHi1N7qTmrBk9LXqBRCIvENnzVMSiLLRj67Sj8nU4M5vmozKR
 lAYA==
X-Gm-Message-State: AC+VfDzd98d1sDO9CbBd4QMrxhdpIwYLHT219yQdROOBgosj8BVcoAdM
 c3nGsGd/S+Qqpy3V0ca+xBmFUoZPYv8htEoSx4fWJFxWSFREyONi5tp7Er9AqYWhTACAJCZIy+r
 THmIqhFLHZIa4McU=
X-Received: by 2002:a1c:7212:0:b0:3f5:146a:c79d with SMTP id
 n18-20020a1c7212000000b003f5146ac79dmr25514800wmc.15.1687851808687; 
 Tue, 27 Jun 2023 00:43:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ailfbybY75q/MrfgDLdpXdHf2ofeU91DqVzNBaDwgsufXC91jJ622QHPyucEfp0lW+DtGfA==
X-Received: by 2002:a1c:7212:0:b0:3f5:146a:c79d with SMTP id
 n18-20020a1c7212000000b003f5146ac79dmr25514754wmc.15.1687851808326; 
 Tue, 27 Jun 2023 00:43:28 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f9b24cf881sm12745516wma.16.2023.06.27.00.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:43:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexander Bulekov <alxndr@bu.edu>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alexandre Iooss
 <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Bandan
 Das <bsd@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,  Peter Xu <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Bin Meng <bmeng.cn@gmail.com>,  qemu-arm@nongnu.org,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 08/26] tests/qtests: clean-up and fix leak in
 generic_fuzz
In-Reply-To: <20230626215926.2522656-9-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 26 Jun 2023 22:59:08 +0100")
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-9-alex.bennee@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 09:43:26 +0200
Message-ID: <87h6qtcpup.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> An update to the clang tooling detects more issues with the code
> including a memory leak from the g_string_new() allocation. Clean up
> the code with g_autoptr and use ARRAY_SIZE while we are at it.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/qtest/fuzz/generic_fuzz.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_f=
uzz.c
> index c525d22951..a4841181cc 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>              .crossover =3D generic_fuzz_crossover
>      });
>=20=20
> -    GString *name;
> +    g_autoptr(GString) name =3D g_string_new("");
>      const generic_fuzz_config *config;
>=20=20
> -    for (int i =3D 0;
> -         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
> -         i++) {
> +    for (int i =3D 0; i < ARRAY_SIZE(predefined_configs); i++) {
>          config =3D predefined_configs + i;
> -        name =3D g_string_new("generic-fuzz");
> -        g_string_append_printf(name, "-%s", config->name);
> +        g_string_printf(name, "generic-fuzz-%s", config->name);
>          fuzz_add_target(&(FuzzTarget){
> -                .name =3D name->str,
> +                .name =3D g_strdup(name->str),
>                  .description =3D "Predefined generic-fuzz config.",
>                  .get_init_cmdline =3D generic_fuzz_predefined_config_cmd=
line,
>                  .pre_fuzz =3D generic_pre_fuzz,

Once that you are here, what about?
(Yes, I didn't care about the ARRAY_SIZE) but you got the idea.

Reviewed-by: Juan Quintela <quintela@redhat.com>

To your proposal with/without the change that I proposse.

modified   tests/qtest/fuzz/generic_fuzz.c
@@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
             .crossover =3D generic_fuzz_crossover
     });
=20
-    GString *name;
     const generic_fuzz_config *config;
=20
     for (int i =3D 0;
          i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
          i++) {
         config =3D predefined_configs + i;
-        name =3D g_string_new("generic-fuzz");
-        g_string_append_printf(name, "-%s", config->name);
         fuzz_add_target(&(FuzzTarget){
-                .name =3D name->str,
+                .name =3D g_strdup_printf("generic-fuzz-%s", config->name),
                 .description =3D "Predefined generic-fuzz config.",
                 .get_init_cmdline =3D generic_fuzz_predefined_config_cmdli=
ne,
                 .pre_fuzz =3D generic_pre_fuzz,


