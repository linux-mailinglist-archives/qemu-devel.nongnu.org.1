Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6741766EEA
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNY9-0003Yp-0c; Fri, 28 Jul 2023 09:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNXu-0003WD-7j
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNXq-0000wE-Fw
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690551013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTVEzCWPYe+YPNzwnA7eOOgWdDBARgvTLKN944Ycb70=;
 b=XDYpoM4OtDsx+BVmJJSv0cztPPR2Fyn40QHZkiZZL9UDDgPiw8iXwcDSroxyHMzVMiUVYD
 DSSzvQe/uOnANxmgjYZuH189gEXVY++8DLha23OR7jA4bj6Et+ug5Cs0AimXhjhG/47/Il
 xLmmUiJt1kaX7Mz441k50rPRAq8/N4s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-4JX0w_L_OpK5w7rGvZt5vA-1; Fri, 28 Jul 2023 09:30:11 -0400
X-MC-Unique: 4JX0w_L_OpK5w7rGvZt5vA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98e1085308eso408205666b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690551011; x=1691155811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTVEzCWPYe+YPNzwnA7eOOgWdDBARgvTLKN944Ycb70=;
 b=JIk1rt1n+UwNWUfM8uTE08osgJgNmaVuAXJKhIzvzzpMOeYQG8Kwj24nFciV+LpPFt
 wS+U+7apixnFPKxrCdo3gWAKJaacjPfs2m4AFzfKm/wXfaXYgQUjeEavxrhuundf37vZ
 piak1frjd37AABP2GMUxjppHkdWF6RcM1BT1ZEwubfhtLgihrG6ajgsHLnJQvGdxCkTB
 Qhzp4FoNtw4uS1Fdgjtwd42Mss28qk4/+qZO7M224xEYxR054l/dBJ/e1m+GeIf5rqVo
 ppXwDEGx2iD2rT8l4IdNTwZbwYHT5BbLV0/AqIo7zOKVg1taNhXzy/vVRRjAAVZQWeV0
 5nug==
X-Gm-Message-State: ABy/qLYk4pB8fMCDK7D2Z4vyd4i101am1O4La9tx+8kbSXbpQew7dmw2
 YnFk8Z7v+jKNlRB265BgCYlYSEZ0sXS5nZgVnDat/7FcHrfYwt4JeWPZHAsNIufLl7N6CDGxzgY
 EwipizvTanPGlQ9I=
X-Received: by 2002:a17:907:9621:b0:992:103c:43fa with SMTP id
 gb33-20020a170907962100b00992103c43famr7117663ejc.30.1690551010879; 
 Fri, 28 Jul 2023 06:30:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVS/k3VUbtObQ5KchIGgUyDtkphvBOanbR6diOoG6heguh6Zo1oL824kgC00kYg3D52ElMUw==
X-Received: by 2002:a17:907:9621:b0:992:103c:43fa with SMTP id
 gb33-20020a170907962100b00992103c43famr7117632ejc.30.1690551010584; 
 Fri, 28 Jul 2023 06:30:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 m15-20020a17090607cf00b00993159ce075sm2038968ejc.210.2023.07.28.06.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:30:09 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:30:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song
 Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 8/8] Turn on CPU hot-(un)plug customization for loongarch
Message-ID: <20230728153009.2e4c3667@imammedo.users.ipa.redhat.com>
In-Reply-To: <bd2121db4e4a54b408f2cfef82132fcccd972257.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <bd2121db4e4a54b408f2cfef82132fcccd972257.1689837093.git.lixianglai@loongson.cn>
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

On Thu, 20 Jul 2023 15:15:13 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> Turn on CPU hot-(un)plug custom for loongarch in the configuration file
>=20
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  configs/devices/loongarch64-softmmu/default.mak | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/devices/loongarch64-softmmu/default.mak b/configs/de=
vices/loongarch64-softmmu/default.mak
> index 928bc117ef..e596706fab 100644
> --- a/configs/devices/loongarch64-softmmu/default.mak
> +++ b/configs/devices/loongarch64-softmmu/default.mak
> @@ -1,3 +1,4 @@
>  # Default configuration for loongarch64-softmmu
> =20
>  CONFIG_LOONGARCH_VIRT=3Dy
> +CONFIG_ACPI_CPU_HOTPLUG=3Dy
this likely shall be part of prior patch (one that starts to use generic cp=
u hotplug functions)
otherwise you risk a broke bisection in the middle of series
(aka try to build series after applying each patch)


