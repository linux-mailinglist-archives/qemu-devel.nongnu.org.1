Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC9711E7F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 05:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2OHZ-0004Kc-1f; Thu, 25 May 2023 23:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <helei.sig11@bytedance.com>)
 id 1q2OHW-0004KE-5H
 for qemu-devel@nongnu.org; Thu, 25 May 2023 23:38:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <helei.sig11@bytedance.com>)
 id 1q2OHR-0002ZI-9w
 for qemu-devel@nongnu.org; Thu, 25 May 2023 23:38:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b00f9c4699so1754695ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685072290; x=1687664290;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfiXV56UR5YcLYk/dwMoW2NczIUtVeHVSPEW7EFcEGo=;
 b=G2v2AsjNB7WSckxXT7sXDYzJXFjbCnJLQGTTuYXtCFYfuJlc7KQl7j0NzD16rt36NJ
 nxQ2mzF32n+aHhQ9071jhe56NIwFQnjlm0TWSOO7m5MqMDYhsvCJInYZzv3VS2mCIkyc
 zUh+ljYxLQrvM8qsX2m3gJpl9zUD98EIMLAXJ5Ld57IiJ+jP0npSHMU2DfYJCLKNio79
 DEI0EuYQRB4D54LRUxWY3r3sCsw3/MIoxMW0jUm69zZ325/UJZdvzrw3RCihFyGmrhPX
 uPN0dmAYtq95GbN/MMKUqbpfOk4ZljZSBETEFRVPgkAAjc6b1dywLp3xbdNe6HBfoOUQ
 mNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685072290; x=1687664290;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfiXV56UR5YcLYk/dwMoW2NczIUtVeHVSPEW7EFcEGo=;
 b=WFkvnNXLLDMH/KqTgtIm4YOS4vvguYM2uO1sfbyx3KjQMrdCOEmfog210i0Hves6a4
 5jsMZlY4E4loLPFn01fQudA8k7pEWf8sCHcnHHpgws88gA+hWsOmeiXXIpT65JNFLM3E
 EzAf1kruIJBFfSXVonXzfA9VO0l/+A3MpKxIbxCCyPs/1yzm+8exb/bCmNJroWKa22II
 h/e1zLysm9BPS5Wc31gza/RpQl81JHCw7elnsSmP+pDpoSbuvdJupNZa2XmcemS+PA2s
 VCv8yxD0CfaMxqoQNGkdcrlKmqUGnXkMUBSlIwKhJGyC1u+7TvzXbEgtgiPxoYUCtHPb
 kL6w==
X-Gm-Message-State: AC+VfDwSLbUersUQhqqyK/n48MfLyB/IrHT1xuQ9cRZwL68W3/sAPpqZ
 vLlXpGRKMVmcjHkijxvee+L+Uw==
X-Google-Smtp-Source: ACHHUZ6AbXVOcZuVX/wYn3vuFfuKlLsKlVJXMDPgALOYNPzrj2LAIgLavKVATvX30BSrrvUIbniWDQ==
X-Received: by 2002:a17:902:ce05:b0:1ad:f7d9:1ae2 with SMTP id
 k5-20020a170902ce0500b001adf7d91ae2mr1110149plg.55.1685072290025; 
 Thu, 25 May 2023 20:38:10 -0700 (PDT)
Received: from smtpclient.apple ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm2086545plg.305.2023.05.25.20.38.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 May 2023 20:38:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] cryptodev: Handle unexpected request to avoid crash
From: Lei He <helei.sig11@bytedance.com>
In-Reply-To: <20230427080509.172477-1-pizhenwei@bytedance.com>
Date: Fri, 26 May 2023 11:38:04 +0800
Cc: Lei He <helei.sig11@bytedance.com>, mst@redhat.com,
 arei.gonglei@huawei.com, qemu-devel@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Xiao Lei <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4856378-68F6-440B-A0C8-B13EEEF452BC@bytedance.com>
References: <20230427080509.172477-1-pizhenwei@bytedance.com>
To: zhenwei pi <pizhenwei@bytedance.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=helei.sig11@bytedance.com; helo=mail-pl1-x636.google.com
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


> On Apr 27, 2023, at 16:05, zhenwei pi <pizhenwei@bytedance.com> wrote:
>=20
> Generally guest side should discover which services the device is
> able to offer, then do requests on device.
>=20
> However it's also possible to break this rule in a guest. Handle
> unexpected request here to avoid NULL pointer dereference.
>=20
> Fixes: e7a775fd ('cryptodev: Account statistics')
> Cc: Gonglei <arei.gonglei@huawei.com>
> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> Cc: Xiao Lei <nop.leixiao@gmail.com>
> Cc: Yongkang Jia <kangel@zju.edu.cn>
> Reported-by: Yiming Tao <taoym@zju.edu.cn>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
> backends/cryptodev.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index 94ca393cee..d3fe92d8c0 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -191,6 +191,11 @@ static int =
cryptodev_backend_account(CryptoDevBackend *backend,
>     if (algtype =3D=3D QCRYPTODEV_BACKEND_ALG_ASYM) {
>         CryptoDevBackendAsymOpInfo *asym_op_info =3D =
op_info->u.asym_op_info;
>         len =3D asym_op_info->src_len;
> +
> +        if (unlikely(!backend->asym_stat)) {
> +            error_report("cryptodev: Unexpected asym operation");
> +            return -VIRTIO_CRYPTO_NOTSUPP;
> +        }
>         switch (op_info->op_code) {
>         case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
>             CryptodevAsymStatIncEncrypt(backend, len);
> @@ -210,6 +215,11 @@ static int =
cryptodev_backend_account(CryptoDevBackend *backend,
>     } else if (algtype =3D=3D QCRYPTODEV_BACKEND_ALG_SYM) {
>         CryptoDevBackendSymOpInfo *sym_op_info =3D =
op_info->u.sym_op_info;
>         len =3D sym_op_info->src_len;
> +
> +        if (unlikely(!backend->sym_stat)) {
> +            error_report("cryptodev: Unexpected sym operation");
> +            return -VIRTIO_CRYPTO_NOTSUPP;
> +        }
>         switch (op_info->op_code) {
>         case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
>             CryptodevSymStatIncEncrypt(backend, len);
> --=20
> 2.34.1
>=20

Reviewed-by: Lei He <helei.sig11@bytedance.com>


Best regards,
Lei He
--
helei.sig11@bytedance.com




