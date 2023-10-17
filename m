Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EDC7CBDED
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfdU-0006jK-42; Tue, 17 Oct 2023 04:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qsfdP-0006io-EG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qsfdN-0007p6-Pc
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697532060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDs2EX5SkqwVC7GQjOfbUiIG7y7fTVk46ReLRuHBUbQ=;
 b=MfupZxvf1+lvJru27XnbZCxBccsNd5z12RTmMe2Vl5kLqA1lCaSBs4I2UDEzOCoGD3Q6pf
 D/jxNWJs9X1amGdMpN/w3Ek4MMleCe160FAF4y760RXe5PzKJqQvjlby8s+VHrG7K7Za6l
 cx0+pDDEyXsuhIKDDXMThGZIxhSKCmo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-oewB3eBpOveWPdSF1PpeMQ-1; Tue, 17 Oct 2023 04:40:42 -0400
X-MC-Unique: oewB3eBpOveWPdSF1PpeMQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-27d0ae627e7so3985514a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 01:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697532042; x=1698136842;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDs2EX5SkqwVC7GQjOfbUiIG7y7fTVk46ReLRuHBUbQ=;
 b=xTgbZM6AWqlnSrnAD3PvPId+1NQ3IDEjTk2Lj0wYqVO0fWyjPYFWNw4MuHrEwggM/A
 /jAVW7tRlDubc82pVzoaU3RCj8USDsIr8wyMNow/CxtDDO/MQNjMeg2Tlap/5IndYfut
 vHwQg8T20rcEIsbvTMcQvGXyb96Pm76Gz9xBEXwnMF9ZDzuaIacY6UDZ3aQX7PqiHQ/K
 EjmSk5sFuGBbkBdzM7E2O/IxjB7A1+lAgYNJ7bBkjgpeJMs/CtzpzsnFXFMKeqIYrtPB
 Y6R0ofQShHHTmA3GkfglytIvPygej+wxIhhubb4/phPwCgmMKHAkVBoOZkJHibE1UplF
 YHgg==
X-Gm-Message-State: AOJu0YxMBfe8d4BsgcmzdfiNRbZxoM2fFnlaS95CzOHFXDogIstp9gcv
 r5Y1wNkizdrxraIgA50Ao22cjEsUgvyBlX61tP+MxmkSdDn79Tjg03PVzAEUSF2Bu/BDFzoH+jO
 Ir5rlaKrK+dy4mws=
X-Received: by 2002:a17:90a:1c3:b0:27d:9f6:47b1 with SMTP id
 3-20020a17090a01c300b0027d09f647b1mr1367813pjd.33.1697532041757; 
 Tue, 17 Oct 2023 01:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRq6TmGZF6ZdxEiUISt4JrFnPCK/zOA+XV3sor5/yDK3H+N/a7eM74lw+9mppVQDITAs1mkA==
X-Received: by 2002:a17:90a:1c3:b0:27d:9f6:47b1 with SMTP id
 3-20020a17090a01c300b0027d09f647b1mr1367799pjd.33.1697532041331; 
 Tue, 17 Oct 2023 01:40:41 -0700 (PDT)
Received: from smtpclient.apple ([115.96.152.97])
 by smtp.gmail.com with ESMTPSA id
 5-20020a17090a034500b0027cf4c554dasm6506042pjf.11.2023.10.17.01.40.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Oct 2023 01:40:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [RFC PATCH v3 09/78] hw/acpi/aml-build.c: add fallthrough
 pseudo-keyword
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <4e765b488f59391b94da71a7cbaaebedc3a0a18f.1697186560.git.manos.pitsidianakis@linaro.org>
Date: Tue, 17 Oct 2023 14:10:34 +0530
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B015E80-A088-4F15-B6E5-1A71C603AB50@redhat.com>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <4e765b488f59391b94da71a7cbaaebedc3a0a18f.1697186560.git.manos.pitsidianakis@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 13-Oct-2023, at 2:15 PM, Emmanouil Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>=20
> Signed-off-by: Emmanouil Pitsidianakis =
<manos.pitsidianakis@linaro.org>

What was wrong with QEMU_FALLTHROUGH?=20
https://www.mail-archive.com/qemu-devel@nongnu.org/msg996916.html does =
not explain and there is no commit message that justifies the change.

Other than that,

Reviewed-by: Ani Sinha <anisinha@redhat.com>


> ---
> hw/acpi/aml-build.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index af66bde0f5..b0cf0c6073 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -326,17 +326,16 @@ build_prepend_package_length(GArray *package, =
unsigned length, bool incl_self)
>         byte =3D length >> PACKAGE_LENGTH_4BYTE_SHIFT;
>         build_prepend_byte(package, byte);
>         length &=3D (1 << PACKAGE_LENGTH_4BYTE_SHIFT) - 1;
> -        /* fall through */
> +        fallthrough;
>     case 3:
>         byte =3D length >> PACKAGE_LENGTH_3BYTE_SHIFT;
>         build_prepend_byte(package, byte);
>         length &=3D (1 << PACKAGE_LENGTH_3BYTE_SHIFT) - 1;
> -        /* fall through */
> +        fallthrough;
>     case 2:
>         byte =3D length >> PACKAGE_LENGTH_2BYTE_SHIFT;
>         build_prepend_byte(package, byte);
>         length &=3D (1 << PACKAGE_LENGTH_2BYTE_SHIFT) - 1;
> -        /* fall through */
>     }
>     /*
>      * Most significant two bits of byte zero indicate how many =
following bytes
> @@ -528,6 +527,7 @@ void aml_append(Aml *parent_ctx, Aml *child)
>          */
>         build_append_byte(buf, 0);
>         /* fall through, to pack resources in buffer */
> +        fallthrough;
>     case AML_BUFFER:
>         build_buffer(buf, child->op);
>         break;
> --=20
> 2.39.2
>=20


