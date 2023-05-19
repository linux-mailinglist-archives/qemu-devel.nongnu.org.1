Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B9770985B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 15:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q00Cr-0004Rg-18; Fri, 19 May 2023 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q00Cp-0004P1-Gi
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:31:39 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q00Cn-0005gt-Su
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:31:39 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-965ab8ed1c0so516861166b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684503095; x=1687095095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m58E9ezTP8ik5vQQkXe/DA0gml36NE6R89Em8nZVOJM=;
 b=v88tRm+hnI8aChmeD54MyjMeGP9zTjwn0dzGhUUaIck6QLQyJdcxWE3e8r/ALSANI9
 557+rckku9kY9eFJ281ZJ7Z5FcQIXDTDtfjhvuoVaqTTFKK30Utowh8iVghWK//NGMMi
 fRlmdYY2MdrGn0Xk+Z5maeY8CgBJIBzKDiX30TvQ6p35gmEDPHIrGhYsZnd6ydkYOQkN
 G0y47QRidmwWjxQ9Ct1HhgiG9+Ut+iC2A4EC5Kv+SqUbLMCTdmHdgXolsXUpl4RXrc8Z
 EEJGwYAENb1/XjA+8/3jRp/Yige/7HmGO6rs6+2hhsagObjMwH2b/XGqJMinHhKl8ee9
 PvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684503095; x=1687095095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m58E9ezTP8ik5vQQkXe/DA0gml36NE6R89Em8nZVOJM=;
 b=TLR9PNYD4E43U/YSUR34sTw8E/WVNdfcyWPbhuN9MaH0wO4ZQ2lNaszklYLZm5BU1E
 zs+U+lZuQaaVMBqQmbGTerr4EgPNrANynyyCu77SBlvxKSofOrkokZNP5mIIQudlm6Y7
 rDMt6i+bdqCA2bW4ZOK0TLBIZg8CumIgvjjLtbVLQMTQYefSSoK3esV7YtN0Zk/N4YqM
 pxqGL6uPvxdwBbUk2gl6QIa6tOUglbcMiVwC7u1AM8vuDfNh/JGqykKpl/0KqvM5fyPd
 4U155Yrh10F3FCjSirNWP6vqDHSSjyDakOFoEjVx8UcFRMOpiwPSQAkXlpQ3Y06fVdTN
 jCmw==
X-Gm-Message-State: AC+VfDzqwSgk/zEvJlrDdPHcD18h4l9fQTN8OikIUaVZRatttSeU5HJZ
 CCs1K2biZVBcTYC23S9sdCW0kcOE00mCIe6s9XRavQ==
X-Google-Smtp-Source: ACHHUZ5yAUnFUf/CAPk8CSlStxMUfadsTxWlk67qfZ8xnDcA/KVj7HOFi5CQ40AzAt+/e3+uu/IT0bMRlseOaZIJLI4=
X-Received: by 2002:a17:906:5f89:b0:96a:ad45:fd51 with SMTP id
 a9-20020a1709065f8900b0096aad45fd51mr1508446eju.27.1684503095580; Fri, 19 May
 2023 06:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230518125107.146421-1-peter.maydell@linaro.org>
 <20230518125107.146421-5-peter.maydell@linaro.org> <878rdklbu2.fsf@linaro.org>
In-Reply-To: <878rdklbu2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 14:31:24 +0100
Message-ID: <CAFEAcA_4ovPWkNw=KNVicD35SzJcQhi4Najt8cS3GSa-TLroKA@mail.gmail.com>
Subject: Re: [PULL 04/29] arm/kvm: add support for MTE
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Fri, 19 May 2023 at 13:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > From: Cornelia Huck <cohuck@redhat.com>
> >
> > Extend the 'mte' property for the virt machine to cover KVM as
> > well. For KVM, we don't allocate tag memory, but instead enable the
> > capability.
> >
> > If MTE has been enabled, we need to disable migration, as we do not
> > yet have a way to migrate the tags as well. Therefore, MTE will stay
> > off with KVM unless requested explicitly.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-id: 20230428095533.21747-2-cohuck@redhat.com
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I bisected to this commit which causes a segfault on one of my test
> kernels (6.3.2 arm64):
>
>   =E2=9E=9C  ag MTE .config
>   486:CONFIG_ARM64_AS_HAS_MTE=3Dy
>   487:CONFIG_ARM64_MTE=3Dy
>   2949:CONFIG_WLAN_VENDOR_ADMTEK=3Dy
>   3573:# CONFIG_I2C_SIMTEC is not set
>   5278:# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
>   9749:CONFIG_ARCH_USE_MEMTEST=3Dy
>   9750:CONFIG_MEMTEST=3Dy

Try this entirely untested patch?

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f6a88e52ac2..f350661a928 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1593,6 +1593,15 @@ static void arm_cpu_realizefn(DeviceState *dev,
Error **errp)
         }
     }

+    /*
+     * For TCG, we can only present MTE to the guest if the board gave us
+     * tag RAM. Set has_mte appropriately so code below doesn't need to
+     * care whether we're TCG or KVM when deciding if MTE is present.
+     */
+    if (tcg_enabled() || qtest_enabled()) {
+        cpu->has_mte =3D cpu->tag_memory !=3D NULL;
+    }
+
     if (!tcg_enabled() && !qtest_enabled()) {
         /*
          * We assume that no accelerator except TCG (and the "not really a=
n

(Signed-off-by: Peter Maydell <peter.maydell@linaro.org> if it
works and you want to turn it into a proper patch...)

-- PMM

