Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4450AD0343
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Jun 2025 15:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXBV-00021N-3W; Fri, 06 Jun 2025 09:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXB1-0001uD-U4
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXAv-0003xT-NE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaA9wd6AGUeKsA9MsczcRO+4cmfggMWFyWPdKnjVHGg=;
 b=LFbLPFvEZCn+gcQS0ht/7vJ52qYAaJlQqj/i6KF4UNvng6XMS3sUJSrUfI0FsxFDUm1WNh
 FRTn4nG8BXG/B7wetzoiTGum+NGWmjP2wH+d9wwbKLbwx/1FlJ78Q7zvkgm8s8nIdWhwI6
 P6X8zIrgXo4X47a6bxl+d6wQi4+IuIE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-KdupeaXJN06cBxB0a1PvBA-1; Fri, 06 Jun 2025 09:31:55 -0400
X-MC-Unique: KdupeaXJN06cBxB0a1PvBA-1
X-Mimecast-MFC-AGG-ID: KdupeaXJN06cBxB0a1PvBA_1749216714
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1856so991915f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216714; x=1749821514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaA9wd6AGUeKsA9MsczcRO+4cmfggMWFyWPdKnjVHGg=;
 b=B8m2exJG/HE/w2gaQivSgtGLWU3hCqRuv3VkAd6ggucaEuY+p87L4yhPwBlpg/XvJu
 VmxAKCkqgqsONeow+KLwu+Sc7ZLBlgfVDPpKQnpiZ2kMoDzgXHwPiXW6Sh3AuFJ7xInh
 kfTe4J89CAn4v3dAKahQZfCb2RIk6KY18plt33aXmeDwiKG91Fk6nMdu2WFLTHX4ea7G
 upLv3CsV0gOLpzA0YLUBf4I3ch0KiPIrvl2xZYPkNR6BUzSmfWLW6Rx6DMLCYlI3Y3BT
 gUrGRZqhUs0J6wN3OKzki95Qo1iV5lPELutoGE/i06dPtbAEL97OOTYtYchTQpxTnC1p
 RfqQ==
X-Gm-Message-State: AOJu0YxxflhkaLBWA7SPOmHaK6Avr/f6g2s+52gaR7ER54foVkQ0ASAh
 XWO0uXGeqqW27XPjai52NBfq1Cow8Vy3164LlN8Cpr5P8sKYh9heHr8AqSa71dfC0oAo3IBdpYW
 0NeJepEi/EUpLyA+dBvEVKiyRyDRAEDwVk8duUaOaejCeejN7pZVsl6ok
X-Gm-Gg: ASbGncsxLJ7JGTaRgx1s3YrWPBhz1OEvQkLrWY5eGUPEmwVsepPgJ3Sh75xt5IspW7B
 EXk7IWrjGEkGvnlb5tol5EkUzzif2jPIGFwUucFPC/7Z4xsD5m80Gj11s9IIhqW3lQXuXy6Zjdf
 c6LADmcZ7QczlcrxPXF5jPoJaKooE+uKHQcJ6Y5QC5wudCQcPf1JQnb6RUJwHNDKy9drBGCw04f
 vvT6/gK7JsxALzOj67SJ76zh7k0KJFlT1v4CMFdbuTQcCO63NCWTH7ZiAvhGN8Hr8+5upVkcrga
 axkyehCzJGdieJBAH8Ycu6C2Xmh9W9pp
X-Received: by 2002:a05:6000:18a5:b0:3a5:24a9:a5c2 with SMTP id
 ffacd0b85a97d-3a5314417admr3084571f8f.0.1749216714451; 
 Fri, 06 Jun 2025 06:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+0B6QQs6YeCGNMilN0Vgsc5FDrekyc4YguUGqXo4XBWBikzS9C9W+u7bdrMKFiTWMfp4pQQ==
X-Received: by 2002:a05:6000:18a5:b0:3a5:24a9:a5c2 with SMTP id
 ffacd0b85a97d-3a5314417admr3084468f8f.0.1749216713536; 
 Fri, 06 Jun 2025 06:31:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce132csm24469385e9.12.2025.06.06.06.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:31:53 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:31:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 15/18] hw/core/machine: Remove hw_compat_2_9[] array
Message-ID: <20250606153151.35435d64@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-16-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-16-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:53 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The hw_compat_2_9[] array was only used by the pc-q35-2.9 and
> pc-i440fx-2.9 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/boards.h | 3 ---
>  hw/core/machine.c   | 8 --------
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 84bd3735c42..513eb2a54fd 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -832,7 +832,4 @@ extern const size_t hw_compat_2_11_len;
>  extern GlobalProperty hw_compat_2_10[];
>  extern const size_t hw_compat_2_10_len;
> =20
> -extern GlobalProperty hw_compat_2_9[];
> -extern const size_t hw_compat_2_9_len;
> -
>  #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bc0606cf740..486d1adb4b9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -244,14 +244,6 @@ GlobalProperty hw_compat_2_10[] =3D {
>  };
>  const size_t hw_compat_2_10_len =3D G_N_ELEMENTS(hw_compat_2_10);
> =20
> -GlobalProperty hw_compat_2_9[] =3D {
> -    { "pci-bridge", "shpc", "off" },
> -    { "intel-iommu", "pt", "off" },
> -    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
> -    { "pcie-root-port", "x-migrate-msix", "false" },
> -};
> -const size_t hw_compat_2_9_len =3D G_N_ELEMENTS(hw_compat_2_9);
> -
>  MachineState *current_machine;
> =20
>  static char *machine_get_kernel(Object *obj, Error **errp)


