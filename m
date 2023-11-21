Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF827F248A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:13:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HCf-0003j6-3m; Mon, 20 Nov 2023 22:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HCd-0003ix-Ct
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:13:31 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HCb-0006wL-Td
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:13:31 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7c423088147so107607241.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 19:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700536409; x=1701141209; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2G9ARXzVHPPAbo0Jevwt8dKQ7fk1sbSVbA9qUDc8ok4=;
 b=AUkjABIBuVTClOk12XgyR+QNi5BTE2dUaz9eS+EcVN3tVlEln5xHZDYt30erBr9f6v
 MBuq08lBVNIry+vfdFMPbgzgOOmkT1w3Qz5x7Lk1wTgPqmlNZ0mqk7CMCKchACE7Chpj
 OFRpEvT+T/2DVyw9Xhi9QTHTOFD17lijv1Pf/QqhO0aMZ9cTmYwNizPXJSZXFKz7d2ps
 K87jGPnISnLplvE5kYrI/nI6iX49D9jmc/vGoG4EyojtrK9k9S/WM5SWrD73EB2mufI9
 zmIeO4uUTMJ3lSzx0Myzgbh0vbDfqeCf+H7wmXGXeNCaZtUdFE8P1hXEjUU+MOEyPIhT
 3SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700536409; x=1701141209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2G9ARXzVHPPAbo0Jevwt8dKQ7fk1sbSVbA9qUDc8ok4=;
 b=uP8N7Upwn6Fm8xniYZMuSuBcueLfiL4Pazrj6YsxpR7XjwWDGsrLcO6hE5npcKvZHP
 bgw5z3S/SSRBaCEpzVygKnHXdNbI/BXaBGhTk4erE65DjOfKyEgrJr65IwCOTrYvDCG+
 0PA8VdL8/DyVvv40yefklnXBcef8Wio+8h6HlxNGAdRmlB2T/wUyrnEfciYJCBUY6saO
 0hwjSlA9tYxXE3n1i2xUY6bs2keVNr67Ic/Xj8zRLEB4RnTQl/ZXE8Zypzn2AkSxmZtX
 rwgqlxMjyPn2nLD5a9PbZQvk/1LR3USXeYGruvLDQNGxAATKdF//3j4UsBERE5kPaoUS
 VyrQ==
X-Gm-Message-State: AOJu0YxOpU53TkOAAyBnmvZ45Je8E/DjVnQGzqrhkb2cJRnLqVH6dpuD
 o+LRToeraDU7qiQq18LQypGjbLbIwBxM4Bdzs3g=
X-Google-Smtp-Source: AGHT+IG4UNEe/hXGMKAIsLbBt32PmZiXszjSEt4mXqgnByKbCMAWm2LhuokM+EgilNlt9Rg/o3VtK9ygy+gH1bUeihw=
X-Received: by 2002:a05:6102:97:b0:45d:95ad:f56c with SMTP id
 t23-20020a056102009700b0045d95adf56cmr7146112vsp.21.1700536408794; Mon, 20
 Nov 2023 19:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-4-thuth@redhat.com>
In-Reply-To: <20231117114457.177308-4-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Nov 2023 13:13:02 +1000
Message-ID: <CAKmqyKOhSn0wm5=qWjikFY9qKFepTKO-SBQ6zJrzift3pOYJrA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] memory: Remove "qemu:" prefix from the
 "qemu:ram-discard-manager" type name
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Nov 17, 2023 at 9:46=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> Type names should not contain special characters like ":". Let's
> remove the whole prefix here since it does not really seem to be
> helpful to have such a prefix here. The type name is only used
> internally for an interface type, so the renaming should not affect
> the user interface or migration.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 831f7c996d..f172e82ac9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -43,7 +43,7 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegion=
Class;
>  DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
>                       IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
>
> -#define TYPE_RAM_DISCARD_MANAGER "qemu:ram-discard-manager"
> +#define TYPE_RAM_DISCARD_MANAGER "ram-discard-manager"
>  typedef struct RamDiscardManagerClass RamDiscardManagerClass;
>  typedef struct RamDiscardManager RamDiscardManager;
>  DECLARE_OBJ_CHECKERS(RamDiscardManager, RamDiscardManagerClass,
> --
> 2.42.0
>
>

