Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F37D8EF4
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:52:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGgs-0003Hr-PS; Fri, 27 Oct 2023 02:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwGgq-0003HV-E9
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwGgp-0007xS-2H
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698389486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDO6Y9QmPRkin3r3dJJ8UlQnwVoKYtfn0f9YwsW8sR8=;
 b=PvQnyVE9xG672HsaKjdDlxErrppgtIsRO10IZLFSyaDfJNAbVeP/kkI/rkhsIuSRDNoAyN
 B9vCb1fFaemqcIKgh0O+q7YR1ABkK7REW31vehxm+QAjiyD7dpsJ6BXvjypSLOYW0T8phI
 DgDCtUUNXS3WK88RNlKaD5lU/8XkuAs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-NCVqmktAPSW6LlsDfC5I1Q-1; Fri, 27 Oct 2023 02:51:24 -0400
X-MC-Unique: NCVqmktAPSW6LlsDfC5I1Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5a31f85e361so1465317a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 23:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698389483; x=1698994283;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDO6Y9QmPRkin3r3dJJ8UlQnwVoKYtfn0f9YwsW8sR8=;
 b=ipc7Hw+pxUn/yJp7vpMjYCALQsxet/JQlwkAGG/YWl+E8V+Wygjbqn0prFDrwXYng7
 stH0N4ToQDKpASMTRTguxRtkrp6yWGgjJjeIZqIftlqWVkkgf5Cz5w500+TcG9Nl0zr7
 cCrGh00u85MCL/ZKfHQqdfIqEA7MCZN0pX2JUzqw+NUWO5huBMtiCtHSyzOpD3T8kNgw
 0/kN4v3BDCxQL53KESVE0OdKr4NAvd41WUYgOlm8CxzcvO+s8m/i3nM1Pr5hZ3M970E2
 Pie3natjrw/2rASer3J/qZGCp/0/ZZIQogyI+X3lV5sqlkG+/MU4ZLJq6R+4vXjQxSdj
 xGaA==
X-Gm-Message-State: AOJu0Yxe5/Z5dQSqPzQgMFHf+TWhcpYFYywZ6TzhGP969tGAV+PPcTyo
 hpfquU8fsOS04+KWYLtNcOO1GS3IqWnz/XoQdIPefcp/Ki1jpDK0IOFsOV2V9u4YHWsdRXceSyy
 jOYjVbg/gz4zYaZo=
X-Received: by 2002:a17:90a:208:b0:27d:22d7:9787 with SMTP id
 c8-20020a17090a020800b0027d22d79787mr1713631pjc.36.1698389483131; 
 Thu, 26 Oct 2023 23:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhmgd09m8U/xYyK2CQxrX2ld+sYeb3VRAhq+LrxyIN7+QEub99IrfqwX1NHKRpKjsQVx2Iow==
X-Received: by 2002:a17:90a:208:b0:27d:22d7:9787 with SMTP id
 c8-20020a17090a020800b0027d22d79787mr1713623pjc.36.1698389482760; 
 Thu, 26 Oct 2023 23:51:22 -0700 (PDT)
Received: from smtpclient.apple ([115.96.30.106])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a035b00b00268b439a0cbsm660772pjf.23.2023.10.26.23.51.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Oct 2023 23:51:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] tests: Fix printf format string in acpi-utils.c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
Date: Fri, 27 Oct 2023 12:21:17 +0530
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C05C01CC-D86C-4900-A173-C38EDE3FFFF4@redhat.com>
References: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 27-Oct-2023, at 8:39 AM, zhujun2 <zhujun2@cmss.chinamobile.com> =
wrote:
>=20
> Inside of acpi_fetch_table() arguments are
> printed via fprintf but '%d' is used to print @flags (of type
> uint). Use '%u' instead.
>=20
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/qtest/acpi-utils.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
> index 673fc97586..6389f1f418 100644
> --- a/tests/qtest/acpi-utils.c
> +++ b/tests/qtest/acpi-utils.c
> @@ -102,7 +102,7 @@ void acpi_fetch_table(QTestState *qts, uint8_t =
**aml, uint32_t *aml_len,
>             char *fname =3D NULL;
>             GError *error =3D NULL;
>=20
> -            fprintf(stderr, "Invalid '%.4s'(%d)\n", *aml, *aml_len);
> +            fprintf(stderr, "Invalid '%.4s'(%u)\n", *aml, *aml_len);
>             fd =3D g_file_open_tmp("malformed-XXXXXX.dat", &fname, =
&error);
>             g_assert_no_error(error);
>             fprintf(stderr, "Dumping invalid table into '%s'\n", =
fname);
> --=20
> 2.17.1
>=20
>=20
>=20


