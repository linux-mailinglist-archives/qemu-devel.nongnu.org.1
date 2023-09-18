Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558867A483A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCIv-0004gc-6J; Mon, 18 Sep 2023 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qiCIh-0004Ye-6S
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qiCIc-00079i-QU
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695036014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krqaxOuJQOD/1gBZSpCC0vrAeCXNgID8Z0sdK8M/d4k=;
 b=XwDlN32CUKCN6Du2rlIRwY3Ob6p0S3Fsbj8UHQIAWbu46Igr9wfAbg/5Kubpo84XzPbY+/
 wyUtViT4pcRUPpG4jvoSppaLryz2Yw0nA85yN3jD9FK7FHS7Dj6dbvjvV/gNi0zL/LbWGk
 3JF4ChWLJcjJJA55ss752eG42s7TYsM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-fqv3xX7DNMqSVywY_Te9cg-1; Mon, 18 Sep 2023 07:20:13 -0400
X-MC-Unique: fqv3xX7DNMqSVywY_Te9cg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-502fff967ccso2087859e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695036011; x=1695640811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krqaxOuJQOD/1gBZSpCC0vrAeCXNgID8Z0sdK8M/d4k=;
 b=okMsjhPbmgou5rC3AhwQytXt6fQTWUsio32w5KgGXL8/gi8WulYhUMoiHg4oKxmxXS
 PubeyR677eVjqjqnxoEVNLn7dNMbj6CtJrx0SOTk5IYSnmmQkzYIq6gvqsArh8UPSpWo
 lc6IfZsMe/XgznY2/+uS77T4d9l/IQNhTWGavMvTtjYk7Lz0mbS5UW/IHVGFYAOvhQvv
 Syi8U5wX14Hkc+jCs5gNhtkmGJeJv03gXVaCEMALyqvjVOEj9/YcOACvvwnwE3Alks6G
 OvRMhEdlvvZCMtUwRLWpKOvpsaqULJJYLWYh7oqwU8Yv4ZFMHxENW0mUM2MFvSnCN4ux
 c6gw==
X-Gm-Message-State: AOJu0YzHD52h0eB8P8/oVpNEgWsKQERh9j4nZMAT8GoxV5GATlQ45FO2
 jGl9Dmv2QJAAGUK7GjtiMNxGkaJV1pkJkFm6r1cuvkRrv1WlYQlAhaRcAJRVMh64Y1qpsOGajUG
 6W0Mgp9MUrmtiiTZNV2EOlfF8kbIRg7k=
X-Received: by 2002:a05:6512:3e05:b0:503:3b5:a65 with SMTP id
 i5-20020a0565123e0500b0050303b50a65mr5989351lfv.31.1695036011670; 
 Mon, 18 Sep 2023 04:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTN8DRjCWODiBwLkLbsV8/kcI1yXy9o9cJw7kSm7SgpDzOOuQJ0gr+mmU42NJS3DDen0/JrNlmIy1z9DRgC00=
X-Received: by 2002:a05:6512:3e05:b0:503:3b5:a65 with SMTP id
 i5-20020a0565123e0500b0050303b50a65mr5989336lfv.31.1695036011350; Mon, 18 Sep
 2023 04:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Sep 2023 15:19:59 +0400
Message-ID: <CAMxuvawHJzQkmta8HNj7riqBC-vqSAuBE41QA+ku9v2qrBgEXA@mail.gmail.com>
Subject: Re: [PATCH 0/8] hw/audio/es1370: bug fix
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Sun, Sep 17, 2023 at 10:55=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onl=
ine.de> wrote:
>
> Cc: qemu-stable. Patch 1/8 is a bug fix.
> Cc: more people. The maintainer of hw/audio is busy with other projects.
>
> Earlier this year I was asked if I could help to debug an audio playback
> speed issue with the es1370 device. While debugging the playback speed
> error, I noticed that the debug code of the ES1370 device has not been
> compiled for a long time and has bit-rotted. This patch series fixes the
> rotten code and also fixes a bug I found while debugging the code. The
> bug fix is in patch 1/8 and prevents corrupted data streams. The
> playback speed issue was caused by lost interrupts. Patch 8/8 helps to
> debug this kind of issues.
>
> Volker R=C3=BCmelin (8):
>   hw/audio/es1370: reset current sample counter
>   hw/audio/es1370: replace bit-rotted code with tracepoints
>   hw/audio/es1370: remove unused dolog macro
>   hw/audio/es1370: remove #ifdef ES1370_DEBUG to avoid bit rot
>   hw/audio/es1370: remove #ifdef ES1370_VERBOSE to avoid bit rot
>   hw/audio/es1370: block structure coding style fixes
>   hw/audio/es1370: change variable type and name
>   hw/audio/es1370: trace lost interrupts
>
>  hw/audio/es1370.c     | 289 +++++++++++++++++++-----------------------
>  hw/audio/trace-events |  11 ++
>  2 files changed, 143 insertions(+), 157 deletions(-)
>
> --
> 2.35.3
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


