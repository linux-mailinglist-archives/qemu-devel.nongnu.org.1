Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7370464C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp3v-0002FM-Qu; Tue, 16 May 2023 03:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyp3u-0002Ex-2M
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:25:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyp3s-0007aJ-Ae
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:25:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f41d087bd3so70076825e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20221208.gappssmtp.com; s=20221208; t=1684221930; x=1686813930; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWOCyyIV2btvZAvfYFkoh+ctTip8VAimAdpfAKKDpYA=;
 b=sR6sKjFCvhO1mE5oa7stZYAnUJmKnnMzl8M97hoUXfjOgLH/h8ktWSKnHvO0xi6MZj
 0plDmWgCvLzThRH0to8qu0H8jVmxXg1tpd07dhLfcCy2rQI6/UHCGV3NR672pSxKHcRI
 LQl+fJE4x9+yjpkXmom0GI9lAFPPelezGtJuFswtS/Zb+7jGKPlhtECBeURkVsdoOc1s
 Cz1fha58GfarlcbYHecGYHcqU5Fzugxoqqk6jJ5twL5qUCdwUJvUF+yYBf/Y4tAYcqnA
 xoJBXS+vhPFrwKhcykTQGeWgaDn7dbS02/9MCrYhNLySNXgdBDwX+kP0yVv5ZcEBUMfv
 4P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684221930; x=1686813930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWOCyyIV2btvZAvfYFkoh+ctTip8VAimAdpfAKKDpYA=;
 b=L0E4EJneRk4QmrqSSDhker0Wdg3rwmPTZKotfdWG4/1CPN5yrW315LEJEh6hIl509c
 GIupd6x4yWORvnE2VY0kmrmtdiTmf+z3xuyqaf+p0PrmJPJcdy4ac7FVatE8Wf/XKfLO
 xxbsdCINqec6EvSuwiQxS5NJz/nOi8KQnYkdCRTDpOOHL/a2+dzrV8J7fnMBZ4pGTrmJ
 hrKFZS1dsrQRcV/zdbNADov35/UkgvFpn3rW20GyWdhrKydGydkRF4ItwtGhq6cfPVS9
 wnlorCe0eELcZzhmxFTahEtXFIzM37CU6QEH/9+GbiK7msgwsbP0HskenU7ziQduFmVE
 ElKA==
X-Gm-Message-State: AC+VfDy+pPNyGBX0JPmb6X00UDQ4rr9wqG7RKG9lGDrg+8JpDGzoWBvv
 qs2MrO9SoBCKGEGrazdIT/cToBqJk1asWymu9zNh2A==
X-Google-Smtp-Source: ACHHUZ42STl2WpztoGbVjl1vHu/wm5osgI47JimrxhR9yvs57tnlLEDiYR3dA2To8gcTumQloU9E5l5jzYPQDk4A6lc=
X-Received: by 2002:adf:fe05:0:b0:306:f6c:1063 with SMTP id
 n5-20020adffe05000000b003060f6c1063mr25557630wrr.38.1684221929969; Tue, 16
 May 2023 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-2-eric.devolder@oracle.com>
In-Reply-To: <20230515203311.2139-2-eric.devolder@oracle.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 16 May 2023 12:55:18 +0530
Message-ID: <CAARzgwzJRbcUnHspiUMO7qNUp6ypwxMJxxJ_RXRHKzN6BY2q_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: bios-tables-test.c step 2 (allowed-diff entries)
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com, 
 imammedo@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::32a;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 16, 2023 at 2:03=E2=80=AFAM Eric DeVolder <eric.devolder@oracle=
.com> wrote:
>
> Following the guidelines in tests/qtest/bios-tables-test.c,
> set up bios-tables-test-allowed-diff.h to exclude the
> imminent changes to the APIC tables, per step 2.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..1e5e354ecf 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,5 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/pc/APIC",
> +"tests/data/acpi/q35/APIC",
> +"tests/data/acpi/microvm/APIC",
> +"tests/data/acpi/virt/APIC",
> --
> 2.31.1
>

