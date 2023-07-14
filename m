Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E675407A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMc0-0007pN-AM; Fri, 14 Jul 2023 13:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMby-0007pB-N1; Fri, 14 Jul 2023 13:29:46 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMbw-0001yx-UV; Fri, 14 Jul 2023 13:29:46 -0400
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1b9cdef8619so14032895ad.0; 
 Fri, 14 Jul 2023 10:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689355783; x=1691947783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=difvMnBSuQrJtvq3RtGwLG2K62Vb8ARiWNGBmRGg2PY=;
 b=We6lxzVjfSbKKtCsXCrwlg8+XMHdmUcfTlm3ZrWXyC7F795ME+hSNtsR0EJEgNMDwF
 YpA+VDvKL1P3OHUVe0TDP8qLRcFafUtYgqBu18Tk9qtnKl/rjP8Dh7A3FdxX2IqyTrBj
 b8p+3XENhl2hR2PT7Xzqi58xORStYwx/sEfWx1j8jOQAKFgW6JdDR3f5WGPqdCWDolvb
 MT9AGpzp8Ni9aXJrdtBRnt3cDE5Zi+bxRIV3zzS9XLZIRWrkAuUWnBlRaa5HOIhCJidE
 CP8HJJ6t25XyTTqaBdYc7+kmbCQt2Qsg79OYEJKFWvukswv+ge4UP8LkdB8E8Zm4jM4v
 BoUw==
X-Gm-Message-State: ABy/qLafNJai5EMWOe37kjr/YcYl89yU394NYpG7Rcy9gdqBt0iyCg2X
 ViUbJ6zCpwGm9Mu74yVKzunIJJavcJWpHg==
X-Google-Smtp-Source: APBJJlHVa4+OmB2AsCJdJuVLUu9OukMGP94YQo68e9r4I2jF8gG3D34Lk88R3sBf7YO7iG9P1AtYFg==
X-Received: by 2002:a17:902:bd94:b0:1b8:1e05:ed09 with SMTP id
 q20-20020a170902bd9400b001b81e05ed09mr3799049pls.36.1689355782995; 
 Fri, 14 Jul 2023 10:29:42 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com.
 [209.85.216.47]) by smtp.gmail.com with ESMTPSA id
 p2-20020a170902eac200b001b9e8e833f3sm8044979pld.61.2023.07.14.10.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 10:29:42 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2637ab3d8efso1247463a91.3; 
 Fri, 14 Jul 2023 10:29:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4c89:b0:267:717f:2f91 with SMTP id
 my9-20020a17090b4c8900b00267717f2f91mr1562300pjb.40.1689355782539; Fri, 14
 Jul 2023 10:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-10-j@getutm.app>
 <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
In-Reply-To: <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 14 Jul 2023 10:29:31 -0700
X-Gmail-Original-Message-ID: <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
Message-ID: <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to
 device
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 Song Gao <gaosong@loongson.cn>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f180.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 14, 2023 at 9:19=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
>
> I don't know whether we would want multiple devices. tpm_find() usage is =
certainly not prepared for multiple devices.
Sorry, "multiple TPM interfaces" here does not mean "at the same
time". Will clarify the description.

>
>
> Good for the consolidation.
>
>
> Does moving the TIS to a different address help on aarch64?
That was the first thing we tried and no it doesn't help.
>
> Can the size really be an option? I don't see it useful and if one gave t=
he wrong size it may break things.
It was added for consistency (otherwise we have to determine the size
by looking at the interface everywhere). Also, it is possible for the
size to be larger than the constant. For example, Apple Silicon uses
16KiB page sizes and we may decide to force the device to be 16KiB
aligned (not sure if this is needed yet while we still track down why
the dual mapping was not working). In that case, we would need to
inform the OS of the true region size to prevent any overlap issues.
Both baseaddr and size should be provided only by the plug handler in
the virt machine, otherwise things may break even if we get rid of
size and have just an incorrect baseaddr.

>
>
>

