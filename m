Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A054873DCF4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:10:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDk71-0000NX-Up; Mon, 26 Jun 2023 07:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDk6e-0000CH-ME
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDk6d-0007zN-8L
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPAzpvcNA10ggGXCNvgeSN0ynyRelapLx0Y79FyDte0=;
 b=Y2rfYhYuQd191rN6tHlVTFVRRcGyYF/3X6RoQTx9YhrQnh38jdmgsVKWWXmutpaoSFrjk5
 xGsG4Kg1RNpE4FdowQsfhEp7zH3o8qc6lZbjUZH2++ujJ+FnApdyC8iW65xt7dYyuGE/DD
 FnkBjbU04MDQGNJ4mac5BMtiJEBSEQE=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-3-Uoq6cRMNWX8poyG13Bdw-1; Mon, 26 Jun 2023 07:09:59 -0400
X-MC-Unique: 3-Uoq6cRMNWX8poyG13Bdw-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-471ae16a13eso474143e0c.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777799; x=1690369799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPAzpvcNA10ggGXCNvgeSN0ynyRelapLx0Y79FyDte0=;
 b=NH+HKkRdkYFDQJs49zWIIMsNeEg9AaMpjorRUuhRYIVfFoMmOS5miEYD5wczuskQHV
 vK2+yQC0vgQLtd8OZcw5k+aHP9Wb1+06wMOJl9pe0P4fHxSkcC9cy2jCautzZdPSrT1l
 nr2+jN8AZapWXLUZ0vfW1PnBdUd8LbQBcApEFO8lp0qod3eH40I/I6sIRYthbbnoXfnh
 aPwCC4itdnG50v/nZeyNIWjjKB4PnAG7mLTgUVs+sMcgMCwqhYpoDMGyNVVbZnU542bI
 E2Lm0y+Ut6XoElkZ/5LSab3qggm/gR9mqoOUoi4WRyB0R9v4jtbMluQwzcmYozV+Fe/w
 lOcA==
X-Gm-Message-State: AC+VfDxGz/PFt0apuM1/59siiCLAC7K4pxNOwcn25ltAMxml9klBsCFI
 GbQmodXm6rxQI0Es06+/S68eeAmGdXs8e9U1LnRIqFgQg63JgDkzcV6tL8npJ1uRezgpOv/L8Vq
 yLq3YkoLyThgy/PqS1UvFQQTBWU65r30HW9ii/jQ=
X-Received: by 2002:a67:d019:0:b0:443:5c9a:5ccf with SMTP id
 r25-20020a67d019000000b004435c9a5ccfmr735430vsi.17.1687777798821; 
 Mon, 26 Jun 2023 04:09:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HSeE5AsDFKftxH9N1BqVYpn+cIUDUGOVNtIV7847Daxao4kjSJwtzPKzCZbzt++jd1N5NOvF6c3fks59wvfs=
X-Received: by 2002:a67:d019:0:b0:443:5c9a:5ccf with SMTP id
 r25-20020a67d019000000b004435c9a5ccfmr735418vsi.17.1687777798582; Mon, 26 Jun
 2023 04:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230625083731.3108-1-npiggin@gmail.com>
 <20230626110847.162190-1-pbonzini@redhat.com>
In-Reply-To: <20230626110847.162190-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Jun 2023 13:09:47 +0200
Message-ID: <CABgObfanTTyz47UKbYbRqk-6xsntpRpK359vvmh0CuX3+o6k4Q@mail.gmail.com>
Subject: Re: [PATCH RFC] icount: don't adjust virtual time backwards after warp
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 26, 2023 at 1:08=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Queued, thanks.

Hmm, almost, can you provide the Signed-off-by?

Thanks,

Paolo


