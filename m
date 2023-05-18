Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68B707F08
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbfj-0007wj-Fd; Thu, 18 May 2023 07:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbfg-0007uh-U9
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbfe-0007gG-3N
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684408784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KLO1K4HHeAR3hFGU6K+0c+STI1mTowqyWEWESQJYOSI=;
 b=D4X/m+whD6+RotgX4kt9X04Zd64frNHmoc/YzUe39mMI4quhgCuiI1qfvWp0SWkaL94mg0
 WnYs5N3lDj+/2EDT7fbG0Kxg0ebDVt4xrhUXQB3H7Rpn525htWZvwOPWjDSQXDs6xyt0ZW
 hm6BbwygKIy0C0zLzeeDKvQ/qDxC1sA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-GJm6g0F7Pc-6Czr3ej4viA-1; Thu, 18 May 2023 07:19:43 -0400
X-MC-Unique: GJm6g0F7Pc-6Czr3ej4viA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5d6dc52fdso4180735e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408782; x=1687000782;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLO1K4HHeAR3hFGU6K+0c+STI1mTowqyWEWESQJYOSI=;
 b=AtuccBoe6aH27/I4LJLFvQw7guMwNGi1/sFOHg8nKkDaV2LJpUWHFVZceHsYzPBDVb
 It8t199T99g1VQvCccsoPs61q0EAf3pTTuy+vUgaNUivo4GE8TiAyHf64unL5xgRTBu6
 Ow7PMg49nuThw286jhaNoD1cAvcRofTOonXQG157B7rMdY5ICFftn7IkKeMo9GzSujs1
 nc0wCPg3Diz0+nBdVP2iRtzZtrXiZG9jeHsApLkdq/EU5bEOw4VaAhSmAJpf0InU0ELh
 +OPtTICM9X9eJS1nSWs+x78mcIQi9ZWRKPkLtaQ9uu7fgHc2i4RTCjHFgFwjAVG1QE3l
 fbdA==
X-Gm-Message-State: AC+VfDwUjw8UZcFJZXfWgMtfiT1e8DkojIEmEs82mQ1TT+0hR6heyUEG
 jM04gZ/8qcaryBXMD1iiscjK+DMw+mDjHyj4jpQXCV7mdm53YDyobuUdAzFOJnEsxKVC8HhIbTK
 bwmeEpztA7EdUUWw=
X-Received: by 2002:a05:600c:4f4d:b0:3f1:89de:7e51 with SMTP id
 m13-20020a05600c4f4d00b003f189de7e51mr1211104wmq.12.1684408781932; 
 Thu, 18 May 2023 04:19:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5r8mnXjZ4TW+TIQLUJFtzZoVQgB3KfBCMqvieUB/l/VcupLZ38a8Xr8jYlEcDQPU0DvP2fBw==
X-Received: by 2002:a05:600c:4f4d:b0:3f1:89de:7e51 with SMTP id
 m13-20020a05600c4f4d00b003f189de7e51mr1211092wmq.12.1684408781630; 
 Thu, 18 May 2023 04:19:41 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l4-20020a7bc444000000b003f42456c490sm1738747wmi.33.2023.05.18.04.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:19:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 3/5] runstate: drop unused runstate_store()
In-Reply-To: <20230517123752.21615-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:50 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-4-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:19:40 +0200
Message-ID: <87edndevjn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> The function is unused since previous commit. Drop it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Depending on how the discussions on previous one go.


