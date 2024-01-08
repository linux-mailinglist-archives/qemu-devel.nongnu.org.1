Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95534827BAD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:44:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzHZ-0005zR-R5; Mon, 08 Jan 2024 18:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMzHY-0005zJ-5s
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMzHW-0000Ug-J1
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704757425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQb7AFsI6c30kO0xmXCDp/xi1mndiKAY1qXYE0X0YS0=;
 b=ObgpgaUIuh4A/O47w4jSntCZ1uHItG74wwClxqlKC70jTWxfdyJLabVpBFX7Dhs7jpCjtM
 DSUsKWy0bSMoWlLW8Aq+j9l27lMfEJd+O1PXKnMrdYDbgJKegyYrLQEJz1kRcAhx10J+VP
 NeKzVRTK4gtRCcrY+HVlviKswfd7icM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-R5zx3rR9MU2z_wD_EUcJNA-1; Mon, 08 Jan 2024 18:43:38 -0500
X-MC-Unique: R5zx3rR9MU2z_wD_EUcJNA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28c5c622a3cso1343327a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704757417; x=1705362217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQb7AFsI6c30kO0xmXCDp/xi1mndiKAY1qXYE0X0YS0=;
 b=DurXroI8uStYcvtywqZ+1LygTAXfgGsDE9vtWPsxtTxqd7nSqNVQCadiQ6CteBq5YM
 0U0vBwu7RyGWcH7O3IY1/i9ElUVbeytUC983mlqvUgUTNUITejBHisR9xD8zVfYR8OAe
 jAojoguEZ7M+XxM98v7MD6fQxPKvqu/dd0fATNm1EFo2N5Mz6L4qev+67lSGa06bG0cf
 KFsMPUfRmU1Bop8rFU/wX9ReHDIsLl5bSBXMd+saTzQgStQ3qCu1UnicSHNV2S473a9R
 AXY1EGwh6SDg9yPup3DSieAwY13x2UGOInb9gMPc/MFwFXFNyX4DvR7Scynp1CbEQ1TZ
 ZXAQ==
X-Gm-Message-State: AOJu0YyqjW1ce50uWTLtB8PEvTIFzBl4zTsy7MrXXqqBGVLBG2sLG8Ow
 QG9LaldUqrSofVNerJ1N5JqSbAbxSI3Pso58teH9eZPMhazEIGw4Mrwws2i/W58XVKmDzt32z35
 ozTV0hps/F/B0f/gg1X0mfzqY2wuM9qyJ4CRYb1g=
X-Received: by 2002:a17:90a:9509:b0:28b:ea0c:f9b8 with SMTP id
 t9-20020a17090a950900b0028bea0cf9b8mr1716802pjo.64.1704757417071; 
 Mon, 08 Jan 2024 15:43:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE57FlNolFkLNvAg6UkshSsKtrdXRzgv/V6EN5qhjmYIPTUZx3SObF4B5hVxBIqZnU320xO9Wmtz4PHxMLe8yw=
X-Received: by 2002:a17:90a:9509:b0:28b:ea0c:f9b8 with SMTP id
 t9-20020a17090a950900b0028bea0cf9b8mr1716796pjo.64.1704757416804; Mon, 08 Jan
 2024 15:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-5-davydov-max@yandex-team.ru>
 <87o7faxncr.fsf@pond.sub.org>
 <620bdb50-39fb-4096-a5eb-df724f31f505@yandex-team.ru>
 <87jzpbsl5l.fsf@pond.sub.org>
In-Reply-To: <87jzpbsl5l.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Jan 2024 18:43:25 -0500
Message-ID: <CAFn=p-a0m1xA-qfLBX7wAL=v+cJY_SkOgC5xYiXi5oKzOGzn8w@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] scripts: add script to compare compatible
 properties
To: Markus Armbruster <armbru@redhat.com>
Cc: Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org, 
 vsementsov@yandex-team.ru, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, crosa@redhat.com, bleal@redhat.com, 
 eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, 
 bsd@redhat.com, stefanha@redhat.com, thuth@redhat.com, 
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 18, 2023 at 8:20=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Maksim Davydov <davydov-max@yandex-team.ru> writes:
>
> > On 12/1/23 12:51, Markus Armbruster wrote:
> >> Review, anyone?
> >
> > Only Vladimir
>
> To be clear: I'm soliciting a second review.
>
> [...]
>

I volunteer to review it from the Python maintenance POV, but please
rebase and resend to fix the patchew desync. We still want review from
a more holistic perspective, though ... but if it's not part of the
build or test infrastructure, it doesn't have to be perfect.

--js


