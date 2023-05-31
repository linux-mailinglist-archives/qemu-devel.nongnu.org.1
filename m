Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808C717E28
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:36:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4K6c-0004Rj-8B; Wed, 31 May 2023 07:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q4K6a-0004RR-Og
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q4K6Z-0000Eu-D0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685532902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDiSI3vVNNW4ONR2xkquJ6tBSn++CiI99ICO2F2mtCE=;
 b=cwLbzsft1jr11M7F0u+xEIG+/Whz11Wz06CflYe4zEsFIgSMae/yg6sPiZXdsV/efjehLa
 n7RwD5b0zVba5hj8Y/NkdgerAlyKIjc3SD7y2VbTNlU0On+V17iJl6E6kvLluPLmeal9rf
 RXSP4rK5lp1WdZxVnCVk+DRzBb306wY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-LrQhDA5-NyWOqh2BVot-Yw-1; Wed, 31 May 2023 07:35:01 -0400
X-MC-Unique: LrQhDA5-NyWOqh2BVot-Yw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-25665d2a250so3779919a91.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 04:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685532900; x=1688124900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jDiSI3vVNNW4ONR2xkquJ6tBSn++CiI99ICO2F2mtCE=;
 b=KoZopDlYa3aW+/mzfhjrl/StsDpZC5L7p/QRwe/8cifNGSVNnR63xQleTRg01Pvn6n
 SIvrEd6UbTOo4q59qAyathjAVTyMYrji0BxpBFfrfe7llq+cPpP2FY0ayW7aAhLw4RnE
 2iSD+ItS3dobbub+oHK/RY8/+q8sBVy4ohb38UF3gKUIoxkMs+GkvKhljHJG63LIUeSY
 vyHh67O0QCfEs4Etu3gMBi8lKr1IziRSZmZW8mfeP4YNbDRmPcTTyQE8qeNqrQ2cmB13
 qdKHyOlTygN+VmmjQZW0TPbv3Uy4uo0UQJax7RyGxlClMhQDzefqIOehnl9FaAARiX3Q
 /4AQ==
X-Gm-Message-State: AC+VfDyIAopS+QXVqQiCJ88X17hq3+IGB6L14h6yIaBcKmM1GyXixcs1
 UHiPscyqxw8QGN/2uwlXZRvZtYFyKqVhs62F3ZW0yMGAtOnrE55YefVYRT9GOQQkLQ/yEBWB2rX
 Xm7n+Z5Bk4StsU4RzcazhC8FuiljIU8k=
X-Received: by 2002:a17:90b:1089:b0:255:2dde:17cc with SMTP id
 gj9-20020a17090b108900b002552dde17ccmr5077174pjb.47.1685532900083; 
 Wed, 31 May 2023 04:35:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UFn0DrtY7cEtq2HNQ+nQTlUNGV1MbWlW38ko2B90+Lf/obY66I/7xRNpjUTkS8hl3zaMSKOhngMkqwqnFt/A=
X-Received: by 2002:a17:90b:1089:b0:255:2dde:17cc with SMTP id
 gj9-20020a17090b108900b002552dde17ccmr5077156pjb.47.1685532899771; Wed, 31
 May 2023 04:34:59 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 31 May 2023 04:34:58 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
 <CAK9=C2VRF-QobT_-qObOAnjqk8haxOUkmnsPCtCKuRk3pL+jPw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK9=C2VRF-QobT_-qObOAnjqk8haxOUkmnsPCtCKuRk3pL+jPw@mail.gmail.com>
Date: Wed, 31 May 2023 04:34:58 -0700
Message-ID: <CABJz62M_98hwGSHc2iJ7T+7AT+rQUa4xwc8s1WHo=TTbfCmbGA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] hw/riscv/virt: pflash improvements
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 10:46:17AM +0530, Anup Patel wrote:
> On Fri, May 26, 2023 at 5:41=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.c=
om> wrote:
> >   hw/riscv: virt: Assume M-mode FW in pflash0 only when "-bios none"
> >   riscv/virt: Support using pflash via -blockdev option
> >   docs/system: riscv: Add pflash usage details
>
> In case of KVM guests, there is no M-mode so pflash0 will always
> contain S-mode FW.
>
> I suggest improving this series to consider KVM guests as well
> such that the same EDK2 S-mode works for KVM and TCG guests.

After these patches are applied, pflash0 is assumed to contain S-mode
code *unless* you go out of your way and add -bios none to the
command line.

It seems to me that this default behavior will work fine for KVM
guests too, based on what you wrote above. Isn't that the case?

--=20
Andrea Bolognani / Red Hat / Virtualization


