Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF7A70309C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:53:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZZT-0004NS-84; Mon, 15 May 2023 10:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyZZ4-0004KN-OY
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyZYu-00022S-LP
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684162351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GKTKxi3bdj5YfH8AJ4Z2p3AMih3DuWDR54KKQaQKDRE=;
 b=FihSf9ONWBdjcQ2a7F7Mj1HfXN4X7rRW2+Niy44Zcwxo8LGTEVUMWxQtKOOrqitaKyiKAe
 zMp4ngF96nhPhGl7g7vFRuEghOXBsUkb2n2Ixeh+26jK7uQ9I144M+xaJRVL5wFHLdtcSX
 fPWLU8g57EuE4TCRgyRO/3MH9pPYNR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-gwvPQGiBORGKH5WcoDD2vw-1; Mon, 15 May 2023 10:52:29 -0400
X-MC-Unique: gwvPQGiBORGKH5WcoDD2vw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42d18a079so39124005e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 07:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684162348; x=1686754348;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKTKxi3bdj5YfH8AJ4Z2p3AMih3DuWDR54KKQaQKDRE=;
 b=LkxK2YvFW2WVZVqdIKdSjLwB8Iku/6AOOBXZFbRkB81mAD2n/PdKFmhxHvG6w23JLS
 zW41AxCSiNnubSf8pYLbkYOXV0y1dL7OnCg4VfAAm3OVUEMYbToQq+ALGlsQ72RWwTtm
 q4XfvGgQsO7bQTdENOjXnVQXVazKgTZEg8Eo0yyPZTUhxJPrqp+nf0tvY+YOUY1p+H+E
 mbvNC//MqUK8azc0rjZYQD2ZMBnYUOawnz05c4zmF4DoJsQw1J6pP+HXqd195CKOCIeQ
 oXIT1OKr3qR2GRcNWAWtOefDi5wjK0iHqzGkzo6CUoI9LTCpXa9ldiM7Ta7cSL550Jev
 jFjw==
X-Gm-Message-State: AC+VfDxQ7GkOJvJPtC5vdB8UWNG6ZsRXM897hAjArUY/+ay1evYthmST
 PuXZSj2hITExekAfVuG/L6WBnrkelEovw/wTDbrDH62kHHYJBTgFl5eCy06t1N0hNn2HR6nriYD
 U7sA2/1XUJXVhPGw=
X-Received: by 2002:a5d:5960:0:b0:2ef:b4a9:202f with SMTP id
 e32-20020a5d5960000000b002efb4a9202fmr25539646wri.69.1684162348131; 
 Mon, 15 May 2023 07:52:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dXRAA/MD1LvpwSQ6e+ljxYM64K+XKEpWUAhddb+7hj3AzxRNmfLw96OtNN4dkVBRWygIaTQ==
X-Received: by 2002:a5d:5960:0:b0:2ef:b4a9:202f with SMTP id
 e32-20020a5d5960000000b002efb4a9202fmr25539626wri.69.1684162347864; 
 Mon, 15 May 2023 07:52:27 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 i3-20020adfefc3000000b002f6dafef040sm33556wrp.12.2023.05.15.07.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 07:52:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  jasowang@redhat.com,  philmd@linaro.org,
 thuth@redhat.com,  berrange@redhat.com,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  leobras@redhat.com,  peterx@redhat.com,
 zhanghailiang@xfusion.com,  chen.zhang@intel.com,  lukasstraub2@web.de
Subject: Re: [PATCH v5 3/3] migration: process_incoming_migration_co(): move
 colo part to colo
In-Reply-To: <20230515130640.46035-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 15 May 2023 16:06:40 +0300")
References: <20230515130640.46035-1-vsementsov@yandex-team.ru>
 <20230515130640.46035-4-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 15 May 2023 16:52:26 +0200
Message-ID: <87r0rhy7dh.fsf@secure.mitica>
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
> Let's make better public interface for COLO: instead of
> colo_process_incoming_thread and not trivial logic around creating the
> thread let's make simple colo_incoming_co(), hiding implementation from
> generic code.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Independent of this patch, I still wonder if moving incoming migration
from a coroutine to a thread makes sense.  On one hand:

- it would simplify (a bit) the already complex code
- it would make a bit better in non-multifd migrations, right now, if we
  put enough networking, the botleneck is the migration incoming
  coroutine.

On the other hand:
- We would have to work with bottom handlers (as the outgoing migration
  does)
- With multifd enabled, the amount of data that is sent through the
  main migration channel is just a few MB, so not that it is going to
  improve a lot.

So, it is not clear to me what to do here.

Later, Juan.


